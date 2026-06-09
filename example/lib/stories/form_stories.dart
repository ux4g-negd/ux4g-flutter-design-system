import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Input Field ──────────────────────────────────────────────────────────────

final inputFieldComponent = WidgetbookComponent(
  name: 'Ux4gInputField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gInputField',
              description:
                  'A styled text input with label, placeholder, caption, '
                  'status colours, and icon slots.',
              code: '''Ux4gInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Email',
  placeholder: 'Enter your email',
  status: Ux4gInputFieldStatus.defaultStatus,
  size: Ux4gInputFieldSize.medium,
);

// Password field
Ux4gInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Password',
  type: Ux4gInputFieldType.password,
  showPasswordToggle: true,
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current text value.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<String>',
                  description: 'Called on text change.',
                  required: true,
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gInputFieldSize',
                  description: 'small / medium / large / xl.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'type',
                  type: 'Ux4gInputFieldType',
                  description: 'text / password / number / email.',
                  defaultValue: 'text',
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gInputFieldStatus',
                  description: 'defaultStatus / error / warning / success.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above the field.',
                ),
                PropRow(
                  name: 'required',
                  type: 'bool',
                  description: 'Shows asterisk on label.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String?',
                  description: 'Hint text.',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description: 'Helper text below field.',
                ),
                PropRow(
                  name: 'leadingIcon',
                  type: 'IconData?',
                  description: 'Icon on the left.',
                ),
                PropRow(
                  name: 'trailingIcon',
                  type: 'IconData?',
                  description: 'Icon on the right.',
                ),
                PropRow(
                  name: 'onTrailingIconPressed',
                  type: 'VoidCallback?',
                  description: 'Called when trailing icon is tapped.',
                ),
                PropRow(
                  name: 'prefixText',
                  type: 'String?',
                  description: 'Text before input.',
                ),
                PropRow(
                  name: 'postfixText',
                  type: 'String?',
                  description: 'Text after input.',
                ),
                PropRow(
                  name: 'trailingIconLabel',
                  type: 'IconData?',
                  description: 'Icon beside label.',
                ),
                PropRow(
                  name: 'showPasswordToggle',
                  type: 'bool',
                  description: 'Show eye icon for password.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'readOnly',
                  type: 'bool',
                  description: 'Non-editable state.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'singleLine',
                  type: 'bool',
                  description: 'Whether to restrict to one line.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'maxLines',
                  type: 'int?',
                  description: 'Max lines if multi-line.',
                ),
                PropRow(
                  name: 'maxLength',
                  type: 'int?',
                  description: 'Max character count.',
                ),
                PropRow(
                  name: 'inputFormatters',
                  type: 'List<TextInputFormatter>?',
                  description: 'Custom input filters.',
                ),
                PropRow(
                  name: 'textAlign',
                  type: 'TextAlign',
                  description: 'Text alignment.',
                  defaultValue: 'start',
                ),
                PropRow(
                  name: 'style',
                  type: 'TextStyle?',
                  description: 'Custom text style for the input value.',
                ),
                PropRow(
                  name: 'placeholderStyle',
                  type: 'TextStyle?',
                  description: 'Custom text style for placeholder text.',
                ),
                PropRow(
                  name: 'labelStyle',
                  type: 'TextStyle?',
                  description: 'Custom text style for the label.',
                ),
                PropRow(
                  name: 'captionStyle',
                  type: 'TextStyle?',
                  description: 'Custom text style for the caption.',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gInputField(
                  value: value,
                  onValueChange: (v) => setState(() => value = v),
                  label: context.knobs.string(
                    label: 'Label',
                    initialValue: 'Email',
                  ),
                  placeholder: context.knobs.string(
                    label: 'Placeholder',
                    initialValue: 'Enter your email',
                  ),
                  status: context.knobs.list(
                    label: 'Status',
                    options: Ux4gInputFieldStatus.values,
                    initialOption: Ux4gInputFieldStatus.defaultStatus,
                    labelBuilder: (v) => v.name,
                  ),
                  size: context.knobs.list(
                    label: 'Size',
                    options: Ux4gInputFieldSize.values,
                    initialOption: Ux4gInputFieldSize.medium,
                    labelBuilder: (v) => v.name,
                  ),
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'All statuses',
      builder: (context) => ComponentDocs(
        name: 'Ux4gInputField — Statuses',
        description:
            'Visual status variations: default, error, warning, success.',
        code: '''Ux4gInputField(value: '', onValueChange: (_) {},
  label: 'Error', status: Ux4gInputFieldStatus.error, caption: 'Invalid input');

Ux4gInputField(value: '', onValueChange: (_) {},
  label: 'Warning', status: Ux4gInputFieldStatus.warning, caption: 'Review this');

Ux4gInputField(value: '', onValueChange: (_) {},
  label: 'Success', status: Ux4gInputFieldStatus.success, caption: 'Looks good!');''',
        child: SizedBox(
          width: 320,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: Ux4gInputFieldStatus.values
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      label: s.name,
                      status: s,
                      caption: ' caption',
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Password field',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gInputField — Password',
              description:
                  'Password type hides input and shows a visibility-toggle icon.',
              code:
                  'Ux4gInputField(\n'
                  '  label: \'Password\', type: Ux4gInputFieldType.password,\n'
                  '  showPasswordToggle: true,\n'
                  ');',
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
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'With icons',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gInputField — Icons',
              description:
                  'Leading and trailing icon slots inside the input border.',
              code:
                  'Ux4gInputField(leadingIcon: Icons.search, trailingIcon: Icons.currency_rupee, ...);',
              child: SizedBox(
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Ux4gInputField(
                      value: value,
                      onValueChange: (v) => setState(() => value = v),
                      label: 'Leading icon',
                      placeholder: 'Search…',
                      leadingIcon: Icons.search,
                    ),
                    const SizedBox(height: 16),
                    Ux4gInputField(
                      value: value,
                      onValueChange: (v) => setState(() => value = v),
                      label: 'Trailing icon',
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
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Prefix & Postfix',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gInputField — Prefix / Postfix',
              description:
                  'Text decorations prepended or appended inside the field border.',
              code:
                  'Ux4gInputField(prefixText: \'₹\', postfixText: \'.00\', label: \'Amount\', ...);',
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
                      prefixText: '₹',
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
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Read-only & Required',
      builder: (context) => ComponentDocs(
        name: 'Ux4gInputField — Read-only & Required',
        description:
            'readOnly disables editing; required shows an asterisk on the label.',
        code:
            'Ux4gInputField(value: \'GOV/2025/001\', readOnly: true, ...);\n'
            'Ux4gInputField(value: \'\', required: true, label: \'Name\', ...);',
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

// ── Text Area ─────────────────────────────────────────────────────────────────

final textAreaComponent = WidgetbookComponent(
  name: 'Ux4gTextArea',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gTextArea',
              description:
                  'A multi-line text input with label and placeholder.',
              code: '''Ux4gTextArea(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Description',
  placeholder: 'Write something...',
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current text value.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<String>',
                  description: 'Called on text change.',
                  required: true,
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gTextAreaSize',
                  description: 'small / large.',
                  defaultValue: 'large',
                ),
                PropRow(
                  name: 'minHeight',
                  type: 'Ux4gTextAreaMinHeight',
                  description: 'small / medium / large.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gInputFieldStatus',
                  description: 'defaultStatus / error / warning / success.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above the field.',
                ),
                PropRow(
                  name: 'required',
                  type: 'bool',
                  description: 'Shows asterisk on label.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String?',
                  description: 'Hint text.',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description: 'Helper text below field.',
                ),
                PropRow(
                  name: 'showCaptionIcon',
                  type: 'bool',
                  description: 'Show status icon with caption.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'trailingIconLabel',
                  type: 'IconData?',
                  description: 'Icon beside label.',
                ),
                PropRow(
                  name: 'characterCountText',
                  type: 'String?',
                  description: 'Text for character counter.',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'readOnly',
                  type: 'bool',
                  description: 'Non-editable state.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'maxLength',
                  type: 'int?',
                  description: 'Max character count.',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gTextArea(
                  value: value,
                  onValueChange: (v) => setState(() => value = v),
                  label: context.knobs.string(
                    label: 'Label',
                    initialValue: 'Description',
                  ),
                  placeholder: context.knobs.string(
                    label: 'Placeholder',
                    initialValue: 'Write something...',
                  ),
                  size: context.knobs.list(
                    label: 'Size',
                    options: Ux4gTextAreaSize.values,
                    initialOption: Ux4gTextAreaSize.large,
                  ),
                  minHeight: context.knobs.list(
                    label: 'Min Height',
                    options: Ux4gTextAreaMinHeight.values,
                    initialOption: Ux4gTextAreaMinHeight.medium,
                  ),
                  status: context.knobs.list(
                    label: 'Status',
                    options: Ux4gInputFieldStatus.values,
                    initialOption: Ux4gInputFieldStatus.defaultStatus,
                  ),
                  required: context.knobs.boolean(
                    label: 'Required',
                    initialValue: false,
                  ),
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                  readOnly: context.knobs.boolean(
                    label: 'Read Only',
                    initialValue: false,
                  ),
                  maxLength: context.knobs.int.input(
                    label: 'Max Length',
                    initialValue: 200,
                  ),
                  caption: context.knobs.string(
                    label: 'Caption',
                    initialValue: '',
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Sizes & Heights',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTextArea — Sizes',
        description: 'Small and Large sizes with different minimum heights.',
        code:
            'Ux4gTextArea(size: Ux4gTextAreaSize.small, minHeight: Ux4gTextAreaMinHeight.small, ...);\n'
            'Ux4gTextArea(size: Ux4gTextAreaSize.large, minHeight: Ux4gTextAreaMinHeight.large, ...);',
        child: SizedBox(
          width: 320,
          child: Column(
            children: [
              Ux4gTextArea(
                value: '',
                onValueChange: (_) {},
                label: 'Small size (80px min-height)',
                size: Ux4gTextAreaSize.small,
                minHeight: Ux4gTextAreaMinHeight.small,
                placeholder: 'Small area...',
              ),
              const SizedBox(height: 24),
              Ux4gTextArea(
                value: '',
                onValueChange: (_) {},
                label: 'Large size (160px min-height)',
                size: Ux4gTextAreaSize.large,
                minHeight: Ux4gTextAreaMinHeight.large,
                placeholder: 'Large area...',
              ),
            ],
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Statuses',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTextArea — Statuses',
        description: 'Visual feedback for different validation states.',
        code:
            'Ux4gTextArea(status: Ux4gInputFieldStatus.error, caption: "Required field", ...);',
        child: SizedBox(
          width: 320,
          child: Column(
            children: [
              Ux4gTextArea(
                value: 'Valid input',
                onValueChange: (_) {},
                label: 'Success Status',
                status: Ux4gInputFieldStatus.success,
                caption: 'Information saved successfully',
              ),
              const SizedBox(height: 24),
              Ux4gTextArea(
                value: 'Incomplete data',
                onValueChange: (_) {},
                label: 'Warning Status',
                status: Ux4gInputFieldStatus.warning,
                caption: 'Please double check this entry',
              ),
              const SizedBox(height: 24),
              Ux4gTextArea(
                value: '',
                onValueChange: (_) {},
                label: 'Error Status',
                status: Ux4gInputFieldStatus.error,
                caption: 'This field is required',
                required: true,
              ),
            ],
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Metadata',
      builder: (context) => ComponentDocs(
        name: 'Ux4gTextArea — Metadata',
        description: 'Showing character counts and helper icons.',
        code:
            'Ux4gTextArea(characterCountText: "0 / 100", trailingIconLabel: Icons.help_outline, ...);',
        child: SizedBox(
          width: 320,
          child: Column(
            children: [
              Ux4gTextArea(
                value: 'Example text',
                onValueChange: (_) {},
                label: 'With Character Count',
                characterCountText: '12 / 500',
                maxLength: 500,
              ),
              const SizedBox(height: 24),
              Ux4gTextArea(
                value: '',
                onValueChange: (_) {},
                label: 'With Info Icon',
                trailingIconLabel: Icons.help_outline,
                placeholder: 'Tap the icon for help',
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

// ── Search Field ──────────────────────────────────────────────────────────────

final searchFieldComponent = WidgetbookComponent(
  name: 'Ux4gSearchField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSearchField',
              description:
                  'A search-optimised input field with a built-in search icon.',
              code: '''Ux4gSearchField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  placeholder: 'Search...',
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current text value.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<String>',
                  description: 'Called on text change.',
                  required: true,
                ),
                PropRow(
                  name: 'variant',
                  type: 'Ux4gSearchFieldVariant',
                  description: 'basicSearch / searchWithSubmit / autocomplete.',
                  defaultValue: 'basicSearch',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gSearchFieldSize',
                  description: 'small / medium / large / xl.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gSearchFieldStatus',
                  description: 'defaultStatus / error / warning / success.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'buttonStyle',
                  type: 'Ux4gSearchFieldButtonStyle',
                  description: 'filled / tonal.',
                  defaultValue: 'filled',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above the field.',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String?',
                  description: 'Hint text.',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description: 'Helper text below field.',
                ),
                PropRow(
                  name: 'options',
                  type: 'List<String>',
                  description: 'Autocomplete suggestions.',
                  defaultValue: '[]',
                ),
                PropRow(
                  name: 'showVoiceIcon',
                  type: 'bool',
                  description: 'Show microphone icon.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'showClearIcon',
                  type: 'bool',
                  description: 'Show clear (X) icon.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'isLoading',
                  type: 'bool',
                  description: 'Show loading spinner.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'onVoiceClick',
                  type: 'VoidCallback?',
                  description: 'Called on voice icon tap.',
                ),
                PropRow(
                  name: 'onClearClick',
                  type: 'VoidCallback?',
                  description: 'Called on clear icon tap.',
                ),
                PropRow(
                  name: 'onSubmitClick',
                  type: 'ValueChanged<String>?',
                  description: 'Called when search button or enter is pressed.',
                ),
                PropRow(
                  name: 'onOptionSelected',
                  type: 'ValueChanged<String>?',
                  description: 'Called when an autocomplete option is chosen.',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'readOnly',
                  type: 'bool',
                  description: 'Non-editable state.',
                  defaultValue: 'false',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gSearchField(
                  value: value,
                  onValueChange: (v) => setState(() => value = v),
                  placeholder: context.knobs.string(
                    label: 'Placeholder',
                    initialValue: 'Search...',
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── Checkbox ──────────────────────────────────────────────────────────────────

final checkboxComponent = WidgetbookComponent(
  name: 'Ux4gCheckbox',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        bool? value = false;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gCheckbox',
              description:
                  'A tri-state checkbox (checked / unchecked / indeterminate) with label and description.',
              code: '''Ux4gCheckbox(
  value: true,
  onChanged: (v) => setState(() => value = v),
  label: 'Accept terms',
  description: 'Optional helper text',
  size: Ux4gCheckboxSize.medium,
);

// Indeterminate state
Ux4gCheckbox(value: null, onChanged: (v) {}, label: 'Partial');''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'bool?',
                  description:
                      'true (checked), false (unchecked), null (indeterminate).',
                  required: true,
                ),
                PropRow(
                  name: 'onChanged',
                  type: 'ValueChanged<bool?>',
                  description: 'Called on state change.',
                  required: true,
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Primary label text.',
                ),
                PropRow(
                  name: 'description',
                  type: 'String?',
                  description: 'Secondary helper text.',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gCheckboxSize',
                  description: 'small / medium / large.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'isRequired',
                  type: 'bool',
                  description: 'Shows asterisk on label.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'descriptionVariant',
                  type: 'Ux4gCheckboxDescriptionVariant',
                  description: 'helper / error / warning / success.',
                  defaultValue: 'helper',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
              ],
              child: Ux4gCheckbox(
                value: value,
                onChanged: (v) => setState(() => value = v),
                label: context.knobs.string(
                  label: 'Label',
                  initialValue: 'Accept terms',
                ),
                description: context.knobs.string(
                  label: 'Description',
                  initialValue: '',
                ),
                size: context.knobs.list(
                  label: 'Size',
                  options: Ux4gCheckboxSize.values,
                  initialOption: Ux4gCheckboxSize.medium,
                  labelBuilder: (v) => v.name,
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'All states',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCheckbox — All States',
        description: 'Checked, unchecked, indeterminate, and disabled states.',
        code:
            'Ux4gCheckbox(value: true,  onChanged: (_) {}, label: \'Checked\');\n'
            'Ux4gCheckbox(value: false, onChanged: (_) {}, label: \'Unchecked\');\n'
            'Ux4gCheckbox(value: null,  onChanged: (_) {}, label: \'Indeterminate\');\n'
            'Ux4gCheckbox(value: true,  onChanged: null,   label: \'Disabled\', enabled: false);',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gCheckbox(value: true, onChanged: (_) {}, label: 'Checked'),
            const SizedBox(height: 8),
            Ux4gCheckbox(value: false, onChanged: (_) {}, label: 'Unchecked'),
            const SizedBox(height: 8),
            Ux4gCheckbox(
              value: null,
              onChanged: (_) {},
              label: 'Indeterminate',
            ),
            const SizedBox(height: 8),
            Ux4gCheckbox(
              value: true,
              onChanged: (_) {},
              label: 'Disabled (checked)',
              enabled: false,
            ),
            const SizedBox(height: 8),
            Ux4gCheckbox(
              value: false,
              onChanged: (_) {},
              label: 'Disabled (unchecked)',
              enabled: false,
            ),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gCheckbox — Sizes',
        description: 'Small, medium, and large checkbox.',
        code:
            'Ux4gCheckbox(value: true, onChanged: (_) {}, label: \'Small\',  size: Ux4gCheckboxSize.small);',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gCheckbox(
              value: true,
              onChanged: (_) {},
              label: 'Small',
              size: Ux4gCheckboxSize.small,
            ),
            const SizedBox(height: 8),
            Ux4gCheckbox(
              value: true,
              onChanged: (_) {},
              label: 'Medium',
              size: Ux4gCheckboxSize.medium,
            ),
            const SizedBox(height: 8),
            Ux4gCheckbox(
              value: true,
              onChanged: (_) {},
              label: 'Large',
              size: Ux4gCheckboxSize.large,
            ),
          ],
        ),
      ),
    ),
  ],
);

// ── Toggle ────────────────────────────────────────────────────────────────────

final toggleComponent = WidgetbookComponent(
  name: 'Ux4gToggle',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        bool checked = false;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gToggle',
              description:
                  'A switch/toggle with label, description, and three size options.',
              code: '''Ux4gToggle(
  checked: checked,
  onCheckedChange: (v) => setState(() => checked = v),
  label: 'Enable notifications',
  size: Ux4gToggleSize.m,
);''',
              props: const [
                PropRow(
                  name: 'checked',
                  type: 'bool',
                  description: 'Current toggle state.',
                  required: true,
                ),
                PropRow(
                  name: 'onCheckedChange',
                  type: 'ValueChanged<bool>?',
                  description: 'Called on toggle.',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Primary label text.',
                ),
                PropRow(
                  name: 'description',
                  type: 'String?',
                  description: 'Secondary helper text.',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gToggleSize',
                  description: 's / m / l.',
                  defaultValue: 'm',
                ),
                PropRow(
                  name: 'labelPosition',
                  type: 'Ux4gToggleLabelPosition',
                  description: 'left / right / bothSides / noLabel.',
                  defaultValue: 'right',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
              ],
              child: Ux4gToggle(
                checked: checked,
                onCheckedChange: (v) => setState(() => checked = v),
                label: context.knobs.string(
                  label: 'Label',
                  initialValue: 'Enable notifications',
                ),
                size: context.knobs.list(
                  label: 'Size',
                  options: Ux4gToggleSize.values,
                  initialOption: Ux4gToggleSize.m,
                  labelBuilder: (v) => v.name,
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToggle — Sizes',
        description: 'Small (s), medium (m), and large (l) toggle switches.',
        code:
            'Ux4gToggle(checked: true, onCheckedChange: (_) {}, label: \'Small\',  size: Ux4gToggleSize.s);',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gToggle(
              checked: true,
              onCheckedChange: (_) {},
              label: 'Small',
              size: Ux4gToggleSize.s,
            ),
            const SizedBox(height: 8),
            Ux4gToggle(
              checked: true,
              onCheckedChange: (_) {},
              label: 'Medium',
              size: Ux4gToggleSize.m,
            ),
            const SizedBox(height: 8),
            Ux4gToggle(
              checked: true,
              onCheckedChange: (_) {},
              label: 'Large',
              size: Ux4gToggleSize.l,
            ),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => ComponentDocs(
        name: 'Ux4gToggle — Disabled',
        description: 'Toggle with onCheckedChange=null renders as disabled.',
        code:
            'Ux4gToggle(checked: false, onCheckedChange: null, label: \'Off (disabled)\');',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gToggle(
              checked: false,
              onCheckedChange: null,
              label: 'Off (disabled)',
            ),
            const SizedBox(height: 8),
            Ux4gToggle(
              checked: true,
              onCheckedChange: null,
              label: 'On  (disabled)',
            ),
          ],
        ),
      ),
    ),
  ],
);

// ── Slider ────────────────────────────────────────────────────────────────────

final sliderComponent = WidgetbookComponent(
  name: 'Ux4gSlider',
  useCases: [
    // ── 1. Basic Single Slider (Small) ─────────────────────────────────
    WidgetbookUseCase(
      name: 'Basic Single Slider (Small)',
      builder: (context) {
        double value = 50;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider',
              description:
                  'A single-thumb slider. Set size to Ux4gSliderSize.small (default). '
                  'Pass steps to show tick marks and value labels below the track.',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  steps: 9,                        // 9 intermediate ticks → 0,10,20…100
  size: Ux4gSliderSize.small,
  showMarksAndValues: true,
  onValueChange: (v) => setState(() => value = v),
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'double',
                  description: 'Current thumb position.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<double>?',
                  description: 'Called when the user drags the thumb.',
                  required: true,
                ),
                PropRow(
                  name: 'min',
                  type: 'double',
                  description: 'Minimum selectable value.',
                  defaultValue: '0.0',
                ),
                PropRow(
                  name: 'max',
                  type: 'double',
                  description: 'Maximum selectable value.',
                  defaultValue: '100.0',
                ),
                PropRow(
                  name: 'steps',
                  type: 'int?',
                  description:
                      'Number of intermediate tick marks between min and max.',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gSliderSize',
                  description: 'small (16 dp thumb) or medium (20 dp thumb).',
                  defaultValue: 'small',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Disables interaction when false.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Text label shown above the slider.',
                ),
                PropRow(
                  name: 'isRequired',
                  type: 'bool',
                  description: 'Appends a red asterisk to the label.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'labelIcon',
                  type: 'IconData?',
                  description: 'Optional icon shown beside the label.',
                ),
                PropRow(
                  name: 'startValueText',
                  type: 'String?',
                  description:
                      'Custom text for the left end of the value row (overrides default %).',
                ),
                PropRow(
                  name: 'endValueText',
                  type: 'String?',
                  description:
                      'Custom text for the right end of the value row (overrides default %).',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description:
                      'Helper / error / warning / success text shown below the track.',
                ),
                PropRow(
                  name: 'captionVariant',
                  type: 'Ux4gSliderCaptionVariant',
                  description: 'helper · error · warning · success.',
                  defaultValue: 'helper',
                ),
                PropRow(
                  name: 'showMarksAndValues',
                  type: 'bool',
                  description:
                      'Shows tick marks and numeric labels below the track. Requires steps.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'showIndicator',
                  type: 'bool',
                  description:
                      'Shows a floating bubble with the current value while dragging.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'showInputFields',
                  type: 'bool',
                  description:
                      'Replaces the value label row with editable text-field inputs.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'showValueLabels',
                  type: 'bool',
                  description:
                      'Shows current-value % and max-value % labels above the track.',
                  defaultValue: 'false',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  steps: 9,
                  size: Ux4gSliderSize.small,
                  showMarksAndValues: true,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 2. Basic Range Slider (Medium) ─────────────────────────────────
    WidgetbookUseCase(
      name: 'Basic Range Slider (Medium)',
      builder: (context) {
        RangeValues range = const RangeValues(20, 90);
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gRangeSlider',
              description:
                  'A dual-thumb range slider. Use size: medium for larger thumbs. '
                  'showValueLabels shows the current start/end percentages above the track.',
              code: '''Ux4gRangeSlider(
  values: RangeValues(20, 90),
  min: 0,
  max: 100,
  steps: 9,
  size: Ux4gSliderSize.medium,
  showValueLabels: true,
  showMarksAndValues: true,
  onValueChange: (v) => setState(() => range = v),
);''',
              props: const [
                PropRow(
                  name: 'values',
                  type: 'RangeValues',
                  description: 'Current start and end positions.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<RangeValues>?',
                  description: 'Called when either thumb is dragged.',
                  required: true,
                ),
                PropRow(
                  name: 'min',
                  type: 'double',
                  description: 'Minimum selectable value.',
                  defaultValue: '0.0',
                ),
                PropRow(
                  name: 'max',
                  type: 'double',
                  description: 'Maximum selectable value.',
                  defaultValue: '100.0',
                ),
                PropRow(
                  name: 'steps',
                  type: 'int?',
                  description: 'Number of intermediate tick marks.',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gSliderSize',
                  description: 'small or medium.',
                  defaultValue: 'small',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Disables interaction when false.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Text label shown above the slider.',
                ),
                PropRow(
                  name: 'isRequired',
                  type: 'bool',
                  description: 'Appends a red asterisk to the label.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'startValueText',
                  type: 'String?',
                  description: 'Custom left-end label text.',
                ),
                PropRow(
                  name: 'endValueText',
                  type: 'String?',
                  description: 'Custom right-end label text.',
                ),
                PropRow(
                  name: 'showMarksAndValues',
                  type: 'bool',
                  description:
                      'Tick marks + numeric labels below track. Requires steps.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'showInputFields',
                  type: 'bool',
                  description:
                      'Editable input fields replace the value label row.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'showValueLabels',
                  type: 'bool',
                  description: 'Shows start/end % labels above the track.',
                  defaultValue: 'false',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gRangeSlider(
                  values: range,
                  min: 0,
                  max: 100,
                  steps: 9,
                  size: Ux4gSliderSize.medium,
                  showValueLabels: true,
                  showMarksAndValues: true,
                  onValueChange: (v) => setState(() => range = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 3. With Value Indicator ─────────────────────────────────────────
    WidgetbookUseCase(
      name: 'With Value Indicator',
      builder: (context) {
        double value = 40;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider — Value Indicator',
              description:
                  'showIndicator: true shows a floating bubble above the thumb '
                  'with the current value while the user is dragging.',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  steps: 4,
  size: Ux4gSliderSize.small,
  showIndicator: true,
  showMarksAndValues: true,
  onValueChange: (v) => setState(() => value = v),
);''',
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  steps: 4,
                  size: Ux4gSliderSize.small,
                  showIndicator: true,
                  showMarksAndValues: true,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 4. With Editable Input Fields ──────────────────────────────────
    WidgetbookUseCase(
      name: 'With Editable Input Fields',
      builder: (context) {
        double value = 50;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider — Input Fields',
              description:
                  'showInputFields: true replaces the value label row with two '
                  'text-field inputs. The left field shows and edits the current '
                  'value; the right field shows the max (read-only).',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  steps: 5,
  size: Ux4gSliderSize.small,
  showInputFields: true,
  showMarksAndValues: true,
  onValueChange: (v) => setState(() => value = v),
);''',
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  steps: 5,
                  size: Ux4gSliderSize.small,
                  showInputFields: true,
                  showMarksAndValues: true,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 5. Disabled State ───────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Disabled State',
      builder: (context) => ComponentDocs(
        name: 'Ux4gSlider — Disabled',
        description:
            'Set enabled: false to prevent interaction. '
            'The track and thumb render at reduced opacity. '
            'Use caption to explain why it is disabled.',
        code: '''Ux4gSlider(
  value: 50,
  min: 0,
  max: 100,
  enabled: false,
  caption: 'Component is disabled',
  onValueChange: null,
);''',
        child: const SizedBox(
          width: 320,
          child: Ux4gSlider(
            value: 50,
            min: 0,
            max: 100,
            enabled: false,
            caption: 'Component is disabled',
            onValueChange: null,
          ),
        ),
      ),
    ),

    // ── 6. Error State ──────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Error State',
      builder: (context) {
        double value = 0;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider — Error',
              description:
                  'captionVariant: error changes the track to the error color '
                  'and shows an error icon beside the caption text.',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  caption: 'Value is out of budget',
  captionVariant: Ux4gSliderCaptionVariant.error,
  onValueChange: (v) => setState(() => value = v),
);''',
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  caption: 'Value is out of budget',
                  captionVariant: Ux4gSliderCaptionVariant.error,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 7. Warning State ────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Warning State',
      builder: (context) {
        double value = 60;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider — Warning',
              description:
                  'captionVariant: warning renders the caption in orange with a '
                  'warning icon, signalling that the selected value needs attention.',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  label: 'Budget Limit',
  caption: 'Approaching the maximum limit',
  captionVariant: Ux4gSliderCaptionVariant.warning,
  onValueChange: (v) => setState(() => value = v),
);''',
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  label: 'Budget Limit',
                  caption: 'Approaching the maximum limit',
                  captionVariant: Ux4gSliderCaptionVariant.warning,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 8. Success State ────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Success State',
      builder: (context) {
        double value = 45;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSlider — Success',
              description:
                  'captionVariant: success renders the caption in green with a '
                  'check icon, confirming that the selected value is valid.',
              code: '''Ux4gSlider(
  value: value,
  min: 0,
  max: 100,
  label: 'Budget Allocation',
  caption: 'Value is within the acceptable range',
  captionVariant: Ux4gSliderCaptionVariant.success,
  onValueChange: (v) => setState(() => value = v),
);''',
              child: SizedBox(
                width: 320,
                child: Ux4gSlider(
                  value: value,
                  min: 0,
                  max: 100,
                  label: 'Budget Allocation',
                  caption: 'Value is within the acceptable range',
                  captionVariant: Ux4gSliderCaptionVariant.success,
                  onValueChange: (v) => setState(() => value = v),
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── OTP Input ─────────────────────────────────────────────────────────────────

final otpInputComponent = WidgetbookComponent(
  name: 'Ux4gOtpInput',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        String otpValue = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gOtpInput',
              description:
                  'A segmented one-time-password input field. '
                  'Automatically advances focus and calls onCompleted when all digits are filled.',
              code: '''Ux4gOtpInput(
  length: 6,
  value: value,
  onChanged: (v) => setState(() => value = v),
  onCompleted: (pin) {
    // verify pin
  },
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current OTP string.',
                  required: true,
                ),
                PropRow(
                  name: 'onChanged',
                  type: 'ValueChanged<String>',
                  description: 'Called on each digit change.',
                  required: true,
                ),
                PropRow(
                  name: 'length',
                  type: 'int',
                  description: 'Number of OTP digit boxes.',
                  defaultValue: '6',
                ),
                PropRow(
                  name: 'onCompleted',
                  type: 'ValueChanged<String>?',
                  description: 'Called when all digits are entered.',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label shown above the boxes.',
                ),
                PropRow(
                  name: 'required',
                  type: 'bool',
                  description: 'Whether label has required asterisk.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'labelTrailingIcon',
                  type: 'IconData?',
                  description: 'Trailing icon next to the label.',
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gOtpInputStatus',
                  description:
                      'Overall status — drives box border colours and caption icon.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'obscure',
                  type: 'bool',
                  description: 'Obscure digits (password-style).',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'boxSize',
                  type: 'double',
                  description: 'Size of each box in logical pixels.',
                  defaultValue: '48',
                ),
                PropRow(
                  name: 'gap',
                  type: 'double',
                  description: 'Gap between boxes.',
                  defaultValue: '8',
                ),
                PropRow(
                  name: 'showSeparator',
                  type: 'bool',
                  description: 'Show a "–" dash separator between boxes.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'keyboardType',
                  type: 'TextInputType',
                  description: 'Keyboard type.',
                  defaultValue: 'TextInputType.number',
                ),
                PropRow(
                  name: 'captionVariant',
                  type: 'Ux4gOtpCaptionVariant?',
                  description: 'Caption variant section below boxes.',
                ),
                PropRow(
                  name: 'captionLeadingText',
                  type: 'String?',
                  description: 'Leading label for caption.',
                ),
                PropRow(
                  name: 'captionTrailingText',
                  type: 'String?',
                  description: 'Trailing label for caption.',
                ),
                PropRow(
                  name: 'onCaptionTrailingTap',
                  type: 'VoidCallback?',
                  description: 'When caption trailing text is tappable.',
                ),
                PropRow(
                  name: 'captionText',
                  type: 'String?',
                  description: 'Plain text caption.',
                ),
                PropRow(
                  name: 'autoCountdownSeconds',
                  type: 'int?',
                  description: 'Auto-counts down this many seconds.',
                ),
                PropRow(
                  name: 'onCountdownComplete',
                  type: 'VoidCallback?',
                  description: 'Called when countdown reaches zero.',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gOtpInput(
                  length: context.knobs.int.input(
                    label: 'Length',
                    initialValue: 6,
                  ),
                  value: otpValue,
                  onChanged: (v) => setState(() => otpValue = v),
                  onCompleted: (_) {},
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── Action Dropdown ───────────────────────────────────────────────────────────

final actionDropdownComponent = WidgetbookComponent(
  name: 'Ux4gActionDropdown',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => ComponentDocs(
        name: 'Ux4gActionDropdown',
        description:
            'A contextual action menu triggered by a custom trigger widget. '
            'Each option can optionally show a trailing arrow.',
        code: '''Ux4gActionDropdown(
  options: [
    Ux4gActionDropdownOption(id: '1', label: 'Edit'),
    Ux4gActionDropdownOption(id: '2', label: 'Duplicate'),
    Ux4gActionDropdownOption(id: '3', label: 'Delete', showTrailingArrow: false),
  ],
  onOptionClick: (option) {
    print('Selected: \${option.label}');
  },
  triggerBuilder: (context, toggle) => ElevatedButton(
    onPressed: toggle,
    child: const Text('Actions'),
  ),
);''',
        props: const [
          PropRow(
            name: 'options',
            type: 'List<Ux4gActionDropdownOption>',
            description: 'Menu items.',
            required: true,
          ),
          PropRow(
            name: 'onOptionClick',
            type: 'ValueChanged<Ux4gActionDropdownOption>',
            description: 'Called when an option is tapped.',
            required: true,
          ),
          PropRow(
            name: 'triggerBuilder',
            type: 'Ux4gDropdownTriggerBuilder',
            description:
                'Builds the trigger widget; receives a toggle callback.',
            required: true,
          ),
        ],
        child: Ux4gActionDropdown(
          options: const [
            Ux4gActionDropdownOption(id: '1', label: 'Edit'),
            Ux4gActionDropdownOption(id: '2', label: 'Duplicate'),
            Ux4gActionDropdownOption(
              id: '3',
              label: 'Delete',
              showTrailingArrow: false,
            ),
          ],
          onOptionClick: (_) {},
          triggerBuilder: (context, toggle) => Ux4gButton(
            text: 'Open Actions',
            variant: Ux4gButtonVariant.outline,
            onPressed: toggle,
          ),
        ),
      ),
    ),
  ],
);

// ── Selection Dropdown ────────────────────────────────────────────────────────

final selectionDropdownComponent = WidgetbookComponent(
  name: 'Ux4gSelectionDropdown',
  useCases: [
    WidgetbookUseCase(
      name: 'Single select',
      builder: (context) {
        List<String> selected = [];
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSelectionDropdown',
              description:
                  'A dropdown for selecting one or multiple options from a list. '
                  'Supports search filtering, single/multi mode, and three sizes.',
              code: '''Ux4gSelectionDropdown(
  label: 'Country',
  placeholder: 'Select country',
  options: [
    Ux4gDropdownOption(id: 'in', label: 'India'),
    Ux4gDropdownOption(id: 'us', label: 'United States'),
    Ux4gDropdownOption(id: 'uk', label: 'United Kingdom'),
  ],
  selectedOptionIds: selectedIds,
  onSelectionChange: (ids) => setState(() => selectedIds = ids),
  mode: Ux4gDropdownMode.single,
);''',
              props: const [
                PropRow(
                  name: 'options',
                  type: 'List<Ux4gDropdownOption>',
                  description: 'Available choices.',
                  required: true,
                ),
                PropRow(
                  name: 'selectedOptionIds',
                  type: 'List<String>',
                  description: 'IDs of currently selected options.',
                  required: true,
                ),
                PropRow(
                  name: 'onSelectionChange',
                  type: 'ValueChanged<List<String>>',
                  description: 'Called with new selection.',
                  required: true,
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above dropdown.',
                ),
                PropRow(
                  name: 'description',
                  type: 'String?',
                  description: 'Supporting text below the dropdown.',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String',
                  description: 'Hint text.',
                  defaultValue: '"Please select.."',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gDropdownSize',
                  description: 's / m / l.',
                  defaultValue: 'm',
                ),
                PropRow(
                  name: 'mode',
                  type: 'Ux4gDropdownMode',
                  description: 'single or multi.',
                  defaultValue: 'single',
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gDropdownStatus',
                  description: 'defaultStatus / error / disabled.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'searchEnabled',
                  type: 'bool',
                  description: 'Show search filter box.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'filterType',
                  type: 'Ux4gDropdownFilterType',
                  description: 'Search matching logic.',
                  defaultValue: 'contains',
                ),
                PropRow(
                  name: 'labelTextStyle',
                  type: 'TextStyle?',
                  description: 'Custom text style for the dropdown label.',
                ),
                PropRow(
                  name: 'valueTextStyle',
                  type: 'TextStyle?',
                  description: 'Custom text style for the selected value.',
                ),
                PropRow(
                  name: 'leadingIcon',
                  type: 'IconData?',
                  description:
                      'Optional icon shown at the start of the trigger button.',
                ),
              ],
              child: SizedBox(
                width: 300,
                child: Ux4gSelectionDropdown(
                  label: 'Country',
                  placeholder: 'Select country',
                  options: const [
                    Ux4gDropdownOption(id: 'in', label: 'India'),
                    Ux4gDropdownOption(id: 'us', label: 'United States'),
                    Ux4gDropdownOption(id: 'uk', label: 'United Kingdom'),
                    Ux4gDropdownOption(id: 'au', label: 'Australia'),
                    Ux4gDropdownOption(id: 'ca', label: 'Canada'),
                  ],
                  selectedOptionIds: selected,
                  onSelectionChange: (ids) => setState(() => selected = ids),
                  mode: Ux4gDropdownMode.single,
                  searchEnabled: context.knobs.boolean(
                    label: 'Search enabled',
                    initialValue: false,
                  ),
                  size: context.knobs.list(
                    label: 'Size',
                    options: Ux4gDropdownSize.values,
                    initialOption: Ux4gDropdownSize.m,
                    labelBuilder: (v) => v.name,
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Multi select',
      builder: (context) {
        List<String> selected = [];
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gSelectionDropdown — Multi',
              description:
                  'Multi-select mode shows chips for each selected option.',
              code: '''Ux4gSelectionDropdown(
  options: options,
  selectedOptionIds: selectedIds,
  onSelectionChange: (ids) => setState(() => selectedIds = ids),
  mode: Ux4gDropdownMode.multi,
  searchEnabled: true,
);''',
              child: SizedBox(
                width: 300,
                child: Ux4gSelectionDropdown(
                  label: 'Tags',
                  placeholder: 'Select tags',
                  options: const [
                    Ux4gDropdownOption(id: 'flutter', label: 'Flutter'),
                    Ux4gDropdownOption(id: 'dart', label: 'Dart'),
                    Ux4gDropdownOption(id: 'design', label: 'Design System'),
                    Ux4gDropdownOption(id: 'mobile', label: 'Mobile'),
                    Ux4gDropdownOption(id: 'web', label: 'Web'),
                  ],
                  selectedOptionIds: selected,
                  onSelectionChange: (ids) => setState(() => selected = ids),
                  mode: Ux4gDropdownMode.multi,
                  searchEnabled: true,
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── Date Picker ───────────────────────────────────────────────────────────────

final datePickerComponent = WidgetbookComponent(
  name: 'Ux4gDatePicker',
  useCases: [
    // ── 1. Single Date ───────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Single Date',
      builder: (context) {
        DateTime? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gDatePicker — Single',
              description:
                  'Single date selection. Tapping the field opens a calendar overlay. '
                  'The calendar icon sits at the right end of the field.',
              code: '''Ux4gDatePicker(
  mode: Ux4gDatePickerMode.single,
  placeholder: 'Select DOB',
  maxDate: DateTime.now(),
  onDateSelected: (date) {
    print('Selected: \$date');
  },
);''',
              props: const [
                PropRow(
                  name: 'mode',
                  type: 'Ux4gDatePickerMode',
                  description: 'single or range selection.',
                  defaultValue: 'single',
                ),
                PropRow(
                  name: 'initialDate',
                  type: 'DateTime?',
                  description: 'Pre-selected date for single mode.',
                ),
                PropRow(
                  name: 'initialDateRange',
                  type: 'DateTimeRange?',
                  description: 'Pre-selected range for range mode.',
                ),
                PropRow(
                  name: 'minDate',
                  type: 'DateTime?',
                  description: 'Earliest selectable date.',
                ),
                PropRow(
                  name: 'maxDate',
                  type: 'DateTime?',
                  description: 'Latest selectable date.',
                ),
                PropRow(
                  name: 'onDateSelected',
                  type: 'ValueChanged<DateTime>?',
                  description: 'Callback with the chosen date (single mode).',
                ),
                PropRow(
                  name: 'onDateRangeSelected',
                  type: 'ValueChanged<DateTimeRange>?',
                  description: 'Callback with the chosen range (range mode).',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String',
                  description: 'Hint text shown when nothing is selected.',
                  defaultValue: '"Select date"',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Whether interaction is enabled.',
                  defaultValue: 'true',
                ),
              ],
              child: SizedBox(
                width: 300,
                child: Ux4gDatePicker(
                  mode: Ux4gDatePickerMode.single,
                  placeholder: 'Select DOB',
                  maxDate: DateTime.now(),
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                  onDateSelected: (d) => setState(() => selected = d),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 2. Date Range ────────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Date Range',
      builder: (context) {
        DateTimeRange? selectedRange;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gDatePicker — Range',
              description:
                  'Date range selection. First tap sets the start date, second tap sets '
                  'the end date. The selected range is displayed as "DD/MM/YYYY – DD/MM/YYYY".',
              code: '''Ux4gDatePicker(
  mode: Ux4gDatePickerMode.range,
  placeholder: 'Select range',
  onDateRangeSelected: (range) {
    print('From \${range.start} to \${range.end}');
  },
);''',
              props: const [
                PropRow(
                  name: 'mode',
                  type: 'Ux4gDatePickerMode',
                  description: 'range — start + end date selection.',
                  defaultValue: 'single',
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String',
                  description: 'Hint text shown when no range is selected.',
                  defaultValue: '"Select date"',
                ),
                PropRow(
                  name: 'initialDateRange',
                  type: 'DateTimeRange?',
                  description: 'Pre-selected date range.',
                ),
                PropRow(
                  name: 'onDateRangeSelected',
                  type: 'ValueChanged<DateTimeRange>?',
                  description: 'Callback with the chosen range.',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Set false to disable tapping.',
                  defaultValue: 'true',
                ),
              ],
              child: SizedBox(
                width: 300,
                child: Ux4gDatePicker(
                  mode: Ux4gDatePickerMode.range,
                  placeholder: 'Select range',
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                  onDateRangeSelected: (r) => setState(() => selectedRange = r),
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── Time Picker ───────────────────────────────────────────────────────────────

final timePickerComponent = WidgetbookComponent(
  name: 'Ux4gTimePicker',
  useCases: [
    // ── 1. Standard ──────────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Standard',
      builder: (context) {
        TimeOfDay? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gTimePicker — Standard',
              description:
                  'Tapping the field opens a time picker overlay in 12-hour AM/PM format. '
                  'The clock icon sits at the right end of the field.',
              code: '''Ux4gTimePicker(
  placeholder: 'Select time',
  onTimeSelected: (time) {
    print('Selected: \$time');
  },
);''',
              props: const [
                PropRow(
                  name: 'placeholder',
                  type: 'String',
                  description: 'Hint text shown when no time is selected.',
                  defaultValue: '"Select time"',
                ),
                PropRow(
                  name: 'initialTime',
                  type: 'TimeOfDay?',
                  description: 'Pre-selected time.',
                ),
                PropRow(
                  name: 'onTimeSelected',
                  type: 'ValueChanged<TimeOfDay>?',
                  description: 'Callback with the chosen time.',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Set false to disable tapping.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'minuteInterval',
                  type: 'int',
                  description: 'Minute step granularity (1, 5, 10, 15, 30).',
                  defaultValue: '1',
                ),
              ],
              child: SizedBox(
                width: 300,
                child: Ux4gTimePicker(
                  placeholder: 'Select time',
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                  onTimeSelected: (t) => setState(() => selected = t),
                ),
              ),
            );
          },
        );
      },
    ),

    // ── 2. 5-Minute Interval ─────────────────────────────────────────────
    WidgetbookUseCase(
      name: '5-Minute Interval',
      builder: (context) {
        TimeOfDay? selected;
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gTimePicker — Interval',
              description:
                  'minuteInterval: 5 restricts minute selection to 5-minute steps '
                  '(00, 05, 10 … 55), useful for scheduling UIs.',
              code: '''Ux4gTimePicker(
  placeholder: 'Select time (5m intervals)',
  minuteInterval: 5,
  onTimeSelected: (time) {
    print('Selected: \$time');
  },
);''',
              child: SizedBox(
                width: 300,
                child: Ux4gTimePicker(
                  placeholder: 'Select time (5m intervals)',
                  minuteInterval: context.knobs.list(
                    label: 'Minute interval',
                    options: const [5, 10, 15, 30],
                    initialOption: 5,
                    labelBuilder: (v) => '$v min',
                  ),
                  enabled: context.knobs.boolean(
                    label: 'Enabled',
                    initialValue: true,
                  ),
                  onTimeSelected: (t) => setState(() => selected = t),
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);

// ── File Upload ───────────────────────────────────────────────────────────────

final fileUploadComponent = WidgetbookComponent(
  name: 'Ux4gFileUpload',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final borderStyle = context.knobs.object
            .dropdown<Ux4gFileUploadBorderStyle>(
              label: 'Border Style',
              options: Ux4gFileUploadBorderStyle.values,
              initialOption: Ux4gFileUploadBorderStyle.solid,
            );

        final variant = context.knobs.object.dropdown<Ux4gFileUploadVariant>(
          label: 'Variant',
          options: Ux4gFileUploadVariant.values,
          initialOption: Ux4gFileUploadVariant.standard,
        );

        return ComponentDocs(
          name: 'Ux4gFileUpload',
          description:
              'A file drop zone that allows users to select or drag-and-drop files. '
              'Shows upload progress per file with idle / uploading / success / error states.',
          code: '''Ux4gFileUpload(
  maxFiles: 5,
  maxFileSize: 5 * 1024 * 1024,  // 5 MB
  borderStyle: Ux4gFileUploadBorderStyle.dashed,
  onFilesChanged: (files) {
    // files is List<UploadedFile>
  },
  onUpload: (file) async {
    // perform upload logic; return true on success
    return true;
  },
);''',
          props: const [
            PropRow(
              name: 'maxFiles',
              type: 'int?',
              description: 'Max number of files allowed.',
            ),
            PropRow(
              name: 'maxFileSize',
              type: 'int?',
              description: 'Max file size in bytes.',
            ),
            PropRow(
              name: 'borderStyle',
              type: 'Ux4gFileUploadBorderStyle',
              description:
                  'Border style for the upload area. Options: solid, dashed. Default: solid.',
            ),
            PropRow(
              name: 'variant',
              type: 'Ux4gFileUploadVariant',
              description:
                  'Upload area layout variant. Options: standard (two buttons), dropzone (single upload button with "Or" divider). Default: standard.',
            ),
            PropRow(
              name: 'buttonBorderRadius',
              type: 'double',
              description: 'Border radius for upload buttons. Default: 8.',
            ),
            PropRow(
              name: 'buttonColor',
              type: 'Color?',
              description:
                  'Custom color for upload buttons (icon, text, and filled background).',
            ),
            PropRow(
              name: 'buttonBorderColor',
              type: 'Color?',
              description: 'Custom border color for outlined upload buttons.',
            ),
            PropRow(
              name: 'buttonStyle',
              type: 'ButtonStyle?',
              description:
                  'Fully custom ButtonStyle for the upload button. Overrides other button params when provided.',
            ),
            PropRow(
              name: 'onFilesChanged',
              type: 'ValueChanged<List<UploadedFile>>?',
              description: 'Called whenever the file list changes.',
            ),
            PropRow(
              name: 'onUpload',
              type: 'Future<bool> Function(UploadedFile)?',
              description:
                  'Handles uploading a single file; return true on success.',
            ),
          ],
          child: SizedBox(
            width: 360,
            child: Ux4gFileUpload(
              maxFiles: 5,
              maxFileSize: 5 * 1024 * 1024,
              borderStyle: borderStyle,
              variant: variant,
              onFilesChanged: (_) {},
              onUpload: (file) async => true,
            ),
          ),
        );
      },
    ),
  ],
);

// ── Radio Button ─────────────────────────────────────────────────────────────────

final radioButtonComponent = WidgetbookComponent(
  name: 'Ux4gRadioButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive',
      builder: (context) {
        String selected = 'Option B';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gRadioButton',
              description:
                  'A single-selection radio button. Use a shared groupValue '
                  'and onChanged to create a mutually-exclusive group.',
              code:
                  'Ux4gRadioButton(\n'
                  '  value: \'option1\',\n'
                  '  groupValue: selectedValue,\n'
                  '  onChanged: (v) => setState(() => selectedValue = v),\n'
                  '  label: \'Option A\',\n'
                  '  size: Ux4gRadioButtonSize.medium,\n'
                  ');',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: "This radio's value.",
                  required: true,
                ),
                PropRow(
                  name: 'groupValue',
                  type: 'String?',
                  description: 'Currently selected value in the group.',
                  required: true,
                ),
                PropRow(
                  name: 'onChanged',
                  type: 'ValueChanged<String>?',
                  description: 'Called when this radio is selected.',
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label text.',
                ),
                PropRow(
                  name: 'description',
                  type: 'String?',
                  description: 'Helper / status text below label.',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gRadioButtonSize',
                  description: 'small / medium / large.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'enabled',
                  type: 'bool',
                  description: 'Interactive state.',
                  defaultValue: 'true',
                ),
                PropRow(
                  name: 'descriptionVariant',
                  type: 'Ux4gRadioButtonDescriptionVariant',
                  description: 'helper / error / warning / success.',
                  defaultValue: 'helper',
                ),
              ],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ['Option A', 'Option B', 'Option C']
                    .map(
                      (v) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Ux4gRadioButton(
                          value: v,
                          groupValue: selected,
                          onChanged: (val) => setState(() => selected = val!),
                          label: v,
                          size: context.knobs.list(
                            label: 'Size',
                            options: Ux4gRadioButtonSize.values,
                            initialOption: Ux4gRadioButtonSize.medium,
                            labelBuilder: (s) => s.name,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    ),
    WidgetbookUseCase(
      name: 'All sizes',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton — Sizes',
        description: 'Small, medium, and large radio buttons shown together.',
        code:
            'Ux4gRadioButton(value: \'a\', groupValue: \'a\', onChanged: (_) {}, label: \'Small\',  size: Ux4gRadioButtonSize.small);',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Small',
              size: Ux4gRadioButtonSize.small,
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'b',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Medium',
              size: Ux4gRadioButtonSize.medium,
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'c',
              groupValue: 'c',
              onChanged: (_) {},
              label: 'Large',
              size: Ux4gRadioButtonSize.large,
            ),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Description variants',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton — Description Variants',
        description:
            'Each variant applies a semantic colour to the helper text. '
            'Pair with [status] so the radio circle colour matches.',
        code:
            'Ux4gRadioButton(\n'
            '  descriptionVariant: Ux4gRadioButtonDescriptionVariant.error,\n'
            '  status: Ux4gRadioButtonStatus.error,\n'
            '  description: \'Error message\',\n'
            '  ...\n'
            ');',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: Ux4gRadioButtonDescriptionVariant.values.map((v) {
            // Map description variant → matching radio status so the
            // circle uses the same semantic colour from our palette.
            final status = switch (v) {
              Ux4gRadioButtonDescriptionVariant.error =>
                Ux4gRadioButtonStatus.error,
              Ux4gRadioButtonDescriptionVariant.warning =>
                Ux4gRadioButtonStatus.warning,
              Ux4gRadioButtonDescriptionVariant.success =>
                Ux4gRadioButtonStatus.success,
              Ux4gRadioButtonDescriptionVariant.helper =>
                Ux4gRadioButtonStatus.defaultStatus,
            };
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Ux4gRadioButton(
                value: v.name,
                groupValue: v.name,
                onChanged: (_) {},
                label: v.name[0].toUpperCase() + v.name.substring(1),
                description: '${v.name} description text',
                descriptionVariant: v,
                status: status,
              ),
            );
          }).toList(),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton — Disabled',
        description: 'Disabled radio buttons cannot be interacted with.',
        code:
            'Ux4gRadioButton(value: \'a\', groupValue: \'a\', onChanged: null, label: \'Disabled (selected)\', enabled: false);',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Disabled (selected)',
              enabled: false,
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'b',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Disabled (unselected)',
              enabled: false,
            ),
          ],
        ),
      ),
    ),

    // ── Status: error / warning / success ───────────────────────────────
    WidgetbookUseCase(
      name: 'Status states',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton — Status',
        description:
            'The [status] prop drives the radio circle color so callers '
            'can show error / warning / success states alongside selection. '
            'Works for both selected and unselected radios.',
        code:
            'Ux4gRadioButton(\n'
            '  value: \'a\',\n'
            '  groupValue: \'a\',\n'
            '  onChanged: (_) {},\n'
            '  label: \'Required field\',\n'
            '  status: Ux4gRadioButtonStatus.error,\n'
            ');',
        props: const [
          PropRow(
            name: 'status',
            type: 'Ux4gRadioButtonStatus',
            description:
                'defaultStatus / error / warning / success — drives the radio circle color.',
            defaultValue: 'defaultStatus',
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Default (purple)',
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Error',
              status: Ux4gRadioButtonStatus.error,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Warning',
              status: Ux4gRadioButtonStatus.warning,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Success',
              status: Ux4gRadioButtonStatus.success,
            ),
            const SizedBox(height: 16),
            const Text(
              'Unselected',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Default',
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Error',
              status: Ux4gRadioButtonStatus.error,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Warning',
              status: Ux4gRadioButtonStatus.warning,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Success',
              status: Ux4gRadioButtonStatus.success,
            ),
          ],
        ),
      ),
    ),

    // ── Custom color override ───────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Custom color',
      builder: (context) => ComponentDocs(
        name: 'Ux4gRadioButton — Custom Color',
        description:
            'Use [color] to override the radio circle color (overrides '
            '[status] and theme primary). Use [labelColor] to override '
            'the label text color. Useful for brand-specific accents '
            'outside the standard status palette.',
        code:
            'Ux4gRadioButton(\n'
            '  value: \'a\',\n'
            '  groupValue: \'a\',\n'
            '  onChanged: (_) {},\n'
            '  label: \'Custom teal\',\n'
            '  color: Colors.teal,\n'
            '  labelColor: Colors.teal.shade700,\n'
            ');',
        props: const [
          PropRow(
            name: 'color',
            type: 'Color?',
            description:
                'Override for the radio circle color. Takes precedence over status and theme primary.',
          ),
          PropRow(
            name: 'labelColor',
            type: 'Color?',
            description: 'Override for the label text color.',
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Teal',
              color: Colors.teal,
              labelColor: Colors.teal.shade700,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Pink',
              color: Colors.pink,
              labelColor: Colors.pink.shade700,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Orange',
              color: Colors.deepOrange,
              labelColor: Colors.deepOrange.shade700,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Indigo',
              color: Colors.indigo,
            ),
            const SizedBox(height: 16),
            const Text(
              'Mixed selected + unselected',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'a',
              onChanged: (_) {},
              label: 'Teal (selected)',
              color: Colors.teal,
            ),
            const SizedBox(height: 4),
            Ux4gRadioButton(
              value: 'a',
              groupValue: 'b',
              onChanged: (_) {},
              label: 'Teal (unselected)',
              color: Colors.teal,
            ),
          ],
        ),
      ),
    ),
  ],
);
