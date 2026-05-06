import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum Ux4gDividerOrientation {
  horizontal,
  vertical
}

enum Ux4gDividerStyle {
  solid,
  dashed,
  dotted
}

class Ux4gDivider extends StatelessWidget {
  final Ux4gDividerOrientation orientation;
  final Color? color;
  final double thickness;
  final Ux4gDividerStyle style;
  final double startIndent;
  final double endIndent;
  final Widget? label;
  final double labelSpacing;

  const Ux4gDivider({
    super.key,
    this.orientation = Ux4gDividerOrientation.horizontal,
    this.color,
    this.thickness = 1.0,
    this.style = Ux4gDividerStyle.solid,
    this.startIndent = 0.0,
    this.endIndent = 0.0,
    this.label,
    this.labelSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final dividerColor = color ?? colors.onSurface.withValues(alpha: 0.2);

    if (label != null) {
      if (orientation == Ux4gDividerOrientation.horizontal) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _Ux4gDividerLine(
                orientation: orientation,
                color: dividerColor,
                thickness: thickness,
                style: style,
                startIndent: startIndent,
                endIndent: 0,
              ),
            ),
            SizedBox(width: labelSpacing),
            label!,
            SizedBox(width: labelSpacing),
            Expanded(
              child: _Ux4gDividerLine(
                orientation: orientation,
                color: dividerColor,
                thickness: thickness,
                style: style,
                startIndent: 0,
                endIndent: endIndent,
              ),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _Ux4gDividerLine(
                orientation: orientation,
                color: dividerColor,
                thickness: thickness,
                style: style,
                startIndent: startIndent,
                endIndent: 0,
              ),
            ),
            SizedBox(height: labelSpacing),
            label!,
            SizedBox(height: labelSpacing),
            Expanded(
              child: _Ux4gDividerLine(
                orientation: orientation,
                color: dividerColor,
                thickness: thickness,
                style: style,
                startIndent: 0,
                endIndent: endIndent,
              ),
            ),
          ],
        );
      }
    }

    return _Ux4gDividerLine(
      orientation: orientation,
      color: dividerColor,
      thickness: thickness,
      style: style,
      startIndent: startIndent,
      endIndent: endIndent,
    );
  }
}

class _Ux4gDividerLine extends StatelessWidget {
  final Ux4gDividerOrientation orientation;
  final Color color;
  final double thickness;
  final Ux4gDividerStyle style;
  final double startIndent;
  final double endIndent;

  const _Ux4gDividerLine({
    required this.orientation,
    required this.color,
    required this.thickness,
    required this.style,
    required this.startIndent,
    required this.endIndent,
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == Ux4gDividerOrientation.horizontal) {
      return SizedBox(
        height: thickness,
        width: double.infinity,
        child: CustomPaint(
          painter: _DividerPainter(
            orientation: orientation,
            color: color,
            thickness: thickness,
            style: style,
            startIndent: startIndent,
            endIndent: endIndent,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: thickness,
        height: double.infinity,
        child: CustomPaint(
          painter: _DividerPainter(
            orientation: orientation,
            color: color,
            thickness: thickness,
            style: style,
            startIndent: startIndent,
            endIndent: endIndent,
          ),
        ),
      );
    }
  }
}

class _DividerPainter extends CustomPainter {
  final Ux4gDividerOrientation orientation;
  final Color color;
  final double thickness;
  final Ux4gDividerStyle style;
  final double startIndent;
  final double endIndent;

  _DividerPainter({
    required this.orientation,
    required this.color,
    required this.thickness,
    required this.style,
    required this.startIndent,
    required this.endIndent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double dashWidth = 0;
    double dashSpace = 0;

    switch (style) {
      case Ux4gDividerStyle.solid:
        break;
      case Ux4gDividerStyle.dashed:
        dashWidth = 12.0;
        dashSpace = 8.0;
        break;
      case Ux4gDividerStyle.dotted:
        dashWidth = 4.0;
        dashSpace = 4.0;
        break;
    }

    if (orientation == Ux4gDividerOrientation.horizontal) {
      final y = size.height / 2;
      final startX = startIndent;
      final endX = size.width - endIndent;

      if (style == Ux4gDividerStyle.solid) {
        canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
      } else {
        double currentX = startX;
        while (currentX < endX) {
          final nextX = (currentX + dashWidth).clamp(startX, endX);
          canvas.drawLine(Offset(currentX, y), Offset(nextX, y), paint);
          currentX += dashWidth + dashSpace;
        }
      }
    } else {
      final x = size.width / 2;
      final startY = startIndent;
      final endY = size.height - endIndent;

      if (style == Ux4gDividerStyle.solid) {
        canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
      } else {
        double currentY = startY;
        while (currentY < endY) {
          final nextY = (currentY + dashWidth).clamp(startY, endY);
          canvas.drawLine(Offset(x, currentY), Offset(x, nextY), paint);
          currentY += dashWidth + dashSpace;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DividerPainter oldDelegate) {
    return oldDelegate.orientation != orientation ||
        oldDelegate.color != color ||
        oldDelegate.thickness != thickness ||
        oldDelegate.style != style ||
        oldDelegate.startIndent != startIndent ||
        oldDelegate.endIndent != endIndent;
  }
}
