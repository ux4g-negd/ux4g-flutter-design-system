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
);

// Group (only one open at a time)
Ux4gAccordionGroup(
  items: [
    Ux4gAccordionItem(title: 'Item 1'),
    Ux4gAccordionItem(title: 'Item 2'),
  ],
  expandedIndex: 0,
  onExpandedIndexChange: (i) {},
  contentBuilder: (index, item) => Text('Content \'),
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
      name: 'Group',
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

// ── Status Banner ─────────────────────────────────────────────────────────────

final statusBannerComponent = WidgetbookComponent(
  name: 'Ux4gStatusBanner',
  useCases: [
    WidgetbookUseCase(
      name: 'All variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStatusBanner',
        description: 'Notification banners with semantic colour variants: warning, error, success, and saving.',
        code: '''Ux4gStatusBanner(
  variant: Ux4gBannerVariant.successLight,
  title: 'Operation successful',
  subtitle: 'Your data was saved.',
  onDismiss: () {},
);''',
        props: const [
          PropRow(name: 'variant', type: 'Ux4gBannerVariant', description: 'warningLight / warningSolid / errorLight / successLight / savingLight.', required: true),
          PropRow(name: 'title', type: 'String', description: 'Banner heading.', required: true),
          PropRow(name: 'subtitle', type: 'String?', description: 'Supporting text.'),
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
          PropRow(name: 'subtitle', type: 'String?', description: 'Secondary message.'),
          PropRow(name: 'description', type: 'String?', description: 'Descriptive text.'),
          PropRow(name: 'icon', type: 'IconData?', description: 'Icon displayed above title.'),
          PropRow(name: 'buttonText', type: 'String?', description: 'CTA button label.'),
          PropRow(name: 'onButtonPressed', type: 'VoidCallback?', description: 'CTA button callback.'),
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

final chipsComponent = WidgetbookComponent(
  name: 'Chips',
  useCases: [
    WidgetbookUseCase(
      name: 'Choice Chip',
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
    WidgetbookUseCase(
      name: 'Filter Chip',
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
    WidgetbookUseCase(
      name: 'Input Chip',
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
              PropRow(name: 'onDismiss', type: 'VoidCallback?', description: 'Called when × is tapped.'),
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
