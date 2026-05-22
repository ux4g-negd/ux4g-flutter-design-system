import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'avatar.dart';

/// Visual variant for [Ux4gAppHeader].
enum Ux4gAppHeaderVariant {
  /// White/surface background with dark text.
  light,

  /// Primary (purple) background with white text/icons.
  filled,

  /// White/surface background with a subtle bottom border.
  outlined,
}

/// A single action item in the header's trailing section.
class Ux4gAppHeaderAction {
  /// Icon to display.
  final IconData icon;

  /// Callback when tapped.
  final VoidCallback? onPressed;

  /// Optional tooltip.
  final String? tooltip;

  /// Optional custom widget (overrides icon).
  final Widget? customWidget;

  const Ux4gAppHeaderAction({
    this.icon = Icons.settings_outlined,
    this.onPressed,
    this.tooltip,
    this.customWidget,
  });
}

/// A configurable app bar / header component for the UX4G Design System.
///
/// Supports:
/// - Leading section: back button, or custom leading widgets (emblem, logo, etc.)
/// - Title
/// - Trailing actions: configurable list of icon buttons or custom widgets
/// - 3 visual variants: [light], [filled], [outlined]
/// - Status bar style auto-adapts to variant
///
/// Default configuration (image 3): emblem + logo + title + settings + hamburger menu.
class Ux4gAppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Title text displayed in the header.
  final String title;

  /// Visual variant.
  final Ux4gAppHeaderVariant variant;

  /// Whether to show a back button as the leading widget.
  /// If true, [leadingWidgets] is ignored.
  final bool showBackButton;

  /// Callback when back button is pressed. Defaults to `Navigator.pop`.
  final VoidCallback? onBackPressed;

  /// Custom leading widgets (e.g., emblem icon, logo).
  /// Ignored when [showBackButton] is true.
  final List<Widget>? leadingWidgets;

  /// List of trailing action items.
  final List<Ux4gAppHeaderAction>? actions;

  /// Optional avatar shown at the trailing end (after actions).
  /// By default uses [Ux4gAvatar]. Pass a [Ux4gAvatar] with desired
  /// properties, or any custom widget.
  final Widget? avatar;

  /// Avatar size when using the default [Ux4gAvatar].
  /// Only used when [avatar] is null but [showAvatar] is true.
  final Ux4gAvatarSize avatarSize;

  /// Whether to show an avatar. When true and [avatar] is null,
  /// a default [Ux4gAvatar] is rendered.
  final bool showAvatar;

  /// Image URL for the default avatar.
  /// Only used when [avatar] is null and [showAvatar] is true.
  final String? avatarImageUrl;

  /// Initials for the default avatar.
  /// Only used when [avatar] is null and [showAvatar] is true.
  final String? avatarInitials;

  /// Callback when the avatar is tapped.
  final VoidCallback? onAvatarPressed;

  /// Custom title widget (overrides [title] text).
  final Widget? titleWidget;

  /// Title text style override.
  final TextStyle? titleStyle;

  /// Background color override.
  final Color? backgroundColor;

  /// Foreground (text/icon) color override.
  final Color? foregroundColor;

  /// Border color for [outlined] variant.
  final Color? borderColor;

  /// Height of the header (excluding status bar).
  final double height;

  /// Horizontal padding.
  final double horizontalPadding;

  /// Spacing between leading widgets.
  final double leadingSpacing;

  /// Spacing between trailing action items.
  final double actionSpacing;

  /// Elevation (shadow depth).
  final double elevation;

  const Ux4gAppHeader({
    super.key,
    this.title = 'Title',
    this.variant = Ux4gAppHeaderVariant.outlined,
    this.showBackButton = false,
    this.onBackPressed,
    this.leadingWidgets,
    this.actions,
    this.avatar,
    this.avatarSize = Ux4gAvatarSize.s,
    this.showAvatar = false,
    this.avatarImageUrl,
    this.avatarInitials,
    this.onAvatarPressed,
    this.titleWidget,
    this.titleStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.height = 56,
    this.horizontalPadding = Ux4gSpace.space12,
    this.leadingSpacing = Ux4gSpace.space8,
    this.actionSpacing = Ux4gSpace.space4,
    this.elevation = 0,
  });

  Color _resolveBackgroundColor(Ux4gColors? ux4gColors, ThemeData materialTheme) {
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case Ux4gAppHeaderVariant.light:
      case Ux4gAppHeaderVariant.outlined:
        return ux4gColors?.surface ?? materialTheme.colorScheme.surface;
      case Ux4gAppHeaderVariant.filled:
        return ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    }
  }

  Color _resolveForegroundColor(Ux4gColors? ux4gColors, ThemeData materialTheme) {
    if (foregroundColor != null) return foregroundColor!;
    switch (variant) {
      case Ux4gAppHeaderVariant.light:
      case Ux4gAppHeaderVariant.outlined:
        return ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
      case Ux4gAppHeaderVariant.filled:
        return ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final bg = _resolveBackgroundColor(ux4gColors, materialTheme);
    final fg = _resolveForegroundColor(ux4gColors, materialTheme);

    final resolvedTitleStyle =
        titleStyle ??
        (ux4gTypography?.tS_strong ?? materialTheme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
          color: fg,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );

    // Build leading section
    Widget? leadingSection;
    if (showBackButton) {
      leadingSection = _HeaderIconButton(
        icon: Icons.arrow_back,
        color: fg,
        onPressed: onBackPressed ?? () => Navigator.maybePop(context),
      );
    } else if (leadingWidgets != null && leadingWidgets!.isNotEmpty) {
      leadingSection = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < leadingWidgets!.length; i++) ...[
            if (i > 0) SizedBox(width: leadingSpacing),
            leadingWidgets![i],
          ],
        ],
      );
    }

    // Build avatar widget
    Widget? avatarWidget;
    if (avatar != null) {
      avatarWidget = GestureDetector(onTap: onAvatarPressed, child: avatar);
    } else if (showAvatar) {
      avatarWidget = GestureDetector(
        onTap: onAvatarPressed,
        child: Ux4gAvatar(
          size: avatarSize,
          imageUrl: avatarImageUrl,
          initials: avatarInitials,
        ),
      );
    }

    // Build trailing section
    Widget? trailingSection;
    final hasActions = actions != null && actions!.isNotEmpty;
    final hasAvatar = avatarWidget != null;

    if (hasActions || hasAvatar) {
      trailingSection = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasActions)
            for (int i = 0; i < actions!.length; i++) ...[
              if (i > 0) SizedBox(width: actionSpacing),
              actions![i].customWidget ??
                  _HeaderIconButton(
                    icon: actions![i].icon,
                    color: fg,
                    onPressed: actions![i].onPressed,
                    tooltip: actions![i].tooltip,
                  ),
            ],
          if (hasActions && hasAvatar) SizedBox(width: actionSpacing),
          if (hasAvatar) avatarWidget,
        ],
      );
    }

    // Bottom border for outlined variant
    final bottomBorder = variant == Ux4gAppHeaderVariant.outlined
        ? Border(
            bottom: BorderSide(
              color: borderColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12),
              width: 1,
            ),
          )
        : null;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: bottomBorder,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation,
                  offset: Offset(0, elevation / 2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              children: [
                // Leading
                if (leadingSection != null) ...[
                  leadingSection,
                  SizedBox(width: leadingSpacing),
                ],

                // Title
                Expanded(
                  child:
                      titleWidget ??
                      Text(
                        title,
                        style: resolvedTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),

                // Trailing actions
                if (trailingSection != null) ...[
                  SizedBox(width: actionSpacing),
                  trailingSection,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Internal icon button with consistent sizing.
class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;

  const _HeaderIconButton({
    required this.icon,
    required this.color,
    this.onPressed,
    this.tooltip,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: Icon(icon, color: color, size: size),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
