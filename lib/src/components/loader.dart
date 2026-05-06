import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/theme.dart';

class Ux4gLoader extends StatefulWidget {
  final double size;
  final Color? color;
  final double percentage; // 0 to 100
  final double strokeWidth;
  final int rotationDurationMillis;

  const Ux4gLoader({
    super.key,
    this.size = 40,
    this.color,
    this.percentage = 100,
    this.strokeWidth = 4,
    this.rotationDurationMillis = 1200,
  });

  @override
  State<Ux4gLoader> createState() => _Ux4gLoaderState();
}

class _Ux4gLoaderState extends State<Ux4gLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.rotationDurationMillis),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Ux4gTheme.colors(context).primary;

    return RotationTransition(
      turns: _controller,
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _LoaderPainter(
            color: color,
            percentage: widget.percentage,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Color color;
  final double percentage;
  final double strokeWidth;

  _LoaderPainter({
    required this.color,
    required this.percentage,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final normalized = (percentage / 100).clamp(0.0, 1.0);
    final sweepAngle = 2 * math.pi * normalized;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [color.withValues(alpha: 0.0), color],
        stops: [0.0, normalized],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      sweepAngle,
      false,
      paint,
    );

    final capPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final capX = center.dx + radius * math.cos(sweepAngle);
    final capY = center.dy + radius * math.sin(sweepAngle);
    canvas.drawCircle(Offset(capX, capY), strokeWidth / 2, capPaint);
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.percentage != percentage ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
