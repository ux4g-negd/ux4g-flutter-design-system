import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';

enum Ux4gCircularProgressSize { xs, s, m, l, xl, xxl, xxxl }

class Ux4gCircularProgress extends StatelessWidget {
  final double value;
  final Ux4gCircularProgressSize size;
  final double? diameter;
  final double? strokeWidth;
  final Color? progressColor;
  final Color? trackColor;
  final Gradient? progressGradient;
  final StrokeCap strokeCap;
  final double startAngle;
  final String? centerValueText;
  final String? centerDescription;
  final Widget? center;
  final String? label;
  final String? description;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign textAlign;
  final double gap;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final TextStyle? descriptionStyle;

  const Ux4gCircularProgress({
    super.key,
    required this.value,
    this.size = Ux4gCircularProgressSize.l,
    this.diameter,
    this.strokeWidth,
    this.progressColor,
    this.trackColor,
    this.progressGradient,
    this.strokeCap = StrokeCap.butt,
    this.startAngle = -math.pi / 2,
    this.centerValueText,
    this.centerDescription,
    this.center,
    this.label,
    this.description,
    this.footer,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
    this.labelStyle,
    this.descriptionStyle,
    this.gap = Ux4gSpace.space8,
  }) : assert(value >= 0 && value <= 1, 'value must be between 0 and 1');

  double _resolvedDiameter() {
    if (diameter != null) return diameter!;

    switch (size) {
      case Ux4gCircularProgressSize.xs:
        return 20;
      case Ux4gCircularProgressSize.s:
        return 28;
      case Ux4gCircularProgressSize.m:
        return 36;
      case Ux4gCircularProgressSize.l:
        return 48;
      case Ux4gCircularProgressSize.xl:
        return 88;
      case Ux4gCircularProgressSize.xxl:
        return 116;
      case Ux4gCircularProgressSize.xxxl:
        return 144;
    }
  }

  double _resolvedStrokeWidth(double ringSize) {
    if (strokeWidth != null) return strokeWidth!;
    return (ringSize * 0.12).clamp(3.0, 20.0);
  }

  double _scale(double ringSize, double factor, double min, double max) {
    return (ringSize * factor).clamp(min, max);
  }

  TextStyle _centerValueStyle(
    Ux4gTypography? typography,
    ThemeData materialTheme,
    double ringSize,
  ) {
    final fontSize = _scale(ringSize, 0.18, 7, 22);
    return (typography?.bS_strong ??
            materialTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ) ??
            const TextStyle())
        .copyWith(fontSize: fontSize, height: 1.1, fontWeight: FontWeight.w700);
  }

  TextStyle _centerDescriptionStyle(
    Ux4gTypography? typography,
    ThemeData materialTheme,
    double ringSize,
  ) {
    final fontSize = _scale(ringSize, 0.1, 6, 12);
    return (typography?.bXS_default ??
            materialTheme.textTheme.bodySmall?.copyWith(fontSize: 10) ??
            const TextStyle())
        .copyWith(
          fontSize: fontSize,
          height: 1.15,
          fontWeight: FontWeight.w600,
        );
  }

  TextStyle _labelStyle(
    Ux4gTypography? typography,
    ThemeData materialTheme,
    double ringSize,
  ) {
    final fontSize = _scale(ringSize, 0.16, 10, 16);
    return (typography?.tS_strong ??
            materialTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ) ??
            const TextStyle())
        .copyWith(fontSize: fontSize, height: 1.2, fontWeight: FontWeight.w700);
  }

  TextStyle _descriptionStyle(
    Ux4gTypography? typography,
    ThemeData materialTheme,
    double ringSize,
  ) {
    final fontSize = _scale(ringSize, 0.14, 9, 14);
    return (typography?.bS_default ??
            materialTheme.textTheme.bodySmall ??
            const TextStyle())
        .copyWith(
          fontSize: fontSize,
          height: 1.25,
          fontWeight: FontWeight.w600,
        );
  }

  /// Rings smaller than this diameter cannot comfortably fit text inside.
  static const double _inlineTextThreshold = 72.0;

  bool _textFitsInside(double ringSize) => ringSize >= _inlineTextThreshold;

  bool get _hasMeta => label != null || description != null || footer != null;

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final ringSize = _resolvedDiameter();
    final resolvedStrokeWidth = _resolvedStrokeWidth(ringSize);
    final resolvedProgressColor =
        progressColor ??
        (ux4gColors?.primary ?? materialTheme.colorScheme.primary);
    final resolvedTrackColor =
        trackColor ??
        (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
            .withValues(alpha: 0.16);
    final resolvedGap = gap.clamp(4.0, 16.0);

    // Whether the centerValueText / centerDescription should render inside the ring
    final inlineCenter = _textFitsInside(ringSize);

    // The center content widget (inside the ring)
    final Color contentColor = backgroundColor != null
        ? (ThemeData.estimateBrightnessForColor(
                    Color.alphaBlend(
                      backgroundColor!,
                      ux4gColors?.surface ?? materialTheme.colorScheme.surface,
                    ),
                  ) ==
                  Brightness.dark
              ? Colors.white
              : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface))
        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface);

    final centerWidget =
        center ??
        (inlineCenter
            ? _Ux4gCircularCenter(
                valueText: centerValueText,
                description: centerDescription,
                valueStyle: _centerValueStyle(
                  ux4gTypography,
                  materialTheme,
                  ringSize,
                ).copyWith(color: contentColor),
                descriptionStyle: _centerDescriptionStyle(
                  ux4gTypography,
                  materialTheme,
                  ringSize,
                ).copyWith(color: contentColor.withValues(alpha: 0.6)),
              )
            : null);

    // For small rings, if centerValueText exists and NO label is provided, show it below the ring
    final hasSmallCenterText =
        !inlineCenter &&
        (centerValueText != null || centerDescription != null) &&
        label == null;

    final child = Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // ── Ring ─────────────────────────────────────────────────────
        SizedBox(
          width: ringSize,
          height: ringSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.square(ringSize),
                painter: _Ux4gCircularProgressPainter(
                  value: value,
                  strokeWidth: resolvedStrokeWidth,
                  progressColor: resolvedProgressColor,
                  trackColor: resolvedTrackColor,
                  backgroundColor: backgroundColor,
                  progressGradient: progressGradient ??
                      (progressColor == null
                          ? const LinearGradient(
                              colors: [
                                Ux4gPalette.primary600,
                                Ux4gPalette.primary200,
                              ],
                            )
                          : null),
                  strokeCap: strokeCap,
                  startAngle: startAngle,
                ),
              ),
              if (centerWidget != null)
                Padding(
                  padding: EdgeInsets.all(
                    resolvedStrokeWidth + ringSize * 0.06,
                  ),
                  child: FittedBox(fit: BoxFit.scaleDown, child: centerWidget),
                ),
            ],
          ),
        ),

        // ── Center text below ring (small sizes only) ─────────────────
        if (hasSmallCenterText) ...[
          SizedBox(height: resolvedGap * 0.5),
          _Ux4gCircularCenter(
            valueText: centerValueText,
            description: centerDescription,
            valueStyle: _centerValueStyle(
              ux4gTypography,
              materialTheme,
              ringSize,
            ).copyWith(color: contentColor, fontSize: 11),
            descriptionStyle: _centerDescriptionStyle(
              ux4gTypography,
              materialTheme,
              ringSize,
            ).copyWith(color: contentColor.withValues(alpha: 0.6), fontSize: 9),
          ),
        ],

        // ── label / description / footer ──────────────────────────────
        if (_hasMeta) SizedBox(height: resolvedGap),
        if (label != null)
          Text(
            label!,
            textAlign: textAlign,
            style:
                (labelStyle ??
                        _labelStyle(ux4gTypography, materialTheme, ringSize))
                    .copyWith(
                      color:
                          labelStyle?.color ??
                          (ux4gColors?.onSurface ??
                              materialTheme.colorScheme.onSurface),
                    ),
          ),
        if (label != null && description != null)
          SizedBox(height: _scale(ringSize, 0.035, 2, 6)),
        if (description != null)
          Text(
            description!,
            textAlign: textAlign,
            style:
                (descriptionStyle ??
                        _descriptionStyle(
                          ux4gTypography,
                          materialTheme,
                          ringSize,
                        ))
                    .copyWith(
                      color:
                          descriptionStyle?.color ??
                          (ux4gColors?.onSurface ??
                                  materialTheme.colorScheme.onSurface)
                              .withValues(alpha: 0.62),
                    ),
          ),
        if ((label != null || description != null) && footer != null)
          SizedBox(height: _scale(ringSize, 0.06, 4, 10)),
        ?footer,
      ],
    );

    return padding == null ? child : Padding(padding: padding!, child: child);
  }
}

class Ux4gAnimatedCircularProgress extends StatelessWidget {
  final double value;
  final Ux4gCircularProgressSize size;
  final double? diameter;
  final double? strokeWidth;
  final Color? progressColor;
  final Color? trackColor;
  final Gradient? progressGradient;
  final StrokeCap strokeCap;
  final double startAngle;
  final String? centerValueText;
  final String? centerDescription;
  final Widget? center;
  final String? label;
  final String? description;
  final Widget? footer;
  final EdgeInsetsGeometry? padding;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign textAlign;
  final double gap;
  final Color? backgroundColor;
  final TextStyle? labelStyle;
  final TextStyle? descriptionStyle;
  final Duration duration;
  final Curve curve;

  const Ux4gAnimatedCircularProgress({
    super.key,
    required this.value,
    this.size = Ux4gCircularProgressSize.l,
    this.diameter,
    this.strokeWidth,
    this.progressColor,
    this.trackColor,
    this.progressGradient,
    this.strokeCap = StrokeCap.butt,
    this.startAngle = -math.pi / 2,
    this.centerValueText,
    this.centerDescription,
    this.center,
    this.label,
    this.description,
    this.footer,
    this.padding,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
    this.labelStyle,
    this.descriptionStyle,
    this.gap = Ux4gSpace.space8,
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
        return Ux4gCircularProgress(
          value: animatedValue,
          size: size,
          diameter: diameter,
          strokeWidth: strokeWidth,
          progressColor: progressColor,
          trackColor: trackColor,
          progressGradient: progressGradient,
          backgroundColor: backgroundColor,
          labelStyle: labelStyle,
          descriptionStyle: descriptionStyle,
          strokeCap: strokeCap,
          startAngle: startAngle,
          centerValueText: centerValueText,
          centerDescription: centerDescription,
          center: center,
          label: label,
          description: description,
          footer: footer,
          padding: padding,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textAlign: textAlign,
          gap: gap,
        );
      },
    );
  }
}

class _Ux4gCircularCenter extends StatelessWidget {
  final String? valueText;
  final String? description;
  final TextStyle valueStyle;
  final TextStyle descriptionStyle;

  const _Ux4gCircularCenter({
    required this.valueText,
    required this.description,
    required this.valueStyle,
    required this.descriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (valueText == null && description == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (valueText != null)
          Text(
            valueText!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: valueStyle,
          ),
        if (valueText != null && description != null)
          const SizedBox(height: Ux4gSpace.space2),
        if (description != null)
          Text(
            description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: descriptionStyle,
          ),
      ],
    );
  }
}

class _Ux4gCircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color progressColor;
  final Color trackColor;
  final Color? backgroundColor;
  final Gradient? progressGradient;
  final StrokeCap strokeCap;
  final double startAngle;

  const _Ux4gCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.progressColor,
    required this.trackColor,
    required this.backgroundColor,
    required this.progressGradient,
    required this.strokeCap,
    required this.startAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shortestSide = math.min(size.width, size.height);
    final radius = (shortestSide - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background Fill
    if (backgroundColor != null) {
      final fillPaint = Paint()
        ..color = backgroundColor!
        ..style = PaintingStyle.fill
        ..isAntiAlias = true;
      canvas.drawCircle(center, radius + strokeWidth / 2, fillPaint);
    }

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;

    // Only draw track where progress isn't
    if (value < 1.0) {
      final trackStartAngle = startAngle + (math.pi * 2 * value);
      final trackSweepAngle = math.pi * 2 * (1 - value);
      canvas.drawArc(rect, trackStartAngle, trackSweepAngle, false, trackPaint);
    }

    if (value <= 0) return;

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

    canvas.drawArc(rect, startAngle, math.pi * 2 * value, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _Ux4gCircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressGradient != progressGradient ||
        oldDelegate.strokeCap != strokeCap ||
        oldDelegate.startAngle != startAngle;
  }
}
