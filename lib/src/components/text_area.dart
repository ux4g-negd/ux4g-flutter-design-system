import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'input_field.dart';

enum Ux4gTextAreaSize { small, large }

enum Ux4gTextAreaMinHeight {
  small(80),
  medium(120),
  large(160);

  final double height;
  const Ux4gTextAreaMinHeight(this.height);
}

class Ux4gTextArea extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final Ux4gTextAreaSize size;
  final Ux4gTextAreaMinHeight minHeight;
  final Ux4gInputFieldStatus status;
  final String? label;
  final bool required;
  final String? placeholder;
  final String? caption;
  final bool showCaptionIcon;
  final IconData? trailingIconLabel;
  final String? characterCountText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;

  const Ux4gTextArea({
    super.key,
    required this.value,
    required this.onValueChange,
    this.size = Ux4gTextAreaSize.large,
    this.minHeight = Ux4gTextAreaMinHeight.medium,
    this.status = Ux4gInputFieldStatus.defaultStatus,
    this.label,
    this.required = false,
    this.placeholder,
    this.caption,
    this.showCaptionIcon = true,
    this.trailingIconLabel,
    this.characterCountText,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final borderColor = _getBorderColor(colors);
    final bgColor = enabled ? colors.surface : colors.onSurface.withValues(alpha: 0.05);
    final textColor = enabled ? colors.onBackground : colors.onSurface.withValues(alpha: 0.4);
    final labelColor = _getLabelColor(colors);
    final captionColor = _getCaptionColor(colors);

    final contentPadding = size == Ux4gTextAreaSize.large ? 16.0 : 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(label!, style: typography.bM_strong.copyWith(color: labelColor)),
              if (required) ...[
                const SizedBox(width: 4),
                Text("*", style: typography.bM_strong.copyWith(color: colors.error)),
              ],
              if (trailingIconLabel != null) ...[
                const SizedBox(width: 4),
                Icon(trailingIconLabel, size: 16, color: colors.onSurface.withValues(alpha: 0.5)),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          constraints: BoxConstraints(minHeight: minHeight.height),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
            border: Border.all(color: borderColor, width: 1),
          ),
          padding: EdgeInsets.all(contentPadding),
          child: Stack(
            children: [
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  ),
                ),
                onChanged: onValueChange,
                enabled: enabled,
                readOnly: readOnly,
                maxLines: null,
                maxLength: maxLength,
                style: typography.bM_default.copyWith(color: textColor),
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle: typography.bM_default.copyWith(color: colors.onSurface.withValues(alpha: 0.4)),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  counterText: "", // Hide default counter
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (characterCountText != null)
                      Text(
                        characterCountText!,
                        style: typography.bXS_default.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
                      ),
                    const SizedBox(width: 4),
                    Text(
                      "◢",
                      style: typography.bS_default.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (caption != null || status == Ux4gInputFieldStatus.error) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              if (showCaptionIcon) ...[
                Icon(_getStatusIcon() ?? Icons.info_outline, size: 14, color: captionColor),
                const SizedBox(width: 6),
              ],
              Text(caption ?? "", style: typography.bXS_default.copyWith(color: captionColor)),
            ],
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(Ux4gColors colors) {
    if (!enabled) return colors.onSurface.withValues(alpha: 0.3);
    return switch (status) {
      Ux4gInputFieldStatus.error => colors.error,
      Ux4gInputFieldStatus.warning => colors.secondary,
      Ux4gInputFieldStatus.success => Ux4gPalette.green500,
      Ux4gInputFieldStatus.defaultStatus => colors.onSurface.withValues(alpha: 0.3),
    };
  }

  Color _getLabelColor(Ux4gColors colors) {
    if (!enabled) return colors.onSurface.withValues(alpha: 0.4);
    return switch (status) {
      Ux4gInputFieldStatus.error => colors.error,
      Ux4gInputFieldStatus.warning => colors.secondary,
      Ux4gInputFieldStatus.success => Ux4gPalette.green500,
      Ux4gInputFieldStatus.defaultStatus => colors.onBackground,
    };
  }

  Color _getCaptionColor(Ux4gColors colors) {
    if (!enabled) return colors.onSurface.withValues(alpha: 0.4);
    return switch (status) {
      Ux4gInputFieldStatus.error => colors.error,
      Ux4gInputFieldStatus.warning => colors.secondary,
      Ux4gInputFieldStatus.success => Ux4gPalette.green500,
      Ux4gInputFieldStatus.defaultStatus => colors.onSurface.withValues(alpha: 0.6),
    };
  }

  IconData? _getStatusIcon() {
    return switch (status) {
      Ux4gInputFieldStatus.error => Icons.error,
      Ux4gInputFieldStatus.warning => Icons.warning,
      Ux4gInputFieldStatus.success => Icons.check_circle,
      Ux4gInputFieldStatus.defaultStatus => null,
    };
  }
}
