import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

/// Controls how rounded the progress bar corners are.
enum Ux4gProgressShape {
  /// No rounding — square ends.
  sharp,

  /// Fully rounded pill-shaped ends.
  rounded,
}

/// Where the percentage label is rendered.
enum Ux4gProgressLabelPosition {
  /// Percentage shown to the top-right, outside the bar.
  outside,

  /// Percentage shown inside the filled portion of the bar.
  inside,
}

// ─── Component ────────────────────────────────────────────────────────────────

/// A customizable linear progress indicator following the Ux4G Design System.
///
/// ### Basic usage
/// ```dart
/// Ux4gLinearProgress(value: 0.6)
/// ```
///
/// ### With label, icon, hint and gradient
/// ```dart
/// Ux4gLinearProgress(
///   value: 0.75,
///   label: 'Upload',
///   hint: 'Almost done',
///   icon: Icons.cloud_upload_outlined,
///   gradientColors: [Colors.blue, Colors.purple],
///   shape: Ux4gProgressShape.rounded,
///   labelPosition: Ux4gProgressLabelPosition.inside,
///   showPercentage: true,
/// )
/// ```
class Ux4gLinearProgress extends StatelessWidget {
  /// Progress value between **0.0** (empty) and **1.0** (full).
  final double value;

  /// Optional leading icon shown to the left of the label row.
  final IconData? icon;

  /// Optional icon color. Defaults to [Ux4gColors.primary].
  final Color? iconColor;

  /// Optional icon background color (circle behind icon). Pass `null` to hide bg.
  final Color? iconBackgroundColor;

  /// Optional main label text shown above-left of the bar.
  final String? label;

  /// Optional hint text shown above-right of the bar.
  final String? hint;

  /// Height of the progress track in logical pixels. Default: **8**.
  final double height;

  /// Controls corner roundness.
  /// - [Ux4gProgressShape.sharp] → `borderRadius = 0`
  /// - [Ux4gProgressShape.rounded] → `borderRadius = height / 2` (pill)
  ///
  /// Override with [customBorderRadius] for fine-grained control.
  final Ux4gProgressShape shape;

  /// Custom border radius that overrides [shape] when provided.
  final double? customBorderRadius;

  /// Single solid fill color. Ignored when [gradientColors] is non-empty.
  final Color? color;

  /// Two or more colors for a left-to-right gradient fill.
  /// Takes priority over [color].
  final List<Color>? gradientColors;

  /// Background track color. Defaults to a semi-transparent `onSurface`.
  final Color? trackColor;

  /// Whether to render the percentage value.
  final bool showPercentage;

  /// Where the percentage text appears when [showPercentage] is `true`.
  final Ux4gProgressLabelPosition labelPosition;

  /// Text style for the percentage rendered inside the bar.
  /// Defaults to a small bold white style.
  final TextStyle? insideLabelStyle;

  const Ux4gLinearProgress({
    super.key,
    required this.value,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.label,
    this.hint,
    this.height = 8,
    this.shape = Ux4gProgressShape.rounded,
    this.customBorderRadius,
    this.color,
    this.gradientColors,
    this.trackColor,
    this.showPercentage = false,
    this.labelPosition = Ux4gProgressLabelPosition.outside,
    this.insideLabelStyle,
  }) : assert(value >= 0.0 && value <= 1.0,
            'value must be between 0.0 and 1.0');

  double _resolvedRadius() {
    if (customBorderRadius != null) return customBorderRadius!;
    return shape == Ux4gProgressShape.rounded ? height / 2 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final radius = _resolvedRadius();
    final clampedValue = value.clamp(0.0, 1.0);
    final percent = (clampedValue * 100).toStringAsFixed(0);

    final resolvedColor = color ?? colors.primary;
    final resolvedTrack =
        trackColor ?? colors.onSurface.withValues(alpha: 0.12);

    final hasHeader = icon != null || label != null || hint != null ||
        (showPercentage && labelPosition == Ux4gProgressLabelPosition.outside);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Header row ────────────────────────────────────────────────
        if (hasHeader) ...[
          Row(
            children: [
              // Leading icon
              if (icon != null) ...[
                _IconBubble(
                  icon: icon!,
                  iconColor: iconColor ?? colors.primary,
                  backgroundColor: iconBackgroundColor ??
                      colors.primary.withValues(alpha: 0.12),
                  size: 32,
                ),
                const SizedBox(width: Ux4gSpace.space8),
              ],

              // Label
              if (label != null)
                Expanded(
                  child: Text(
                    label!,
                    style: typography.bS_strong
                        .copyWith(color: colors.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                const Spacer(),

              // Hint + outside percentage
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hint != null)
                    Text(
                      hint!,
                      style: typography.bS_default.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  if (showPercentage &&
                      labelPosition ==
                          Ux4gProgressLabelPosition.outside) ...[
                    if (hint != null)
                      const SizedBox(width: Ux4gSpace.space8),
                    Text(
                      '$percent%',
                      style: typography.bS_strong
                          .copyWith(color: colors.onSurface),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: Ux4gSpace.space8),
        ],

        // ── Progress track ─────────────────────────────────────────────
        _ProgressBar(
          value: clampedValue,
          height: height,
          radius: radius,
          resolvedColor: resolvedColor,
          gradientColors: gradientColors,
          trackColor: resolvedTrack,
          showPercentage:
              showPercentage &&
              labelPosition == Ux4gProgressLabelPosition.inside,
          percent: percent,
          insideLabelStyle: insideLabelStyle ??
              typography.lS_strong.copyWith(
                color: Colors.white,
                fontSize: height > 14 ? 11 : (height * 0.7).clamp(8, 11),
              ),
        ),
      ],
    );
  }
}

// ─── Internal: progress bar ────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final double value;
  final double height;
  final double radius;
  final Color resolvedColor;
  final List<Color>? gradientColors;
  final Color trackColor;
  final bool showPercentage;
  final String percent;
  final TextStyle insideLabelStyle;

  const _ProgressBar({
    required this.value,
    required this.height,
    required this.radius,
    required this.resolvedColor,
    required this.gradientColors,
    required this.trackColor,
    required this.showPercentage,
    required this.percent,
    required this.insideLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CustomPaint(
          size: Size.infinite,
          painter: _ProgressPainter(
            value: value,
            fillColor: resolvedColor,
            gradientColors: gradientColors,
            trackColor: trackColor,
            radius: radius,
            showLabel: showPercentage,
            label: '$percent%',
            labelStyle: insideLabelStyle,
          ),
        ),
      ),
    );
  }
}

// ─── CustomPainter ─────────────────────────────────────────────────────────────

class _ProgressPainter extends CustomPainter {
  final double value;
  final Color fillColor;
  final List<Color>? gradientColors;
  final Color trackColor;
  final double radius;
  final bool showLabel;
  final String label;
  final TextStyle labelStyle;

  const _ProgressPainter({
    required this.value,
    required this.fillColor,
    required this.gradientColors,
    required this.trackColor,
    required this.radius,
    required this.showLabel,
    required this.label,
    required this.labelStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    // Track
    canvas.drawRRect(rrect, Paint()..color = trackColor);

    if (value <= 0) return;

    final fillWidth = size.width * value;
    final fillRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, fillWidth, size.height),
      Radius.circular(radius),
    );

    final fillPaint = Paint();
    if (gradientColors != null && gradientColors!.length >= 2) {
      fillPaint.shader = LinearGradient(
        colors: gradientColors!,
      ).createShader(Rect.fromLTWH(0, 0, fillWidth, size.height));
    } else {
      fillPaint.color = fillColor;
    }

    canvas.drawRRect(fillRRect, fillPaint);

    // Inside label
    if (showLabel && fillWidth > 20) {
      final tp = TextPainter(
        text: TextSpan(text: label, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: fillWidth - 8);

      final dx = fillWidth - tp.width - 6;
      final dy = (size.height - tp.height) / 2;
      if (dx > 0) tp.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(_ProgressPainter old) =>
      old.value != value ||
      old.fillColor != fillColor ||
      old.gradientColors != gradientColors ||
      old.trackColor != trackColor;
}

// ─── Internal: icon bubble ─────────────────────────────────────────────────────

class _IconBubble extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;

  const _IconBubble({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: size * 0.55),
    );
  }
}

// ─── Convenience: animated version ────────────────────────────────────────────

/// Animated version of [Ux4gLinearProgress] — smoothly transitions when
/// [value] changes.
class Ux4gAnimatedLinearProgress extends StatelessWidget {
  final double value;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final String? label;
  final String? hint;
  final double height;
  final Ux4gProgressShape shape;
  final double? customBorderRadius;
  final Color? color;
  final List<Color>? gradientColors;
  final Color? trackColor;
  final bool showPercentage;
  final Ux4gProgressLabelPosition labelPosition;
  final Duration duration;
  final Curve curve;

  const Ux4gAnimatedLinearProgress({
    super.key,
    required this.value,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.label,
    this.hint,
    this.height = 8,
    this.shape = Ux4gProgressShape.rounded,
    this.customBorderRadius,
    this.color,
    this.gradientColors,
    this.trackColor,
    this.showPercentage = false,
    this.labelPosition = Ux4gProgressLabelPosition.outside,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: duration,
      curve: curve,
      builder: (_, animVal, child) => Ux4gLinearProgress(
        value: animVal,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        label: label,
        hint: hint,
        height: height,
        shape: shape,
        customBorderRadius: customBorderRadius,
        color: color,
        gradientColors: gradientColors,
        trackColor: trackColor,
        showPercentage: showPercentage,
        labelPosition: labelPosition,
      ),
    );
  }
}
