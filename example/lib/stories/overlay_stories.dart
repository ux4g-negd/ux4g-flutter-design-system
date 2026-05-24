import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Modal ─────────────────────────────────────────────────────────────────────

final modalComponent = WidgetbookComponent(
  name: 'Ux4gModal',
  useCases: [
    // ── 1. Default (with header image) ────────────────────────────────────
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal',
        description:
            'Full-bleed gradient header with title, subtitle, body text, '
            'and two footer buttons aligned to the right.',
        code: '''Ux4gModal(
  headerImageContent: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD), Color(0xFF7B9FE0)],
      ),
    ),
  ),
  showHeader: true,
  headerTitle: 'Header',
  showSubtitle: true,
  showBody: true,
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.twoButtons,
  footerAlign: Ux4gModalFooterAlign.right,
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);''',
        props: const [
          PropRow(name: 'onDismiss', type: 'VoidCallback', description: 'Called when backdrop or close button is tapped.', required: true),
          PropRow(name: 'headerImageContent', type: 'Widget?', description: 'Widget rendered as the full-bleed header image.'),
          PropRow(name: 'headerImageUrl', type: 'String?', description: 'URL for the header image.'),
          PropRow(name: 'headerImageHeight', type: 'double', description: 'Height of the header image area.', defaultValue: '160'),
          PropRow(name: 'headerImageStyle', type: 'Ux4gModalHeaderImage', description: 'fullBleed / padded / none.', defaultValue: 'fullBleed'),
          PropRow(name: 'leadingItem', type: 'Ux4gModalLeadingItem', description: 'none / icon / avatar / image.', defaultValue: 'none'),
          PropRow(name: 'leadingIcon', type: 'IconData', description: 'Icon used when leadingItem is icon.', defaultValue: 'Icons.info_outline'),
          PropRow(name: 'leadingIconTint', type: 'Color?', description: 'Color tint for the leading icon.'),
          PropRow(name: 'avatarInitials', type: 'String?', description: 'Initials for leading avatar.'),
          PropRow(name: 'avatarImageUrl', type: 'String?', description: 'Image URL for leading avatar.'),
          PropRow(name: 'avatarIcon', type: 'IconData?', description: 'Icon for leading avatar.'),
          PropRow(name: 'avatarSize', type: 'Ux4gAvatarSize', description: 'Size for centered avatar.', defaultValue: 'l'),
          PropRow(name: 'avatarInlineSize', type: 'Ux4gAvatarSize', description: 'Size for inline avatar.', defaultValue: 's'),
          PropRow(name: 'avatarContainerColor', type: 'Color?', description: 'Background color for avatar.'),
          PropRow(name: 'avatarContentColor', type: 'Color?', description: 'Color for avatar initials/icon.'),
          PropRow(name: 'leadingImageUrl', type: 'String?', description: 'URL for leading image.'),
          PropRow(name: 'leadingImageContent', type: 'Widget?', description: 'Widget for leading image.'),
          PropRow(name: 'showHeader', type: 'bool', description: 'Show the header section.', defaultValue: 'true'),
          PropRow(name: 'headerTitle', type: 'String', description: 'Modal title text.', defaultValue: '"Header"'),
          PropRow(name: 'showDescription', type: 'bool', description: 'Show description text below title.', defaultValue: 'false'),
          PropRow(name: 'descriptionText', type: 'String', description: 'Description text.', defaultValue: '"Write description here"'),
          PropRow(name: 'showSubtitle', type: 'bool', description: 'Show subtitle section.', defaultValue: 'true'),
          PropRow(name: 'subtitleText', type: 'String', description: 'Subtitle label.', defaultValue: '"Subtitle"'),
          PropRow(name: 'showBody', type: 'bool', description: 'Show the body text block.', defaultValue: 'true'),
          PropRow(name: 'bodyText', type: 'String', description: 'Body paragraph text.'),
          PropRow(name: 'bodyContent', type: 'Widget?', description: 'Custom widget content for the body.'),
          PropRow(name: 'showFooter', type: 'bool', description: 'Show footer buttons.', defaultValue: 'true'),
          PropRow(name: 'footerButtons', type: 'Ux4gModalFooterButtons', description: 'oneButton / twoButtons / oneButtonWithIcon / twoButtonsWithIcon.', defaultValue: 'twoButtons'),
          PropRow(name: 'footerAlign', type: 'Ux4gModalFooterAlign', description: 'left / right / center / split.', defaultValue: 'right'),
          PropRow(name: 'primaryButtonText', type: 'String', description: 'Primary CTA label.', defaultValue: '"Button"'),
          PropRow(name: 'secondaryButtonText', type: 'String', description: 'Secondary CTA label.', defaultValue: '"Button"'),
          PropRow(name: 'leadingActionIcon', type: 'IconData', description: 'Icon for leading action button.', defaultValue: 'Icons.info_outline'),
          PropRow(name: 'onPrimaryClick', type: 'VoidCallback?', description: 'Called when primary button is tapped.'),
          PropRow(name: 'onSecondaryClick', type: 'VoidCallback?', description: 'Called when secondary button is tapped.'),
          PropRow(name: 'onLeadingIconPressed', type: 'VoidCallback?', description: 'Called when leading action icon is tapped.'),
          PropRow(name: 'alignment', type: 'Ux4gModalAlignment', description: 'leftAligned or centered.', defaultValue: 'leftAligned'),
          PropRow(name: 'showCloseButton', type: 'bool', description: 'Show × close button.', defaultValue: 'true'),
          PropRow(name: 'isDestructive', type: 'bool', description: 'Renders primary button in error color.', defaultValue: 'false'),
          PropRow(name: 'showDividers', type: 'bool', description: 'Show horizontal dividers between sections.', defaultValue: 'true'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Modal background color.'),
          PropRow(name: 'cornerRadius', type: 'double', description: 'Modal corner radius.', defaultValue: '16'),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerImageContent: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD), Color(0xFF7B9FE0)],
                ),
              ),
            ),
            showHeader: true,
            headerTitle: 'Header',
            showSubtitle: true,
            showBody: true,
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.twoButtons,
            footerAlign: Ux4gModalFooterAlign.right,
            isDestructive: false,
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),

    // ── 2. Destructive (Centered) ──────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Destructive (Centered)',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal — Destructive',
        description:
            'Centered alignment with a gradient header image, description, '
            'subtitle "Delete Item?", body text, and two centered footer buttons in error color.',
        code: '''Ux4gModal(
  headerImageContent: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD)],
      ),
    ),
  ),
  alignment: Ux4gModalAlignment.centered,
  showHeader: true,
  headerTitle: 'Warning',
  showDescription: true,
  descriptionText: 'This action cannot be undone.',
  showSubtitle: true,
  subtitleText: 'Delete Item?',
  showBody: true,
  bodyText: 'Are you sure you want to permanently delete this item?',
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.twoButtons,
  footerAlign: Ux4gModalFooterAlign.center,
  isDestructive: true,
  primaryButtonText: 'Delete',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerImageContent: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD)],
                ),
              ),
            ),
            alignment: Ux4gModalAlignment.centered,
            showHeader: true,
            headerTitle: 'Warning',
            showDescription: true,
            descriptionText: 'This action cannot be undone.',
            showSubtitle: true,
            subtitleText: 'Delete Item?',
            showBody: true,
            bodyText: 'Are you sure you want to permanently delete this item?',
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.twoButtons,
            footerAlign: Ux4gModalFooterAlign.center,
            isDestructive: true,
            primaryButtonText: 'Delete',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),

    // ── 3. Minimal Confirm (No header, no image) ───────────────────────────
    WidgetbookUseCase(
      name: 'Minimal Confirm',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal — Minimal',
        description:
            'No header image, no header section, no dividers, no close button. '
            'Just subtitle + body + split footer — ideal for confirmation dialogs.',
        code: '''Ux4gModal(
  headerImageStyle: Ux4gModalHeaderImage.none,
  showHeader: false,
  showDividers: false,
  showCloseButton: false,
  showSubtitle: true,
  subtitleText: 'Confirm Action',
  showBody: true,
  bodyText: 'This will permanently remove the selected items. Continue?',
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.twoButtons,
  footerAlign: Ux4gModalFooterAlign.split,
  isDestructive: true,
  primaryButtonText: 'Confirm',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerImageStyle: Ux4gModalHeaderImage.none,
            showHeader: false,
            showDividers: false,
            showCloseButton: false,
            showSubtitle: true,
            subtitleText: 'Confirm Action',
            showBody: true,
            bodyText: 'This will permanently remove the selected items. Continue?',
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.twoButtons,
            footerAlign: Ux4gModalFooterAlign.split,
            isDestructive: true,
            primaryButtonText: 'Confirm',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),

    // ── 4. Avatar (Centered + Padded image) ───────────────────────────────
    WidgetbookUseCase(
      name: 'Avatar (Centered + Padded)',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal — Avatar',
        description:
            'Padded header image with an avatar leading item, centered alignment, '
            'description, subtitle, body, and a single centered footer button.',
        code: '''Ux4gModal(
  headerImageContent: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD)],
      ),
    ),
  ),
  headerImageStyle: Ux4gModalHeaderImage.padded,
  leadingItem: Ux4gModalLeadingItem.avatar,
  avatarInitials: 'JD',
  alignment: Ux4gModalAlignment.centered,
  showHeader: true,
  headerTitle: 'Header',
  showDescription: true,
  descriptionText: 'Write description here',
  showSubtitle: true,
  showBody: true,
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.oneButton,
  footerAlign: Ux4gModalFooterAlign.center,
  isDestructive: true,
  onPrimaryClick: () {},
  onDismiss: () {},
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerImageContent: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9C6FE0), Color(0xFFE07BAD)],
                ),
              ),
            ),
            headerImageStyle: Ux4gModalHeaderImage.padded,
            leadingItem: Ux4gModalLeadingItem.avatar,
            avatarInitials: 'JD',
            alignment: Ux4gModalAlignment.centered,
            showHeader: true,
            headerTitle: 'Header',
            showDescription: true,
            descriptionText: 'Write description here',
            showSubtitle: true,
            showBody: true,
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.oneButton,
            footerAlign: Ux4gModalFooterAlign.center,
            isDestructive: true,
            onPrimaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),

    // ── 5. Icon (No image + Split footer) ─────────────────────────────────
    WidgetbookUseCase(
      name: 'Icon (No image + Split)',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal — Icon',
        description:
            'No header image, info icon leading item with red tint, left-aligned layout, '
            'description, subtitle, body, and split two-button footer.',
        code: '''Ux4gModal(
  headerImageStyle: Ux4gModalHeaderImage.none,
  leadingItem: Ux4gModalLeadingItem.icon,
  leadingIcon: Icons.info_outline,
  leadingIconTint: Color(0xFFEF4444),
  alignment: Ux4gModalAlignment.leftAligned,
  showHeader: true,
  headerTitle: 'Header',
  showDescription: true,
  descriptionText: 'Write description here',
  showSubtitle: true,
  showBody: true,
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.twoButtons,
  footerAlign: Ux4gModalFooterAlign.split,
  isDestructive: true,
  primaryButtonText: 'Delete',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerImageStyle: Ux4gModalHeaderImage.none,
            leadingItem: Ux4gModalLeadingItem.icon,
            leadingIcon: Icons.info_outline,
            leadingIconTint: Ux4gPalette.red500,
            alignment: Ux4gModalAlignment.leftAligned,
            showHeader: true,
            headerTitle: 'Header',
            showDescription: true,
            descriptionText: 'Write description here',
            showSubtitle: true,
            showBody: true,
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.twoButtons,
            footerAlign: Ux4gModalFooterAlign.split,
            isDestructive: true,
            primaryButtonText: 'Delete',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),

    // ── 6. Footer Variants (interactive knobs) ────────────────────────────
    WidgetbookUseCase(
      name: 'Footer variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal — Footer Variants',
        description: 'All four footer button types and alignment options — switch via knobs.',
        code: 'Ux4gModal(footerButtons: Ux4gModalFooterButtons.twoButtonsWithIcon, footerAlign: Ux4gModalFooterAlign.split, ...);',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerTitle: 'Footer Variants',
            showDescription: true,
            descriptionText: 'Switch footer button type and alignment using the knobs.',
            showFooter: true,
            footerButtons: context.knobs.list(
              label: 'Footer buttons',
              options: Ux4gModalFooterButtons.values,
              initialOption: Ux4gModalFooterButtons.twoButtons,
              labelBuilder: (v) => v.name,
            ),
            footerAlign: context.knobs.list(
              label: 'Footer align',
              options: Ux4gModalFooterAlign.values,
              initialOption: Ux4gModalFooterAlign.right,
              labelBuilder: (v) => v.name,
            ),
            primaryButtonText: 'Confirm',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),
  ],
);

// ── Bottom Sheet ──────────────────────────────────────────────────────────────

final bottomSheetComponent = WidgetbookComponent(
  name: 'Ux4gBottomSheet',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gBottomSheet',
        description:
            'A bottom-anchored sheet with optional header, description, draggable handle, '
            'and footer action buttons. Use Ux4gBottomSheet.show() to display it.',
        code: '''// Show via helper
Ux4gBottomSheet.show(
  context,
  title: 'Select Option',
  description: 'Choose one of the options below.',
  showCloseButton: true,
  isDraggable: true,
  content: YourContentWidget(),
);

// Or embed directly (for preview)
Ux4gBottomSheet(
  headerTitle: 'Filter',
  content: Text('Filter content here'),
  footerType: Ux4gCardFooterType.primaryAndSecondary,
  primaryButtonText: 'Apply',
  secondaryButtonText: 'Reset',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);''',
        props: const [
          PropRow(name: 'onDismiss', type: 'VoidCallback', description: 'Called when sheet is dismissed.', required: true),
          PropRow(name: 'content', type: 'Widget', description: 'Main body content.', required: true),
          PropRow(name: 'headerTitle', type: 'String?', description: 'Sheet header title.'),
          PropRow(name: 'headerSubtleText', type: 'String?', description: 'Secondary header text.'),
          PropRow(name: 'headerIcon', type: 'IconData?', description: 'Icon shown in the header.'),
          PropRow(name: 'showCloseButton', type: 'bool', description: 'Show × close button.', defaultValue: 'true'),
          PropRow(name: 'description', type: 'String?', description: 'Description below header.'),
          PropRow(name: 'footerType', type: 'Ux4gCardFooterType', description: 'Footer button layout.', defaultValue: 'none'),
          PropRow(name: 'footerAlignment', type: 'Ux4gBottomSheetFooterAlignment', description: 'Align footer buttons.', defaultValue: 'left'),
          PropRow(name: 'primaryButtonText', type: 'String', description: 'Primary CTA label.', defaultValue: '"Confirm"'),
          PropRow(name: 'secondaryButtonText', type: 'String', description: 'Secondary CTA label.', defaultValue: '"Cancel"'),
          PropRow(name: 'onPrimaryClick', type: 'VoidCallback?', description: 'Primary button callback.'),
          PropRow(name: 'onSecondaryClick', type: 'VoidCallback?', description: 'Secondary button callback.'),
          PropRow(name: 'showDividers', type: 'bool', description: 'Show horizontal dividers.', defaultValue: 'true'),
          PropRow(name: 'isDraggable', type: 'bool', description: 'Show drag handle and allow drag-to-dismiss.', defaultValue: 'true'),
          PropRow(name: 'containerColor', type: 'Color?', description: 'Background of the sheet surface.'),
          PropRow(name: 'scrimColor', type: 'Color?', description: 'Backdrop overlay color.'),
        ],
        child: SizedBox(
          width: 380,
          child: Ux4gBottomSheet(
            headerTitle: context.knobs.string(label: 'Title', initialValue: 'Filter Options'),
            description: context.knobs.string(label: 'Description', initialValue: 'Choose filters to apply.'),
            showCloseButton: true,
            isDraggable: false,
            footerType: Ux4gCardFooterType.primaryAndSecondary,
            primaryButtonText: 'Apply',
            secondaryButtonText: 'Reset',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(leading: const Icon(Icons.sort), title: const Text('Sort by date')),
                ListTile(leading: const Icon(Icons.filter_list), title: const Text('Filter by category')),
              ],
            ),
          ),
        ),
      ),
    ),
  ],
);

// ── Toast ─────────────────────────────────────────────────────────────────────

final toastComponent = WidgetbookComponent(
  name: 'Ux4gToast',
  useCases: [
    WidgetbookUseCase(
      name: 'All categories',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToast',
        description:
            'An inline notification toast. Use Ux4gToastHost with Ux4gToastHostState '
            'to programmatically show toasts from anywhere in your app.',
        code: '''// Wrap your app/page with Ux4gToastHost
final toastState = Ux4gToastHostState();

Ux4gToastHost(
  state: toastState,
  child: YourApp(),
);

// Trigger a toast
toastState.showToast(
  category: Ux4gToastCategory.success,
  title: 'Saved successfully',
  subtitle: 'Your changes have been saved.',
  autoClose: true,
);''',
        props: const [
          PropRow(name: 'category', type: 'Ux4gToastCategory', description: 'info / success / warning / error / slot.', required: true),
          PropRow(name: 'title', type: 'String', description: 'Toast heading.', required: true),
          PropRow(name: 'subtitle', type: 'String?', description: 'Supporting text.'),
          PropRow(name: 'actionText', type: 'String?', description: 'Inline action link text.'),
          PropRow(name: 'onActionClick', type: 'VoidCallback?', description: 'Called when action text is tapped.'),
          PropRow(name: 'onCloseClick', type: 'VoidCallback?', description: 'Called when × is tapped.'),
          PropRow(name: 'showCloseButton', type: 'bool', description: 'Show × dismiss button.', defaultValue: 'true'),
          PropRow(name: 'layout', type: 'Ux4gToastLayout?', description: 'full or stacked. Defaults to auto (responsive).'),
        ],
        child: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Ux4gToastCategory.values
                .where((c) => c != Ux4gToastCategory.slot)
                .map((c) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Ux4gToast(
                        category: c,
                        title: '${c.name[0].toUpperCase()}${c.name.substring(1)} message',
                        subtitle: 'Supporting description text.',
                        showCloseButton: true,
                        onCloseClick: () {},
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToast — Interactive',
        description: 'Use the knobs to preview a single toast with custom content.',
        code: '''Ux4gToast(
  category: Ux4gToastCategory.success,
  title: 'Item saved',
  subtitle: 'Changes have been applied.',
  actionText: 'Undo',
  showCloseButton: true,
  onCloseClick: () {},
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gToast(
            category: context.knobs.list(
              label: 'Category',
              options: Ux4gToastCategory.values.where((c) => c != Ux4gToastCategory.slot).toList(),
              initialOption: Ux4gToastCategory.success,
              labelBuilder: (v) => v.name,
            ),
            title: context.knobs.string(label: 'Title', initialValue: 'Operation successful'),
            subtitle: context.knobs.string(label: 'Subtitle', initialValue: 'Your changes have been saved.'),
            showCloseButton: context.knobs.boolean(label: 'Close button', initialValue: true),
            onCloseClick: () {},
          ),
        ),
      ),
    ),
  ],
);

// ── Tooltip ───────────────────────────────────────────────────────────────────

final tooltipComponent = WidgetbookComponent(
  name: 'Ux4gTooltip',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTooltip',
        description:
            'A positioned tooltip that appears above/below/beside a trigger widget. '
            'Tap the trigger to show.',
        code: '''// Simple tooltip
Ux4gTooltip(
  tooltipText: 'This is a helpful tip',
  placement: Ux4gTooltipPlacement.top,
  child: Icon(Icons.info_outline),
);''',
        props: const [
          PropRow(name: 'child', type: 'Widget', description: 'Trigger widget.', required: true),
          PropRow(name: 'tooltipText', type: 'String', description: 'Tooltip body text.', required: true),
          PropRow(name: 'placement', type: 'Ux4gTooltipPlacement', description: 'top / bottom / left / right and start/end variants.', defaultValue: 'top'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Tooltip background color.'),
          PropRow(name: 'contentColor', type: 'Color?', description: 'Color for text and icons.'),
          PropRow(name: 'textStyle', type: 'TextStyle?', description: 'Custom style for body text.'),
          PropRow(name: 'cornerRadius', type: 'double', description: 'Tooltip corner radius.', defaultValue: 'Ux4gRadius.radius4'),
          PropRow(name: 'arrowWidth', type: 'double', description: 'Width of the indicator arrow.', defaultValue: '10'),
          PropRow(name: 'arrowHeight', type: 'double', description: 'Height of the indicator arrow.', defaultValue: '6'),
          PropRow(name: 'enableUserInput', type: 'bool', description: 'Whether to handle tap gestures.', defaultValue: 'true'),
          PropRow(name: 'isPersistent', type: 'bool', description: 'Stay visible until tapped again.', defaultValue: 'false'),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ux4gTooltip(
                  tooltipText: 'Simple tooltip text',
                  placement: context.knobs.list(
                    label: 'Placement',
                    options: Ux4gTooltipPlacement.values,
                    initialOption: Ux4gTooltipPlacement.top,
                    labelBuilder: (v) => v.name,
                  ),
                  child: Ux4gButton(
                    text: 'Hover / Tap me',
                    variant: Ux4gButtonVariant.outline,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    ),
  ],
);

final richTooltipComponent = WidgetbookComponent(
  name: 'Ux4gRichTooltip',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRichTooltip',
        description: 'Rich tooltip with title, icon, and optional action.',
        code: '''Ux4gRichTooltip(
  tooltipText: 'Detailed explanation here.',
  title: 'Info',
  icon: Icons.info_outline,
  placement: Ux4gTooltipPlacement.bottom,
  action: TextButton(onPressed: () {}, child: Text('Learn more')),
  child: Icon(Icons.help_outline),
);''',
        props: const [
          PropRow(name: 'child', type: 'Widget', description: 'Trigger widget.', required: true),
          PropRow(name: 'tooltipText', type: 'String', description: 'Tooltip body text.', required: true),
          PropRow(name: 'title', type: 'String?', description: 'Optional title above text.'),
          PropRow(name: 'icon', type: 'IconData?', description: 'Icon shown beside title.'),
          PropRow(name: 'placement', type: 'Ux4gTooltipPlacement', description: 'top / bottom / left / right and start/end variants.', defaultValue: 'top'),
          PropRow(name: 'backgroundColor', type: 'Color?', description: 'Tooltip background color.'),
          PropRow(name: 'contentColor', type: 'Color?', description: 'Color for text and icons.'),
          PropRow(name: 'textStyle', type: 'TextStyle?', description: 'Custom style for body text.'),
          PropRow(name: 'cornerRadius', type: 'double', description: 'Tooltip corner radius.', defaultValue: 'Ux4gRadius.radius4'),
          PropRow(name: 'arrowWidth', type: 'double', description: 'Width of the indicator arrow.', defaultValue: '10'),
          PropRow(name: 'arrowHeight', type: 'double', description: 'Height of the indicator arrow.', defaultValue: '6'),
          PropRow(name: 'enableUserInput', type: 'bool', description: 'Whether to handle tap gestures.', defaultValue: 'true'),
          PropRow(name: 'isPersistent', type: 'bool', description: 'Stay visible until tapped again.', defaultValue: 'false'),
          PropRow(name: 'action', type: 'Widget?', description: 'Optional action widget inside tooltip.'),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Ux4gRichTooltip(
              tooltipText: 'This is a rich tooltip with a title, icon, and action.',
              title: 'More Info',
              icon: Icons.info_outline,
              placement: Ux4gTooltipPlacement.bottom,
              action: TextButton(onPressed: () {}, child: const Text('Learn more')),
              child: const Icon(Icons.help_outline, size: 28),
            ),
          ],
        ),
      ),
    ),
  ],
);
