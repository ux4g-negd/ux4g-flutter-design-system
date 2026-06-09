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
        description:
            'A compact label chip with four style variants and six color schemes. '
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
          PropRow(
            name: 'text',
            type: 'String',
            description: 'Label text.',
            required: true,
          ),
          PropRow(
            name: 'style',
            type: 'Ux4gTagStyle',
            description: 'tonal / filled / outline / text.',
            defaultValue: 'tonal',
          ),
          PropRow(
            name: 'colorScheme',
            type: 'Ux4gTagColor',
            description: 'neutral / brand / success / warning / error / info.',
            defaultValue: 'neutral',
          ),
          PropRow(
            name: 'size',
            type: 'Ux4gTagSize',
            description: 'm / l.',
            defaultValue: 'm',
          ),
          PropRow(
            name: 'shape',
            type: 'Ux4gTagShape',
            description: 'circular / rectangular.',
            defaultValue: 'circular',
          ),
          PropRow(
            name: 'leadingContent',
            type: 'Widget?',
            description: 'Widget shown before text.',
          ),
          PropRow(
            name: 'onDismiss',
            type: 'VoidCallback?',
            description: 'Shows × button when provided.',
          ),
          PropRow(
            name: 'customBackgroundColor',
            type: 'Color?',
            description: 'Background color override.',
          ),
          PropRow(
            name: 'customContentColor',
            type: 'Color?',
            description: 'Text/icon color override.',
          ),
          PropRow(
            name: 'customBorderColor',
            type: 'Color?',
            description: 'Border color override.',
          ),
          PropRow(
            name: 'customBorderRadius',
            type: 'BorderRadius?',
            description: 'Border radius override.',
          ),
        ],
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: Ux4gTagStyle.values
              .map((s) => Ux4gTag(text: s.name, style: s))
              .toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Unified Pill Tag',
      builder: (context) => ComponentDocs(
        name: 'Ux4gUnifiedPillTag',
        description:
            'A pill-shaped tag containing multiple segments separated by dividers.',
        code: '''Ux4gUnifiedPillTag(
  segments: [
    Ux4gPillSegment(text: '2 days remaining', leading: Icon(Icons.timer)),
    Ux4gPillSegment(text: 'Pending', bold: true, textColor: Colors.orange),
  ],
)''',
        props: const [
          PropRow(
            name: 'segments',
            type: 'List<Ux4gPillSegment>',
            description: 'List of segments to display.',
            required: true,
          ),
          PropRow(
            name: 'size',
            type: 'Ux4gTagSize',
            description: 'm / l.',
            defaultValue: 'l',
          ),
          PropRow(
            name: 'backgroundColor',
            type: 'Color?',
            description: 'Container background.',
          ),
          PropRow(
            name: 'borderColor',
            type: 'Color?',
            description: 'Container border.',
          ),
          PropRow(
            name: 'dividerColor',
            type: 'Color?',
            description: 'Divider between segments.',
          ),
          PropRow(
            name: 'customBorderRadius',
            type: 'BorderRadius?',
            description: 'Corner radius override.',
          ),
        ],
        child: const Ux4gUnifiedPillTag(
          segments: [
            Ux4gPillSegment(text: '2 days remaining'),
            Ux4gPillSegment(
              text: 'Pending',
              bold: true,
              textColor: Colors.orange,
            ),
          ],
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
          spacing: 8,
          runSpacing: 8,
          children: Ux4gTagColor.values
              .map((c) => Ux4gTag(text: c.name, colorScheme: c))
              .toList(),
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
            label: 'Style',
            options: Ux4gTagStyle.values,
            initialOption: Ux4gTagStyle.tonal,
            labelBuilder: (v) => v.name,
          ),
          colorScheme: context.knobs.list(
            label: 'Color',
            options: Ux4gTagColor.values,
            initialOption: Ux4gTagColor.brand,
            labelBuilder: (v) => v.name,
          ),
          size: context.knobs.list(
            label: 'Size',
            options: Ux4gTagSize.values,
            initialOption: Ux4gTagSize.m,
            labelBuilder: (v) => v.name,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Shapes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag — Shapes',
        description:
            'Circular tags are fully rounded; rectangular tags have a smaller border radius.',
        code: '''Ux4gTag(text: 'Rectangular', shape: Ux4gTagShape.rectangular);
Ux4gTag(text: 'Circular',    shape: Ux4gTagShape.circular);''',
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Ux4gTag(
              text: 'Rectangular',
              shape: Ux4gTagShape.rectangular,
              colorScheme: Ux4gTagColor.brand,
            ),
            Ux4gTag(
              text: 'Circular',
              shape: Ux4gTagShape.circular,
              colorScheme: Ux4gTagColor.brand,
            ),
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
          spacing: 8,
          runSpacing: 8,
          children: [
            Ux4gTag(
              text: 'Medium',
              size: Ux4gTagSize.m,
              colorScheme: Ux4gTagColor.brand,
            ),
            Ux4gTag(
              text: 'Large',
              size: Ux4gTagSize.l,
              colorScheme: Ux4gTagColor.brand,
            ),
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
        description:
            'A surface container with optional title, subtitle, body text, '
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
          PropRow(
            name: 'child',
            type: 'Widget?',
            description: 'Custom content (overrides text fields).',
          ),
          PropRow(
            name: 'cornerRadius',
            type: 'double',
            description: 'Corner radius.',
            defaultValue: 'Ux4gRadius.radius12',
          ),
          PropRow(
            name: 'backgroundColor',
            type: 'Color?',
            description: 'Background color.',
          ),
          PropRow(
            name: 'borderColor',
            type: 'Color',
            description: 'Border color.',
            defaultValue: 'Colors.transparent',
          ),
          PropRow(
            name: 'borderWidth',
            type: 'double',
            description: 'Border width.',
            defaultValue: '0',
          ),
          PropRow(
            name: 'elevation',
            type: 'double',
            description: 'Elevation.',
            defaultValue: '0',
          ),
          PropRow(
            name: 'isClickable',
            type: 'bool',
            description: 'Enables ink well ripple.',
            defaultValue: 'false',
          ),
          PropRow(
            name: 'onPressed',
            type: 'VoidCallback?',
            description: 'Click callback.',
          ),
          PropRow(
            name: 'direction',
            type: 'Ux4gCardDirection',
            description: 'vertical / horizontal.',
            defaultValue: 'vertical',
          ),
          PropRow(
            name: 'mediaImageUrl',
            type: 'String?',
            description: 'Hero image URL.',
          ),
          PropRow(
            name: 'mediaHeight',
            type: 'double',
            description: 'Hero image height (vertical only).',
            defaultValue: '180',
          ),
          PropRow(
            name: 'mediaWidth',
            type: 'double',
            description: 'Thumbnail width (horizontal only).',
            defaultValue: '120',
          ),
          PropRow(
            name: 'mediaLabelText',
            type: 'String?',
            description: 'Label badge on top of media.',
          ),
          PropRow(
            name: 'avatar',
            type: 'Widget?',
            description: 'Leading avatar in header.',
          ),
          PropRow(name: 'title', type: 'String?', description: 'Heading text.'),
          PropRow(
            name: 'subtitle',
            type: 'String?',
            description: 'Supporting text below title.',
          ),
          PropRow(
            name: 'statusChips',
            type: 'List<String>',
            description: 'Chips shown in header row.',
            defaultValue: '[]',
          ),
          PropRow(
            name: 'body',
            type: 'String?',
            description: 'Main paragraph text.',
          ),
          PropRow(
            name: 'bottomChips',
            type: 'List<String>',
            description: 'Pill chips below body text.',
            defaultValue: '[]',
          ),
          PropRow(
            name: 'footerType',
            type: 'Ux4gCardFooterType',
            description: 'Buttons layout.',
            defaultValue: 'none',
          ),
          PropRow(
            name: 'footerAlignment',
            type: 'Ux4gCardFooterAlignment',
            description: 'left / centered / right.',
            defaultValue: 'left',
          ),
          PropRow(
            name: 'primaryButtonText',
            type: 'String',
            description: 'Primary CTA label.',
            defaultValue: "'Confirm'",
          ),
          PropRow(
            name: 'secondaryButtonText',
            type: 'String',
            description: 'Secondary CTA label.',
            defaultValue: "'Cancel'",
          ),
          PropRow(
            name: 'onPrimaryClick',
            type: 'VoidCallback?',
            description: 'Primary action callback.',
          ),
          PropRow(
            name: 'onSecondaryClick',
            type: 'VoidCallback?',
            description: 'Secondary action callback.',
          ),
        ],
        child: SizedBox(
          width: 320,
          child: Ux4gCard(
            title: context.knobs.string(
              label: 'Title',
              initialValue: 'Card Title',
            ),
            subtitle: context.knobs.string(
              label: 'Subtitle',
              initialValue: 'Card subtitle',
            ),
            body: context.knobs.string(
              label: 'Body',
              initialValue: 'This is the card body.',
            ),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With footer buttons',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard — With Actions',
        description:
            'Attach primary and/or secondary action buttons to the card footer.',
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
        description:
            'When direction is set to horizontal, the media thumbnail appears on the left side.',
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
        description:
            'Provide a mediaImageUrl to display a hero image at the top of the card.',
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
    WidgetbookUseCase(
      name: 'Complex Rich Card',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard — Custom Composition',
        description:
            'Replicating complex UI layouts using the child property for full flexibility.',
        code: '''Ux4gCard(
  elevation: 2,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 1. Hero Image with Overlays
      Stack(
        children: [
          Image.network(
            'https://picsum.photos/seed/richcard/600/300',
            height: 180, width: double.infinity, fit: BoxFit.cover,
          ),
          Positioned(
            top: 12, left: 12,
            child: Ux4gTag(
              text: 'Label', 
              leadingContent: Icon(Icons.category, size: 12, color: Colors.white),
              customBackgroundColor: Colors.black,
              customContentColor: Colors.white,
            ),
          ),
          Positioned(
            top: 12, right: 12,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white24,
              child: Icon(Icons.category, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      // 2. Content
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Ux4gAvatar(initials: 'JD', size: Ux4gAvatarSize.m),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      Text('Subtitle', style: TextStyle(color: Colors.black54, fontSize: 13)),
                    ],
                  ),
                ),
                Icon(Icons.category_outlined, color: Colors.indigo, size: 20),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _IconLabel(text: 'Label'),
                SizedBox(width: 12),
                _IconLabel(text: 'Label'),
                SizedBox(width: 12),
                _IconLabel(text: 'Label'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum is a dummy text commonly used in graphic design...',
              style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                _SmallTag(text: 'Label'),
                _SmallTag(text: 'Label'),
                _SmallTag(text: 'Label'),
              ],
            ),
            SizedBox(height: 24),
            // 3. Footer
            Row(
              children: [
                Expanded(
                  child: Ux4gButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 16),
                        SizedBox(width: 4),
                        Text('Button'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, size: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Ux4gOutlineButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 16),
                        SizedBox(width: 4),
                        Text('Button'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);''',
        child: SizedBox(
          width: 400,
          child: Ux4gCard(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Hero Image with Overlays
                Stack(
                  children: [
                    Image.network(
                      'https://picsum.photos/seed/richcard/600/300',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Ux4gTag(
                        text: 'Label',
                        leadingContent: const Icon(
                          Icons.category,
                          size: 12,
                          color: Colors.white,
                        ),
                        customBackgroundColor: Colors.black,
                        customContentColor: Colors.white,
                      ),
                    ),
                    const Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.category,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // 2. Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Ux4gAvatar(
                            initials: 'JD',
                            size: Ux4gAvatarSize.m,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Subtitle',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.category_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          _IconLabel(text: 'Label'),
                          SizedBox(width: 12),
                          _IconLabel(text: 'Label'),
                          SizedBox(width: 12),
                          _IconLabel(text: 'Label'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, '
                        'publishing, and web development.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Wrap(
                        spacing: 8,
                        children: [
                          _SmallTag(text: 'Label'),
                          _SmallTag(text: 'Label'),
                          _SmallTag(text: 'Label'),
                          _SmallTag(text: 'Label'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // 3. Footer
                      Row(
                        children: [
                          Expanded(
                            child: Ux4gButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 16),
                                  SizedBox(width: 4),
                                  Text('Button'),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down, size: 16),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Ux4gOutlineButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 16),
                                  SizedBox(width: 4),
                                  Text('Button'),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_drop_down, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
);

// ── Private Helpers for Complex Card ──────────────────────────────────────

class _IconLabel extends StatelessWidget {
  final String text;
  const _IconLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.category_outlined, size: 14, color: Colors.black45),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String text;
  const _SmallTag({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.category, size: 12, color: Colors.black54),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

final dividerComponent = WidgetbookComponent(
  name: 'Ux4gDivider',
  useCases: [
    WidgetbookUseCase(
      name: 'Horizontal',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider',
        description:
            'A thin separator line. Can be horizontal or vertical, with an optional centre label.',
        code: '''// Horizontal (default)
Ux4gDivider()

// Vertical
Ux4gDivider(orientation: Ux4gDividerOrientation.vertical)

// With label
Ux4gDivider(label: Text('OR'))''',
        props: const [
          PropRow(
            name: 'orientation',
            type: 'Ux4gDividerOrientation',
            description: 'horizontal or vertical.',
            defaultValue: 'horizontal',
          ),
          PropRow(name: 'color', type: 'Color?', description: 'Line color.'),
          PropRow(
            name: 'thickness',
            type: 'double',
            description: 'Stroke thickness.',
            defaultValue: '1.0',
          ),
          PropRow(
            name: 'style',
            type: 'Ux4gDividerStyle',
            description: 'solid / dashed / dotted.',
            defaultValue: 'solid',
          ),
          PropRow(
            name: 'startIndent',
            type: 'double',
            description: 'Leading gap.',
            defaultValue: '0.0',
          ),
          PropRow(
            name: 'endIndent',
            type: 'double',
            description: 'Trailing gap.',
            defaultValue: '0.0',
          ),
          PropRow(
            name: 'label',
            type: 'Widget?',
            description: 'Widget placed in the centre of the line.',
          ),
          PropRow(
            name: 'labelSpacing',
            type: 'double',
            description: 'Gap between line and label.',
            defaultValue: '8.0',
          ),
        ],
        child: const SizedBox(width: 300, child: Ux4gDivider()),
      ),
    ),
    WidgetbookUseCase(
      name: 'With label',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider — With Label',
        description:
            'Embed any widget (e.g. Text) in the centre of the divider line.',
        code: '''Ux4gDivider(label: Text('OR'))''',
        child: const SizedBox(
          width: 300,
          child: Ux4gDivider(label: Text('OR')),
        ),
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
