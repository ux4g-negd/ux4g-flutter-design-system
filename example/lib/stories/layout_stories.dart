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
          PropRow(name: 'title', type: 'String', description: 'Header title text.', required: true),
          PropRow(name: 'variant', type: 'Ux4gAppHeaderVariant', description: 'light / filled / outlined.', defaultValue: 'light'),
          PropRow(name: 'showBackButton', type: 'bool', description: 'Show a back-arrow button.', defaultValue: 'false'),
          PropRow(name: 'onBackPressed', type: 'VoidCallback?', description: 'Called when back button is tapped.'),
          PropRow(name: 'leadingWidgets', type: 'List<Widget>?', description: 'Widgets placed before the title.'),
          PropRow(name: 'actions', type: 'List<Ux4gAppHeaderAction>?', description: 'Icon buttons on the trailing side.'),
          PropRow(name: 'showAvatar', type: 'bool', description: 'Show an avatar on the trailing side.', defaultValue: 'false'),
          PropRow(name: 'avatarSize', type: 'Ux4gAvatarSize', description: 'Size of the avatar when shown.', defaultValue: 's'),
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
