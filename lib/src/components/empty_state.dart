import 'package:flutter/material.dart';
import '../foundation/dimensions.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'buttons.dart';

/// Semantic preset for [Ux4gEmptyState].
///
/// Each variant pre-configures a default icon that matches its meaning.
/// Every property can still be overridden via the widget's named parameters.
enum Ux4gEmptyStateVariant {
  /// Search returned no results.
  noResults,

  /// The list / inbox is empty — no items to show.
  noData,

  /// Feature is not yet available.
  comingSoon,

  /// Data could not be loaded (network / server error).
  error,

  /// Fully custom — no pre-configured values are applied.
  custom,
}

/// A flexible empty-state widget that follows the UX4G design system.
///
/// Displays an icon, a bold header, up to two secondary text lines, and an
/// optional action button with a filled tonal style.
///
/// ### Quick usage
/// ```dart
/// Ux4gEmptyState(
///   variant: Ux4gEmptyStateVariant.noResults,
///   title: 'No results found',
///   subtitle: 'Did you mean: Driving License, Ration Card',
///   buttonText: 'Clear all filters',
///   onButtonPressed: () {},
/// )
/// ```
class Ux4gEmptyState extends StatelessWidget {
  /// Semantic preset that controls the default icon.
  final Ux4gEmptyStateVariant variant;

  // ── Icon ────────────────────────────────────────────────────────────────
  /// Override the icon. Falls back to the variant's default when `null`.
  final IconData? icon;

  /// Size of the icon. Defaults to `48`.
  final double? iconSize;

  /// Colour of the icon. Defaults to `colors.primary`.
  final Color? iconColor;

  // ── Text ────────────────────────────────────────────────────────────────
  /// Bold header line shown directly below the icon.
  final String title;

  /// Second (child) text line. Optional.
  final String? subtitle;

  /// Third (child) text line. Optional.
  final String? description;

  /// Override the title [TextStyle]. Defaults to `hXXS_strong`.
  final TextStyle? titleStyle;

  /// Override the subtitle / description [TextStyle]. Defaults to `bS_default`.
  final TextStyle? bodyStyle;

  // ── Button ──────────────────────────────────────────────────────────────
  /// Label for the action button. Pass `null` to hide the button entirely.
  final String? buttonText;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onButtonPressed;

  /// Size of the button. Defaults to [Ux4gButtonSize.small].
  final Ux4gButtonSize buttonSize;

  /// Leading icon shown on the button. Optional.
  final IconData? buttonLeadingIcon;

  // ── Layout ──────────────────────────────────────────────────────────────
  /// Padding around the whole widget. Defaults to `EdgeInsets.all(24)`.
  final EdgeInsetsGeometry? padding;

  /// Horizontal padding applied to subtitle / description for a narrower read
  /// width. Defaults to `24` on each side.
  final double bodyHorizontalPadding;

  const Ux4gEmptyState({
    super.key,
    this.variant = Ux4gEmptyStateVariant.custom,
    this.icon,
    this.iconSize,
    this.iconColor,
    required this.title,
    this.subtitle,
    this.description,
    this.titleStyle,
    this.bodyStyle,
    this.buttonText,
    this.onButtonPressed,
    this.buttonSize = Ux4gButtonSize.small,
    this.buttonLeadingIcon,
    this.padding,
    this.bodyHorizontalPadding = 24,
  });

  // ── Variant defaults ─────────────────────────────────────────────────────

  static const Map<Ux4gEmptyStateVariant, IconData> _variantIcons = {
    Ux4gEmptyStateVariant.noResults: Icons.search_off_rounded,
    Ux4gEmptyStateVariant.noData: Icons.inbox_outlined,
    Ux4gEmptyStateVariant.comingSoon: Icons.rocket_launch_outlined,
    Ux4gEmptyStateVariant.error: Icons.error_outline_rounded,
    Ux4gEmptyStateVariant.custom: Icons.info_outline,
  };

  @override
  Widget build(BuildContext context) {
    final uxColors = Theme.of(context).extension<Ux4gColors>();
    final uxTypography = Theme.of(context).extension<Ux4gTypography>();
    final materialTheme = Theme.of(context);

    final effectiveIcon = icon ?? _variantIcons[variant]!;
    final effectiveIconColor = iconColor ?? uxColors?.primary ?? materialTheme.colorScheme.primary;
    final effectiveIconSize = iconSize ?? 48.0;

    final effectiveTitleStyle =
        titleStyle ??
        (uxTypography?.hXXS_strong ?? materialTheme.textTheme.headlineSmall)?.copyWith(color: uxColors?.onBackground ?? materialTheme.colorScheme.onSurface);
    final effectiveBodyStyle =
        bodyStyle ??
        (uxTypography?.bS_default ?? materialTheme.textTheme.bodyMedium)?.copyWith(
          color: (uxColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.6),
        );

    // Tonal button: filled light-primary background, primary-coloured text.
    final buttonBg = (uxColors?.primary ?? materialTheme.colorScheme.primary).withValues(alpha: 0.12);
    final buttonFg = uxColors?.primary ?? materialTheme.colorScheme.primary;

    return Padding(
      padding: padding ?? const EdgeInsets.all(Ux4gSpace.space24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Icon (no background) ────────────────────────────────────────
          Icon(
            effectiveIcon,
            size: effectiveIconSize,
            color: effectiveIconColor,
          ),

          const SizedBox(height: Ux4gSpace.space16),

          // ── Bold header ─────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: bodyHorizontalPadding),
            child: Text(
              title,
              style: effectiveTitleStyle,
              textAlign: TextAlign.center,
            ),
          ),

          // ── Child text lines (combined on one line) ──────────────────────
          if (subtitle != null || description != null) ...[
            const SizedBox(height: Ux4gSpace.space8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: bodyHorizontalPadding),
              child: Text(
                [
                  if (subtitle != null) subtitle,
                  if (description != null) description,
                ].join(' '),
                style: effectiveBodyStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],

          // ── Action button (always filled tonal) ─────────────────────────
          if (buttonText != null) ...[
            const SizedBox(height: Ux4gSpace.space16),
            Ux4gButton(
              onPressed: onButtonPressed,
              text: buttonText,
              variant: Ux4gButtonVariant.primary,
              backgroundColor: buttonBg,
              contentColor: buttonFg,
              size: buttonSize,
              leadingIcon: buttonLeadingIcon,
            ),
          ],
        ],
      ),
    );
  }
}
