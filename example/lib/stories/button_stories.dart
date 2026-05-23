import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

final buttonComponent = WidgetbookComponent(
  name: 'Ux4gButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Primary',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton',
        description:
            'The primary action button. Supports loading state, disabled state, '
            'and optional leading / trailing icons.',
        code: '''Ux4gButton(
  text: 'Primary Button',
  variant: Ux4gButtonVariant.primary,
  size: Ux4gButtonSize.medium,
  onPressed: () {},
);

// With loading state
Ux4gButton(
  text: 'Saving...',
  variant: Ux4gButtonVariant.primary,
  isLoading: true,
  onPressed: () {},
);

// Disabled
Ux4gButton(
  text: 'Disabled',
  variant: Ux4gButtonVariant.primary,
  enabled: false,
  onPressed: () {},
);''',
        props: const [
          PropRow(name: 'text', type: 'String', description: 'Label inside the button.', required: true),
          PropRow(name: 'onPressed', type: 'VoidCallback', description: 'Called when button is tapped.', required: true),
          PropRow(name: 'variant', type: 'Ux4gButtonVariant', description: 'primary / secondary / outline / ghost.', defaultValue: 'primary'),
          PropRow(name: 'size', type: 'Ux4gButtonSize', description: 'small / medium / large.', defaultValue: 'medium'),
          PropRow(name: 'enabled', type: 'bool', description: 'Whether the button is interactive.', defaultValue: 'true'),
          PropRow(name: 'isLoading', type: 'bool', description: 'Shows a spinner and disables interaction.', defaultValue: 'false'),
          PropRow(name: 'leadingIcon', type: 'IconData?', description: 'Icon placed before the label.'),
          PropRow(name: 'trailingIcon', type: 'IconData?', description: 'Icon placed after the label.'),
        ],
        child: Ux4gButton(
          onPressed: () {},
          text: context.knobs.string(label: 'Text', initialValue: 'Primary Button'),
          variant: Ux4gButtonVariant.primary,
          size: context.knobs.list(
            label: 'Size',
            options: Ux4gButtonSize.values,
            initialOption: Ux4gButtonSize.medium,
            labelBuilder: (v) => v.name,
          ),
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          isLoading: context.knobs.boolean(label: 'Loading', initialValue: false),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton — Variants',
        description: 'Four visual variants: Primary, Secondary, Outline, and Ghost.',
        code: '''Ux4gButton(text: 'Primary', variant: Ux4gButtonVariant.primary, onPressed: () {});
Ux4gButton(text: 'Secondary', variant: Ux4gButtonVariant.secondary, onPressed: () {});
Ux4gButton(text: 'Outline', variant: Ux4gButtonVariant.outline, onPressed: () {});
Ux4gButton(text: 'Ghost', variant: Ux4gButtonVariant.ghost, onPressed: () {});''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: Ux4gButtonVariant.values
              .map((v) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Ux4gButton(
                      onPressed: () {},
                      text: v.name[0].toUpperCase() + v.name.substring(1),
                      variant: v,
                    ),
                  ))
              .toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton — Sizes',
        description: 'Three size options controlling height and padding.',
        code: '''Ux4gButton(text: 'Small',  size: Ux4gButtonSize.small,  onPressed: () {});
Ux4gButton(text: 'Medium', size: Ux4gButtonSize.medium, onPressed: () {});
Ux4gButton(text: 'Large',  size: Ux4gButtonSize.large,  onPressed: () {});''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: Ux4gButtonSize.values
              .map((s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Ux4gButton(onPressed: () {}, text: s.name.toUpperCase(), variant: Ux4gButtonVariant.primary, size: s),
                  ))
              .toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Icons',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton — With Icons',
        description: 'Attach icons to the leading or trailing position of the button label.',
        code: '''Ux4gButton(
  text: 'Add Item',
  variant: Ux4gButtonVariant.primary,
  leadingIcon: Icons.add,
  onPressed: () {},
);

Ux4gButton(
  text: 'Next',
  variant: Ux4gButtonVariant.primary,
  trailingIcon: Icons.arrow_forward,
  onPressed: () {},
);''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gButton(onPressed: () {}, text: 'Add Item', variant: Ux4gButtonVariant.primary, leadingIcon: Icons.add),
            const SizedBox(height: 12),
            Ux4gButton(onPressed: () {}, text: 'Next', variant: Ux4gButtonVariant.primary, trailingIcon: Icons.arrow_forward),
            const SizedBox(height: 12),
            Ux4gButton(onPressed: () {}, text: 'Download', variant: Ux4gButtonVariant.outline, leadingIcon: Icons.download_outlined),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Ux4gIconButton',
      builder: (context) => ComponentDocs(
        name: 'Ux4gIconButton',
        description: 'A square icon-only button. Same variant/size system as Ux4gButton.',
        code: '''Ux4gIconButton(icon: Icons.favorite, onPressed: () {});
Ux4gIconButton(icon: Icons.share,    variant: Ux4gButtonVariant.outline, onPressed: () {});
Ux4gIconButton(icon: Icons.delete,   variant: Ux4gButtonVariant.ghost,   onPressed: () {});''',
        props: const [
          PropRow(name: 'icon', type: 'IconData', description: 'The icon to display.', required: true),
          PropRow(name: 'onPressed', type: 'VoidCallback', description: 'Called when tapped.', required: true),
          PropRow(name: 'variant', type: 'Ux4gButtonVariant', description: 'Visual style.', defaultValue: 'primary'),
          PropRow(name: 'size', type: 'Ux4gButtonSize', description: 'Button size.', defaultValue: 'medium'),
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gIconButton(onPressed: () {}, icon: Icons.favorite),
            const SizedBox(width: 12),
            Ux4gIconButton(onPressed: () {}, icon: Icons.share, variant: Ux4gButtonVariant.outline),
            const SizedBox(width: 12),
            Ux4gIconButton(onPressed: () {}, icon: Icons.delete, variant: Ux4gButtonVariant.ghost),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'States',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton — States',
        description: 'Default, loading, and disabled states side by side.',
        code: 'Ux4gButton(text: \'Default\',  onPressed: () {});\n'
            'Ux4gButton(text: \'Loading\',  isLoading: true, onPressed: () {});\n'
            'Ux4gButton(text: \'Disabled\', enabled: false,  onPressed: () {});',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gButton(text: 'Default',   onPressed: () {}),
            const SizedBox(height: 12),
            Ux4gButton(text: 'Loading…', isLoading: true, onPressed: () {}),
            const SizedBox(height: 12),
            Ux4gButton(text: 'Disabled',  enabled: false, onPressed: () {}),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Convenience buttons',
      builder: (context) => ComponentDocs(
        name: 'Ux4gOutlineButton & Ux4gTextButton',
        description:
            'Shorthand constructors: Ux4gOutlineButton wraps variant=outline, '
            'Ux4gTextButton wraps variant=ghost.',
        code: 'Ux4gOutlineButton(text: \'Cancel\',           onPressed: () {});\n'
            'Ux4gTextButton(   text: \'Forgot password?\', onPressed: () {});',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gOutlineButton(text: 'Outline Button',     onPressed: () {}),
            const SizedBox(height: 12),
            Ux4gTextButton(  text: 'Text / Ghost Button', onPressed: () {}),
          ],
        ),
      ),
    ),
  ],
);
