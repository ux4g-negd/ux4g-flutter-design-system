import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

final tagComponent = WidgetbookComponent(
  name: 'Ux4gTag',
  useCases: [
    WidgetbookUseCase(
      name: 'Styles',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag',
        description: 'A compact label chip with four style variants and six color schemes. '
            'Optionally dismissible.',
        code: '''// Style variants
Ux4gTag(text: 'Tonal',   style: Ux4gTagStyle.tonal);
Ux4gTag(text: 'Filled',  style: Ux4gTagStyle.filled);
Ux4gTag(text: 'Outline', style: Ux4gTagStyle.outline);
Ux4gTag(text: 'Text',    style: Ux4gTagStyle.text);

// Color schemes
Ux4gTag(text: 'Brand',   colorScheme: Ux4gTagColor.brand);
Ux4gTag(text: 'Success', colorScheme: Ux4gTagColor.success);
Ux4gTag(text: 'Warning', colorScheme: Ux4gTagColor.warning);
Ux4gTag(text: 'Error',   colorScheme: Ux4gTagColor.error);

// Dismissible
Ux4gTag(text: 'Close me', onDismiss: () {});''',
        props: const [
          PropRow(name: 'text', type: 'String', description: 'Label text.', required: true),
          PropRow(name: 'style', type: 'Ux4gTagStyle', description: 'tonal / filled / outline / text.', defaultValue: 'tonal'),
          PropRow(name: 'colorScheme', type: 'Ux4gTagColor', description: 'neutral / brand / success / warning / error / info.', defaultValue: 'neutral'),
          PropRow(name: 'size', type: 'Ux4gTagSize', description: 'm / l.', defaultValue: 'm'),
          PropRow(name: 'onDismiss', type: 'VoidCallback?', description: 'Shows × button when provided.'),
        ],
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: Ux4gTagStyle.values.map((s) => Ux4gTag(text: s.name, style: s)).toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Color schemes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag — Colors',
        description: 'Six semantic color schemes available.',
        code: '''Ux4gTag(text: 'neutral', colorScheme: Ux4gTagColor.neutral);
Ux4gTag(text: 'brand',   colorScheme: Ux4gTagColor.brand);
Ux4gTag(text: 'success', colorScheme: Ux4gTagColor.success);
Ux4gTag(text: 'warning', colorScheme: Ux4gTagColor.warning);
Ux4gTag(text: 'error',   colorScheme: Ux4gTagColor.error);
Ux4gTag(text: 'info',    colorScheme: Ux4gTagColor.info);''',
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: Ux4gTagColor.values.map((c) => Ux4gTag(text: c.name, colorScheme: c)).toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Interactive (knobs)',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag — Interactive',
        description: 'Use the knobs panel to customise style, color, and size.',
        code: '''Ux4gTag(
  text: 'Label',
  style: Ux4gTagStyle.tonal,
  colorScheme: Ux4gTagColor.brand,
  size: Ux4gTagSize.m,
);''',
        child: Ux4gTag(
          text: context.knobs.string(label: 'Text', initialValue: 'Label'),
          style: context.knobs.list(
            label: 'Style', options: Ux4gTagStyle.values,
            initialOption: Ux4gTagStyle.tonal, labelBuilder: (v) => v.name,
          ),
          colorScheme: context.knobs.list(
            label: 'Color', options: Ux4gTagColor.values,
            initialOption: Ux4gTagColor.brand, labelBuilder: (v) => v.name,
          ),
          size: context.knobs.list(
            label: 'Size', options: Ux4gTagSize.values,
            initialOption: Ux4gTagSize.m, labelBuilder: (v) => v.name,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Shapes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag — Shapes',
        description: 'Circular tags are fully rounded; rectangular tags have a smaller border radius.',
        code: '''Ux4gTag(text: 'Rectangular', shape: Ux4gTagShape.rectangular);
Ux4gTag(text: 'Circular',    shape: Ux4gTagShape.circular);''',
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            Ux4gTag(text: 'Rectangular', shape: Ux4gTagShape.rectangular, colorScheme: Ux4gTagColor.brand),
            Ux4gTag(text: 'Circular',    shape: Ux4gTagShape.circular,    colorScheme: Ux4gTagColor.brand),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag — Sizes',
        description: 'Medium (m) and Large (l) size variants side-by-side.',
        code: '''Ux4gTag(text: 'Medium', size: Ux4gTagSize.m);
Ux4gTag(text: 'Large',  size: Ux4gTagSize.l);''',
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            Ux4gTag(text: 'Medium', size: Ux4gTagSize.m, colorScheme: Ux4gTagColor.brand),
            Ux4gTag(text: 'Large',  size: Ux4gTagSize.l, colorScheme: Ux4gTagColor.brand),
          ],
        ),
      ),
    ),
  ],
);

final cardComponent = WidgetbookComponent(
  name: 'Ux4gCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Basic content',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard',
        description: 'A surface container with optional title, subtitle, body text, '
            'media image, and footer action buttons.',
        code: '''Ux4gCard(
  title: 'Card Title',
  subtitle: 'Subtitle',
  body: 'Card body content here.',
);

// With footer buttons
Ux4gCard(
  title: 'Confirm Action',
  body: 'Are you sure?',
  footerType: Ux4gCardFooterType.primaryAndSecondary,
  primaryButtonText: 'Confirm',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
);''',
        props: const [
          PropRow(name: 'title', type: 'String?', description: 'Card heading text.'),
          PropRow(name: 'subtitle', type: 'String?', description: 'Smaller text below title.'),
          PropRow(name: 'body', type: 'String?', description: 'Main body text.'),
          PropRow(name: 'mediaImageUrl', type: 'String?', description: 'URL for top media image.'),
          PropRow(name: 'footerType', type: 'Ux4gCardFooterType?', description: 'Controls footer button layout.'),
          PropRow(name: 'child', type: 'Widget?', description: 'Custom content (overrides text fields).'),
        ],
        child: SizedBox(
          width: 320,
          child: Ux4gCard(
            title: context.knobs.string(label: 'Title', initialValue: 'Card Title'),
            subtitle: context.knobs.string(label: 'Subtitle', initialValue: 'Card subtitle'),
            body: context.knobs.string(label: 'Body', initialValue: 'This is the card body.'),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With footer buttons',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard — With Actions',
        description: 'Attach primary and/or secondary action buttons to the card footer.',
        code: '''Ux4gCard(
  title: 'Confirm Action',
  body: 'This action cannot be undone.',
  footerType: Ux4gCardFooterType.primaryAndSecondary,
  primaryButtonText: 'Confirm',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
);''',
        child: SizedBox(
          width: 320,
          child: Ux4gCard(
            title: 'Card with Actions',
            body: 'This card has primary and secondary action buttons.',
            footerType: Ux4gCardFooterType.primaryAndSecondary,
            primaryButtonText: 'Confirm',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Horizontal layout',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard — Horizontal',
        description: 'When direction is set to horizontal, the media thumbnail appears on the left side.',
        code: '''Ux4gCard(
  title: 'Horizontal Card',
  subtitle: 'Side-by-side layout',
  body: 'Media appears on the left.',
  direction: Ux4gCardDirection.horizontal,
  mediaImageUrl: 'https://picsum.photos/200/200',
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gCard(
            title: 'Horizontal Card',
            subtitle: 'Side-by-side layout',
            body: 'The media thumbnail appears on the left in horizontal mode.',
            direction: Ux4gCardDirection.horizontal,
            mediaImageUrl: 'https://picsum.photos/200/200',
            mediaWidth: 100,
            mediaHeight: 100,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With media',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard — With Media',
        description: 'Provide a mediaImageUrl to display a hero image at the top of the card.',
        code: '''Ux4gCard(
  title: 'Media Card',
  body: 'Hero image displayed above the content.',
  mediaImageUrl: 'https://picsum.photos/400/200',
);''',
        child: SizedBox(
          width: 320,
          child: Ux4gCard(
            title: 'Media Card',
            subtitle: 'Hero image above content',
            body: 'This card displays a hero image at the top.',
            mediaImageUrl: 'https://picsum.photos/400/200',
          ),
        ),
      ),
    ),
  ],
);

final dividerComponent = WidgetbookComponent(
  name: 'Ux4gDivider',
  useCases: [
    WidgetbookUseCase(
      name: 'Horizontal',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider',
        description: 'A thin separator line. Can be horizontal or vertical, with an optional centre label.',
        code: '''// Horizontal (default)
Ux4gDivider()

// Vertical
Ux4gDivider(orientation: Ux4gDividerOrientation.vertical)

// With label
Ux4gDivider(label: Text('OR'))''',
        props: const [
          PropRow(name: 'orientation', type: 'Ux4gDividerOrientation', description: 'horizontal or vertical.', defaultValue: 'horizontal'),
          PropRow(name: 'label', type: 'Widget?', description: 'Widget placed in the centre of the line.'),
        ],
        child: const SizedBox(width: 300, child: Ux4gDivider()),
      ),
    ),
    WidgetbookUseCase(
      name: 'With label',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider — With Label',
        description: 'Embed any widget (e.g. Text) in the centre of the divider line.',
        code: '''Ux4gDivider(label: Text('OR'))''',
        child: const SizedBox(width: 300, child: Ux4gDivider(label: Text('OR'))),
      ),
    ),
    WidgetbookUseCase(
      name: 'Vertical',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider — Vertical',
        description: 'Vertical dividers separate inline content.',
        code: 'Ux4gDivider(orientation: Ux4gDividerOrientation.vertical)',
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Left'),
              const SizedBox(width: 12),
              const Ux4gDivider(orientation: Ux4gDividerOrientation.vertical),
              const SizedBox(width: 12),
              const Text('Right'),
            ],
          ),
        ),
      ),
    ),
  ],
);
