"""Fix remaining two navigation_stories.dart patches."""
import os

BASE = r'C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories'


def patch(filename, anchor, replacement):
    p = os.path.join(BASE, filename)
    with open(p, encoding='utf-8') as f:
        content = f.read()
    if anchor not in content:
        print(f'  ANCHOR NOT FOUND in {filename}')
        return False
    count = content.count(anchor)
    if count > 1:
        print(f'  ANCHOR AMBIGUOUS ({count}) in {filename}')
        return False
    with open(p, 'w', encoding='utf-8') as f:
        f.write(content.replace(anchor, replacement))
    print(f'  OK: {filename}')
    return True


# ─── Accordion Group + Disabled (correct indentation: 14 spaces for child) ──
patch(
    'navigation_stories.dart',
    "              child: Ux4gAccordion(\n"
    "                title: context.knobs.string(label: 'Title', initialValue: 'What is UX4G?'),\n"
    "                expanded: expanded,\n"
    "                onExpandedChange: (v) => setState(() => expanded = v),\n"
    "                child: const Padding(\n"
    "                  padding: EdgeInsets.all(12),\n"
    "                  child: Text('UX4G is a Flutter design system providing reusable UI components.'),\n"
    "                ),\n"
    "              ),\n"
    "            ),\n"
    "          );\n"
    "        });\n"
    "      },\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "// \u2500\u2500 Status Banner",
    """              child: Ux4gAccordion(
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
        int expandedIndex = 0;
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
            code: 'Ux4gAccordionGroup(\\n'
                '  items: items, expandedIndex: expandedIndex,\\n'
                '  onExpandedIndexChange: (i) => setState(() => expandedIndex = i),\\n'
                '  contentBuilder: (index, item) => Text(contents[index]),\\n'
                ');',
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
        name: 'Ux4gAccordion \u2014 Disabled',
        description: 'A disabled accordion cannot be expanded.',
        code: 'Ux4gAccordion(title: \\'Locked\\', expanded: false, enabled: false, onExpandedChange: (_) {});',
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
  ],
);

// \u2500\u2500 Status Banner""",
)

# ─── EmptyState with CTA (correct indentation: 8 spaces for child: SizedBox) ─
patch(
    'navigation_stories.dart',
    "        child: SizedBox(\n"
    "          width: 320,\n"
    "          child: Ux4gEmptyState(\n"
    "            title: context.knobs.string(label: 'Title', initialValue: 'No results found'),\n"
    "            description: context.knobs.string(label: 'Description', initialValue: 'Try adjusting your filters.'),\n"
    "            icon: Icons.search_off,\n"
    "          ),\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "// \u2500\u2500 Chips",
    """        child: SizedBox(
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
        name: 'Ux4gEmptyState \u2014 With CTA',
        description: 'Providing buttonText and onButtonPressed adds a primary action button.',
        code: 'Ux4gEmptyState(\\n'
            '  title: \\'Nothing here yet\\',\\n'
            '  icon: Icons.inbox_outlined,\\n'
            '  buttonText: \\'Get Started\\', onButtonPressed: () {},\\n'
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

// \u2500\u2500 Chips""",
)

print('Done.')
