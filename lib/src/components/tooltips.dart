import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../foundation/dimensions.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

enum Ux4gTooltipPlacement {
  topStart,
  top,
  topEnd,
  bottomStart,
  bottom,
  bottomEnd,
  leftStart,
  left,
  leftEnd,
  rightStart,
  right,
  rightEnd,
}

class Ux4gTooltip extends StatefulWidget {
  final Widget child;
  final String tooltipText;
  final String? title;
  final IconData? icon;
  final Ux4gTooltipPlacement placement;
  final Color? backgroundColor;
  final Color? contentColor;
  final TextStyle? textStyle;
  final double cornerRadius;
  final double arrowWidth;
  final double arrowHeight;
  final bool enableUserInput;
  final bool isPersistent;
  final Widget? action;

  const Ux4gTooltip({
    super.key,
    required this.child,
    required this.tooltipText,
    this.title,
    this.icon,
    this.placement = Ux4gTooltipPlacement.top,
    this.backgroundColor,
    this.contentColor,
    this.textStyle,
    this.cornerRadius = Ux4gRadius.radius4,
    this.arrowWidth = 10,
    this.arrowHeight = 6,
    this.enableUserInput = true,
    this.isPersistent = false,
    this.action,
  });

  @override
  State<Ux4gTooltip> createState() => _Ux4gTooltipState();
}

class Ux4gRichTooltip extends StatelessWidget {
  final Widget child;
  final String tooltipText;
  final String? title;
  final IconData? icon;
  final Ux4gTooltipPlacement placement;
  final Color? backgroundColor;
  final Color? contentColor;
  final double cornerRadius;
  final double arrowWidth;
  final double arrowHeight;
  final bool enableUserInput;
  final Widget? action;

  const Ux4gRichTooltip({
    super.key,
    required this.child,
    required this.tooltipText,
    this.title,
    this.icon,
    this.placement = Ux4gTooltipPlacement.top,
    this.backgroundColor,
    this.contentColor,
    this.cornerRadius = Ux4gRadius.radius4,
    this.arrowWidth = 10,
    this.arrowHeight = 6,
    this.enableUserInput = true,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Ux4gTooltip(
      tooltipText: tooltipText,
      title: title,
      icon: icon,
      placement: placement,
      backgroundColor: backgroundColor,
      contentColor: contentColor,
      cornerRadius: cornerRadius,
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      enableUserInput: enableUserInput,
      isPersistent: true,
      action: action,
      child: child,
    );
  }
}

class _Ux4gTooltipState extends State<Ux4gTooltip>
    with SingleTickerProviderStateMixin {
  static _Ux4gTooltipState? _activeTooltip;

  final GlobalKey _anchorKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  OverlayEntry? _overlayEntry;
  Timer? _dismissTimer;
  bool _isVisible = false;
  bool _pointerInsideAnchor = false;
  bool _pointerInsideTooltip = false;
  bool get _isRich => widget.title != null || widget.action != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _removeTooltip(immediate: true, clearActive: true);
    _controller.dispose();
    super.dispose();
  }

  void _showTooltip({required bool persistent}) {
    if (!mounted || _isVisible) {
      return;
    }

    if (_activeTooltip != null && _activeTooltip != this) {
      _activeTooltip!._removeTooltip(immediate: true, clearActive: true);
    }

    final overlay = Overlay.of(context);
    if (overlay.mounted == false) {
      return;
    }

    _activeTooltip = this;
    _overlayEntry = OverlayEntry(builder: _buildOverlay);
    overlay.insert(_overlayEntry!);
    _isVisible = true;
    _controller.forward(from: 0);

    if (!persistent && !widget.isPersistent) {
      _scheduleAutoDismiss();
    }
  }

  void _scheduleAutoDismiss() {
    _dismissTimer?.cancel();
    _dismissTimer = Timer(const Duration(seconds: 2), () {
      if (!_pointerInsideAnchor && !_pointerInsideTooltip) {
        _removeTooltip();
      }
    });
  }

  void _removeTooltip({bool immediate = false, bool clearActive = false}) {
    _dismissTimer?.cancel();
    _dismissTimer = null;

    if (!_isVisible && _overlayEntry == null) {
      if (clearActive && identical(_activeTooltip, this)) {
        _activeTooltip = null;
      }
      return;
    }

    void cleanup() {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isVisible = false;
      if (clearActive || identical(_activeTooltip, this)) {
        _activeTooltip = null;
      }
    }

    if (immediate) {
      cleanup();
      _controller.value = 0;
      return;
    }

    _controller.reverse().whenComplete(cleanup);
  }

  Widget _buildOverlay(BuildContext context) {
    final box = _anchorKey.currentContext?.findRenderObject() as RenderBox?;
    final overlayBox =
        Overlay.of(context).context.findRenderObject() as RenderBox?;

    if (box == null ||
        !box.hasSize ||
        overlayBox == null ||
        !overlayBox.hasSize) {
      return const SizedBox.shrink();
    }

    final anchorTopLeft = box.localToGlobal(Offset.zero, ancestor: overlayBox);
    final anchorRect = anchorTopLeft & box.size;
    final screenSize = overlayBox.size;
    final effectivePlacement = _resolvePlacement(anchorRect, screenSize);
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _removeTooltip(),
            ),
          ),
          _TooltipOverlayChild(
            anchorRect: anchorRect,
            screenSize: screenSize,
            placement: effectivePlacement,
            arrowWidth: widget.arrowWidth,
            arrowHeight: widget.arrowHeight,
            bubble: MouseRegion(
              onEnter: (_) {
                _pointerInsideTooltip = true;
                _dismissTimer?.cancel();
              },
              onExit: (_) {
                _pointerInsideTooltip = false;
                if (!widget.isPersistent && !_isRich) {
                  _scheduleAutoDismiss();
                }
              },
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.96,
                    end: 1,
                  ).animate(_fadeAnimation),
                  alignment: _scaleAlignmentFor(effectivePlacement),
                  child: _TooltipBubble(
                    text: widget.tooltipText,
                    title: widget.title,
                    icon: widget.icon,
                    placement: effectivePlacement,
                    action: widget.action,
                    backgroundColor: widget.backgroundColor,
                    contentColor: widget.contentColor,
                    textStyle: widget.textStyle,
                    cornerRadius: widget.cornerRadius,
                    arrowWidth: widget.arrowWidth,
                    arrowHeight: widget.arrowHeight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Ux4gTooltipPlacement _resolvePlacement(Rect anchorRect, Size screenSize) {
    const spacing = 8.0;
    final current = widget.placement;

    final roomAbove = anchorRect.top;
    final roomBelow = screenSize.height - anchorRect.bottom;
    final roomLeft = anchorRect.left;
    final roomRight = screenSize.width - anchorRect.right;

    if (_isVertical(current)) {
      if (_isTop(current) && roomAbove < 72 && roomBelow > roomAbove) {
        return _mirrorVertical(current);
      }
      if (_isBottom(current) && roomBelow < 72 && roomAbove > roomBelow) {
        return _mirrorVertical(current);
      }
    } else {
      if (_isLeft(current) && roomLeft < 120 && roomRight > roomLeft) {
        return _mirrorHorizontal(current);
      }
      if (_isRight(current) && roomRight < 120 && roomLeft > roomRight) {
        return _mirrorHorizontal(current);
      }
    }

    if (_isTop(current) && roomAbove < spacing && roomBelow > roomAbove) {
      return _mirrorVertical(current);
    }
    if (_isBottom(current) && roomBelow < spacing && roomAbove > roomBelow) {
      return _mirrorVertical(current);
    }
    if (_isLeft(current) && roomLeft < spacing && roomRight > roomLeft) {
      return _mirrorHorizontal(current);
    }
    if (_isRight(current) && roomRight < spacing && roomLeft > roomRight) {
      return _mirrorHorizontal(current);
    }

    return current;
  }

  Alignment _scaleAlignmentFor(Ux4gTooltipPlacement placement) {
    switch (placement) {
      case Ux4gTooltipPlacement.topStart:
        return Alignment.bottomLeft;
      case Ux4gTooltipPlacement.top:
        return Alignment.bottomCenter;
      case Ux4gTooltipPlacement.topEnd:
        return Alignment.bottomRight;
      case Ux4gTooltipPlacement.bottomStart:
        return Alignment.topLeft;
      case Ux4gTooltipPlacement.bottom:
        return Alignment.topCenter;
      case Ux4gTooltipPlacement.bottomEnd:
        return Alignment.topRight;
      case Ux4gTooltipPlacement.leftStart:
        return Alignment.topRight;
      case Ux4gTooltipPlacement.left:
        return Alignment.centerRight;
      case Ux4gTooltipPlacement.leftEnd:
        return Alignment.bottomRight;
      case Ux4gTooltipPlacement.rightStart:
        return Alignment.topLeft;
      case Ux4gTooltipPlacement.right:
        return Alignment.centerLeft;
      case Ux4gTooltipPlacement.rightEnd:
        return Alignment.bottomLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        key: _anchorKey,
        behavior: HitTestBehavior.translucent,
        onLongPress: widget.enableUserInput
            ? () => _showTooltip(persistent: _isRich || widget.isPersistent)
            : null,
        onTap: () {
          if (_isVisible) {
            _removeTooltip();
          }
        },
        child: MouseRegion(
          onEnter: widget.enableUserInput
              ? (_) {
                  _pointerInsideAnchor = true;
                  _showTooltip(persistent: _isRich || widget.isPersistent);
                }
              : null,
          onExit: widget.enableUserInput
              ? (_) {
                  _pointerInsideAnchor = false;
                  if (!_isRich && !widget.isPersistent) {
                    _scheduleAutoDismiss();
                  }
                }
              : null,
          child: widget.child,
        ),
      ),
    );
  }
}

class _TooltipOverlayChild extends StatelessWidget {
  final Rect anchorRect;
  final Size screenSize;
  final Ux4gTooltipPlacement placement;
  final double arrowWidth;
  final double arrowHeight;
  final Widget bubble;

  const _TooltipOverlayChild({
    required this.anchorRect,
    required this.screenSize,
    required this.placement,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.bubble,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _TooltipPositionDelegate(
        anchorRect: anchorRect,
        screenSize: screenSize,
        placement: placement,
        spacing: 8,
      ),
      child: bubble,
    );
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  final Rect anchorRect;
  final Size screenSize;
  final Ux4gTooltipPlacement placement;
  final double spacing;

  const _TooltipPositionDelegate({
    required this.anchorRect,
    required this.screenSize,
    required this.placement,
    required this.spacing,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      maxWidth: math.min(280, screenSize.width - 16),
      maxHeight: screenSize.height - 16,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x;
    double y;

    switch (placement) {
      case Ux4gTooltipPlacement.topStart:
        x = anchorRect.left;
        y = anchorRect.top - childSize.height - spacing;
        break;
      case Ux4gTooltipPlacement.top:
        x = anchorRect.center.dx - childSize.width / 2;
        y = anchorRect.top - childSize.height - spacing;
        break;
      case Ux4gTooltipPlacement.topEnd:
        x = anchorRect.right - childSize.width;
        y = anchorRect.top - childSize.height - spacing;
        break;
      case Ux4gTooltipPlacement.bottomStart:
        x = anchorRect.left;
        y = anchorRect.bottom + spacing;
        break;
      case Ux4gTooltipPlacement.bottom:
        x = anchorRect.center.dx - childSize.width / 2;
        y = anchorRect.bottom + spacing;
        break;
      case Ux4gTooltipPlacement.bottomEnd:
        x = anchorRect.right - childSize.width;
        y = anchorRect.bottom + spacing;
        break;
      case Ux4gTooltipPlacement.leftStart:
        x = anchorRect.left - childSize.width - spacing;
        y = anchorRect.top;
        break;
      case Ux4gTooltipPlacement.left:
        x = anchorRect.left - childSize.width - spacing;
        y = anchorRect.center.dy - childSize.height / 2;
        break;
      case Ux4gTooltipPlacement.leftEnd:
        x = anchorRect.left - childSize.width - spacing;
        y = anchorRect.bottom - childSize.height;
        break;
      case Ux4gTooltipPlacement.rightStart:
        x = anchorRect.right + spacing;
        y = anchorRect.top;
        break;
      case Ux4gTooltipPlacement.right:
        x = anchorRect.right + spacing;
        y = anchorRect.center.dy - childSize.height / 2;
        break;
      case Ux4gTooltipPlacement.rightEnd:
        x = anchorRect.right + spacing;
        y = anchorRect.bottom - childSize.height;
        break;
    }

    x = x.clamp(8.0, size.width - childSize.width - 8.0);
    y = y.clamp(8.0, size.height - childSize.height - 8.0);
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant _TooltipPositionDelegate oldDelegate) {
    return anchorRect != oldDelegate.anchorRect ||
        screenSize != oldDelegate.screenSize ||
        placement != oldDelegate.placement;
  }
}

class _TooltipBubble extends StatelessWidget {
  final String text;
  final String? title;
  final IconData? icon;
  final Ux4gTooltipPlacement placement;
  final Widget? action;
  final Color? backgroundColor;
  final Color? contentColor;
  final TextStyle? textStyle;
  final double cornerRadius;
  final double arrowWidth;
  final double arrowHeight;

  const _TooltipBubble({
    required this.text,
    this.title,
    this.icon,
    required this.placement,
    this.action,
    this.backgroundColor,
    this.contentColor,
    this.textStyle,
    required this.cornerRadius,
    required this.arrowWidth,
    required this.arrowHeight,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    final lSDefault =
        ux4gTypography?.lS_default ??
        materialTheme.textTheme.labelSmall ??
        const TextStyle();
    final hXXSStrong =
        ux4gTypography?.hXXS_strong ??
        materialTheme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle();

    final bgColor = backgroundColor ?? onSurface;
    final fgColor = contentColor ?? surface;

    return CustomPaint(
      painter: _TooltipPainter(
        color: bgColor,
        placement: placement,
        arrowWidth: arrowWidth,
        arrowHeight: arrowHeight,
        cornerRadius: cornerRadius,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        padding: _bubblePadding(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title == null && action == null)
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: fgColor),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: (textStyle ?? lSDefault).copyWith(color: fgColor),
                    ),
                  ),
                ],
              )
            else ...[
              if (title != null || icon != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20, color: fgColor),
                      const SizedBox(width: 8),
                    ],
                    if (title != null)
                      Flexible(
                        child: Text(
                          title!,
                          style: hXXSStrong.copyWith(color: fgColor),
                        ),
                      ),
                  ],
                ),
              if (title != null || icon != null) const SizedBox(height: 8),
              Text(text, style: lSDefault.copyWith(color: fgColor)),
              if (action != null) ...[
                const SizedBox(height: 12),
                Align(alignment: Alignment.centerRight, child: action!),
              ],
            ],
          ],
        ),
      ),
    );
  }

  EdgeInsets _bubblePadding() {
    const horizontal = 12.0;
    const vertical = 8.0;
    final richHorizontal = title != null || action != null ? 16.0 : horizontal;
    final richVertical = title != null || action != null ? 16.0 : vertical;

    if (_isTop(placement)) {
      return EdgeInsets.fromLTRB(
        richHorizontal,
        richVertical,
        richHorizontal,
        richVertical + arrowHeight,
      );
    }
    if (_isBottom(placement)) {
      return EdgeInsets.fromLTRB(
        richHorizontal,
        richVertical + arrowHeight,
        richHorizontal,
        richVertical,
      );
    }
    if (_isLeft(placement)) {
      return EdgeInsets.fromLTRB(
        richHorizontal,
        richVertical,
        richHorizontal + arrowHeight,
        richVertical,
      );
    }
    return EdgeInsets.fromLTRB(
      richHorizontal + arrowHeight,
      richVertical,
      richHorizontal,
      richVertical,
    );
  }
}

class _TooltipPainter extends CustomPainter {
  final Color color;
  final Ux4gTooltipPlacement placement;
  final double arrowWidth;
  final double arrowHeight;
  final double cornerRadius;

  const _TooltipPainter({
    required this.color,
    required this.placement,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final path = Path();
    Rect bodyRect;

    if (_isTop(placement)) {
      bodyRect = Rect.fromLTWH(0, 0, size.width, size.height - arrowHeight);
    } else if (_isBottom(placement)) {
      bodyRect = Rect.fromLTWH(
        0,
        arrowHeight,
        size.width,
        size.height - arrowHeight,
      );
    } else if (_isLeft(placement)) {
      bodyRect = Rect.fromLTWH(0, 0, size.width - arrowHeight, size.height);
    } else {
      bodyRect = Rect.fromLTWH(
        arrowHeight,
        0,
        size.width - arrowHeight,
        size.height,
      );
    }

    path.addRRect(
      RRect.fromRectAndRadius(bodyRect, Radius.circular(cornerRadius)),
    );

    final tipOffset = cornerRadius + arrowWidth / 2 + 8;

    double tipX;
    double tipY;
    double base1X;
    double base1Y;
    double base2X;
    double base2Y;

    switch (placement) {
      case Ux4gTooltipPlacement.topStart:
        tipX = math.min(bodyRect.left + tipOffset, size.width / 2);
        tipY = size.height;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.bottom;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.bottom;
        break;
      case Ux4gTooltipPlacement.top:
        tipX = size.width / 2;
        tipY = size.height;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.bottom;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.bottom;
        break;
      case Ux4gTooltipPlacement.topEnd:
        tipX = math.max(bodyRect.right - tipOffset, size.width / 2);
        tipY = size.height;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.bottom;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.bottom;
        break;
      case Ux4gTooltipPlacement.bottomStart:
        tipX = math.min(bodyRect.left + tipOffset, size.width / 2);
        tipY = 0;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.top;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.top;
        break;
      case Ux4gTooltipPlacement.bottom:
        tipX = size.width / 2;
        tipY = 0;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.top;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.top;
        break;
      case Ux4gTooltipPlacement.bottomEnd:
        tipX = math.max(bodyRect.right - tipOffset, size.width / 2);
        tipY = 0;
        base1X = tipX - arrowWidth / 2;
        base1Y = bodyRect.top;
        base2X = tipX + arrowWidth / 2;
        base2Y = bodyRect.top;
        break;
      case Ux4gTooltipPlacement.leftStart:
        tipX = size.width;
        tipY = math.min(bodyRect.top + tipOffset, size.height / 2);
        base1X = bodyRect.right;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.right;
        base2Y = tipY + arrowWidth / 2;
        break;
      case Ux4gTooltipPlacement.left:
        tipX = size.width;
        tipY = size.height / 2;
        base1X = bodyRect.right;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.right;
        base2Y = tipY + arrowWidth / 2;
        break;
      case Ux4gTooltipPlacement.leftEnd:
        tipX = size.width;
        tipY = math.max(bodyRect.bottom - tipOffset, size.height / 2);
        base1X = bodyRect.right;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.right;
        base2Y = tipY + arrowWidth / 2;
        break;
      case Ux4gTooltipPlacement.rightStart:
        tipX = 0;
        tipY = math.min(bodyRect.top + tipOffset, size.height / 2);
        base1X = bodyRect.left;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.left;
        base2Y = tipY + arrowWidth / 2;
        break;
      case Ux4gTooltipPlacement.right:
        tipX = 0;
        tipY = size.height / 2;
        base1X = bodyRect.left;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.left;
        base2Y = tipY + arrowWidth / 2;
        break;
      case Ux4gTooltipPlacement.rightEnd:
        tipX = 0;
        tipY = math.max(bodyRect.bottom - tipOffset, size.height / 2);
        base1X = bodyRect.left;
        base1Y = tipY - arrowWidth / 2;
        base2X = bodyRect.left;
        base2Y = tipY + arrowWidth / 2;
        break;
    }

    path.moveTo(base1X, base1Y);
    path.lineTo(tipX, tipY);
    path.lineTo(base2X, base2Y);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.placement != placement ||
        oldDelegate.arrowWidth != arrowWidth ||
        oldDelegate.arrowHeight != arrowHeight ||
        oldDelegate.cornerRadius != cornerRadius;
  }
}

bool _isTop(Ux4gTooltipPlacement placement) =>
    placement == Ux4gTooltipPlacement.topStart ||
    placement == Ux4gTooltipPlacement.top ||
    placement == Ux4gTooltipPlacement.topEnd;

bool _isBottom(Ux4gTooltipPlacement placement) =>
    placement == Ux4gTooltipPlacement.bottomStart ||
    placement == Ux4gTooltipPlacement.bottom ||
    placement == Ux4gTooltipPlacement.bottomEnd;

bool _isLeft(Ux4gTooltipPlacement placement) =>
    placement == Ux4gTooltipPlacement.leftStart ||
    placement == Ux4gTooltipPlacement.left ||
    placement == Ux4gTooltipPlacement.leftEnd;

bool _isRight(Ux4gTooltipPlacement placement) =>
    placement == Ux4gTooltipPlacement.rightStart ||
    placement == Ux4gTooltipPlacement.right ||
    placement == Ux4gTooltipPlacement.rightEnd;

bool _isVertical(Ux4gTooltipPlacement placement) =>
    _isTop(placement) || _isBottom(placement);

Ux4gTooltipPlacement _mirrorVertical(Ux4gTooltipPlacement placement) {
  switch (placement) {
    case Ux4gTooltipPlacement.topStart:
      return Ux4gTooltipPlacement.bottomStart;
    case Ux4gTooltipPlacement.top:
      return Ux4gTooltipPlacement.bottom;
    case Ux4gTooltipPlacement.topEnd:
      return Ux4gTooltipPlacement.bottomEnd;
    case Ux4gTooltipPlacement.bottomStart:
      return Ux4gTooltipPlacement.topStart;
    case Ux4gTooltipPlacement.bottom:
      return Ux4gTooltipPlacement.top;
    case Ux4gTooltipPlacement.bottomEnd:
      return Ux4gTooltipPlacement.topEnd;
    default:
      return placement;
  }
}

Ux4gTooltipPlacement _mirrorHorizontal(Ux4gTooltipPlacement placement) {
  switch (placement) {
    case Ux4gTooltipPlacement.leftStart:
      return Ux4gTooltipPlacement.rightStart;
    case Ux4gTooltipPlacement.left:
      return Ux4gTooltipPlacement.right;
    case Ux4gTooltipPlacement.leftEnd:
      return Ux4gTooltipPlacement.rightEnd;
    case Ux4gTooltipPlacement.rightStart:
      return Ux4gTooltipPlacement.leftStart;
    case Ux4gTooltipPlacement.right:
      return Ux4gTooltipPlacement.left;
    case Ux4gTooltipPlacement.rightEnd:
      return Ux4gTooltipPlacement.leftEnd;
    default:
      return placement;
  }
}
