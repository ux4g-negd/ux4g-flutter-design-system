import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';

enum Ux4gToggleSize {
  s(32, 18, 14, 2),
  m(40, 22, 18, 2),
  l(48, 28, 24, 2);

  final double width;
  final double height;
  final double thumbSize;
  final double thumbPadding;
  const Ux4gToggleSize(this.width, this.height, this.thumbSize, this.thumbPadding);
}

enum Ux4gToggleLabelPosition {
  noLabel,
  left,
  right,
  bothSides
}

class Ux4gToggle extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool>? onCheckedChange;
  final String? label;
  final String? description;
  final Ux4gToggleSize size;
  final Ux4gToggleLabelPosition labelPosition;
  final bool enabled;

  const Ux4gToggle({
    super.key,
    required this.checked,
    this.onCheckedChange,
    this.label,
    this.description,
    this.size = Ux4gToggleSize.m,
    this.labelPosition = Ux4gToggleLabelPosition.right,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    // Color definitions
    final checkedTrackColor = colors.primary;
    final uncheckedTrackColor = colors.onSurface.withValues(alpha: 0.3);
    final disabledCheckedTrackColor = colors.primary.withValues(alpha: 0.4);
    final disabledUncheckedTrackColor = colors.onSurface.withValues(alpha: 0.2);

    final trackColor = !enabled && checked
        ? disabledCheckedTrackColor
        : !enabled && !checked
            ? disabledUncheckedTrackColor
            : checked
                ? checkedTrackColor
                : uncheckedTrackColor;

    final thumbColor = colors.surface; // Thumb is always surface color in default setup

    final endOffset = size.width - size.thumbSize - size.thumbPadding;
    final startOffset = size.thumbPadding;

    Widget toggleControl = MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled && onCheckedChange != null ? () => onCheckedChange!(!checked) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(size.height / 2),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                left: checked ? endOffset : startOffset,
                child: Container(
                  width: size.thumbSize,
                  height: size.thumbSize,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: enabled
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            )
                          ]
                        : [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    TextStyle labelStyle;
    TextStyle descStyle;
    switch (size) {
      case Ux4gToggleSize.s:
        labelStyle = typography.lM_default;
        descStyle = typography.lS_default;
        break;
      case Ux4gToggleSize.m:
        labelStyle = typography.lL_default;
        descStyle = typography.lM_default;
        break;
      case Ux4gToggleSize.l:
        labelStyle = typography.lXL_default;
        descStyle = typography.lL_default;
        break;
    }

    Widget textsWidget = const SizedBox.shrink();
    if (label != null || description != null) {
      textsWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null)
            Text(
              label!,
              style: labelStyle.copyWith(
                color: enabled ? colors.onSurface : colors.onSurface.withValues(alpha: 0.38),
              ),
            ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: descStyle.copyWith(
                color: enabled ? colors.onSurface.withValues(alpha: 0.7) : colors.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ],
      );
    }

    if (labelPosition == Ux4gToggleLabelPosition.noLabel) {
      return toggleControl;
    }

    if (labelPosition == Ux4gToggleLabelPosition.bothSides) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: textsWidget),
          const SizedBox(width: 12),
          toggleControl,
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (labelPosition == Ux4gToggleLabelPosition.left) ...[
          textsWidget,
          const SizedBox(width: 12),
          toggleControl,
        ] else ...[
          toggleControl,
          const SizedBox(width: 12),
          textsWidget,
        ],
      ],
    );
  }
}
