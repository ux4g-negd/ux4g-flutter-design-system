import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'loader.dart';

enum Ux4gButtonVariant { primary, secondary, outline, ghost }

enum Ux4gButtonSize {
  small(Ux4gSpace.space12, Ux4gSpace.space8),
  medium(Ux4gSpace.space24, Ux4gSpace.space16),
  large(Ux4gSpace.space32, Ux4gSpace.space20);

  final double horizontalPadding;
  final double verticalPadding;
  const Ux4gButtonSize(this.horizontalPadding, this.verticalPadding);
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
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final style = _getStyle(colors);

    final effectiveBgColor = backgroundColor ?? style.backgroundColor;
    final effectiveContentColor = contentColor ?? style.contentColor;
    final effectiveDisabledBgColor =
        disabledBackgroundColor ??
        (variant == Ux4gButtonVariant.primary ||
                variant == Ux4gButtonVariant.secondary
            ? colors.onSurface.withValues(alpha: 0.12)
            : Colors.transparent);
    final effectiveDisabledContentColor =
        disabledContentColor ?? colors.onSurface.withValues(alpha: 0.38);
    final effectiveBorderColor = borderColor ?? style.borderColor;
    final effectiveBorderWidth =
        borderWidth ?? (variant == Ux4gButtonVariant.outline ? 1.0 : 0.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: width,
        height: height,
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
                  vertical: size.verticalPadding,
                ),
            side: effectiveBorderColor != Colors.transparent
                ? BorderSide(
                    color: enabled
                        ? effectiveBorderColor
                        : colors.onSurface.withValues(alpha: 0.12),
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
                  size: 16,
                  color: effectiveContentColor,
                  strokeWidth: 2,
                ),
                const SizedBox(width: 8),
              ],
              if (leadingIcon != null && !isLoading) ...[
                Icon(
                  leadingIcon,
                  size: iconSize ?? 18,
                  color: effectiveContentColor,
                ),
                if (text != null || child != null) const SizedBox(width: 8),
              ],
              DefaultTextStyle(
                style: typography.lM_default.copyWith(
                  color: effectiveContentColor,
                ),
                child:
                    child ??
                    (text != null ? Text(text!) : const SizedBox.shrink()),
              ),
              if (trailingIcon != null) ...[
                if (text != null || child != null || leadingIcon != null)
                  const SizedBox(width: 8),
                Icon(
                  trailingIcon,
                  size: iconSize ?? 18,
                  color: effectiveContentColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  _ButtonStyle _getStyle(Ux4gColors colors) {
    return switch (variant) {
      Ux4gButtonVariant.primary => _ButtonStyle(
        backgroundColor: colors.primary,
        contentColor: colors.onPrimary,
        borderColor: Colors.transparent,
      ),
      Ux4gButtonVariant.secondary => _ButtonStyle(
        backgroundColor: colors.secondary,
        contentColor: colors.onSecondary,
        borderColor: Colors.transparent,
      ),
      Ux4gButtonVariant.outline => _ButtonStyle(
        backgroundColor: Colors.transparent,
        contentColor: colors.primary,
        borderColor: colors.primary,
      ),
      Ux4gButtonVariant.ghost => _ButtonStyle(
        backgroundColor: Colors.transparent,
        contentColor: colors.primary,
        borderColor: Colors.transparent,
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
    this.size = 40,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);

    final bgColor = switch (variant) {
      Ux4gButtonVariant.primary => colors.primary,
      Ux4gButtonVariant.secondary => colors.secondary,
      Ux4gButtonVariant.outline => Colors.transparent,
      Ux4gButtonVariant.ghost => Colors.transparent,
    };

    final contentColor = switch (variant) {
      Ux4gButtonVariant.primary => colors.onPrimary,
      Ux4gButtonVariant.secondary => colors.onSecondary,
      Ux4gButtonVariant.outline => colors.primary,
      Ux4gButtonVariant.ghost => colors.primary,
    };

    return IconButton(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: size * 0.6),
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: contentColor,
        fixedSize: Size(size, size),
        side: variant == Ux4gButtonVariant.outline
            ? BorderSide(color: colors.primary)
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
