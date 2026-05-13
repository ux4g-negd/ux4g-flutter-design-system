import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../theme/theme.dart';

enum Ux4gCheckboxSize {
  small(16),
  medium(20),
  large(24);

  final double size;
  const Ux4gCheckboxSize(this.size);
}

enum Ux4gCheckboxDescriptionVariant { helper, error, warning, success }

class Ux4gCheckbox extends StatelessWidget {
  final bool? value; // true = On, false = Off, null = Indeterminate
  final ValueChanged<bool?> onChanged;
  final String? label;
  final String? description;
  final Ux4gCheckboxSize size;
  final bool isRequired;
  final Ux4gCheckboxDescriptionVariant descriptionVariant;
  final bool enabled;

  const Ux4gCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.size = Ux4gCheckboxSize.medium,
    this.isRequired = false,
    this.descriptionVariant = Ux4gCheckboxDescriptionVariant.helper,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final descriptionColor = switch (descriptionVariant) {
      Ux4gCheckboxDescriptionVariant.helper => colors.onSurface.withValues(
        alpha: 0.7,
      ),
      Ux4gCheckboxDescriptionVariant.error => colors.error,
      Ux4gCheckboxDescriptionVariant.warning => Ux4gPalette.secondary700,
      Ux4gCheckboxDescriptionVariant.success => Ux4gPalette.green600,
    };

    final labelTextStyle = switch (size) {
      Ux4gCheckboxSize.small => typography.lM_default,
      Ux4gCheckboxSize.medium => typography.lL_default,
      Ux4gCheckboxSize.large => typography.lXL_default,
    };

    return InkWell(
      onTap: enabled ? () => onChanged(value == null ? true : !value!) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SizedBox(
                width: size.size,
                height: size.size,
                child: Checkbox(
                  value: value,
                  tristate: true,
                  onChanged: enabled ? onChanged : null,
                  activeColor: colors.primary,
                  checkColor: colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: enabled
                        ? colors.onSurface.withValues(alpha: 0.6)
                        : colors.onSurface.withValues(alpha: 0.12),
                    width: 1.5,
                  ),
                ),
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
                              color: enabled
                                  ? colors.onSurface
                                  : colors.onSurface.withValues(alpha: 0.38),
                            ),
                          ),
                          if (isRequired) ...[
                            const SizedBox(width: 4),
                            Text(
                              "*",
                              style: labelTextStyle.copyWith(
                                color: colors.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description!,
                        style: typography.lS_default.copyWith(
                          color: descriptionColor,
                        ),
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
