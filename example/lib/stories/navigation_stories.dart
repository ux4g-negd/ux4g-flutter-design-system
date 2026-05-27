import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Accordion ─────────────────────────────────────────────────────────────────

final accordionComponent = WidgetbookComponent(
  name: 'Ux4gAccordion',
  useCases: [
    WidgetbookUseCase(
      name: 'Single',
      builder: (context) {
        bool expanded = false;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gAccordion',
            description: 'A collapsible panel. Toggle with onExpandedChange. '
                'Use Ux4gAccordionGroup for mutually-exclusive accordion lists.',
            code: '''// Single accordion
Ux4gAccordion(
  title: 'What is UX4G?',
  expanded: expanded,
  onExpandedChange: (v) => setState(() => expanded = v),
  child: Text('Content here'),
);''',
            props: const [
              PropRow(name: 'title', type: 'String', description: 'Header text.', required: true),
              PropRow(name: 'child', type: 'Widget', description: 'Content shown when expanded.', required: true),
              PropRow(name: 'expanded', type: 'bool', description: 'Current expanded state.', defaultValue: 'false'),
              PropRow(name: 'enabled', type: 'bool', description: 'When false, header is grayed out and non-interactive.', defaultValue: 'true'),
              PropRow(name: 'onExpandedChange', type: 'ValueChanged<bool>?', description: 'Called when the panel is toggled.'),
              PropRow(name: 'backgroundColor', type: 'Color?', description: 'Header background. Defaults to colors.surface (theme-aware).'),
              PropRow(name: 'contentBackgroundColor', type: 'Color?', description: 'Background of the expanded content area only. Defaults to colors.surface.'),
              PropRow(name: 'collapsedBorderColor', type: 'Color?', description: 'Border when collapsed. Defaults to colors.onSurface at 12% opacity (theme-aware).'),
              PropRow(name: 'expandedBorderColor', type: 'Color?', description: 'Border when expanded. Defaults to colors.primary (theme-aware).'),
              PropRow(name: 'titleColor', type: 'Color?', description: 'Title text color. Defaults to colors.onSurface (theme-aware).'),
              PropRow(name: 'disabledTitleColor', type: 'Color?', description: 'Title color when disabled. Defaults to colors.onSurface at 38% opacity.'),
              PropRow(name: 'iconColor', type: 'Color?', description: 'Chevron icon color. Defaults to colors.onSurface (theme-aware).'),
              PropRow(name: 'disabledIconColor', type: 'Color?', description: 'Chevron color when disabled. Defaults to colors.onSurface at 38% opacity.'),
            ],
            child: SizedBox(
              width: 340,
              child: Ux4gAccordion(
                title: context.knobs.string(label: 'Title', initialValue: 'What is UX4G?'),
                expanded: expanded,
                onExpandedChange: (v) => setState(() => expanded = v),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('UX4G is a Flutter design system providing reusable UI components.'),
                ),
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAccordion — Disabled',
        description: 'A disabled accordion cannot be expanded.',
        code: 'Ux4gAccordion(title: \'Locked\', expanded: false, enabled: false, onExpandedChange: (_) {});',
        child: SizedBox(
          width: 340,
          child: Ux4gAccordion(
            title: 'Locked Section (disabled)',
            expanded: false,
            enabled: false,
            onExpandedChange: (_) {},
            child: const Text('This content cannot be accessed.'),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Custom colors',
      builder: (context) {
        bool expanded = false;
        return StatefulBuilder(builder: (ctx, setState) {
          final colors = Ux4gTheme.colors(context);
          return ComponentDocs(
            name: 'Ux4gAccordion — Custom Colors',
            description:
                'Every color parameter can be overridden.\n\n'
                'Use Ux4gTheme.colors(context) for theme-aware values that '
                'automatically adapt between Light and Dark.\n'
                'Use Ux4gPalette.xxx for fixed, always-constant palette shades.',
            code: '''// 1. Get theme-aware semantic colors
final colors = Ux4gTheme.colors(context);

// 2. Pass them (or fixed palette values) to the component
Ux4gAccordion(
  title: 'Custom styled',
  child: Text('Content'),       // required

  // onExpandedChange is optional (nullable)
  onExpandedChange: (v) => setState(() => expanded = v),

  // theme-aware (changes with Light / Dark toggle)
  backgroundColor: colors.surface,
  expandedBorderColor: colors.primary,

  // fixed palette shades (override the theme-aware defaults)
  titleColor: Ux4gPalette.primary600,
  collapsedBorderColor: Ux4gPalette.gray200,
  iconColor: Ux4gPalette.primary500,

  child: Text(\'Content\', style: TextStyle(color: colors.onSurface)),
);''',
            child: SizedBox(
              width: 340,
              child: Ux4gAccordion(
                title: 'Custom styled accordion',
                expanded: expanded,
                onExpandedChange: (v) => setState(() => expanded = v),
                backgroundColor: colors.surface,
                expandedBorderColor: colors.primary,
                titleColor: Ux4gPalette.primary600,
                collapsedBorderColor: Ux4gPalette.gray200,
                iconColor: Ux4gPalette.primary500,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Themed content area.',
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ),
          );
        });
      },
    ),
  ],
);

final accordionGroupComponent = WidgetbookComponent(
  name: 'Ux4gAccordionGroup',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        int? expandedIndex = 0;
        return StatefulBuilder(builder: (ctx, setState) {
          final items = [
            const Ux4gAccordionItem(title: 'What is UX4G?'),
            const Ux4gAccordionItem(title: 'How do I install it?'),
            const Ux4gAccordionItem(title: 'Is it open source?'),
          ];
          final contents = [
            'UX4G is a Flutter design system providing reusable UI components.',
            'Add it to pubspec.yaml and run flutter pub get.',
            'Yes, UX4G is open source under the MIT licence.',
          ];
          return ComponentDocs(
            name: 'Ux4gAccordionGroup',
            description: 'AccordionGroup ensures only one item is open at a time.',
            code: 'Ux4gAccordionGroup(\n'
                '  items: items, expandedIndex: expandedIndex,\n'
                '  onExpandedIndexChange: (i) => setState(() => expandedIndex = i),\n'
                '  contentBuilder: (index, item) => Text(contents[index]),\n'
                '  itemSpacing: 20, // default Ux4gSpace.space20\n'
                ');',
            props: const [
              PropRow(name: 'items', type: 'List<Ux4gAccordionItem>', description: 'List of accordion items (title + enabled).', required: true),
              PropRow(name: 'contentBuilder', type: 'Widget Function(int, Ux4gAccordionItem)', description: 'Builds content for the item at the given index.', required: true),
              PropRow(name: 'expandedIndex', type: 'int?', description: 'Index of the currently expanded item. null = all collapsed.'),
              PropRow(name: 'onExpandedIndexChange', type: 'ValueChanged<int?>?', description: 'Called when an item is toggled. null means collapsed.'),
              PropRow(name: 'itemSpacing', type: 'double', description: 'Vertical gap between accordion items.', defaultValue: 'Ux4gSpace.space20'),
            ],
            child: SizedBox(
              width: 340,
              child: Ux4gAccordionGroup(
                items: items,
                expandedIndex: expandedIndex,
                onExpandedIndexChange: (i) => setState(() => expandedIndex = i),
                contentBuilder: (index, item) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(contents[index]),
                ),
              ),
            ),
          );
        });
      },
    ),
  ],
);

// ── Status Banner ─────────────────────────────────────────────────────────────

final statusBannerComponent = WidgetbookComponent(
  name: 'Ux4gStatusBanner',
  useCases: [
    WidgetbookUseCase(
      name: 'All variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStatusBanner',
        description: 'Notification banners with semantic colour variants including light and solid options.',
        code: '''Ux4gStatusBanner(
  variant: Ux4gBannerVariant.successLight,
  title: 'Operation successful',
  subtitle: 'Your data was saved.',
  onDismiss: () {},
);''',
        props: const [
          PropRow(name: 'variant', type: 'Ux4gBannerVariant', description: 'warningLight / warningSolid / errorLight / successLight / savingLight / infoLight / neutralLight / primaryLight.', required: true),
          PropRow(name: 'title', type: 'String', description: 'Banner heading.', required: true),
          PropRow(name: 'subtitle', type: 'String?', description: 'Supporting text.'),
          PropRow(name: 'titleStyle', type: 'TextStyle?', description: 'Custom style for title.'),
          PropRow(name: 'subtitleStyle', type: 'TextStyle?', description: 'Custom style for subtitle.'),
          PropRow(name: 'badge', type: 'Widget?', description: 'Small badge shown next to title.'),
          PropRow(name: 'leadingIcon', type: 'Widget?', description: 'Custom icon on the left.'),
          PropRow(name: 'trailingIcon', type: 'Widget?', description: 'Custom icon on the right.'),
          PropRow(name: 'actions', type: 'List<Widget>?', description: 'Action buttons at the bottom.'),
          PropRow(name: 'onDismiss', type: 'VoidCallback?', description: 'Shows × button when provided.'),
        ],
        child: SizedBox(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Ux4gBannerVariant.values
                .map((v) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Ux4gStatusBanner(variant: v, title: v.name, subtitle: 'Supporting subtitle text'),
                    ))
                .toList(),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Custom styling',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStatusBanner — Custom Styling',
        description: 'You can override the title and subtitle styles, including size, weight, and color.',
        code: '''Ux4gStatusBanner(
  variant: Ux4gBannerVariant.infoLight,
  title: 'Custom Title',
  titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.blue.shade900),
  subtitle: 'Custom subtitle styling example.',
  subtitleStyle: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black54),
);''',
        child: SizedBox(
          width: 380,
          child: Ux4gStatusBanner(
            variant: Ux4gBannerVariant.infoLight,
            title: 'Custom Styled Banner',
            titleStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.blue.shade900,
              letterSpacing: 1.1,
            ),
            subtitle: 'This subtitle has custom styling applied directly.',
            subtitleStyle: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
            leadingIcon: const Icon(Icons.info_outline, color: Colors.blue),
            trailingIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('New', style: TextStyle(fontSize: 12, color: Colors.blue)),
            ),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With dismiss',
      builder: (context) {
        bool dismissed = false;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gStatusBanner — With Dismiss',
            description: 'Providing onDismiss shows a × close button on the banner.',
            code: 'Ux4gStatusBanner(\n'
                '  variant: Ux4gBannerVariant.successLight,\n'
                '  title: \'Changes saved\',\n'
                '  onDismiss: () => setState(() => dismissed = true),\n'
                ');',
            child: SizedBox(
              width: 380,
              child: dismissed
                  ? const Text('Banner dismissed', style: TextStyle(color: Colors.grey))
                  : Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.successLight,
                      title: 'Changes saved',
                      subtitle: 'Your profile has been updated.',
                      onDismiss: () => setState(() => dismissed = true),
                    ),
            ),
          );
        });
      },
    ),
  ],
);

// ── Empty State ────────────────────────────────────────────────────────────────

final emptyStateComponent = WidgetbookComponent(
  name: 'Ux4gEmptyState',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gEmptyState',
        description: 'A full-page empty state placeholder with icon, title, description, and an optional CTA button.',
        code: '''Ux4gEmptyState(
  title: 'No results found',
  description: 'Try adjusting your search.',
  icon: Icons.search_off,
);

// With CTA button
Ux4gEmptyState(
  title: 'Nothing here yet',
  subtitle: 'Create your first item.',
  icon: Icons.inbox_outlined,
  buttonText: 'Get Started',
  onButtonPressed: () {},
);''',
        props: const [
          PropRow(name: 'title', type: 'String', description: 'Primary message.', required: true),
          PropRow(name: 'variant', type: 'Ux4gEmptyStateVariant', description: 'Semantic preset for the empty state.', defaultValue: 'custom'),
          PropRow(name: 'subtitle', type: 'String?', description: 'Secondary message.'),
          PropRow(name: 'description', type: 'String?', description: 'Descriptive text.'),
          PropRow(name: 'icon', type: 'IconData?', description: 'Icon displayed above title.'),
          PropRow(name: 'iconSize', type: 'double?', description: 'Size of the top icon.', defaultValue: '48'),
          PropRow(name: 'iconColor', type: 'Color?', description: 'Color of the top icon.'),
          PropRow(name: 'titleStyle', type: 'TextStyle?', description: 'Custom style for the title.'),
          PropRow(name: 'bodyStyle', type: 'TextStyle?', description: 'Custom style for subtitle and description.'),
          PropRow(name: 'buttonText', type: 'String?', description: 'CTA button label.'),
          PropRow(name: 'onButtonPressed', type: 'VoidCallback?', description: 'CTA button callback.'),
          PropRow(name: 'buttonSize', type: 'Ux4gButtonSize', description: 'Size of the CTA button.', defaultValue: 'small'),
          PropRow(name: 'buttonLeadingIcon', type: 'IconData?', description: 'Icon shown inside the CTA button.'),
          PropRow(name: 'padding', type: 'EdgeInsetsGeometry?', description: 'Padding around the whole widget.', defaultValue: 'EdgeInsets.all(24)'),
          PropRow(name: 'bodyHorizontalPadding', type: 'double', description: 'Extra horizontal padding for text.', defaultValue: '24.0'),
        ],
        child: SizedBox(
          width: 320,
          child: Ux4gEmptyState(
            title: context.knobs.string(label: 'Title', initialValue: 'No results found'),
            description: context.knobs.string(label: 'Description', initialValue: 'Try adjusting your filters.'),
            icon: Icons.search_off,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With CTA button',
      builder: (context) => ComponentDocs(
        name: 'Ux4gEmptyState — With CTA',
        description: 'Providing buttonText and onButtonPressed adds a primary action button.',
        code: 'Ux4gEmptyState(\n'
            '  title: \'Nothing here yet\',\n'
            '  icon: Icons.inbox_outlined,\n'
            '  buttonText: \'Get Started\', onButtonPressed: () {},\n'
            ');',
        child: SizedBox(
          width: 320,
          child: Ux4gEmptyState(
            title: 'Nothing here yet',
            description: 'Create your first item to get started.',
            icon: Icons.inbox_outlined,
            buttonText: 'Get Started',
            onButtonPressed: () {},
          ),
        ),
      ),
    ),
  ],
);

// ── Chips ─────────────────────────────────────────────────────────────────────

final choiceChipComponent = WidgetbookComponent(
  name: 'Ux4gChoiceChip',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        int selected = 0;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gChoiceChip',
            description: 'Single-select chips. Exactly one option is active at a time.',
            code: '''Ux4gChoiceChip(
  text: 'Option A',
  selected: selected == 0,
  onClick: () => setState(() => selected = 0),
);''',
            props: const [
              PropRow(name: 'text', type: 'String', description: 'Chip label.', required: true),
              PropRow(name: 'selected', type: 'bool', description: 'Whether this chip is active.', required: true),
              PropRow(name: 'onClick', type: 'VoidCallback', description: 'Called when tapped.', required: true),
              PropRow(name: 'enabled', type: 'bool', description: 'Interactive state.', defaultValue: 'true'),
              PropRow(name: 'size', type: 'Ux4gChoiceChipSize', description: 's or m.', defaultValue: 'm'),
              PropRow(name: 'leadingContent', type: 'Widget?', description: 'Optional icon or widget before text.'),
              PropRow(name: 'borderRadius', type: 'double', description: 'Corner radius.', defaultValue: 'Ux4gRadius.radius4'),
              PropRow(name: 'selectedBackgroundColor', type: 'Color?', description: 'Background when selected.'),
              PropRow(name: 'unselectedBackgroundColor', type: 'Color?', description: 'Background when unselected.'),
              PropRow(name: 'selectedBorderColor', type: 'Color?', description: 'Border when selected.'),
              PropRow(name: 'unselectedBorderColor', type: 'Color?', description: 'Border when unselected.'),
              PropRow(name: 'selectedTextColor', type: 'Color?', description: 'Text when selected.'),
              PropRow(name: 'unselectedTextColor', type: 'Color?', description: 'Text when unselected.'),
              PropRow(name: 'selectedBorderWidth', type: 'double', description: 'Border width when selected.', defaultValue: '1'),
              PropRow(name: 'unselectedBorderWidth', type: 'double', description: 'Border width when unselected.', defaultValue: '1'),
            ],
            child: Wrap(
              spacing: 8,
              children: ['Option A', 'Option B', 'Option C']
                  .asMap()
                  .entries
                  .map((e) => Ux4gChoiceChip(
                        text: e.value,
                        selected: selected == e.key,
                        onClick: () => setState(() => selected = e.key),
                      ))
                  .toList(),
            ),
          );
        });
      },
    ),
  ],
);

final filterChipComponent = WidgetbookComponent(
  name: 'Ux4gFilterChip',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final Set<int> selectedSet = {};
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gFilterChip',
            description: 'Multi-select chips. Any number of options can be active simultaneously.',
            code: '''Ux4gFilterChip(
  text: 'Flutter',
  selected: selected.contains(0),
  onClick: () => setState(() => selected.toggle(0)),
);''',
            props: const [
              PropRow(name: 'text', type: 'String', description: 'Chip label.', required: true),
              PropRow(name: 'selected', type: 'bool', description: 'Whether this chip is active.', required: true),
              PropRow(name: 'onClick', type: 'VoidCallback', description: 'Called when tapped.', required: true),
              PropRow(name: 'enabled', type: 'bool', description: 'Interactive state.', defaultValue: 'true'),
              PropRow(name: 'size', type: 'Ux4gFilterChipSize', description: 's or m.', defaultValue: 'm'),
              PropRow(name: 'leadingContent', type: 'Widget?', description: 'Optional icon or widget before text.'),
              PropRow(name: 'borderRadius', type: 'double', description: 'Corner radius.', defaultValue: 'Ux4gRadius.radius4'),
              PropRow(name: 'selectedBackgroundColor', type: 'Color?', description: 'Background when selected.'),
              PropRow(name: 'unselectedBackgroundColor', type: 'Color?', description: 'Background when unselected.'),
              PropRow(name: 'selectedBorderColor', type: 'Color?', description: 'Border when selected.'),
              PropRow(name: 'unselectedBorderColor', type: 'Color?', description: 'Border when unselected.'),
              PropRow(name: 'selectedTextColor', type: 'Color?', description: 'Text when selected.'),
              PropRow(name: 'unselectedTextColor', type: 'Color?', description: 'Text when unselected.'),
              PropRow(name: 'selectedBorderWidth', type: 'double', description: 'Border width when selected.', defaultValue: '2'),
              PropRow(name: 'unselectedBorderWidth', type: 'double', description: 'Border width when unselected.', defaultValue: '1'),
            ],
            child: Wrap(
              spacing: 8,
              children: ['Flutter', 'Dart', 'Firebase', 'Material']
                  .asMap()
                  .entries
                  .map((e) => Ux4gFilterChip(
                        text: e.value,
                        selected: selectedSet.contains(e.key),
                        onClick: () => setState(() => selectedSet.contains(e.key)
                            ? selectedSet.remove(e.key)
                            : selectedSet.add(e.key)),
                      ))
                  .toList(),
            ),
          );
        });
      },
    ),
  ],
);

final inputChipComponent = WidgetbookComponent(
  name: 'Ux4gInputChip',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        List<String> chips = ['Design', 'Code', 'Review'];
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gInputChip',
            description: 'Dismissible tag chips. Tap × to remove.',
            code: '''Ux4gInputChip(
  text: 'Design',
  onDismiss: () => setState(() => chips.remove('Design')),
);''',
            props: const [
              PropRow(name: 'text', type: 'String', description: 'Chip label.', required: true),
              PropRow(name: 'onDismiss', type: 'VoidCallback', description: 'Called when × is tapped.', required: true),
              PropRow(name: 'enabled', type: 'bool', description: 'Interactive state.', defaultValue: 'true'),
              PropRow(name: 'size', type: 'Ux4gInputChipSize', description: 'xs, s, or m.', defaultValue: 'm'),
              PropRow(name: 'leadingContent', type: 'Widget?', description: 'Optional icon or widget before text.'),
              PropRow(name: 'borderRadius', type: 'double', description: 'Corner radius.', defaultValue: 'Ux4gRadius.radius4'),
              PropRow(name: 'backgroundColor', type: 'Color?', description: 'Chip background color.'),
              PropRow(name: 'borderColor', type: 'Color?', description: 'Chip border color.'),
              PropRow(name: 'textColor', type: 'Color?', description: 'Chip text and icon color.'),
              PropRow(name: 'borderWidth', type: 'double', description: 'Border width.', defaultValue: '1'),
            ],
            child: Wrap(
              spacing: 8,
              children: chips
                  .map((c) => Ux4gInputChip(text: c, onDismiss: () => setState(() => chips.remove(c))))
                  .toList(),
            ),
          );
        });
      },
    ),
  ],
);

final inputChipFieldComponent = WidgetbookComponent(
  name: 'Ux4gInputChipField',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        List<String> labels = ['Design', 'Code'];
        String currentText = '';
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gInputChipField',
            description: 'A text field that allows adding multiple chips/tags.',
            code: '''Ux4gInputChipField(
  value: currentText,
  onValueChange: (v) => setState(() => currentText = v),
  onAddChip: (v) => setState(() => labels.add(v)),
  chips: labels.map((l) => Ux4gInputChip(
    text: l, 
    onDismiss: () => setState(() => labels.remove(l)),
  )).toList(),
  placeholder: 'Add tag...',
);''',
            props: const [
              PropRow(name: 'value', type: 'String', description: 'Current text in the input field.', required: true),
              PropRow(name: 'onValueChange', type: 'ValueChanged<String>', description: 'Called when input text changes.', required: true),
              PropRow(name: 'onAddChip', type: 'ValueChanged<String>', description: 'Called when the add button is pressed.', required: true),
              PropRow(name: 'chips', type: 'List<Widget>', description: 'List of chips to display below the field.', defaultValue: '[]'),
              PropRow(name: 'placeholder', type: 'String', description: 'Placeholder text.', defaultValue: "'Please select..'"),
              PropRow(name: 'leadingIcon', type: 'Widget?', description: 'Icon at the start of the field.'),
              PropRow(name: 'isDropdown', type: 'bool', description: 'Whether to show a dropdown instead of text input.', defaultValue: 'false'),
              PropRow(name: 'dropdownOptions', type: 'List<String>', description: 'Options if isDropdown is true.', defaultValue: '[]'),
            ],
            child: SizedBox(
              width: 340,
              child: Ux4gInputChipField(
                value: currentText,
                onValueChange: (v) => setState(() => currentText = v),
                onAddChip: (v) => setState(() => labels.add(v)),
                chips: labels
                    .map((l) => Ux4gInputChip(
                          text: l,
                          onDismiss: () => setState(() => labels.remove(l)),
                        ))
                    .toList(),
                placeholder: 'Add tag...',
              ),
            ),
          );
        });
      },
    ),
  ],
);

// ── Pagination ────────────────────────────────────────────────────────────────

final paginationComponent = WidgetbookComponent(
  name: 'Ux4gPaginationIndicator',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        int current = 0;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gPaginationIndicator',
            description: 'A page-dot indicator for carousels or steppers.',
            code: '''Ux4gPaginationIndicator(
  totalPageCount: 5,
  currentPageIndex: currentPage,
  onPageChange: (i) => setState(() => currentPage = i),
);''',
            props: const [
              PropRow(name: 'totalPageCount', type: 'int', description: 'Total number of pages.', required: true),
              PropRow(name: 'currentPageIndex', type: 'int', description: 'Zero-based active page index.', required: true),
              PropRow(name: 'onPageChange', type: 'ValueChanged<int>', description: 'Called when dot is tapped.', required: true),
              PropRow(name: 'showArrows', type: 'bool', description: 'Show prev/next chevron buttons.', defaultValue: 'true'),
              PropRow(name: 'variant', type: 'Ux4gPaginationVariant', description: 'defaultVariant or capsule.', defaultValue: 'defaultVariant'),
              PropRow(name: 'size', type: 'Ux4gPaginationSize', description: 'small or medium.', defaultValue: 'small'),
              PropRow(name: 'enabled', type: 'bool', description: 'Interactive state.', defaultValue: 'true'),
              PropRow(name: 'activeColor', type: 'Color?', description: 'Color of the active dot.'),
              PropRow(name: 'inactiveColor', type: 'Color?', description: 'Background of inactive dots.'),
              PropRow(name: 'inactiveBorderColor', type: 'Color?', description: 'Border of inactive dots.'),
            ],
            child: Ux4gPaginationIndicator(
              totalPageCount: context.knobs.int.input(label: 'Count', initialValue: 5),
              currentPageIndex: current,
              onPageChange: (i) => setState(() => current = i),
            ),
          );
        });
      },
    ),
  ],
);
