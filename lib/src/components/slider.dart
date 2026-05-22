import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
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
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final isError = captionVariant == Ux4gSliderCaptionVariant.error;
    final activeColor = enabled
        ? (isError ? (ux4gColors?.error ?? materialTheme.colorScheme.error) : (ux4gColors?.primary ?? materialTheme.colorScheme.primary))
        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38);
    final inactiveColor = (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showValueLabels || showInputFields)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildTopRow(context, ux4gTypography, ux4gColors, materialTheme),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: size.trackHeight,
            thumbShape: _Ux4gThumbShape(
              enabledThumbRadius: size.thumbSize / 2,
              borderColor: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
                alpha: enabled ? 0.12 : 0.38,
              ),
            ),
            trackShape: _Ux4gTrackShape(thumbRadius: size.thumbSize / 2),
            tickMarkShape: SliderTickMarkShape.noTickMark,
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            thumbColor: ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary,
            overlayColor: activeColor.withValues(alpha: 0.12),
            showValueIndicator: showIndicator
                ? ShowValueIndicator.onDrag
                : ShowValueIndicator.never,
            valueIndicatorColor: ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface,
            valueIndicatorTextStyle: (ux4gTypography?.lS_strong ?? materialTheme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
              color: ux4gColors?.surface ?? materialTheme.colorScheme.surface,
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
              ux4gTypography,
              ux4gColors,
              materialTheme,
              activeColor,
              min,
              value,
            ),
          ),
        if (caption != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildCaption(context, ux4gTypography, ux4gColors, materialTheme),
          ),
        ],
      ],
    );
  }

  Widget _buildTopRow(
    BuildContext context,
    Ux4gTypography? ux4gTypography,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
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
                  style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(
                    color: enabled
                        ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    "*",
                    style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(color: ux4gColors?.error ?? materialTheme.colorScheme.error),
                  ),
                ],
                if (labelIcon != null) ...[
                  const SizedBox(width: 4),
                  Icon(
                    labelIcon,
                    size: 16,
                    color: enabled
                        ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
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
                style: (ux4gTypography?.lM_strong ?? materialTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
                  color: enabled
                      ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                ),
              ),
              Text(
                endValueText ?? "${_formatValue(max)}%",
                style: (ux4gTypography?.lM_strong ?? materialTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
                  color: enabled
                      ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMarksAndValues(
    BuildContext context,
    Ux4gTypography? ux4gTypography,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
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
                  ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12)
                  : (isActive
                        ? activeColor
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38));
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
                  ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38)
                  : (isActive
                        ? activeColor
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.6));

              TextAlign align = TextAlign.center;
              if (i == 0) align = TextAlign.left;
              if (i == totalTicks - 1) align = TextAlign.right;

              return Expanded(
                child: Text(
                  _formatValue(val),
                  textAlign: align,
                  style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(color: textColor),
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
    Ux4gTypography? ux4gTypography,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
  ) {
    final color = switch (captionVariant) {
      Ux4gSliderCaptionVariant.helper => (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
        alpha: 0.7,
      ),
      Ux4gSliderCaptionVariant.error => ux4gColors?.error ?? materialTheme.colorScheme.error,
      Ux4gSliderCaptionVariant.warning => ux4gColors?.warning ?? Ux4gPalette.secondary,
      Ux4gSliderCaptionVariant.success => ux4gColors?.success ?? Ux4gPalette.green,
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
        Text(caption!, style: (ux4gTypography?.lS_default ?? materialTheme.textTheme.labelSmall ?? const TextStyle()).copyWith(color: color)),
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
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final activeColor = enabled
        ? (ux4gColors?.primary ?? materialTheme.colorScheme.primary)
        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38);
    final inactiveColor = (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || showValueLabels || showInputFields)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.thumbSize / 2),
            child: _buildTopRow(context, ux4gTypography, ux4gColors, materialTheme),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: size.trackHeight,
            rangeThumbShape: _Ux4gRangeThumbShape(
              enabledThumbRadius: size.thumbSize / 2,
              borderColor: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
                alpha: enabled ? 0.12 : 0.38,
              ),
            ),
            rangeTrackShape: _Ux4gRangeTrackShape(
              thumbRadius: size.thumbSize / 2,
            ),
            rangeTickMarkShape: const RoundRangeSliderTickMarkShape(
              tickMarkRadius: 0,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            thumbColor: ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary,
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
              ux4gTypography,
              ux4gColors,
              materialTheme,
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
    Ux4gTypography? ux4gTypography,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
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
                  style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(
                    color: enabled
                        ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                  ),
                ),
                if (isRequired) ...[
                  const SizedBox(width: 4),
                  Text(
                    "*",
                    style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(color: ux4gColors?.error ?? materialTheme.colorScheme.error),
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
                style: (ux4gTypography?.lM_strong ?? materialTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
                  color: enabled
                      ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                ),
              ),
              Text(
                endValueText ?? "${_formatValue(values.end)}%",
                style: (ux4gTypography?.lM_strong ?? materialTheme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
                  color: enabled
                      ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                      : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMarksAndValues(
    BuildContext context,
    Ux4gTypography? ux4gTypography,
    Ux4gColors? ux4gColors,
    ThemeData materialTheme,
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
                  ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12)
                  : (isActive
                        ? activeColor
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38));
              return Container(width: 1, height: 4, color: tickColor);
            }).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(totalTicks, (i) {
              final val = vals[i];
              final isActive = val >= activeMin && val <= activeMax;
              final textColor = !enabled
                  ? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38)
                  : (isActive
                        ? activeColor
                        : (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.6));

              TextAlign align = TextAlign.center;
              if (i == 0) align = TextAlign.left;
              if (i == totalTicks - 1) align = TextAlign.right;

              return Expanded(
                child: Text(
                  _formatValue(val),
                  textAlign: align,
                  style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium ?? const TextStyle()).copyWith(color: textColor),
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
