import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';

enum Ux4gRadioButtonSize {
  small(16.0, 8.0),
  medium(20.0, 10.0),
  large(24.0, 12.0);

  final double size;
  final double dotSize;
  const Ux4gRadioButtonSize(this.size, this.dotSize);
}

enum Ux4gRadioButtonDescriptionVariant { helper, error, warning, success }

class Ux4gRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? description;
  final Ux4gRadioButtonSize size;
  final bool isRequired;
  final IconData? trailingIcon;
  final Ux4gRadioButtonDescriptionVariant descriptionVariant;
  final bool enabled;

  const Ux4gRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.description,
    this.size = Ux4gRadioButtonSize.medium,
    this.isRequired = false,
    this.trailingIcon,
    this.descriptionVariant = Ux4gRadioButtonDescriptionVariant.helper,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);
    final isSelected = value == groupValue;

    final descriptionColor = switch (descriptionVariant) {
      Ux4gRadioButtonDescriptionVariant.helper => colors.onSurface.withValues(alpha: 0.7),
      Ux4gRadioButtonDescriptionVariant.error => colors.error,
      Ux4gRadioButtonDescriptionVariant.warning => Ux4gPalette.orange700,
      Ux4gRadioButtonDescriptionVariant.success => Ux4gPalette.green700,
    };

    final descriptionIcon = switch (descriptionVariant) {
      Ux4gRadioButtonDescriptionVariant.helper => Icons.info_outline,
      Ux4gRadioButtonDescriptionVariant.error => Icons.error_outline,
      Ux4gRadioButtonDescriptionVariant.warning => Icons.warning_amber_outlined,
      Ux4gRadioButtonDescriptionVariant.success => Icons.check_circle_outline,
    };

    final labelTextStyle = switch (size) {
      Ux4gRadioButtonSize.small => typography.lM_default,
      Ux4gRadioButtonSize.medium => typography.lL_default,
      Ux4gRadioButtonSize.large => typography.lXL_default,
    };

    final descriptionTextStyle = switch (size) {
      Ux4gRadioButtonSize.small => typography.lS_default,
      Ux4gRadioButtonSize.medium => typography.lM_default,
      Ux4gRadioButtonSize.large => typography.lL_default,
    };

    final radioColor = !enabled
        ? colors.onSurface.withValues(alpha: 0.38)
        : isSelected
            ? colors.primary
            : colors.onSurface.withValues(alpha: 0.6);

    return InkWell(
      onTap: enabled ? () => onChanged(value) : null,
      borderRadius: BorderRadius.circular(Ux4gRadius.radius4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                width: size.size,
                height: size.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: radioColor, width: 1.5),
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? Container(
                        width: size.dotSize,
                        height: size.dotSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: radioColor,
                        ),
                      )
                    : null,
              ),
            ),
            if (label != null || description != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (label != null)
                      Row(
                        children: [
                          Text(
                            label!,
                            style: labelTextStyle.copyWith(
                              color: enabled ? colors.onSurface : colors.onSurface.withValues(alpha: 0.38),
                            ),
                          ),
                          if (isRequired) ...[
                            const SizedBox(width: 4),
                            Text('*', style: labelTextStyle.copyWith(color: colors.error)),
                          ],
                          if (trailingIcon != null) ...[
                            const SizedBox(width: 4),
                            Icon(
                              trailingIcon,
                              size: size.size,
                              color: enabled ? colors.onSurface : colors.onSurface.withValues(alpha: 0.38),
                            ),
                          ],
                        ],
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(descriptionIcon, size: 16, color: descriptionColor),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              description!,
                              style: descriptionTextStyle.copyWith(color: descriptionColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


