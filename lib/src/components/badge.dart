import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum Ux4gBadgeLimit {
  singleDigit, // 9+
  doubleDigit, // 99+
}

enum _Ux4gBadgeInternalType { dot, text, label, icon, readyToUse }

class Ux4gBadge extends StatelessWidget {
  final Widget? child;
  final _Ux4gBadgeInternalType _type;
  final String? label;
  final int? count;
  final Ux4gBadgeLimit limit;
  final IconData? icon;
  final String? assetPath;
  final Color? containerColor;
  final Color? contentColor;
  final AlignmentGeometry alignment;

  const Ux4gBadge.dot({
    super.key,
    this.child,
    this.containerColor,
    this.alignment = Alignment.topRight,
  }) : _type = _Ux4gBadgeInternalType.dot,
       label = null,
       count = null,
       limit = Ux4gBadgeLimit.singleDigit,
       icon = null,
       assetPath = null,
       contentColor = null;

  const Ux4gBadge.count(
    this.count, {
    super.key,
    this.child,
    this.limit = Ux4gBadgeLimit.singleDigit,
    this.containerColor,
    this.contentColor,
    this.alignment = Alignment.topRight,
  }) : _type = _Ux4gBadgeInternalType.text,
       label = null,
       icon = null,
       assetPath = null;

  const Ux4gBadge.label(
    this.label, {
    super.key,
    this.child,
    this.containerColor,
    this.contentColor,
    this.alignment = Alignment.topRight,
  }) : _type = _Ux4gBadgeInternalType.label,
       count = null,
       limit = Ux4gBadgeLimit.singleDigit,
       icon = null,
       assetPath = null;

  const Ux4gBadge.icon(
    this.icon, {
    super.key,
    this.child,
    this.containerColor,
    this.contentColor,
    this.alignment = Alignment.topRight,
  }) : _type = _Ux4gBadgeInternalType.icon,
       label = null,
       count = null,
       limit = Ux4gBadgeLimit.singleDigit,
       assetPath = null;

  const Ux4gBadge.readyToUse(
    this.assetPath, {
    super.key,
    this.child,
    this.contentColor,
    this.alignment = Alignment.topRight,
  }) : _type = _Ux4gBadgeInternalType.readyToUse,
       label = null,
       count = null,
       limit = Ux4gBadgeLimit.singleDigit,
       icon = null,
       containerColor = null;

  @override
  Widget build(BuildContext context) {
    if (child == null) {
      return _buildBadge(context);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          // Adjust position so it sits on the edge
          right: alignment == Alignment.topRight ? -4 : null,
          top: alignment == Alignment.topRight ? -4 : null,
          left: alignment == Alignment.topLeft ? -4 : null,
          bottom: alignment == Alignment.bottomRight ? -4 : null,
          child: _buildBadge(context),
        ),
      ],
    );
  }

  Widget _buildBadge(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    if (_type == _Ux4gBadgeInternalType.readyToUse) {
      return Image.asset(
        assetPath!,
        width: 24,
        height: 24,
        color: contentColor,
      );
    }

    final resolvedBg = containerColor ?? colors.primary;
    final resolvedContent = contentColor ?? Colors.white;

    switch (_type) {
      case _Ux4gBadgeInternalType.dot:
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: resolvedBg, shape: BoxShape.circle),
        );
      case _Ux4gBadgeInternalType.text:
        if (count == null) return const SizedBox.shrink();
        final displayCount = limit == Ux4gBadgeLimit.singleDigit
            ? (count! > 9 ? "9+" : count.toString())
            : (count! > 99 ? "99+" : count.toString());

        return Container(
          constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: resolvedBg,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            displayCount,
            style: typography.lS_strong.copyWith(
              color: resolvedContent,
              fontSize: 10,
              height: 1,
            ),
          ),
        );
      case _Ux4gBadgeInternalType.label:
        if (label == null) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: resolvedBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label!,
            style: typography.lS_strong.copyWith(
              color: resolvedContent,
              height: 1,
            ),
          ),
        );
      case _Ux4gBadgeInternalType.icon:
        if (icon == null) return const SizedBox.shrink();
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: resolvedBg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(icon, size: 12, color: resolvedContent),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
