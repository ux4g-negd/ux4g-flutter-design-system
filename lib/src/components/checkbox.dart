import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
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
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final descriptionColor = switch (descriptionVariant) {
      Ux4gCheckboxDescriptionVariant.helper => (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
        alpha: 0.7,
      ),
      Ux4gCheckboxDescriptionVariant.error => ux4gColors?.error ?? materialTheme.colorScheme.error,
      Ux4gCheckboxDescriptionVariant.warning => ux4gColors?.warning ?? Colors.orange,
      Ux4gCheckboxDescriptionVariant.success => ux4gColors?.success ?? Colors.green,
    };

    final labelTextStyle = switch (size) {
      Ux4gCheckboxSize.small => ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle(),
      Ux4gCheckboxSize.medium => ux4gTypography?.lL_default ?? materialTheme.textTheme.labelLarge ?? const TextStyle(),
      Ux4gCheckboxSize.large => ux4gTypography?.lXL_default ?? materialTheme.textTheme.labelLarge?.copyWith(fontSize: 16) ?? const TextStyle(),
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
                  activeColor: ux4gColors?.primary ?? materialTheme.colorScheme.primary,
                  checkColor: ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: enabled
                        ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.6)
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12),
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
                                  ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                                  : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                            ),
                          ),
                          if (isRequired) ...[
                            const SizedBox(width: 4),
                            Text(
                              "*",
                              style: labelTextStyle.copyWith(
                                color: ux4gColors?.error ?? materialTheme.colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description!,
                        style: (ux4gTypography?.lS_default ?? materialTheme.textTheme.labelSmall ?? const TextStyle()).copyWith(
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
