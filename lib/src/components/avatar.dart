import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../theme/theme.dart';

enum Ux4gAvatarSize {
  xs(24, 10, 14),
  s(32, 14, 16),
  m(40, 16, 20),
  l(48, 20, 24),
  xl(64, 24, 32),
  xxl(80, 32, 40),
  xxxl(120, 48, 60);

  final double size;
  final double fontSize;
  final double iconSize;

  const Ux4gAvatarSize(this.size, this.fontSize, this.iconSize);
}

class Ux4gAvatar extends StatelessWidget {
  final Ux4gAvatarSize size;
  final ShapeBorder shape;
  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final Color? containerColor;
  final Color? contentColor;
  final Color? iconColor;

  const Ux4gAvatar({
    super.key,
    this.size = Ux4gAvatarSize.m,
    this.shape = const CircleBorder(),
    this.imageUrl,
    this.initials,
    this.icon = Icons.person,
    this.containerColor,
    this.contentColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final finalContainerColor = containerColor ?? colors.primary.withValues(alpha: 0.1);
    final finalContentColor = contentColor ?? colors.primary;
    final finalIconColor = iconColor ?? colors.primary;

    return Container(
      width: size.size,
      height: size.size,
      decoration: ShapeDecoration(
        color: finalContainerColor,
        shape: shape,
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: _buildContent(context, typography, finalContentColor, finalIconColor),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic typography, Color contentColor, Color iconColor) {
    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: size.size,
        height: size.size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(typography, contentColor, iconColor),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Icon(Icons.person, size: size.iconSize, color: iconColor);
        },
      );
    }
    return _buildFallback(typography, contentColor, iconColor);
  }

  Widget _buildFallback(dynamic typography, Color contentColor, Color iconColor) {
    if (initials != null && initials!.isNotEmpty) {
      return Text(
        initials!.substring(0, initials!.length > 2 ? 2 : initials!.length).toUpperCase(),
        style: typography.bM_default.copyWith(
          fontSize: size.fontSize,
          fontWeight: FontWeight.w500,
          color: contentColor,
        ),
      );
    }
    return Icon(icon ?? Icons.person, size: size.iconSize, color: iconColor);
  }
}

// --- Avatar Group ---

class Ux4gAvatarGroupItem {
  final String? imageUrl;
  final String? initials;
  final IconData? icon;
  final VoidCallback? onClick;

  const Ux4gAvatarGroupItem({
    this.imageUrl,
    this.initials,
    this.icon = Icons.person,
    this.onClick,
  });
}

class Ux4gAvatarGroup extends StatelessWidget {
  final List<Ux4gAvatarGroupItem> items;
  final Ux4gAvatarSize size;
  final int? maxLimit;
  final bool collapsed;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onRemainingClick;

  const Ux4gAvatarGroup({
    super.key,
    required this.items,
    this.size = Ux4gAvatarSize.m,
    this.maxLimit,
    this.collapsed = true,
    this.borderColor,
    this.borderWidth = 2,
    this.onRemainingClick,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final colors = Ux4gTheme.colors(context);
    final resolvedBorderColor = borderColor ?? colors.surface;
    final actualLimit = maxLimit ?? items.length;
    final exceedsLimit = items.length > actualLimit;
    final visibleItems = exceedsLimit ? items.take(actualLimit - 1).toList() : items;
    final remainingCount = exceedsLimit ? items.length - (actualLimit - 1) : 0;

    final double overlap = collapsed ? -(size.size * 0.25) : 8.0;

    return Wrap(
      spacing: overlap,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...visibleItems.asMap().entries.map((entry) {
          final item = entry.value;
          return GestureDetector(
            onTap: item.onClick,
            child: _buildGroupAvatar(
              Ux4gAvatar(
                size: size,
                imageUrl: item.imageUrl,
                initials: item.initials,
                icon: item.icon,
              ),
              resolvedBorderColor,
            ),
          );
        }),
        if (remainingCount > 0)
          GestureDetector(
            onTap: onRemainingClick,
            child: _buildGroupAvatar(
              Ux4gAvatar(
                size: size,
                initials: "+$remainingCount",
              ),
              resolvedBorderColor,
            ),
          ),
      ],
    );
  }

  Widget _buildGroupAvatar(Widget avatar, Color resolvedBorderColor) {
    if (!collapsed) return avatar;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: resolvedBorderColor, width: borderWidth),
      ),
      child: avatar,
    );
  }
}

// --- Profile Avatar ---

enum Ux4gProfileBadge { verified, star, admin }

enum Ux4gProfileAction { edit, camera, remove }

class Ux4gProfileAvatar extends StatelessWidget {
  final Ux4gAvatarSize size;
  final String? imageUrl;
  final String? initials;
  final IconData? avatarIcon;
  final dynamic variant; // Ux4gProfileBadge or Ux4gProfileAction
  final double? badgeSize;
  final VoidCallback? onVariantClick;

  const Ux4gProfileAvatar({
    super.key,
    this.size = Ux4gAvatarSize.m,
    this.imageUrl,
    this.initials,
    this.avatarIcon,
    this.variant,
    this.badgeSize,
    this.onVariantClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final indicatorSize = badgeSize ?? _getIndicatorSize();

    return Stack(
      children: [
        Ux4gAvatar(
          size: size,
          imageUrl: imageUrl,
          initials: initials,
          icon: avatarIcon,
        ),
        if (variant != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onVariantClick,
              child: _buildVariant(colors, indicatorSize),
            ),
          ),
      ],
    );
  }

  double _getIndicatorSize() {
    return switch (size) {
      Ux4gAvatarSize.xs => 12,
      Ux4gAvatarSize.s => 14,
      Ux4gAvatarSize.m => 16,
      Ux4gAvatarSize.l => 18,
      Ux4gAvatarSize.xl => 24,
      Ux4gAvatarSize.xxl => 30,
      Ux4gAvatarSize.xxxl => 42,
    };
  }

  Widget _buildVariant(Ux4gColors colors, double size) {
    if (variant is Ux4gProfileBadge) {
      final icon = switch (variant as Ux4gProfileBadge) {
        Ux4gProfileBadge.verified => Icons.verified,
        Ux4gProfileBadge.star => Icons.stars,
        Ux4gProfileBadge.admin => Icons.shield,
      };
      return Icon(icon, size: size, color: Colors.blue);
    } else if (variant is Ux4gProfileAction) {
      final icon = switch (variant as Ux4gProfileAction) {
        Ux4gProfileAction.edit => Icons.edit,
        Ux4gProfileAction.camera => Icons.camera_alt,
        Ux4gProfileAction.remove => Icons.remove_circle,
      };
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: size * 0.8, color: colors.onSurface),
      );
    }
    return const SizedBox.shrink();
  }
}

// --- Status Avatar ---

enum Ux4gStatusVariant { online, offline, busy, success, error, warning }

class Ux4gStatusAvatar extends StatelessWidget {
  final Ux4gAvatarSize size;
  final String? imageUrl;
  final String? initials;
  final IconData? avatarIcon;
  final Ux4gStatusVariant variant;
  final double? statusSize;

  const Ux4gStatusAvatar({
    super.key,
    this.size = Ux4gAvatarSize.m,
    this.imageUrl,
    this.initials,
    this.avatarIcon,
    this.variant = Ux4gStatusVariant.online,
    this.statusSize,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final indicatorSize = statusSize ?? _getStatusIndicatorSize();

    return Stack(
      children: [
        Ux4gAvatar(
          size: size,
          imageUrl: imageUrl,
          initials: initials,
          icon: avatarIcon,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: indicatorSize,
            height: indicatorSize,
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                color: _getStatusColor(colors),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  double _getStatusIndicatorSize() {
    return switch (size) {
      Ux4gAvatarSize.xs => 10,
      Ux4gAvatarSize.s => 12,
      Ux4gAvatarSize.m => 14,
      Ux4gAvatarSize.l => 16,
      Ux4gAvatarSize.xl => 20,
      Ux4gAvatarSize.xxl => 24,
      Ux4gAvatarSize.xxxl => 34,
    };
  }

  Color _getStatusColor(Ux4gColors colors) {
    return switch (variant) {
      Ux4gStatusVariant.online => colors.success,
      Ux4gStatusVariant.offline => colors.onSurface.withValues(alpha: 0.5),
      Ux4gStatusVariant.busy => colors.error,
      Ux4gStatusVariant.success => colors.success,
      Ux4gStatusVariant.error => colors.error,
      Ux4gStatusVariant.warning => colors.warning,
    };
  }
}
