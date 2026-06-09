import 'package:flutter/material.dart';
import '../foundation/dimensions.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

enum Ux4gTooltipPlacement { top, bottom, left, right }

class Ux4gTooltip extends StatelessWidget {
  final Widget child;
  final String text;
  final String? title;
  final IconData? icon;
  final Ux4gTooltipPlacement placement;
  final Widget? action;

  const Ux4gTooltip({
    super.key,
    required this.child,
    required this.text,
    this.title,
    this.icon,
    this.placement = Ux4gTooltipPlacement.top,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final hXXSStrong =
        ux4gTypography?.hXXS_strong ??
        materialTheme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle();
    final lSDefault =
        ux4gTypography?.lS_default ??
        materialTheme.textTheme.labelSmall ??
        const TextStyle();

    return Tooltip(
      message: text,
      richMessage: (title != null || icon != null || action != null)
          ? TextSpan(
              children: [
                if (icon != null)
                  WidgetSpan(
                    child: Icon(icon, size: 14, color: Colors.white),
                    alignment: PlaceholderAlignment.middle,
                  ),
                if (title != null)
                  TextSpan(
                    text: " $title\n",
                    style: hXXSStrong.copyWith(color: Colors.white),
                  ),
                TextSpan(
                  text: text,
                  style: lSDefault.copyWith(color: Colors.white),
                ),
              ],
            )
          : null,
      decoration: ShapeDecoration(
        color: onSurface,
        shape: _TooltipShape(placement: placement),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.all(8),
      preferBelow: placement == Ux4gTooltipPlacement.bottom,
      child: child,
    );
  }
}

class _TooltipShape extends ShapeBorder {
  final Ux4gTooltipPlacement placement;

  const _TooltipShape({required this.placement});

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(6);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    const arrowSize = 6.0;
    const radius = Ux4gRadius.radius4;

    path.addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(radius)));

    final centerX = rect.center.dx;
    final centerY = rect.center.dy;

    if (placement == Ux4gTooltipPlacement.top) {
      path.moveTo(centerX - arrowSize, rect.bottom);
      path.lineTo(centerX, rect.bottom + arrowSize);
      path.lineTo(centerX + arrowSize, rect.bottom);
    } else if (placement == Ux4gTooltipPlacement.bottom) {
      path.moveTo(centerX - arrowSize, rect.top);
      path.lineTo(centerX, rect.top - arrowSize);
      path.lineTo(centerX + arrowSize, rect.top);
    } else if (placement == Ux4gTooltipPlacement.left) {
      path.moveTo(rect.right, centerY - arrowSize);
      path.lineTo(rect.right + arrowSize, centerY);
      path.lineTo(rect.right, centerY + arrowSize);
    } else if (placement == Ux4gTooltipPlacement.right) {
      path.moveTo(rect.left, centerY - arrowSize);
      path.lineTo(rect.left - arrowSize, centerY);
      path.lineTo(rect.left, centerY + arrowSize);
    }

    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
