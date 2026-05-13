import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/src/foundation/typography.dart';
import '../foundation/colors.dart';
import '../theme/theme.dart';
import 'input_field.dart';

enum Ux4gSliderSize {
  small(16, 4),
  medium(20, 6);

  final double thumbSize;
  final double trackHeight;
  const Ux4gSliderSize(this.thumbSize, this.trackHeight);
}

enum Ux4gSliderCaptionVariant { helper, error, warning, success }

class Ux4gSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onValueChange;
  final double min;
  final double max;
  final int? steps;
  final Ux4gSliderSize size;
  final bool enabled;
  final String? label;
  final bool isRequired;
  final IconData? labelIcon;
  final String? startValueText;
  final String? endValueText;
  final String? caption;
  final Ux4gSliderCaptionVariant captionVariant;
  final bool showMarksAndValues;
  final bool showIndicator;
  final bool showInputFields;
  final bool showValueLabels;

  const Ux4gSlider({
    super.key,
    required this.value,
    required this.onValueChange,
    this.min = 0.0,
    this.max = 100.0,
    this.steps,
    this.size = Ux4gSliderSize.small,
    this.enabled = true,
    this.label,
    this.isRequired = false,
    this.labelIcon,
    this.startValueText,
    this.endValueText,
    this.caption,
    this.captionVariant = Ux4gSliderCaptionVariant.helper,
    this.showMarksAndValues = false,
    this.showIndicator = false,
    this.showInputFields = false,
    this.showValueLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final isError = captionVariant == Ux4gSliderCaptionVariant.error;
    final activeColor = enabled
        ? (isError ? colors.error : colors.primary)
        : colors.onSurface.withValues(alpha: 0.38);
    final inactiveColor = colors.onSurface.withValues(alpha: 0.12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showValueLabels || showInputFields)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildTopRow(context, typography, colors),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: size.trackHeight,
            thumbShape: _Ux4gThumbShape(
              enabledThumbRadius: size.thumbSize / 2,
              borderColor: colors.onSurface.withValues(
                alpha: enabled ? 0.12 : 0.38,
              ),
            ),
            trackShape: _Ux4gTrackShape(thumbRadius: size.thumbSize / 2),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            thumbColor: colors.onPrimary,
            overlayColor: activeColor.withValues(alpha: 0.12),
            showValueIndicator: showIndicator
                ? ShowValueIndicator.onDrag
                : ShowValueIndicator.never,
            valueIndicatorColor: colors.onSurface,
            valueIndicatorTextStyle: typography.lS_strong.copyWith(
              color: colors.surface,
            ),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: steps != null && steps! > 0 ? steps! + 1 : null,
            onChanged: enabled ? onValueChange : null,
            label: value.toInt().toString(),
          ),
        ),
        if (showMarksAndValues && steps != null && steps! > 0)
          Transform.translate(
            offset: const Offset(0, -12),
            child: _buildMarksAndValues(
              context,
              typography,
              colors,
              activeColor,
              min,
              value,
            ),
          ),
        if (caption != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildCaption(context, typography, colors),
          ),
        ],
      ],
    );
  }

  Widget _buildTopRow(
    BuildContext context,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  label!,
                  style: typography.lM_default.copyWith(
                    color: enabled
                        ? colors.onSurface
                        : colors.onSurface.withValues(alpha: 0.38),
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    "*",
                    style: typography.lM_default.copyWith(color: colors.error),
                  ),
                ],
                if (labelIcon != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    labelIcon,
                    size: 16,
                    color: enabled
                        ? colors.onSurface
                        : colors.onSurface.withValues(alpha: 0.38),
                  ),
                ],
              ],
            ),
          ),
        if (showInputFields)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Ux4gInputField(
                  value: _formatValue(value),
                  onValueChange: (v) {
                    final val = double.tryParse(v);
                    if (val != null && onValueChange != null)
                      onValueChange!(val.clamp(min, max));
                  },
                  size: Ux4gInputFieldSize.small,
                  postfixText: "%",
                  enabled: enabled,
                ),
              ),
              SizedBox(
                width: 80,
                child: Ux4gInputField(
                  value: _formatValue(max),
                  onValueChange: (_) {},
                  size: Ux4gInputFieldSize.small,
                  postfixText: "%",
                  enabled: false,
                ),
              ),
            ],
          )
        else if (showValueLabels ||
            startValueText != null ||
            endValueText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startValueText ?? "${_formatValue(min)}%",
                style: typography.lM_strong.copyWith(
                  color: enabled
                      ? colors.onSurface
                      : colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
              Text(
                endValueText ?? "${_formatValue(max)}%",
                style: typography.lM_strong.copyWith(
                  color: enabled
                      ? colors.onSurface
                      : colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMarksAndValues(
    BuildContext context,
    Ux4gTypography typography,
    Ux4gColors colors,
    Color activeColor,
    double activeMin,
    double activeMax,
  ) {
    final int totalTicks = steps! + 2;
    final List<double> values = List.generate(
      totalTicks,
      (i) => min + (max - min) * i / (totalTicks - 1),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
      child: Column(
        children: [
          // Ticks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: values.map((val) {
              final isActive = val >= activeMin && val <= activeMax;
              final tickColor = !enabled
                  ? colors.onSurface.withValues(alpha: 0.12)
                  : (isActive
                        ? activeColor
                        : colors.onSurface.withValues(alpha: 0.38));
              return Container(width: 1, height: 4, color: tickColor);
            }).toList(),
          ),
          const SizedBox(height: 4),
          // Values
          Row(
            children: List.generate(totalTicks, (i) {
              final val = values[i];
              final isActive = val >= activeMin && val <= activeMax;
              final textColor = !enabled
                  ? colors.onSurface.withValues(alpha: 0.38)
                  : (isActive
                        ? activeColor
                        : colors.onSurface.withValues(alpha: 0.6));

              TextAlign align = TextAlign.center;
              if (i == 0) align = TextAlign.left;
              if (i == totalTicks - 1) align = TextAlign.right;

              return Expanded(
                child: Text(
                  _formatValue(val),
                  textAlign: align,
                  style: typography.lM_default.copyWith(color: textColor),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCaption(
    BuildContext context,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    final color = switch (captionVariant) {
      Ux4gSliderCaptionVariant.helper => colors.onSurface.withValues(
        alpha: 0.7,
      ),
      Ux4gSliderCaptionVariant.error => colors.error,
      Ux4gSliderCaptionVariant.warning => Ux4gPalette.orange700,
      Ux4gSliderCaptionVariant.success => Ux4gPalette.green600,
    };

    return Row(
      children: [
        if (captionVariant == Ux4gSliderCaptionVariant.error) ...[
          Icon(Icons.error, size: 14, color: color),
          const SizedBox(width: 4),
        ] else if (captionVariant != Ux4gSliderCaptionVariant.helper) ...[
          Icon(Icons.info_outline, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Text(caption!, style: typography.lS_default.copyWith(color: color)),
      ],
    );
  }
}

class Ux4gRangeSlider extends StatelessWidget {
  final RangeValues values;
  final ValueChanged<RangeValues>? onValueChange;
  final double min;
  final double max;
  final int? steps;
  final Ux4gSliderSize size;
  final bool enabled;
  final String? label;
  final bool isRequired;
  final String? startValueText;
  final String? endValueText;
  final bool showMarksAndValues;
  final bool showInputFields;
  final bool showValueLabels;

  const Ux4gRangeSlider({
    super.key,
    required this.values,
    required this.onValueChange,
    this.min = 0.0,
    this.max = 100.0,
    this.steps,
    this.size = Ux4gSliderSize.small,
    this.enabled = true,
    this.label,
    this.isRequired = false,
    this.startValueText,
    this.endValueText,
    this.showMarksAndValues = false,
    this.showInputFields = false,
    this.showValueLabels = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final activeColor = enabled
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.38);
    final inactiveColor = colors.onSurface.withValues(alpha: 0.12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showValueLabels || showInputFields)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildTopRow(context, typography, colors),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: size.trackHeight,
            rangeThumbShape: _Ux4gRangeThumbShape(
              enabledThumbRadius: size.thumbSize / 2,
              borderColor: colors.onSurface.withValues(
                alpha: enabled ? 0.12 : 0.38,
              ),
            ),
            rangeTrackShape: _Ux4gRangeTrackShape(
              thumbRadius: size.thumbSize / 2,
            ),
            rangeTickMarkShape: RoundRangeSliderTickMarkShape(
              tickMarkRadius: 0,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            thumbColor: colors.onPrimary,
            overlayColor: activeColor.withValues(alpha: 0.12),
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: steps != null && steps! > 0 ? steps! + 1 : null,
            onChanged: enabled ? onValueChange : null,
            labels: RangeLabels(
              values.start.toInt().toString(),
              values.end.toInt().toString(),
            ),
          ),
        ),
        if (showMarksAndValues && steps != null && steps! > 0)
          Transform.translate(
            offset: const Offset(0, -12),
            child: _buildMarksAndValues(
              context,
              typography,
              colors,
              activeColor,
              values.start,
              values.end,
            ),
          ),
      ],
    );
  }

  Widget _buildTopRow(
    BuildContext context,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  label!,
                  style: typography.lM_default.copyWith(
                    color: enabled
                        ? colors.onSurface
                        : colors.onSurface.withValues(alpha: 0.38),
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    "*",
                    style: typography.lM_default.copyWith(color: colors.error),
                  ),
                ],
              ],
            ),
          ),
        if (showInputFields)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Ux4gInputField(
                  value: _formatValue(values.start),
                  onValueChange: (v) {
                    final val = double.tryParse(v);
                    if (val != null && onValueChange != null) {
                      onValueChange!(
                        RangeValues(val.clamp(min, values.end), values.end),
                      );
                    }
                  },
                  size: Ux4gInputFieldSize.small,
                  postfixText: "%",
                  enabled: enabled,
                ),
              ),
              SizedBox(
                width: 80,
                child: Ux4gInputField(
                  value: _formatValue(values.end),
                  onValueChange: (v) {
                    final val = double.tryParse(v);
                    if (val != null && onValueChange != null) {
                      onValueChange!(
                        RangeValues(values.start, val.clamp(values.start, max)),
                      );
                    }
                  },
                  size: Ux4gInputFieldSize.small,
                  postfixText: "%",
                  enabled: enabled,
                ),
              ),
            ],
          )
        else if (showValueLabels ||
            startValueText != null ||
            endValueText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startValueText ?? "${_formatValue(values.start)}%",
                style: typography.lM_strong.copyWith(
                  color: enabled
                      ? colors.onSurface
                      : colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
              Text(
                endValueText ?? "${_formatValue(values.end)}%",
                style: typography.lM_strong.copyWith(
                  color: enabled
                      ? colors.onSurface
                      : colors.onSurface.withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMarksAndValues(
    BuildContext context,
    Ux4gTypography typography,
    Ux4gColors colors,
    Color activeColor,
    double activeMin,
    double activeMax,
  ) {
    final int totalTicks = steps! + 2;
    final List<double> vals = List.generate(
      totalTicks,
      (i) => min + (max - min) * i / (totalTicks - 1),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: vals.map((val) {
              final isActive = val >= activeMin && val <= activeMax;
              final tickColor = !enabled
                  ? colors.onSurface.withValues(alpha: 0.12)
                  : (isActive
                        ? activeColor
                        : colors.onSurface.withValues(alpha: 0.38));
              return Container(width: 1, height: 4, color: tickColor);
            }).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(totalTicks, (i) {
              final val = vals[i];
              final isActive = val >= activeMin && val <= activeMax;
              final textColor = !enabled
                  ? colors.onSurface.withValues(alpha: 0.38)
                  : (isActive
                        ? activeColor
                        : colors.onSurface.withValues(alpha: 0.6));

              TextAlign align = TextAlign.center;
              if (i == 0) align = TextAlign.left;
              if (i == totalTicks - 1) align = TextAlign.right;

              return Expanded(
                child: Text(
                  _formatValue(val),
                  textAlign: align,
                  style: typography.lM_default.copyWith(color: textColor),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

String _formatValue(double v) {
  if (v % 1 == 0) return v.toInt().toString();
  return v.toStringAsFixed(1);
}

class _Ux4gThumbShape extends RoundSliderThumbShape {
  final Color borderColor;

  const _Ux4gThumbShape({
    required super.enabledThumbRadius,
    required this.borderColor,
  });

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final double radius = enabledThumbRadius;

    // Draw shadow
    final Path shadowPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawShadow(shadowPath, Colors.black, 2.0, true);

    // Draw thumb fill
    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, fillPaint);

    // Draw border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, borderPaint);
  }
}

class _Ux4gRangeThumbShape extends RoundRangeSliderThumbShape {
  final Color borderColor;

  const _Ux4gRangeThumbShape({
    required super.enabledThumbRadius,
    required this.borderColor,
  });

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final double radius = enabledThumbRadius;

    // Draw shadow
    final Path shadowPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawShadow(shadowPath, Colors.black, 2.0, true);

    // Draw thumb fill
    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, fillPaint);

    // Draw border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, borderPaint);
  }
}

class _Ux4gTrackShape extends RoundedRectSliderTrackShape {
  final double thumbRadius;

  const _Ux4gTrackShape({required this.thumbRadius});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx + thumbRadius;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - (thumbRadius * 2);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class _Ux4gRangeTrackShape extends RoundedRectRangeSliderTrackShape {
  final double thumbRadius;

  const _Ux4gRangeTrackShape({required this.thumbRadius});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx + thumbRadius;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - (thumbRadius * 2);
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
