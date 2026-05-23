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
          PropRow(name: 'showPercentage', type: 'bool', description: 'Show percentage text.', defaultValue: 'false'),
          PropRow(name: 'shape', type: 'Ux4gProgressShape', description: 'sharp or rounded.', defaultValue: 'rounded'),
          PropRow(name: 'label', type: 'String?', description: 'Text above the bar.'),
          PropRow(name: 'hint', type: 'String?', description: 'Secondary text below.'),
          PropRow(name: 'gradientColors', type: 'List<Color>?', description: 'Gradient fill colors.'),
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
    WidgetbookUseCase(
      name: 'Animated',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAnimatedLinearProgress',
        description: 'Animated version of the linear progress bar.',
        code: '''Ux4gAnimatedLinearProgress(value: 0.6);''',
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
          PropRow(name: 'centerValueText', type: 'String?', description: 'Text shown in the centre.'),
          PropRow(name: 'label', type: 'String?', description: 'Text below the circle.'),
          PropRow(name: 'size', type: 'Ux4gCircularProgressSize', description: 'xs / s / m / l / xl / xxl / xxxl.', defaultValue: 'm'),
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
          PropRow(name: 'description', type: 'String?', description: 'Text below the arc.'),
          PropRow(name: 'size', type: 'Ux4gHalfCircleProgressSize', description: 's / m / l / xl.', defaultValue: 'm'),
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
          PropRow(name: 'strokeWidth', type: 'double', description: 'Arc stroke thickness.', defaultValue: '4'),
          PropRow(name: 'percentage', type: 'double', description: 'Arc fill amount (0–100).', defaultValue: '100'),
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
          PropRow(name: 'value', type: 'double', description: 'Progress value from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gCircularProgressSize', description: 'xs / s / m / l / xl / xxl / xxxl.', defaultValue: 'l'),
          PropRow(name: 'centerValueText', type: 'String?', description: 'Text displayed inside the circle.'),
          PropRow(name: 'label', type: 'String?', description: 'Label below the circle.'),
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
          PropRow(name: 'value', type: 'double', description: 'Progress value from 0.0 to 1.0.', required: true),
          PropRow(name: 'size', type: 'Ux4gHalfCircleProgressSize', description: 's / m / l / xl.', defaultValue: 'l'),
          PropRow(name: 'valueText', type: 'String?', description: 'Text inside the arc.'),
          PropRow(name: 'description', type: 'String?', description: 'Description below the arc.'),
          PropRow(name: 'showScale', type: 'bool', description: 'Show min/max scale labels.', defaultValue: 'false'),
          PropRow(name: 'duration', type: 'Duration', description: 'Animation duration.', defaultValue: '700ms'),
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
