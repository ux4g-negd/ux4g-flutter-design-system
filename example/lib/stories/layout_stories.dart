import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── App Header ────────────────────────────────────────────────────────────────

final appHeaderComponent = WidgetbookComponent(
  name: 'Ux4gAppHeader',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAppHeader',
        description:
            'A top app-bar component with optional back button, leading widgets, '
            'title, and action buttons. Supports three visual variants: light, filled, and outlined.',
        code: '''Ux4gAppHeader(
  title: 'Home',
  variant: Ux4gAppHeaderVariant.light,
  showBackButton: false,
  leadingWidgets: [
    Icon(Icons.menu_rounded),
  ],
  actions: [
    Ux4gAppHeaderAction(
      icon: Icons.notifications_outlined,
      onPressed: () {},
    ),
    Ux4gAppHeaderAction(
      icon: Icons.settings_outlined,
      onPressed: () {},
    ),
  ],
  showAvatar: true,
  avatarSize: Ux4gAvatarSize.s,
);''',
        props: const [
          PropRow(name: 'title', type: 'String', description: 'Header title text.', defaultValue: "'Title'"),
          PropRow(name: 'variant', type: 'Ux4gAppHeaderVariant', description: 'light / filled / outlined.', defaultValue: 'outlined'),
          PropRow(name: 'showBackButton', type: 'bool', description: 'Show a back-arrow button.', defaultValue: 'false'),
          PropRow(name: 'onBackPressed', type: 'VoidCallback?', description: 'Called when back button is tapped.'),
          PropRow(name: 'leadingWidgets', type: 'List<Widget>?', description: 'Widgets placed before the title.'),
          PropRow(name: 'actions', type: 'List<Ux4gAppHeaderAction>?', description: 'Icon buttons on the trailing side.'),
          PropRow(name: 'avatar', type: 'Widget?', description: 'Custom avatar widget.'),
          PropRow(name: 'avatarSize', type: 'Ux4gAvatarSize', description: 'Size of default avatar.', defaultValue: 's'),
          PropRow(name: 'showAvatar', type: 'bool', description: 'Show an avatar.', defaultValue: 'false'),
          PropRow(name: 'avatarImageUrl', type: 'String?', description: 'URL for default avatar image.'),
          PropRow(name: 'avatarInitials', type: 'String?', description: 'Initials for default avatar.'),
          PropRow(name: 'onAvatarPressed', type: 'VoidCallback?', description: 'Called when avatar is tapped.'),
          PropRow(name: 'titleWidget', type: 'Widget?', description: 'Overrides title text with custom widget.'),
          PropRow(name: 'titleStyle', type: 'TextStyle?', description: 'Custom style for title.'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Background color override.'),
          PropRow(name: 'foregroundColor', type: 'Color?', description: 'Text/icon color override.'),
          PropRow(name: 'borderColor', type: 'Color?', description: 'Border color (outlined variant).'),
          PropRow(name: 'height', type: 'double', description: 'Bar height.', defaultValue: '56'),
          PropRow(name: 'horizontalPadding', type: 'double', description: 'Left/right padding.', defaultValue: '12.0'),
          PropRow(name: 'leadingSpacing', type: 'double', description: 'Gap between leading items.', defaultValue: '8.0'),
          PropRow(name: 'actionSpacing', type: 'double', description: 'Gap between action items.', defaultValue: '4.0'),
          PropRow(name: 'elevation', type: 'double', description: 'Shadow depth.', defaultValue: '0'),
        ],
        center: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gAppHeader(
              title: context.knobs.string(label: 'Title', initialValue: 'App Header'),
              variant: context.knobs.list(
                label: 'Variant',
                options: Ux4gAppHeaderVariant.values,
                initialOption: Ux4gAppHeaderVariant.light,
                labelBuilder: (v) => v.name,
              ),
              showBackButton: context.knobs.boolean(label: 'Back button', initialValue: false),
              onBackPressed: () {},
              leadingWidgets: const [Icon(Icons.menu_rounded)],
              actions: [
                Ux4gAppHeaderAction(icon: Icons.notifications_outlined, onPressed: () {}),
                Ux4gAppHeaderAction(icon: Icons.settings_outlined, onPressed: () {}),
              ],
              showAvatar: context.knobs.boolean(label: 'Show avatar', initialValue: true),
              avatarSize: Ux4gAvatarSize.s,
            ),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'All variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAppHeader — Variants',
        description: 'All three visual variants side by side.',
        code: '''// Light
Ux4gAppHeader(title: 'Light', variant: Ux4gAppHeaderVariant.light, ...);
// Filled
Ux4gAppHeader(title: 'Filled', variant: Ux4gAppHeaderVariant.filled, ...);
// Outlined
Ux4gAppHeader(title: 'Outlined', variant: Ux4gAppHeaderVariant.outlined, ...);''',
        center: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: Ux4gAppHeaderVariant.values
              .map((v) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Ux4gAppHeader(
                      title: '${v.name[0].toUpperCase()}${v.name.substring(1)}',
                      variant: v,
                      actions: [
                        Ux4gAppHeaderAction(icon: Icons.notifications_outlined, onPressed: () {}),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    ),
  ],
);
