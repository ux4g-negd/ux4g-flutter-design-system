import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

final badgeComponent = WidgetbookComponent(
  name: 'Ux4gBadge',
  useCases: [
    WidgetbookUseCase(
      name: 'Dot',
      builder: (context) => ComponentDocs(
        name: 'Ux4gBadge',
        description:
            'A small indicator overlaid on another widget. '
            'Use the named constructors: .dot(), .count(), .label(), .icon().',
        code: '''// Dot badge – simple presence indicator
Ux4gBadge.dot(
  child: Icon(Icons.notifications, size: 32),
);

// Count badge
Ux4gBadge.count(5, child: Icon(Icons.mail, size: 32));

// Label badge
Ux4gBadge.label('NEW', child: Icon(Icons.star, size: 32));

// Icon badge
Ux4gBadge.icon(Icons.check, child: Icon(Icons.person, size: 32));''',
        props: const [
          PropRow(
            name: 'child',
            type: 'Widget?',
            description: 'Widget the badge is anchored to.',
          ),
          PropRow(
            name: 'containerColor',
            type: 'Color?',
            description: 'Background color of the badge.',
          ),
          PropRow(
            name: 'contentColor',
            type: 'Color?',
            description: 'Color of the badge content (text/icon).',
          ),
          PropRow(
            name: 'alignment',
            type: 'AlignmentGeometry',
            description: 'Position of the badge relative to child.',
            defaultValue: 'Alignment.topRight',
          ),
          PropRow(
            name: 'count (factory)',
            type: 'int',
            description: 'Number shown on count badge.',
            required: true,
          ),
          PropRow(
            name: 'limit',
            type: 'Ux4gBadgeLimit',
            description: 'Limit for count display (9+ or 99+).',
            defaultValue: 'singleDigit',
          ),
          PropRow(
            name: 'label (factory)',
            type: 'String',
            description: 'Text shown on label badge.',
            required: true,
          ),
          PropRow(
            name: 'icon (factory)',
            type: 'IconData',
            description: 'Icon shown on icon badge.',
            required: true,
          ),
          PropRow(
            name: 'assetPath (factory)',
            type: 'String',
            description: 'Asset path for readyToUse badge.',
            required: true,
          ),
        ],
        child: Ux4gBadge.dot(child: const Icon(Icons.notifications, size: 32)),
      ),
    ),
    WidgetbookUseCase(
      name: 'Count',
      builder: (context) => ComponentDocs(
        name: 'Ux4gBadge — Count',
        description:
            'Shows a numeric count. Use the limit param to cap at 9 or 99.',
        code: '''Ux4gBadge.count(
  5,
  limit: Ux4gBadgeLimit.singleDigit,   // shows "9+" when > 9
  child: Icon(Icons.mail, size: 32),
);''',
        child: Ux4gBadge.count(
          context.knobs.int.input(label: 'Count', initialValue: 5),
          limit: context.knobs.list(
            label: 'Limit',
            options: Ux4gBadgeLimit.values,
            initialOption: Ux4gBadgeLimit.singleDigit,
            labelBuilder: (v) => v.name,
          ),
          child: const Icon(Icons.mail, size: 32),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Label',
      builder: (context) => ComponentDocs(
        name: 'Ux4gBadge — Label',
        description: 'Displays a short text string as a badge.',
        code: '''Ux4gBadge.label('NEW', child: Icon(Icons.star, size: 32));''',
        child: Ux4gBadge.label(
          context.knobs.string(label: 'Label', initialValue: 'NEW'),
          child: const Icon(Icons.star, size: 32),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Standalone variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gBadge — Standalone',
        description:
            'Badges can be used without a child widget as standalone indicators.',
        code: '''Row(children: [
  Ux4gBadge.dot(),
  Ux4gBadge.count(7),
  Ux4gBadge.label('BETA'),
  Ux4gBadge.icon(Icons.check),
]);''',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gBadge.dot(),
            const SizedBox(width: 16),
            Ux4gBadge.count(7),
            const SizedBox(width: 16),
            Ux4gBadge.label('BETA'),
            const SizedBox(width: 16),
            Ux4gBadge.icon(Icons.check),
          ],
        ),
      ),
    ),
  ],
);
