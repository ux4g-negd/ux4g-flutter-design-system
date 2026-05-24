import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Linear Progress ───────────────────────────────────────────────────────────

final linearProgressComponent = WidgetbookComponent(
  name: 'Ux4gLinearProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gLinearProgress',
        description: 'A horizontal progress bar with optional label, hint, icon, '
            'percentage display, gradient fill, and shape.',
        code: '''Ux4gLinearProgress(
  value: 0.6,                       // 0.0 – 1.0
  showPercentage: true,
  shape: Ux4gProgressShape.rounded,
);

// With label and icon
Ux4gLinearProgress(
  value: 0.75,
  label: 'Uploading...',
  hint: 'Almost done',
  icon: Icons.cloud_upload_outlined,
  showPercentage: true,
);

// Animated
Ux4gAnimatedLinearProgress(value: 0.6);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'icon', type: 'IconData?', description: 'Leading icon above the bar.'),
          PropRow(name: 'iconColor', type: 'Color?', description: 'Color of the leading icon.'),
          PropRow(name: 'iconBackgroundColor', type: 'Color?', description: 'Background circle color for the icon.'),
          PropRow(name: 'label', type: 'String?', description: 'Text above the bar.'),
          PropRow(name: 'hint', type: 'String?', description: 'Secondary text below.'),
          PropRow(name: 'height', type: 'double', description: 'Thickness of the bar.', defaultValue: '8'),
          PropRow(name: 'shape', type: 'Ux4gProgressShape', description: 'sharp or rounded.', defaultValue: 'rounded'),
          PropRow(name: 'customBorderRadius', type: 'double?', description: 'Override for corner roundness.'),
          PropRow(name: 'color', type: 'Color?', description: 'Solid fill color.'),
          PropRow(name: 'gradientColors', type: 'List<Color>?', description: 'Gradient fill colors (overrides color).'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Background track color.'),
          PropRow(name: 'showPercentage', type: 'bool', description: 'Show percentage text.', defaultValue: 'false'),
          PropRow(name: 'labelPosition', type: 'Ux4gProgressLabelPosition', description: 'outside or inside.', defaultValue: 'outside'),
          PropRow(name: 'insideLabelStyle', type: 'TextStyle?', description: 'Style for percentage text when inside.'),
        ],
        child: SizedBox(
          width: 300,
          child: Ux4gLinearProgress(
            value: context.knobs.double.slider(label: 'Value', initialValue: 0.6, min: 0, max: 1),
            showPercentage: context.knobs.boolean(label: 'Show %', initialValue: true),
            shape: context.knobs.list(
              label: 'Shape', options: Ux4gProgressShape.values,
              initialOption: Ux4gProgressShape.rounded, labelBuilder: (v) => v.name,
            ),
          ),
        ),
      ),
    ),
  ],
);

final animatedLinearProgressComponent = WidgetbookComponent(
  name: 'Ux4gAnimatedLinearProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAnimatedLinearProgress',
        description: 'Animated version of the linear progress bar.',
        code: '''Ux4gAnimatedLinearProgress(value: 0.6);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'icon', type: 'IconData?', description: 'Leading icon above the bar.'),
          PropRow(name: 'iconColor', type: 'Color?', description: 'Color of the leading icon.'),
          PropRow(name: 'iconBackgroundColor', type: 'Color?', description: 'Background circle color for the icon.'),
          PropRow(name: 'label', type: 'String?', description: 'Text above the bar.'),
          PropRow(name: 'hint', type: 'String?', description: 'Secondary text below.'),
          PropRow(name: 'height', type: 'double', description: 'Thickness of the bar.', defaultValue: '8'),
          PropRow(name: 'shape', type: 'Ux4gProgressShape', description: 'sharp or rounded.', defaultValue: 'rounded'),
          PropRow(name: 'customBorderRadius', type: 'double?', description: 'Override for corner roundness.'),
          PropRow(name: 'color', type: 'Color?', description: 'Solid fill color.'),
          PropRow(name: 'gradientColors', type: 'List<Color>?', description: 'Gradient fill colors (overrides color).'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Background track color.'),
          PropRow(name: 'showPercentage', type: 'bool', description: 'Show percentage text.', defaultValue: 'false'),
          PropRow(name: 'labelPosition', type: 'Ux4gProgressLabelPosition', description: 'outside or inside.', defaultValue: 'outside'),
          PropRow(name: 'insideLabelStyle', type: 'TextStyle?', description: 'Style for percentage text when inside.'),
          PropRow(name: 'duration', type: 'Duration', description: 'Animation duration.', defaultValue: '600ms'),
          PropRow(name: 'curve', type: 'Curve', description: 'Animation curve.', defaultValue: 'easeInOut'),
        ],
        child: SizedBox(
          width: 300,
          child: Ux4gAnimatedLinearProgress(
            value: context.knobs.double.slider(label: 'Value', initialValue: 0.6, min: 0, max: 1),
          ),
        ),
      ),
    ),
  ],
);

// ── Circular Progress ─────────────────────────────────────────────────────────

final circularProgressComponent = WidgetbookComponent(
  name: 'Ux4gCircularProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCircularProgress',
        description: 'A circular gauge that displays a progress value with an optional centre text and label.',
        code: '''Ux4gCircularProgress(
  value: 0.65,
  centerValueText: '65%',
  label: 'Progress',
  size: Ux4gCircularProgressSize.m,
);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gCircularProgressSize', description: 'xs / s / m / l / xl / xxl / xxxl.', defaultValue: 'l'),
          PropRow(name: 'diameter', type: 'double?', description: 'Custom diameter override.'),
          PropRow(name: 'strokeWidth', type: 'double?', description: 'Custom arc thickness override.'),
          PropRow(name: 'progressColor', type: 'Color?', description: 'Color of the progress arc.'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Color of the background track.'),
          PropRow(name: 'progressGradient', type: 'Gradient?', description: 'Gradient fill for the progress arc.'),
          PropRow(name: 'strokeCap', type: 'StrokeCap', description: 'butt / round / square.', defaultValue: 'butt'),
          PropRow(name: 'startAngle', type: 'double', description: 'Starting angle in radians.', defaultValue: '-π/2'),
          PropRow(name: 'centerValueText', type: 'String?', description: 'Large text inside/below the circle.'),
          PropRow(name: 'centerDescription', type: 'String?', description: 'Smaller text below centerValueText.'),
          PropRow(name: 'center', type: 'Widget?', description: 'Custom widget inside the circle.'),
          PropRow(name: 'label', type: 'String?', description: 'Main title below the circle.'),
          PropRow(name: 'description', type: 'String?', description: 'Supporting text below the label.'),
          PropRow(name: 'footer', type: 'Widget?', description: 'Widget shown at the very bottom.'),
          PropRow(name: 'padding', type: 'EdgeInsetsGeometry?', description: 'Outer padding.'),
          PropRow(name: 'mainAxisSize', type: 'MainAxisSize', description: 'Column size.', defaultValue: 'min'),
          PropRow(name: 'crossAxisAlignment', type: 'CrossAxisAlignment', description: 'Alignment.', defaultValue: 'center'),
          PropRow(name: 'textAlign', type: 'TextAlign', description: 'Text alignment.', defaultValue: 'center'),
          PropRow(name: 'gap', type: 'double', description: 'Spacing between elements.', defaultValue: '8'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Background color behind the ring.'),
          PropRow(name: 'labelStyle', type: 'TextStyle?', description: 'Style for the label.'),
          PropRow(name: 'descriptionStyle', type: 'TextStyle?', description: 'Style for the description.'),
        ],
        child: Ux4gCircularProgress(
          value: context.knobs.double.slider(label: 'Value', initialValue: 0.65, min: 0, max: 1),
          centerValueText: '65%',
          label: 'Progress',
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCircularProgress — Sizes',
        description: 'All available circular progress sizes.',
        code: '''Wrap(
  children: Ux4gCircularProgressSize.values
      .map((s) => Ux4gCircularProgress(value: 0.6, size: s))
      .toList(),
);''',
        child: Wrap(
          spacing: 16, runSpacing: 12,
          children: Ux4gCircularProgressSize.values.map((s) => Ux4gCircularProgress(value: 0.6, size: s)).toList(),
        ),
      ),
    ),
  ],
);

// ── Half-circle Progress ──────────────────────────────────────────────────────

final halfCircleProgressComponent = WidgetbookComponent(
  name: 'Ux4gHalfCircleProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gHalfCircleProgress',
        description: 'A semi-circular gauge with optional description text.',
        code: '''Ux4gHalfCircleProgress(
  value: 0.6,
  description: 'Progress',
  size: Ux4gHalfCircleProgressSize.m,
);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gHalfCircleProgressSize', description: 's / m / l / xl.', defaultValue: 'l'),
          PropRow(name: 'width', type: 'double?', description: 'Custom width override.'),
          PropRow(name: 'strokeWidth', type: 'double?', description: 'Custom arc thickness override.'),
          PropRow(name: 'progressColor', type: 'Color?', description: 'Color of the progress arc.'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Color of the background track.'),
          PropRow(name: 'progressGradient', type: 'Gradient?', description: 'Gradient for the progress arc.'),
          PropRow(name: 'strokeCap', type: 'StrokeCap', description: 'butt / round / square.', defaultValue: 'round'),
          PropRow(name: 'valueText', type: 'String?', description: 'Text shown inside the arc (defaults to %).'),
          PropRow(name: 'description', type: 'String?', description: 'Supporting text below/inside the arc.'),
          PropRow(name: 'showScale', type: 'bool', description: 'Show 0% and 100% labels.', defaultValue: 'false'),
          PropRow(name: 'valueStyle', type: 'TextStyle?', description: 'Style for valueText.'),
          PropRow(name: 'descriptionStyle', type: 'TextStyle?', description: 'Style for description.'),
          PropRow(name: 'scaleStyle', type: 'TextStyle?', description: 'Style for scale labels.'),
          PropRow(name: 'gap', type: 'double', description: 'Gap between arc and content.', defaultValue: '4'),
        ],
        child: Ux4gHalfCircleProgress(
          value: context.knobs.double.slider(label: 'Value', initialValue: 0.6, min: 0, max: 1),
          description: 'Progress',
        ),
      ),
    ),
  ],
);

// ── Loader ────────────────────────────────────────────────────────────────────

final loaderComponent = WidgetbookComponent(
  name: 'Ux4gLoader',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gLoader',
        description: 'A circular spinning loader indicator. '
            'Customise size, stroke width, and percentage fill.',
        code: '''// Basic spinner
Ux4gLoader(size: 40);

// Customised
Ux4gLoader(
  size: 48,
  strokeWidth: 5,
  percentage: 75,
);''',
        props: const [
          PropRow(name: 'size', type: 'double', description: 'Diameter of the loader.', defaultValue: '40'),
          PropRow(name: 'color', type: 'Color?', description: 'Color of the spinner.'),
          PropRow(name: 'percentage', type: 'double', description: 'Arc fill amount (0–100).', defaultValue: '100'),
          PropRow(name: 'strokeWidth', type: 'double', description: 'Arc stroke thickness.', defaultValue: '4'),
          PropRow(name: 'rotationDurationMillis', type: 'int', description: 'Speed of rotation.', defaultValue: '1200'),
        ],
        child: Ux4gLoader(
          size: context.knobs.double.slider(label: 'Size', initialValue: 40, min: 20, max: 80),
          percentage: context.knobs.double.slider(label: 'Percentage', initialValue: 100, min: 0, max: 100),
          strokeWidth: context.knobs.double.slider(label: 'Stroke width', initialValue: 4, min: 2, max: 10),
        ),
      ),
    ),
  ],
);

// ── Animated Circular Progress ────────────────────────────────────────────────

final animatedCircularProgressComponent = WidgetbookComponent(
  name: 'Ux4gAnimatedCircularProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAnimatedCircularProgress',
        description:
            'An animated version of Ux4gCircularProgress. Smoothly transitions '
            'from 0 to the target value using a tween animation.',
        code: '''Ux4gAnimatedCircularProgress(
  value: 0.75,
  size: Ux4gCircularProgressSize.l,
  centerValueText: '75%',
  label: 'Progress',
  duration: Duration(milliseconds: 700),
  curve: Curves.easeInOut,
);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gCircularProgressSize', description: 'xs / s / m / l / xl / xxl / xxxl.', defaultValue: 'l'),
          PropRow(name: 'diameter', type: 'double?', description: 'Custom diameter override.'),
          PropRow(name: 'strokeWidth', type: 'double?', description: 'Custom arc thickness override.'),
          PropRow(name: 'progressColor', type: 'Color?', description: 'Color of the progress arc.'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Color of the background track.'),
          PropRow(name: 'progressGradient', type: 'Gradient?', description: 'Gradient fill for the progress arc.'),
          PropRow(name: 'strokeCap', type: 'StrokeCap', description: 'butt / round / square.', defaultValue: 'butt'),
          PropRow(name: 'startAngle', type: 'double', description: 'Starting angle in radians.', defaultValue: '-π/2'),
          PropRow(name: 'centerValueText', type: 'String?', description: 'Large text inside/below the circle.'),
          PropRow(name: 'centerDescription', type: 'String?', description: 'Smaller text below centerValueText.'),
          PropRow(name: 'center', type: 'Widget?', description: 'Custom widget inside the circle.'),
          PropRow(name: 'label', type: 'String?', description: 'Main title below the circle.'),
          PropRow(name: 'description', type: 'String?', description: 'Supporting text below the label.'),
          PropRow(name: 'footer', type: 'Widget?', description: 'Widget shown at the very bottom.'),
          PropRow(name: 'padding', type: 'EdgeInsetsGeometry?', description: 'Outer padding.'),
          PropRow(name: 'mainAxisSize', type: 'MainAxisSize', description: 'Column size.', defaultValue: 'min'),
          PropRow(name: 'crossAxisAlignment', type: 'CrossAxisAlignment', description: 'Alignment.', defaultValue: 'center'),
          PropRow(name: 'textAlign', type: 'TextAlign', description: 'Text alignment.', defaultValue: 'center'),
          PropRow(name: 'gap', type: 'double', description: 'Spacing between elements.', defaultValue: '8'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Background color behind the ring.'),
          PropRow(name: 'labelStyle', type: 'TextStyle?', description: 'Style for the label.'),
          PropRow(name: 'descriptionStyle', type: 'TextStyle?', description: 'Style for the description.'),
          PropRow(name: 'duration', type: 'Duration', description: 'Animation duration.', defaultValue: '700ms'),
          PropRow(name: 'curve', type: 'Curve', description: 'Animation curve.', defaultValue: 'easeInOut'),
        ],
        child: Ux4gAnimatedCircularProgress(
          value: context.knobs.double.slider(label: 'Value', initialValue: 0.75, min: 0, max: 1),
          size: context.knobs.list(
            label: 'Size',
            options: Ux4gCircularProgressSize.values,
            initialOption: Ux4gCircularProgressSize.l,
            labelBuilder: (v) => v.name,
          ),
          centerValueText: '75%',
          label: 'Animated',
        ),
      ),
    ),
  ],
);

// ── Animated Half-Circle Progress ─────────────────────────────────────────────

final animatedHalfCircleProgressComponent = WidgetbookComponent(
  name: 'Ux4gAnimatedHalfCircleProgress',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAnimatedHalfCircleProgress',
        description:
            'An animated version of Ux4gHalfCircleProgress. Smoothly transitions '
            'from 0 to the target value using a tween animation.',
        code: '''Ux4gAnimatedHalfCircleProgress(
  value: 0.65,
  size: Ux4gHalfCircleProgressSize.l,
  valueText: '65',
  description: 'Score',
  showScale: true,
  duration: Duration(milliseconds: 700),
);''',
        props: const [
          PropRow(name: 'value', type: 'double', description: 'Progress from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gHalfCircleProgressSize', description: 's / m / l / xl.', defaultValue: 'l'),
          PropRow(name: 'width', type: 'double?', description: 'Custom width override.'),
          PropRow(name: 'strokeWidth', type: 'double?', description: 'Custom arc thickness override.'),
          PropRow(name: 'progressColor', type: 'Color?', description: 'Color of the progress arc.'),
          PropRow(name: 'trackColor', type: 'Color?', description: 'Color of the background track.'),
          PropRow(name: 'progressGradient', type: 'Gradient?', description: 'Gradient for the progress arc.'),
          PropRow(name: 'strokeCap', type: 'StrokeCap', description: 'butt / round / square.', defaultValue: 'round'),
          PropRow(name: 'valueText', type: 'String?', description: 'Text shown inside the arc (defaults to %).'),
          PropRow(name: 'description', type: 'String?', description: 'Supporting text below/inside the arc.'),
          PropRow(name: 'showScale', type: 'bool', description: 'Show 0% and 100% labels.', defaultValue: 'false'),
          PropRow(name: 'valueStyle', type: 'TextStyle?', description: 'Style for valueText.'),
          PropRow(name: 'descriptionStyle', type: 'TextStyle?', description: 'Style for description.'),
          PropRow(name: 'scaleStyle', type: 'TextStyle?', description: 'Style for scale labels.'),
          PropRow(name: 'gap', type: 'double', description: 'Gap between arc and content.', defaultValue: '4'),
          PropRow(name: 'duration', type: 'Duration', description: 'Animation duration.', defaultValue: '700ms'),
          PropRow(name: 'curve', type: 'Curve', description: 'Animation curve.', defaultValue: 'easeInOut'),
        ],
        child: Ux4gAnimatedHalfCircleProgress(
          value: context.knobs.double.slider(label: 'Value', initialValue: 0.65, min: 0, max: 1),
          size: context.knobs.list(
            label: 'Size',
            options: Ux4gHalfCircleProgressSize.values,
            initialOption: Ux4gHalfCircleProgressSize.l,
            labelBuilder: (v) => v.name,
          ),
          valueText: '65',
          description: 'Animated',
          showScale: context.knobs.boolean(label: 'Show scale', initialValue: true),
        ),
      ),
    ),
  ],
);
