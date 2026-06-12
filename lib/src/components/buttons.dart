import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';
import 'loader.dart';

enum Ux4gButtonVariant { primary, secondary, outline, ghost }

enum Ux4gButtonSize {
  small(Ux4gSpace.space12, Ux4gSpace.space32, Ux4gSpace.space16),
  medium(Ux4gSpace.space16, Ux4gSpace.space40, Ux4gSpace.space20),
  large(Ux4gSpace.space20, Ux4gSpace.space48, Ux4gSpace.space24);

  final double horizontalPadding;
  final double minHeight;
  final double iconSize;
  const Ux4gButtonSize(this.horizontalPadding, this.minHeight, this.iconSize);
}

class Ux4gButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final Ux4gButtonVariant variant;
  final Ux4gButtonSize size;
  final bool enabled;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? contentColor;
  final Color? disabledBackgroundColor;
  final Color? disabledContentColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? iconSize;
  final double? width;
  final double? height;
  final double? elevation;

  const Ux4gButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.variant = Ux4gButtonVariant.primary,
    this.size = Ux4gButtonSize.medium,
    this.enabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.contentColor,
    this.disabledBackgroundColor,
    this.disabledContentColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
    this.width,
    this.height,
    this.elevation,
  }) : assert(
         text != null ||
             child != null ||
             leadingIcon != null ||
             trailingIcon != null,
       );

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final style = _getStyle(ux4gColors, materialTheme);

    final effectiveBgColor = backgroundColor ?? style.backgroundColor;
    final effectiveContentColor = contentColor ?? style.contentColor;

    final effectiveDisabledBgColor =
      disabledBackgroundColor ??
      (variant == Ux4gButtonVariant.primary ||
          variant == Ux4gButtonVariant.secondary
        ? Ux4gPalette.neutral200
        : Ux4gPalette.transparent);
    final effectiveDisabledContentColor =
      disabledContentColor ?? Ux4gPalette.neutral900A;
    final activeContentColor =
      (enabled && !isLoading) ? effectiveContentColor : effectiveDisabledContentColor;
    final effectiveBorderColor = borderColor ?? style.borderColor;
    final effectiveBorderWidth =
        borderWidth ??
        (variant == Ux4gButtonVariant.outline
            ? Ux4gBorderWidth.thin
            : Ux4gBorderWidth.none);

    final textStyle =
        switch (size) {
          Ux4gButtonSize.small => ux4gTypography?.lL_default,
          Ux4gButtonSize.medium => ux4gTypography?.lXL_default,
          Ux4gButtonSize.large => ux4gTypography?.lXL_default,
        } ??
        materialTheme.textTheme.labelLarge ??
        const TextStyle();

    return SizedBox(
        width: width,
        height: height ?? size.minHeight,
        child: OutlinedButton(
          onPressed: (enabled && !isLoading) ? onPressed : null,
          style: OutlinedButton.styleFrom(
            backgroundColor: effectiveBgColor,
            foregroundColor: effectiveContentColor,
            disabledBackgroundColor: effectiveDisabledBgColor,
            disabledForegroundColor: effectiveDisabledContentColor,
            elevation: elevation ?? 0,
            padding:
                padding ??
                EdgeInsets.symmetric(
                  horizontal: size.horizontalPadding,
                  vertical: Ux4gSpace.spaceNone,
                ),
            side: effectiveBorderColor != Colors.transparent
                ? BorderSide(
                    color: enabled
                        ? effectiveBorderColor
                        : (variant == Ux4gButtonVariant.outline
                              ? Ux4gPalette.neutral200
                              : effectiveDisabledBgColor),
                    width: effectiveBorderWidth,
                  )
                : BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Ux4gRadius.radius8,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading) ...[
                Ux4gLoader(
                  size: size.iconSize,
                  color: activeContentColor,
                  strokeWidth: Ux4gBorderWidth.thin,
                ),
                const SizedBox(width: Ux4gSpace.space4),
              ],
              if (leadingIcon != null && !isLoading) ...[
                Icon(
                  leadingIcon,
                  size: iconSize ?? size.iconSize,
                  color: activeContentColor,
                ),
                if (text != null || child != null)
                  const SizedBox(width: Ux4gSpace.space4),
              ],
              DefaultTextStyle(
                style: textStyle.copyWith(color: activeContentColor),
                child:
                    child ??
                    (text != null ? Text(text!) : const SizedBox.shrink()),
              ),
              if (trailingIcon != null) ...[
                if (text != null || child != null || leadingIcon != null)
                  const SizedBox(width: Ux4gSpace.space4),
                Icon(
                  trailingIcon,
                  size: iconSize ?? size.iconSize,
                  color: activeContentColor,
                ),
              ],
            ],
          ),
        ),
    );
  }

  _ButtonStyle _getStyle(Ux4gColors? ux4gColors, ThemeData materialTheme) {
    final colorScheme = materialTheme.colorScheme;

    final primary = ux4gColors?.primary ?? colorScheme.primary;
    final onPrimary = ux4gColors?.onPrimary ?? colorScheme.onPrimary;
    final secondary = ux4gColors?.secondary ?? colorScheme.secondary;
    final onSecondary = ux4gColors?.onSecondary ?? colorScheme.onSecondary;
    final outlineBorder =
      materialTheme.brightness == Brightness.dark
        ? Ux4gPalette.primary400
        : Ux4gPalette.primary300;

    return switch (variant) {
      Ux4gButtonVariant.primary => _ButtonStyle(
        backgroundColor: primary,
        contentColor: onPrimary,
        borderColor: Colors.transparent,
      ),
      Ux4gButtonVariant.secondary => _ButtonStyle(
        backgroundColor: secondary,
        contentColor: onSecondary,
        borderColor: Colors.transparent,
      ),
      Ux4gButtonVariant.outline => _ButtonStyle(
        backgroundColor: Ux4gPalette.transparent,
        contentColor: primary,
        borderColor: outlineBorder,
      ),
      Ux4gButtonVariant.ghost => _ButtonStyle(
        backgroundColor: Ux4gPalette.transparent,
        contentColor: primary,
        borderColor: Ux4gPalette.transparent,
      ),
    };
  }
}

class Ux4gOutlineButton extends Ux4gButton {
  const Ux4gOutlineButton({
    super.key,
    required super.onPressed,
    super.text,
    super.child,
    super.size,
    super.enabled,
    super.isLoading,
    super.backgroundColor,
    Color? color,
    super.borderRadius,
    super.padding,
    super.width,
    super.height,
  }) : super(
         variant: Ux4gButtonVariant.outline,
         contentColor: color,
         borderColor: color,
       );
}

class Ux4gTextButton extends Ux4gButton {
  const Ux4gTextButton({
    super.key,
    required super.onPressed,
    super.text,
    super.child,
    super.size,
    super.enabled,
    super.isLoading,
    Color? color,
    super.borderRadius,
    super.padding,
    super.width,
    super.height,
  }) : super(variant: Ux4gButtonVariant.ghost, contentColor: color);
}

class Ux4gIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Ux4gButtonVariant variant;
  final double size;
  final bool enabled;

  const Ux4gIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = Ux4gButtonVariant.primary,
    this.size = Ux4gSpace.space40,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary =
        ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    final secondary =
        ux4gColors?.secondary ?? materialTheme.colorScheme.secondary;
    final onSecondary =
        ux4gColors?.onSecondary ?? materialTheme.colorScheme.onSecondary;

    final bgColor = switch (variant) {
      Ux4gButtonVariant.primary => primary,
      Ux4gButtonVariant.secondary => secondary,
      Ux4gButtonVariant.outline => Colors.transparent,
      Ux4gButtonVariant.ghost => Colors.transparent,
    };

    final contentColor = switch (variant) {
      Ux4gButtonVariant.primary => onPrimary,
      Ux4gButtonVariant.secondary => onSecondary,
      Ux4gButtonVariant.outline => primary,
      Ux4gButtonVariant.ghost => primary,
    };

    final outlineBorder =
        materialTheme.brightness == Brightness.dark
            ? Ux4gPalette.primary400
            : Ux4gPalette.primary300;

    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: size - Ux4gSpace.space16),
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: contentColor,
        fixedSize: Size(size, size),
        side: variant == Ux4gButtonVariant.outline
            ? BorderSide(color: outlineBorder)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
        ),
      ),
    );
  }
}

class _ButtonStyle {
  final Color backgroundColor;
  final Color contentColor;
  final Color borderColor;

  const _ButtonStyle({
    required this.backgroundColor,
    required this.contentColor,
    required this.borderColor,
  });
}
