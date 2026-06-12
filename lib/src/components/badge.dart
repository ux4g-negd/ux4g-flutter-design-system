import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

enum Ux4gBadgeLimit {
  singleDigit, // 9+
  doubleDigit, // 99+
}

enum Ux4gBadgeColor {
  brand,
  information,
  success,
  warning,
  destructive,
  disabled,
}

enum _Ux4gBadgeInternalType { dot, text, label, icon, readyToUse }

class Ux4gBadge extends StatelessWidget {
  static const bool _useFigmaSpec = false;

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
  final Ux4gBadgeColor? badgeColor;
  final double borderWidth;
  final Color? borderColor;
  final bool hideWhenZero;

  const Ux4gBadge.dot({
    super.key,
    this.child,
    this.containerColor,
    this.alignment = Alignment.topRight,
    this.badgeColor,
    this.borderWidth = 0,
    this.borderColor,
    this.hideWhenZero = false,
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
    this.badgeColor,
    this.borderWidth = 0,
    this.borderColor,
    this.hideWhenZero = false,
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
    this.badgeColor,
    this.borderWidth = 0,
    this.borderColor,
    this.hideWhenZero = false,
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
    this.badgeColor,
    this.borderWidth = 0,
    this.borderColor,
    this.hideWhenZero = false,
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
    this.badgeColor,
    this.borderWidth = 0,
    this.borderColor,
    this.hideWhenZero = false,
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
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    if (_type == _Ux4gBadgeInternalType.readyToUse) {
      return Image.asset(
        assetPath!,
        width: 24,
        height: 24,
        color: contentColor,
      );
    }

    if (_type == _Ux4gBadgeInternalType.text &&
        hideWhenZero &&
        (count ?? 0) <= 0) {
      return const SizedBox.shrink();
    }

    final mappedBg = _mapBackgroundColor(ux4gColors);
    final mappedContent = _mapContentColor(ux4gColors);
    final resolvedBg =
        containerColor ??
        mappedBg ??
        (ux4gColors?.primary ?? materialTheme.colorScheme.primary);
    final resolvedContent = contentColor ?? mappedContent ?? Colors.white;
    final resolvedBorderColor =
        borderColor ?? (_useFigmaSpec ? Ux4gPalette.neutral0 : resolvedContent);
    final borderDecoration = borderWidth > 0
        ? Border.all(color: resolvedBorderColor, width: borderWidth)
        : null;

    switch (_type) {
      case _Ux4gBadgeInternalType.dot:
        return Container(
          width: _useFigmaSpec ? 10 : 8,
          height: _useFigmaSpec ? 10 : 8,
          decoration: BoxDecoration(
            color: resolvedBg,
            shape: BoxShape.circle,
            border: borderDecoration,
          ),
        );
      case _Ux4gBadgeInternalType.text:
        if (count == null) return const SizedBox.shrink();
        final displayCount = limit == Ux4gBadgeLimit.singleDigit
            ? (count! > 9 ? "9+" : count.toString())
            : (count! > 99 ? "99+" : count.toString());
        final countStyle = _useFigmaSpec
            ? (ux4gTypography?.lS_default ??
                  materialTheme.textTheme.labelSmall ??
                  const TextStyle())
            : (ux4gTypography?.lS_strong ??
                  materialTheme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ) ??
                  const TextStyle());

        return Container(
          constraints: BoxConstraints(
            minWidth: _useFigmaSpec ? 16 : 18,
            minHeight: _useFigmaSpec ? 16 : 18,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: _useFigmaSpec ? 4 : 6,
            vertical: _useFigmaSpec ? 1 : 2,
          ),
          decoration: BoxDecoration(
            color: resolvedBg,
            borderRadius: BorderRadius.circular(100),
            border: borderDecoration,
          ),
          alignment: Alignment.center,
          child: Text(
            displayCount,
            style: countStyle.copyWith(
              color: resolvedContent,
              fontSize: _useFigmaSpec ? null : 10,
              height: _useFigmaSpec ? null : 1,
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
            border: borderDecoration,
          ),
          child: Text(
            label!,
            style:
                (ux4gTypography?.lS_strong ??
                        materialTheme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle())
                    .copyWith(color: resolvedContent, height: 1),
          ),
        );
      case _Ux4gBadgeInternalType.icon:
        if (icon == null) return const SizedBox.shrink();
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: resolvedBg,
            shape: BoxShape.circle,
            border: borderDecoration,
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 12, color: resolvedContent),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Color? _mapBackgroundColor(Ux4gColors? colors) {
    switch (badgeColor) {
      case Ux4gBadgeColor.brand:
        return colors?.primary ?? Ux4gPalette.primary;
      case Ux4gBadgeColor.information:
        return colors?.info ?? Ux4gPalette.cyan600;
      case Ux4gBadgeColor.success:
        return colors?.success ?? Ux4gPalette.green600;
      case Ux4gBadgeColor.warning:
        return colors?.warning ?? Ux4gPalette.orange600;
      case Ux4gBadgeColor.destructive:
        return colors?.error ?? Ux4gPalette.red600;
      case Ux4gBadgeColor.disabled:
        return Ux4gPalette.neutral200;
      case null:
        return null;
    }
  }

  Color? _mapContentColor(Ux4gColors? colors) {
    switch (badgeColor) {
      case Ux4gBadgeColor.brand:
        return colors?.onPrimary ?? Ux4gPalette.neutral50;
      case Ux4gBadgeColor.information:
        return colors?.onInfo ?? Ux4gPalette.neutral50;
      case Ux4gBadgeColor.success:
        return colors?.onSuccess ?? Ux4gPalette.neutral50;
      case Ux4gBadgeColor.warning:
        return colors?.onWarning ?? Ux4gPalette.neutral900;
      case Ux4gBadgeColor.destructive:
        return colors?.onError ?? Ux4gPalette.neutral50;
      case Ux4gBadgeColor.disabled:
        return Ux4gPalette.neutral900A;
      case null:
        return null;
    }
  }
}
