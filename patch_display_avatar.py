"""Patch display_stories.dart and avatar_stories.dart with missing use cases."""
import os

BASE = r'C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories'


def patch(filename, anchor, replacement, label=''):
    p = os.path.join(BASE, filename)
    with open(p, encoding='utf-8') as f:
        content = f.read()
    if anchor not in content:
        print(f'  ANCHOR NOT FOUND in {filename} [{label}]')
        return False
    count = content.count(anchor)
    if count > 1:
        print(f'  ANCHOR AMBIGUOUS ({count}) in {filename} [{label}]')
        return False
    with open(p, 'w', encoding='utf-8') as f:
        f.write(content.replace(anchor, replacement))
    print(f'  OK: {filename} [{label}]')
    return True


# ═══ display_stories.dart ════════════════════════════════════════════════════

# 1. Tag: add "Shapes" + "Sizes" use cases after "Interactive (knobs)"
patch(
    'display_stories.dart',
    "          size: context.knobs.list(\n"
    "            label: 'Size', options: Ux4gTagSize.values,\n"
    "            initialOption: Ux4gTagSize.m, labelBuilder: (v) => v.name,\n"
    "          ),\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "final cardComponent",
    """          size: context.knobs.list(
            label: 'Size', options: Ux4gTagSize.values,
            initialOption: Ux4gTagSize.m, labelBuilder: (v) => v.name,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Shapes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTag \u2014 Shapes',
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
        name: 'Ux4gTag \u2014 Sizes',
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

final cardComponent""",
    'Tag Shapes+Sizes',
)

# 2. Card: add "Horizontal layout" + "With media" after "With footer buttons"
patch(
    'display_stories.dart',
    "            onPrimaryClick: () {},\n"
    "            onSecondaryClick: () {},\n"
    "          ),\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "final dividerComponent",
    """            onPrimaryClick: () {},
            onSecondaryClick: () {},
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Horizontal layout',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCard \u2014 Horizontal',
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
        name: 'Ux4gCard \u2014 With Media',
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

final dividerComponent""",
    'Card Horizontal+Media',
)

# 3. Divider: add "Vertical" after "With label"
patch(
    'display_stories.dart',
    "        child: const SizedBox(width: 300, child: Ux4gDivider(label: Text('OR'))),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");",
    """        child: const SizedBox(width: 300, child: Ux4gDivider(label: Text('OR'))),
      ),
    ),
    WidgetbookUseCase(
      name: 'Vertical',
      builder: (context) => ComponentDocs(
        name: 'Ux4gDivider \u2014 Vertical',
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
);""",
    'Divider Vertical',
)

# ═══ avatar_stories.dart ═════════════════════════════════════════════════════

# 4. ProfileAvatar: add "Action overlays" after "Badge variants"
patch(
    'avatar_stories.dart',
    "              .toList(),\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "final statusAvatarComponent",
    """              .toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Action overlays',
      builder: (context) => ComponentDocs(
        name: 'Ux4gProfileAvatar \u2014 Actions',
        description: 'Edit, camera, and remove action overlays appear as tappable icons on the avatar.',
        code: '''Ux4gProfileAvatar(
  initials: 'AB',
  variant: Ux4gProfileAction.edit,
  size: Ux4gAvatarSize.l,
  onVariantClick: () {},
);''',
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: Ux4gProfileAction.values
              .map((a) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ux4gProfileAvatar(
                          initials: 'AB',
                          variant: a,
                          size: Ux4gAvatarSize.l,
                          onVariantClick: () {},
                        ),
                        const SizedBox(height: 4),
                        Text(a.name, style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    ),
  ],
);

final statusAvatarComponent""",
    'ProfileAvatar Actions',
)

# 5. Ux4gAvatar: add "With initials" + "With image" after "All sizes"
patch(
    'avatar_stories.dart',
    "              .toList(),\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");\n"
    "\n"
    "final profileAvatarComponent",
    """              .toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With initials',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAvatar \u2014 Initials',
        description: 'Pass up to 2 letters via initials to show a text-based avatar.',
        code: 'Ux4gAvatar(initials: \\'AB\\', size: Ux4gAvatarSize.l)',
        child: Ux4gAvatar(
          initials: context.knobs.string(label: 'Initials', initialValue: 'AB'),
          size: context.knobs.list(
            label: 'Size', options: Ux4gAvatarSize.values,
            initialOption: Ux4gAvatarSize.l, labelBuilder: (v) => v.name,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With image',
      builder: (context) => ComponentDocs(
        name: 'Ux4gAvatar \u2014 Image',
        description: 'Provide an imageUrl to display a network photo in the avatar.',
        code: 'Ux4gAvatar(imageUrl: \\'https://i.pravatar.cc/150?img=3\\', size: Ux4gAvatarSize.l)',
        child: Ux4gAvatar(
          imageUrl: 'https://i.pravatar.cc/150?img=3',
          size: context.knobs.list(
            label: 'Size', options: Ux4gAvatarSize.values,
            initialOption: Ux4gAvatarSize.l, labelBuilder: (v) => v.name,
          ),
        ),
      ),
    ),
  ],
);

final profileAvatarComponent""",
    'Avatar Initials+Image',
)

print('Done.')
