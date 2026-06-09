"""Add all missing use cases to Widgetbook story files."""
import os

BASE = r'C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories'


def patch(filename, anchor, replacement):
    p = os.path.join(BASE, filename)
    with open(p, encoding='utf-8') as f:
        content = f.read()
    if anchor not in content:
        print(f"  ANCHOR NOT FOUND in {filename}")
        return False
    count = content.count(anchor)
    if count > 1:
        print(f"  ANCHOR AMBIGUOUS ({count} occurrences) in {filename}")
        return False
    with open(p, 'w', encoding='utf-8') as f:
        f.write(content.replace(anchor, replacement))
    print(f"  OK: {filename}")
    return True


# ─────────────────────────────────────────────────────────────────────────────
# 1. button_stories.dart
# ─────────────────────────────────────────────────────────────────────────────
BUTTON_ANCHOR = """\
            Ux4gIconButton(onPressed: () {}, icon: Icons.delete, variant: Ux4gButtonVariant.ghost),
          ],
        ),
      ),
    ),
  ],
);"""

BUTTON_REPLACEMENT = """\
            Ux4gIconButton(onPressed: () {}, icon: Icons.delete, variant: Ux4gButtonVariant.ghost),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'States',
      builder: (context) => ComponentDocs(
        name: 'Ux4gButton \u2014 States',
        description: 'Default, loading, and disabled states side by side.',
        code: '''
Ux4gButton(text: 'Default',  onPressed: () {});
Ux4gButton(text: 'Loading',  isLoading: true, onPressed: () {});
Ux4gButton(text: 'Disabled', enabled: false,  onPressed: () {});
''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ux4gButton(text: 'Default',  onPressed: () {}),
            const SizedBox(height: 12),
            Ux4gButton(text: 'Loading\u2026', isLoading: true, onPressed: () {}),
            const SizedBox(height: 12),
            Ux4gButton(text: 'Disabled', enabled: false, onPressed: () {}),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Convenience buttons',
      builder: (context) => ComponentDocs(
        name: 'Ux4gOutlineButton & Ux4gTextButton',
        description: 'Shorthand constructors: Ux4gOutlineButton wraps variant=outline, Ux4gTextButton wraps variant=ghost.',
        code: '''
Ux4gOutlineButton(text: 'Cancel',           onPressed: () {});
Ux4gTextButton(   text: 'Forgot password?', onPressed: () {});
''',
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
);"""

patch('button_stories.dart', BUTTON_ANCHOR, BUTTON_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 2. form_stories.dart — InputField extra cases
# ─────────────────────────────────────────────────────────────────────────────
FORM_INPUT_ANCHOR = """\
              child: Ux4gInputField(
                        value: '', onValueChange: (_) {},
                        label: s.name, status: s, caption: ' caption',
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ),
  ],
);

// \u2500\u2500 Text Area"""

FORM_INPUT_REPLACEMENT = """\
              child: Ux4gInputField(
                        value: '', onValueChange: (_) {},
                        label: s.name, status: s, caption: ' caption',
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Password field',
      builder: (context) {
        String value = '';
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gInputField \u2014 Password',
            description: 'Password type hides input and shows a visibility toggle icon.',
            code: '''
Ux4gInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Password',
  placeholder: 'Enter your password',
  type: Ux4gInputFieldType.password,
  showPasswordToggle: true,
);
''',
            child: SizedBox(
              width: 320,
              child: Ux4gInputField(
                value: value,
                onValueChange: (v) => setState(() => value = v),
                label: 'Password',
                placeholder: 'Enter your password',
                type: Ux4gInputFieldType.password,
                showPasswordToggle: true,
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'With icons',
      builder: (context) {
        String value = '';
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gInputField \u2014 Icons',
            description: 'Leading and trailing icons inside the input field.',
            code: '''
Ux4gInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Search location',
  leadingIcon: Icons.location_on_outlined,
  trailingIcon: Icons.my_location,
);
''',
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Ux4gInputField(
                    value: value,
                    onValueChange: (v) => setState(() => value = v),
                    label: 'With leading icon',
                    placeholder: 'Search...',
                    leadingIcon: Icons.search,
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: value,
                    onValueChange: (v) => setState(() => value = v),
                    label: 'With trailing icon',
                    placeholder: 'Enter amount',
                    trailingIcon: Icons.currency_rupee,
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: value,
                    onValueChange: (v) => setState(() => value = v),
                    label: 'Both icons',
                    placeholder: 'Location',
                    leadingIcon: Icons.location_on_outlined,
                    trailingIcon: Icons.my_location,
                  ),
                ],
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'Prefix & Postfix',
      builder: (context) {
        String value = '';
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gInputField \u2014 Prefix / Postfix',
            description: 'Text decorations prepended or appended inside the field border.',
            code: '''
Ux4gInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Amount',
  prefixText: '\u20b9',
  postfixText: '.00',
);
''',
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Ux4gInputField(
                    value: value,
                    onValueChange: (v) => setState(() => value = v),
                    label: 'Amount',
                    placeholder: '0',
                    prefixText: '\u20b9',
                    postfixText: '.00',
                  ),
                  const SizedBox(height: 16),
                  Ux4gInputField(
                    value: value,
                    onValueChange: (v) => setState(() => value = v),
                    label: 'Website',
                    placeholder: 'example.com',
                    prefixText: 'https://',
                  ),
                ],
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'Read-only & Required',
      builder: (context) => ComponentDocs(
        name: 'Ux4gInputField \u2014 Read-only & Required',
        description: 'readOnly disables editing while keeping field visible. required shows an asterisk.',
        code: '''
Ux4gInputField(
  value: 'GOV/2025/001',
  onValueChange: (_) {},
  label: 'Application ID',
  readOnly: true,
);
Ux4gInputField(
  value: '',
  onValueChange: (_) {},
  label: 'Full Name',
  required: true,
  placeholder: 'Enter full name',
);
''',
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Ux4gInputField(
                value: 'GOV/2025/001',
                onValueChange: (_) {},
                label: 'Application ID (read-only)',
                readOnly: true,
              ),
              const SizedBox(height: 16),
              Ux4gInputField(
                value: '',
                onValueChange: (_) {},
                label: 'Full Name',
                required: true,
                placeholder: 'Enter full name',
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

// \u2500\u2500 Text Area"""

patch('form_stories.dart', FORM_INPUT_ANCHOR, FORM_INPUT_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 2b. form_stories.dart — Checkbox extra cases
# ─────────────────────────────────────────────────────────────────────────────
FORM_CHECKBOX_ANCHOR = """\
            child: Ux4gCheckbox(
              value: value,
              onChanged: (v) => setState(() => value = v),
              label: context.knobs.string(label: 'Label', initialValue: 'Accept terms'),
              description: context.knobs.string(label: 'Description', initialValue: ''),
              size: context.knobs.list(
                label: 'Size', options: Ux4gCheckboxSize.values,
                initialOption: Ux4gCheckboxSize.medium, labelBuilder: (v) => v.name,
              ),
            ),
          );
        });
      },
    ),
  ],
);

// \u2500\u2500 Toggle"""

FORM_CHECKBOX_REPLACEMENT = """\
            child: Ux4gCheckbox(
              value: value,
              onChanged: (v) => setState(() => value = v),
              label: context.knobs.string(label: 'Label', initialValue: 'Accept terms'),
              description: context.knobs.string(label: 'Description', initialValue: ''),
              size: context.knobs.list(
                label: 'Size', options: Ux4gCheckboxSize.values,
                initialOption: Ux4gCheckboxSize.medium, labelBuilder: (v) => v.name,
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'All states',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCheckbox \u2014 All States',
        description: 'Shows checked, unchecked, indeterminate, and disabled states.',
        code: '''
Ux4gCheckbox(value: true,  onChanged: (v) {}, label: 'Checked');
Ux4gCheckbox(value: false, onChanged: (v) {}, label: 'Unchecked');
Ux4gCheckbox(value: null,  onChanged: (v) {}, label: 'Indeterminate');
Ux4gCheckbox(value: true,  onChanged: null,   label: 'Disabled checked', enabled: false);
''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gCheckbox(value: true,  onChanged: (_) {}, label: 'Checked'),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: false, onChanged: (_) {}, label: 'Unchecked'),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: null,  onChanged: (_) {}, label: 'Indeterminate'),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: true,  onChanged: null,   label: 'Disabled (checked)', enabled: false),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: false, onChanged: null,   label: 'Disabled (unchecked)', enabled: false),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCheckbox \u2014 Sizes',
        description: 'Small, medium, and large checkbox side by side.',
        code: '''
Ux4gCheckbox(value: true, onChanged: (v) {}, label: 'Small',  size: Ux4gCheckboxSize.small);
Ux4gCheckbox(value: true, onChanged: (v) {}, label: 'Medium', size: Ux4gCheckboxSize.medium);
Ux4gCheckbox(value: true, onChanged: (v) {}, label: 'Large',  size: Ux4gCheckboxSize.large);
''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gCheckbox(value: true, onChanged: (_) {}, label: 'Small',  size: Ux4gCheckboxSize.small),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: true, onChanged: (_) {}, label: 'Medium', size: Ux4gCheckboxSize.medium),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: true, onChanged: (_) {}, label: 'Large',  size: Ux4gCheckboxSize.large),
          ],
        ),
      ),
    ),
  ],
);

// \u2500\u2500 Toggle"""

patch('form_stories.dart', FORM_CHECKBOX_ANCHOR, FORM_CHECKBOX_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 2c. form_stories.dart — Toggle extra cases
# ─────────────────────────────────────────────────────────────────────────────
FORM_TOGGLE_ANCHOR = """\
            child: Ux4gToggle(
              checked: checked,
              onCheckedChange: (v) => setState(() => checked = v),
              label: context.knobs.string(label: 'Label', initialValue: 'Enable notifications'),
              size: context.knobs.list(
                label: 'Size', options: Ux4gToggleSize.values,
                initialOption: Ux4gToggleSize.m, labelBuilder: (v) => v.name,
              ),
            ),
          );
        });
      },
    ),
  ],
);

// \u2500\u2500 Slider"""

FORM_TOGGLE_REPLACEMENT = """\
            child: Ux4gToggle(
              checked: checked,
              onCheckedChange: (v) => setState(() => checked = v),
              label: context.knobs.string(label: 'Label', initialValue: 'Enable notifications'),
              size: context.knobs.list(
                label: 'Size', options: Ux4gToggleSize.values,
                initialOption: Ux4gToggleSize.m, labelBuilder: (v) => v.name,
              ),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToggle \u2014 Sizes',
        description: 'Small (s), medium (m), and large (l) toggle switches.',
        code: '''
Ux4gToggle(checked: true, onCheckedChange: (v) {}, label: 'Small',  size: Ux4gToggleSize.s);
Ux4gToggle(checked: true, onCheckedChange: (v) {}, label: 'Medium', size: Ux4gToggleSize.m);
Ux4gToggle(checked: true, onCheckedChange: (v) {}, label: 'Large',  size: Ux4gToggleSize.l);
''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gToggle(checked: true, onCheckedChange: (_) {}, label: 'Small',  size: Ux4gToggleSize.s),
            const SizedBox(height: 8),
            Ux4gToggle(checked: true, onCheckedChange: (_) {}, label: 'Medium', size: Ux4gToggleSize.m),
            const SizedBox(height: 8),
            Ux4gToggle(checked: true, onCheckedChange: (_) {}, label: 'Large',  size: Ux4gToggleSize.l),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToggle \u2014 Disabled',
        description: 'Toggle with onCheckedChange=null is visually disabled.',
        code: '''
Ux4gToggle(checked: false, onCheckedChange: null, label: 'Off  (disabled)');
Ux4gToggle(checked: true,  onCheckedChange: null, label: 'On   (disabled)');
''',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gToggle(checked: false, onCheckedChange: null, label: 'Off (disabled)'),
            const SizedBox(height: 8),
            Ux4gToggle(checked: true,  onCheckedChange: null, label: 'On  (disabled)'),
          ],
        ),
      ),
    ),
  ],
);

// \u2500\u2500 Slider"""

patch('form_stories.dart', FORM_TOGGLE_ANCHOR, FORM_TOGGLE_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 2d. form_stories.dart — Add RadioButton component at end of file
# ─────────────────────────────────────────────────────────────────────────────
FORM_FILEUPLOAD_END = """\
        child: SizedBox(
          width: 360,
          child: Ux4gFileUpload(
            maxFiles: 5,
            maxFileSize: 5 * 1024 * 1024,
            onFilesChanged: (_) {},
            onUpload: (file) async => true,
          ),
        ),
      ),
    ),
  ],
);"""

RADIO_COMPONENT = """

// \u2500\u2500 Radio Button \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500

final radioButtonComponent = WidgetbookComponent(
  name: 'Ux4gRadioButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        String selected = 'b';
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gRadioButton',
            description:
                'A single-selection radio button with label, optional description, '
                'three sizes, and four description-variant styles.',
            code: \\'\\'\\'
Ux4gRadioButton(
  value: \\'option1\\',
  groupValue: selectedValue,
  onChanged: (v) => setState(() => selectedValue = v),
  label: \\'Option A\\',
  description: \\'Helper text\\',
  descriptionVariant: Ux4gRadioButtonDescriptionVariant.helper,
  size: Ux4gRadioButtonSize.medium,
);
\\'\\'\\',
            props: const [
              PropRow(name: \\'value\\', type: \\'String\\', description: \\'This radio\\'s value.\\', required: true),
              PropRow(name: \\'groupValue\\', type: \\'String?\\', description: \\'The currently selected value in the group.\\', required: true),
              PropRow(name: \\'onChanged\\', type: \\'ValueChanged<String>?\\', description: \\'Called when selected.\\'),
              PropRow(name: \\'label\\', type: \\'String?\\', description: \\'Label text.\\'),
              PropRow(name: \\'description\\', type: \\'String?\\', description: \\'Helper / status text below label.\\'),
              PropRow(name: \\'size\\', type: \\'Ux4gRadioButtonSize\\', description: \\'small / medium / large.\\', defaultValue: \\'medium\\'),
              PropRow(name: \\'enabled\\', type: \\'bool\\', description: \\'Interactive state.\\', defaultValue: \\'true\\'),
              PropRow(name: \\'descriptionVariant\\', type: \\'Ux4gRadioButtonDescriptionVariant\\', description: \\'helper / error / warning / success.\\', defaultValue: \\'helper\\'),
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [\\'Option A\\', \\'Option B\\', \\'Option C\\']
                  .map((v) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Ux4gRadioButton(
                          value: v,
                          groupValue: selected,
                          onChanged: (val) => setState(() => selected = val!),
                          label: v,
                          size: context.knobs.list(
                            label: \\'Size\\',
                            options: Ux4gRadioButtonSize.values,
                            initialOption: Ux4gRadioButtonSize.medium,
                            labelBuilder: (s) => s.name,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton \\u2014 Sizes',
        description: 'Small, medium, and large radio buttons.',
        code: \\'\\'\\'
Ux4gRadioButton(value: \\'a\\', groupValue: \\'a\\', onChanged: (v) {}, label: \\'Small\\',  size: Ux4gRadioButtonSize.small);
Ux4gRadioButton(value: \\'b\\', groupValue: \\'b\\', onChanged: (v) {}, label: \\'Medium\\', size: Ux4gRadioButtonSize.medium);
Ux4gRadioButton(value: \\'c\\', groupValue: \\'c\\', onChanged: (v) {}, label: \\'Large\\',  size: Ux4gRadioButtonSize.large);
\\'\\'\\',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gRadioButton(value: \\'a\\', groupValue: \\'a\\', onChanged: (_) {}, label: \\'Small\\',  size: Ux4gRadioButtonSize.small),
            const SizedBox(height: 8),
            Ux4gRadioButton(value: \\'b\\', groupValue: \\'b\\', onChanged: (_) {}, label: \\'Medium\\', size: Ux4gRadioButtonSize.medium),
            const SizedBox(height: 8),
            Ux4gRadioButton(value: \\'c\\', groupValue: \\'c\\', onChanged: (_) {}, label: \\'Large\\',  size: Ux4gRadioButtonSize.large),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Description variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton \\u2014 Description Variants',
        description: 'Each description variant applies a semantic colour to the helper text.',
        code: \\'\\'\\'
Ux4gRadioButton(value: \\'a\\', groupValue: \\'a\\', onChanged: (_) {}, label: \\'Helper\\',
  description: \\'Helper message\\', descriptionVariant: Ux4gRadioButtonDescriptionVariant.helper);
\\'\\'\\',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: Ux4gRadioButtonDescriptionVariant.values.map((v) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Ux4gRadioButton(
              value: v.name,
              groupValue: v.name,
              onChanged: (_) {},
              label: v.name[0].toUpperCase() + v.name.substring(1),
              description: '${v.name} description text',
              descriptionVariant: v,
            ),
          )).toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton \\u2014 Disabled',
        description: 'Disabled radio buttons cannot be interacted with.',
        code: \\'\\'\\'
Ux4gRadioButton(value: \\'a\\', groupValue: \\'a\\', onChanged: null, label: \\'Selected & disabled\\', enabled: false);
Ux4gRadioButton(value: \\'b\\', groupValue: \\'a\\', onChanged: null, label: \\'Unselected & disabled\\', enabled: false);
\\'\\'\\',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gRadioButton(value: \\'a\\', groupValue: \\'a\\', onChanged: null, label: \\'Selected & disabled\\',   enabled: false),
            const SizedBox(height: 8),
            Ux4gRadioButton(value: \\'b\\', groupValue: \\'a\\', onChanged: null, label: \\'Unselected & disabled\\', enabled: false),
          ],
        ),
      ),
    ),
  ],
);"""

p_form = os.path.join(BASE, 'form_stories.dart')
with open(p_form, encoding='utf-8') as f:
    form_content = f.read()

if FORM_FILEUPLOAD_END in form_content:
    form_content = form_content.replace(FORM_FILEUPLOAD_END, FORM_FILEUPLOAD_END + RADIO_COMPONENT)
    with open(p_form, 'w', encoding='utf-8') as f:
        f.write(form_content)
    print("  OK: form_stories.dart (RadioButton appended)")
else:
    print("  ANCHOR NOT FOUND: form_stories.dart (RadioButton)")


# ─────────────────────────────────────────────────────────────────────────────
# 3. navigation_stories.dart — Accordion extra cases
# ─────────────────────────────────────────────────────────────────────────────
NAV_ACCORDION_ANCHOR = """\
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
  ],
);

// \u2500\u2500 Status Banner"""

NAV_ACCORDION_REPLACEMENT = """\
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
        int expandedIndex = 0;
        return StatefulBuilder(builder: (ctx, setState) {
          final items = [
            const Ux4gAccordionItem(title: 'What is UX4G?'),
            const Ux4gAccordionItem(title: 'How do I install it?'),
            const Ux4gAccordionItem(title: 'Is it open source?'),
          ];
          final contents = [
            'UX4G is a Flutter design system providing reusable UI components.',
            'Add it to your pubspec.yaml and run flutter pub get.',
            'Yes, UX4G is open source under the MIT licence.',
          ];
          return ComponentDocs(
            name: 'Ux4gAccordionGroup',
            description: 'AccordionGroup ensures only one item is expanded at a time.',
            code: '''
Ux4gAccordionGroup(
  items: items,
  expandedIndex: expandedIndex,
  onExpandedIndexChange: (i) => setState(() => expandedIndex = i),
  contentBuilder: (index, item) => Padding(
    padding: const EdgeInsets.all(12),
    child: Text(contents[index]),
  ),
);
''',
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
        code: '''
Ux4gAccordion(
  title: 'Locked Section',
  expanded: false,
  enabled: false,
  onExpandedChange: (_) {},
  child: Text('Hidden content'),
);
''',
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

// \u2500\u2500 Status Banner"""

patch('navigation_stories.dart', NAV_ACCORDION_ANCHOR, NAV_ACCORDION_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 3b. navigation_stories.dart — EmptyState with CTA
# ─────────────────────────────────────────────────────────────────────────────
NAV_EMPTY_ANCHOR = """\
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
  ],
);

// \u2500\u2500 Chips"""

NAV_EMPTY_REPLACEMENT = """\
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
        name: 'Ux4gEmptyState \u2014 With CTA',
        description: 'Adds a primary call-to-action button below the description.',
        code: '''
Ux4gEmptyState(
  title: 'Nothing here yet',
  description: 'Create your first item to get started.',
  icon: Icons.inbox_outlined,
  buttonText: 'Get Started',
  onButtonPressed: () {},
);
''',
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

// \u2500\u2500 Chips"""

patch('navigation_stories.dart', NAV_EMPTY_ANCHOR, NAV_EMPTY_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 3c. navigation_stories.dart — StatusBanner with dismiss
# ─────────────────────────────────────────────────────────────────────────────
NAV_BANNER_ANCHOR = """\
                  child: Ux4gStatusBanner(variant: v, title: v.name, subtitle: 'Supporting subtitle text'),
                    ))
                .toList(),
          ),
        ),
      ),
    ),
  ],
);

// \u2500\u2500 Empty State"""

NAV_BANNER_REPLACEMENT = """\
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
            name: 'Ux4gStatusBanner \u2014 With Dismiss',
            description: 'Providing onDismiss shows a \u00d7 close button on the banner.',
            code: '''
Ux4gStatusBanner(
  variant: Ux4gBannerVariant.successLight,
  title: 'Changes saved',
  subtitle: 'Your profile has been updated.',
  onDismiss: () => setState(() => dismissed = true),
);
''',
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

// \u2500\u2500 Empty State"""

patch('navigation_stories.dart', NAV_BANNER_ANCHOR, NAV_BANNER_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 4. overlay_stories.dart — Modal extra cases
# ─────────────────────────────────────────────────────────────────────────────
OVERLAY_MODAL_ANCHOR = """\
            primaryButtonText: 'Delete',
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

// \u2500\u2500 Bottom Sheet"""

OVERLAY_MODAL_REPLACEMENT = """\
            primaryButtonText: 'Delete',
            secondaryButtonText: 'Cancel',
            onPrimaryClick: () {},
            onSecondaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Centered alignment',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal \u2014 Centered',
        description: 'Centers title, description, and icon for confirmation dialogs.',
        code: '''
Ux4gModal(
  alignment: Ux4gModalAlignment.centered,
  leadingItem: Ux4gModalLeadingItem.icon,
  leadingIcon: Icons.check_circle_outline,
  headerTitle: 'Payment successful!',
  showDescription: true,
  descriptionText: 'Your transaction has been completed.',
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.oneButton,
  primaryButtonText: 'Done',
  onPrimaryClick: () {},
  onDismiss: () {},
);
''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            alignment: Ux4gModalAlignment.centered,
            leadingItem: Ux4gModalLeadingItem.icon,
            leadingIcon: Icons.check_circle_outline,
            headerTitle: 'Payment successful!',
            showDescription: true,
            descriptionText: 'Your transaction has been completed.',
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.oneButton,
            primaryButtonText: 'Done',
            onPrimaryClick: () {},
            onDismiss: () {},
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Footer variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal \u2014 Footer Button Variants',
        description: 'oneButton, twoButtons, oneButtonWithIcon, twoButtonsWithIcon.',
        code: '''
// One button
Ux4gModal(footerButtons: Ux4gModalFooterButtons.oneButton, primaryButtonText: 'OK', ...);
// Two buttons
Ux4gModal(footerButtons: Ux4gModalFooterButtons.twoButtons, primaryButtonText: 'Confirm', secondaryButtonText: 'Cancel', ...);
// With icons
Ux4gModal(footerButtons: Ux4gModalFooterButtons.twoButtonsWithIcon, primaryButtonText: 'Save', secondaryButtonText: 'Discard', ...);
''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            headerTitle: 'Footer Variants',
            showDescription: true,
            descriptionText: 'Use the knob to switch footer button types.',
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
    WidgetbookUseCase(
      name: 'With avatar',
      builder: (context) => ComponentDocs(
        name: 'Ux4gModal \u2014 With Avatar',
        description: 'Modal with an avatar as the leading item in the header.',
        code: '''
Ux4gModal(
  leadingItem: Ux4gModalLeadingItem.avatar,
  avatarInitials: 'AK',
  headerTitle: 'Assign to Anil Kumar',
  showDescription: true,
  descriptionText: 'This task will be assigned to Anil Kumar.',
  showFooter: true,
  footerButtons: Ux4gModalFooterButtons.twoButtons,
  primaryButtonText: 'Assign',
  secondaryButtonText: 'Cancel',
  onPrimaryClick: () {},
  onSecondaryClick: () {},
  onDismiss: () {},
);
''',
        child: SizedBox(
          width: 380,
          child: Ux4gModal(
            leadingItem: Ux4gModalLeadingItem.avatar,
            avatarInitials: 'AK',
            headerTitle: 'Assign to Anil Kumar',
            showDescription: true,
            descriptionText: 'This task will be assigned to Anil Kumar.',
            showFooter: true,
            footerButtons: Ux4gModalFooterButtons.twoButtons,
            primaryButtonText: 'Assign',
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

// \u2500\u2500 Bottom Sheet"""

patch('overlay_stories.dart', OVERLAY_MODAL_ANCHOR, OVERLAY_MODAL_REPLACEMENT)


# ─────────────────────────────────────────────────────────────────────────────
# 5. data_stories.dart — Stepper extra cases
# ─────────────────────────────────────────────────────────────────────────────
DATA_STEPPER_ANCHOR = """\
                    Ux4gButton(
                      onPressed: current < 3 ? () => setState(() => current++) : null,
                      text: 'Next', variant: Ux4gButtonVariant.primary,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    ),
  ],
);

// \u2500\u2500 Result Row"""

DATA_STEPPER_REPLACEMENT = """\
                    Ux4gButton(
                      onPressed: current < 3 ? () => setState(() => current++) : null,
                      text: 'Next', variant: Ux4gButtonVariant.primary,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'Vertical',
      builder: (context) {
        int current = 2;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gStepper \u2014 Vertical',
            description: 'Vertical orientation stacks steps top-to-bottom with connecting lines.',
            code: '''
Ux4gStepper(
  totalSteps: 4,
  currentStep: 2,
  orientation: StepperOrientation.vertical,
  steps: const [
    Ux4gStepItem(title: 'Personal', description: 'Name and contact'),
    Ux4gStepItem(title: 'Address',  description: 'Home address'),
    Ux4gStepItem(title: 'Documents'),
    Ux4gStepItem(title: 'Review'),
  ],
);
''',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 280,
                  child: Ux4gStepper(
                    totalSteps: 4, currentStep: current,
                    orientation: StepperOrientation.vertical,
                    steps: const [
                      Ux4gStepItem(title: 'Personal', description: 'Name and contact'),
                      Ux4gStepItem(title: 'Address',  description: 'Home address'),
                      Ux4gStepItem(title: 'Documents'),
                      Ux4gStepItem(title: 'Review'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Ux4gButton(
                      onPressed: current > 1 ? () => setState(() => current--) : null,
                      text: 'Back', variant: Ux4gButtonVariant.outline,
                    ),
                    const SizedBox(width: 12),
                    Ux4gButton(
                      onPressed: current < 4 ? () => setState(() => current++) : null,
                      text: 'Next', variant: Ux4gButtonVariant.primary,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    ),
    WidgetbookUseCase(
      name: 'Dashed line',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStepper \u2014 Dashed Line',
        description: 'lineStyle=dashed renders dotted connector lines between steps.',
        code: '''
Ux4gStepper(
  totalSteps: 4,
  currentStep: 2,
  lineStyle: StepperLineStyle.dashed,
  steps: const [
    Ux4gStepItem(title: 'Step 1'),
    Ux4gStepItem(title: 'Step 2'),
    Ux4gStepItem(title: 'Step 3'),
    Ux4gStepItem(title: 'Step 4'),
  ],
);
''',
        child: SizedBox(
          width: 380,
          child: Ux4gStepper(
            totalSteps: 4, currentStep: 2,
            lineStyle: StepperLineStyle.dashed,
            steps: const [
              Ux4gStepItem(title: 'Step 1'),
              Ux4gStepItem(title: 'Step 2'),
              Ux4gStepItem(title: 'Step 3'),
              Ux4gStepItem(title: 'Step 4'),
            ],
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With error step',
      builder: (context) => ComponentDocs(
        name: 'Ux4gStepper \u2014 Error Step',
        description: 'Mark a step as errored with isError: true on Ux4gStepItem.',
        code: '''
Ux4gStepper(
  totalSteps: 4,
  currentStep: 3,
  steps: const [
    Ux4gStepItem(title: 'Personal'),
    Ux4gStepItem(title: 'Address', isError: true, statusLabel: 'Needs review'),
    Ux4gStepItem(title: 'Documents'),
    Ux4gStepItem(title: 'Review'),
  ],
);
''',
        child: SizedBox(
          width: 380,
          child: Ux4gStepper(
            totalSteps: 4, currentStep: 3,
            steps: const [
              Ux4gStepItem(title: 'Personal'),
              Ux4gStepItem(title: 'Address', isError: true, statusLabel: 'Needs review'),
              Ux4gStepItem(title: 'Documents'),
              Ux4gStepItem(title: 'Review'),
            ],
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Capsule stepper',
      builder: (context) {
        int current = 1;
        return StatefulBuilder(builder: (ctx, setState) {
          return ComponentDocs(
            name: 'Ux4gCapsuleStepper',
            description:
                'A compact capsule-style progress indicator with Prev/Next navigation. '
                'Supports linear, rightAligned, centered, and split layouts.',
            code: '''
Ux4gCapsuleStepper(
  totalSteps: 5,
  currentStep: 1,
  stepLabel: 'Step 2 of 5',
  description: 'Personal information',
  layout: Ux4gCapsuleStepperLayout.linear,
  onNext: () => setState(() => current++),
  onPrevious: () => setState(() => current--),
);
''',
            props: const [
              PropRow(name: 'totalSteps', type: 'int', description: 'Total steps.', required: true),
              PropRow(name: 'currentStep', type: 'int', description: 'Current step (1-based).', required: true),
              PropRow(name: 'stepLabel', type: 'String', description: 'Text shown alongside capsules.', required: true),
              PropRow(name: 'description', type: 'String?', description: 'Sub-label below stepLabel.'),
              PropRow(name: 'layout', type: 'Ux4gCapsuleStepperLayout', description: 'linear / rightAligned / centered / split.', defaultValue: 'linear'),
              PropRow(name: 'onNext', type: 'VoidCallback', description: 'Next button callback.'),
              PropRow(name: 'onPrevious', type: 'VoidCallback', description: 'Previous button callback.'),
            ],
            child: SizedBox(
              width: 380,
              child: Ux4gCapsuleStepper(
                totalSteps: 5,
                currentStep: current,
                stepLabel: 'Step $current of 5',
                description: 'Complete all steps to finish',
                layout: context.knobs.list(
                  label: 'Layout',
                  options: Ux4gCapsuleStepperLayout.values,
                  initialOption: Ux4gCapsuleStepperLayout.linear,
                  labelBuilder: (v) => v.name,
                ),
                onNext: current < 5 ? () => setState(() => current++) : () {},
                onPrevious: current > 1 ? () => setState(() => current--) : () {},
              ),
            ),
          );
        });
      },
    ),
  ],
);

// \u2500\u2500 Result Row"""

patch('data_stories.dart', DATA_STEPPER_ANCHOR, DATA_STEPPER_REPLACEMENT)

print("\nAll done.")
PYEOF
