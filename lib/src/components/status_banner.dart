import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'buttons.dart';

enum Ux4gBannerVariant {
  warningLight,
  warningSolid,
  errorLight,
  successLight,
  savingLight,
}

class Ux4gStatusBanner extends StatelessWidget {
  final Ux4gBannerVariant variant;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final String? subtitle;
  final Widget? badge;
  final List<Widget>? actions;
  final VoidCallback? onDismiss;

  const Ux4gStatusBanner({
    super.key,
    required this.variant,
    required this.title,
    this.subtitle,
    this.badge,
    this.leadingIcon,
    this.trailingIcon,
    this.actions,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final warning = ux4gColors?.warning ?? materialTheme.colorScheme.tertiary;
    final onWarning = ux4gColors?.onWarning ?? materialTheme.colorScheme.onTertiary;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final success = ux4gColors?.success ?? materialTheme.colorScheme.primary;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onBackground = ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;

    final bMStrong = ux4gTypography?.bM_strong ?? materialTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle();
    final bMDefault = ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle();

    // Determine colors based on variant
    Color backgroundColor;
    Color textColor = onSurface;
    Color subtitleColor = onSurface.withValues(alpha: 0.6);

    switch (variant) {
      case Ux4gBannerVariant.warningLight:
        backgroundColor = Color.lerp(surface, warning, 0.12)!;
        break;
      case Ux4gBannerVariant.warningSolid:
        backgroundColor = warning;
        textColor = onWarning;
        subtitleColor = onWarning.withValues(alpha: 0.7);
        break;
      case Ux4gBannerVariant.errorLight:
        backgroundColor = Color.lerp(surface, error, 0.12)!;
        break;
      case Ux4gBannerVariant.successLight:
        backgroundColor = Color.lerp(surface, success, 0.12)!;
        break;
      case Ux4gBannerVariant.savingLight:
        backgroundColor = Color.lerp(surface, primary, 0.12)!;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: onBackground.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 500;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: subtitle != null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 12,
                          runSpacing: 6,
                          children: [
                            Text(
                              title,
                              style: bMStrong.copyWith(
                                color: textColor,
                              ),
                            ),
                            if (badge != null) badge!,
                          ],
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle!,
                            style: bMDefault.copyWith(
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 16),
                    trailingIcon!,
                  ],
                  if (!isMobile && actions != null && actions!.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!.map((action) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: action,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
              if (isMobile && actions != null && actions!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 12,
                  runSpacing: 12,
                  children: actions!,
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// A service to show top snackbars (banners) overlaying the screen.
class Ux4gBannerManager {
  static OverlayEntry? _currentEntry;
  static AnimationController? _animationController;

  static void show(
    BuildContext context, {
    required Ux4gBannerVariant variant,
    required String title,
    String? subtitle,
    Widget? badge,
    Widget? leadingIcon,
    Widget? trailingIcon,
    List<Widget>? actions,
    Duration duration = const Duration(seconds: 4),
    bool autoDismiss = true,
  }) {
    // Dismiss existing
    hide();

    final overlay = Overlay.of(context);

    // Setup animation controller manually using a TickerProvider from the context if possible,
    // but since this is static, we'll use an implicit animation widget like AnimatedPositioned or TweenAnimationBuilder.

    final entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: -100.0, end: 0.0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value),
                  child: Opacity(
                    opacity: (1 - (value / -100)).clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: Ux4gStatusBanner(
                variant: variant,
                title: title,
                subtitle: subtitle,
                badge: badge,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                actions: actions,
                onDismiss: hide,
              ),
            ),
          ),
        );
      },
    );

    _currentEntry = entry;
    overlay.insert(entry);

    if (autoDismiss) {
      Future.delayed(duration, () {
        if (_currentEntry == entry) {
          hide();
        }
      });
    }
  }

  static void hide() {
    _currentEntry?.remove();
    _currentEntry = null;
  }
}
