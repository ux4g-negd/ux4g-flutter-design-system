import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../foundation/typography.dart';

/// Size variants for [Ux4gHalfCircleProgress].
enum Ux4gHalfCircleProgressSize { s, m, l, xl }

/// A half-circle (gauge / semicircle) progress indicator.
///
/// The gauge sweeps from 0% (left) to 100% (right) in a 180° arc.
/// Percentage text and description auto-scale based on [size].
///
/// Two visual variants controlled by [showScale]:
/// - **Without scale** (default): clean arc with percentage & description.
/// - **With scale**: adds 0% and 100% labels at the arc ends.
class Ux4gHalfCircleProgress extends StatelessWidget {
  /// Progress value between 0 and 1.
  final double value;

  /// Predefined size variant.
  final Ux4gHalfCircleProgressSize size;

  /// Custom width override (height is calculated automatically).
  final double? width;

  /// Custom stroke width for the arc.
  final double? strokeWidth;

  /// Color of the progress arc.
  final Color? progressColor;

  /// Color of the track (background arc).
  final Color? trackColor;

  /// Optional gradient for the progress arc.
  final Gradient? progressGradient;

  /// Stroke cap style for the arcs.
  final StrokeCap strokeCap;

  /// Text shown as the main value (defaults to percentage).
  final String? valueText;

  /// Description text shown below the value.
  final String? description;

  /// Whether to show 0% and 100% labels at the ends.
  final bool showScale;

  /// Custom text style for the value text.
  final TextStyle? valueStyle;

  /// Custom text style for the description.
  final TextStyle? descriptionStyle;

  /// Custom text style for scale labels.
  final TextStyle? scaleStyle;

  /// Gap between arc and text content.
  final double gap;

  const Ux4gHalfCircleProgress({
    super.key,
    required this.value,
    this.size = Ux4gHalfCircleProgressSize.l,
    this.width,
    this.strokeWidth,
    this.progressColor,
    this.trackColor,
    this.progressGradient,
    this.strokeCap = StrokeCap.round,
    this.valueText,
    this.description,
    this.showScale = false,
    this.valueStyle,
    this.descriptionStyle,
    this.scaleStyle,
    this.gap = Ux4gSpace.space4,
  }) : assert(value >= 0 && value <= 1, 'value must be between 0 and 1');

  double _resolvedWidth() {
    if (width != null) return width!;
    switch (size) {
      case Ux4gHalfCircleProgressSize.s:
        return 80;
      case Ux4gHalfCircleProgressSize.m:
        return 140;
      case Ux4gHalfCircleProgressSize.l:
        return 200;
      case Ux4gHalfCircleProgressSize.xl:
        return 280;
    }
  }

  double _resolvedStrokeWidth(double w) {
    if (strokeWidth != null) return strokeWidth!;
    return (w * 0.08).clamp(4.0, 22.0);
  }

  double _valueFontSize(double w) {
    return (w * 0.18).clamp(10.0, 48.0);
  }

  double _descriptionFontSize(double w) {
    return (w * 0.10).clamp(7.0, 20.0);
  }

  double _scaleFontSize(double w) {
    return (w * 0.075).clamp(6.0, 14.0);
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final w = _resolvedWidth();
    final sw = _resolvedStrokeWidth(w);
    final arcHeight = w / 2 + sw / 2;

    final resolvedProgressColor =
        progressColor ??
        (ux4gColors?.primary ?? materialTheme.colorScheme.primary);
    final resolvedTrackColor =
        trackColor ??
        (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
            .withValues(alpha: 0.16);

    final percent = (value * 100).round();
    final displayValue = valueText ?? '$percent%';

    final resolvedValueStyle =
        valueStyle ??
        (ux4gTypography?.bS_strong ??
                materialTheme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ) ??
                const TextStyle())
            .copyWith(
              fontSize: _valueFontSize(w),
              fontWeight: FontWeight.w700,
              height: 1.1,
              color:
                  ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface,
            );

    final resolvedDescriptionStyle =
        descriptionStyle ??
        (ux4gTypography?.bXS_default ??
                materialTheme.textTheme.bodySmall?.copyWith(fontSize: 12) ??
                const TextStyle())
            .copyWith(
              fontSize: _descriptionFontSize(w),
              fontWeight: FontWeight.w500,
              height: 1.2,
              color:
                  (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      .withValues(alpha: 0.6),
            );

    final resolvedScaleStyle =
        scaleStyle ??
        (ux4gTypography?.bXS_default ??
                materialTheme.textTheme.bodySmall?.copyWith(fontSize: 12) ??
                const TextStyle())
            .copyWith(
              fontSize: _scaleFontSize(w),
              fontWeight: FontWeight.w400,
              height: 1.2,
              color:
                  (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      .withValues(alpha: 0.5),
            );

    // Description fits inside the arc only for larger sizes
    final bool descriptionFitsInside = w >= 120;

    // Scale label height to account for in layout
    final scaleLabelHeight = showScale ? _scaleFontSize(w) * 1.3 : 0.0;

    // Build the arc + text area
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Arc + centered text + scale labels
        SizedBox(
          width: w,
          height: arcHeight + scaleLabelHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(w, arcHeight),
                painter: _HalfCirclePainter(
                  value: value,
                  strokeWidth: sw,
                  progressColor: resolvedProgressColor,
                  trackColor: resolvedTrackColor,
                  progressGradient: progressGradient,
                  strokeCap: strokeCap,
                ),
              ),
              // Percentage always inside; description inside only if fits
              Positioned(
                left: sw,
                right: sw,
                bottom: scaleLabelHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        displayValue,
                        style: resolvedValueStyle,
                        maxLines: 1,
                      ),
                    ),
                    if (description != null && descriptionFitsInside) ...[
                      SizedBox(height: gap * 0.25),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          description!,
                          style: resolvedDescriptionStyle,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Scale labels at arc endpoints (directly below arc ends)
              if (showScale) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text('0%', style: resolvedScaleStyle),
                ),
                Positioned(
                  right: -sw,
                  bottom: 0,
                  child: Text('100%', style: resolvedScaleStyle),
                ),
              ],
            ],
          ),
        ),

        // Description below the arc for small sizes
        if (description != null && !descriptionFitsInside) ...[
          SizedBox(height: gap * 0.5),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              description!,
              style: resolvedDescriptionStyle.copyWith(
                fontSize: _descriptionFontSize(w) * 0.85,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ],
    );
  }
}

/// Animated version of [Ux4gHalfCircleProgress].
class Ux4gAnimatedHalfCircleProgress extends StatelessWidget {
  final double value;
  final Ux4gHalfCircleProgressSize size;
  final double? width;
  final double? strokeWidth;
  final Color? progressColor;
  final Color? trackColor;
  final Gradient? progressGradient;
  final StrokeCap strokeCap;
  final String? valueText;
  final String? description;
  final bool showScale;
  final TextStyle? valueStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? scaleStyle;
  final double gap;
  final Duration duration;
  final Curve curve;

  const Ux4gAnimatedHalfCircleProgress({
    super.key,
    required this.value,
    this.size = Ux4gHalfCircleProgressSize.l,
    this.width,
    this.strokeWidth,
    this.progressColor,
    this.trackColor,
    this.progressGradient,
    this.strokeCap = StrokeCap.round,
    this.valueText,
    this.description,
    this.showScale = false,
    this.valueStyle,
    this.descriptionStyle,
    this.scaleStyle,
    this.gap = Ux4gSpace.space4,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: duration,
      curve: curve,
      builder: (context, animatedValue, _) {
        final percent = (animatedValue * 100).round();
        return Ux4gHalfCircleProgress(
          value: animatedValue,
          size: size,
          width: width,
          strokeWidth: strokeWidth,
          progressColor: progressColor,
          trackColor: trackColor,
          progressGradient: progressGradient,
          strokeCap: strokeCap,
          valueText: valueText ?? '$percent%',
          description: description,
          showScale: showScale,
          valueStyle: valueStyle,
          descriptionStyle: descriptionStyle,
          scaleStyle: scaleStyle,
          gap: gap,
        );
      },
    );
  }
}

/// CustomPainter that draws a half-circle (semicircle) arc from left to right.
class _HalfCirclePainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color progressColor;
  final Color trackColor;
  final Gradient? progressGradient;
  final StrokeCap strokeCap;

  const _HalfCirclePainter({
    required this.value,
    required this.strokeWidth,
    required this.progressColor,
    required this.trackColor,
    required this.progressGradient,
    required this.strokeCap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final radius = (w - strokeWidth) / 2;
    final center = Offset(w / 2, size.height - strokeWidth / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Track (full semicircle dome: left → top → right, clockwise sweep of PI)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..isAntiAlias = true;

    canvas.drawArc(rect, math.pi, math.pi, false, trackPaint);

    if (value <= 0) return;

    // Progress arc
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..isAntiAlias = true;

    if (progressGradient != null) {
      progressPaint.shader = progressGradient!.createShader(rect);
    } else {
      progressPaint.color = progressColor;
    }

    // Sweep from left (PI) going clockwise by value * PI
    final sweepAngle = math.pi * value.clamp(0.0, 1.0);
    canvas.drawArc(rect, math.pi, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _HalfCirclePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressGradient != progressGradient ||
        oldDelegate.strokeCap != strokeCap;
  }
}
