import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

enum Ux4gToggleSize {
  s(32, 18, 14, 2),
  m(40, 22, 18, 2),
  l(48, 28, 24, 2);

  final double width;
  final double height;
  final double thumbSize;
  final double thumbPadding;
  const Ux4gToggleSize(
    this.width,
    this.height,
    this.thumbSize,
    this.thumbPadding,
  );
}

enum Ux4gToggleLabelPosition { noLabel, left, right, bothSides }

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
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    // Color definitions
    final checkedTrackColor = primary;
    final uncheckedTrackColor = onSurface.withValues(alpha: 0.3);
    final disabledCheckedTrackColor = primary.withValues(alpha: 0.4);
    final disabledUncheckedTrackColor = onSurface.withValues(alpha: 0.2);

    final trackColor = !enabled && checked
        ? disabledCheckedTrackColor
        : !enabled && !checked
        ? disabledUncheckedTrackColor
        : checked
        ? checkedTrackColor
        : uncheckedTrackColor;

    final thumbColor = surface; // Thumb is always surface color in default setup

    final endOffset = size.width - size.thumbSize - size.thumbPadding;
    final startOffset = size.thumbPadding;

    Widget toggleControl = MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled && onCheckedChange != null
            ? () => onCheckedChange!(!checked)
            : null,
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
                            ),
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
    
    final lMDefault = ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle();
    final lSDefault = ux4gTypography?.lS_default ?? materialTheme.textTheme.labelSmall ?? const TextStyle();
    final lLDefault = ux4gTypography?.lL_default ?? materialTheme.textTheme.labelLarge ?? const TextStyle();
    final lXLDefault = ux4gTypography?.lXL_default ?? materialTheme.textTheme.labelLarge?.copyWith(fontSize: 16) ?? const TextStyle();

    switch (size) {
      case Ux4gToggleSize.s:
        labelStyle = lMDefault;
        descStyle = lSDefault;
        break;
      case Ux4gToggleSize.m:
        labelStyle = lLDefault;
        descStyle = lMDefault;
        break;
      case Ux4gToggleSize.l:
        labelStyle = lXLDefault;
        descStyle = lLDefault;
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
                color: enabled
                    ? onSurface
                    : onSurface.withValues(alpha: 0.38),
              ),
            ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: descStyle.copyWith(
                color: enabled
                    ? onSurface.withValues(alpha: 0.7)
                    : onSurface.withValues(alpha: 0.38),
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
