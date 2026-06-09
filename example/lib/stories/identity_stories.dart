import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Aadhaar Input Field ──────────────────────────────────────────────────────

final aadhaarInputFieldComponent = WidgetbookComponent(
  name: 'Ux4gAadhaarInputField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gAadhaarInputField',
              description:
                  'A specialized input field for Aadhaar numbers (12 digits) '
                  'with auto-formatting (XXXX XXXX XXXX) and Verhoeff validation.',
              code: '''Ux4gAadhaarInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'Aadhaar Number',
  placeholder: 'XXXX XXXX XXXX',
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current value.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<String>',
                  description: 'Called on text change.',
                  required: true,
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above the field.',
                  defaultValue: "'Aadhaar Number'",
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String?',
                  description: 'Hint text.',
                  defaultValue: "'XXXX XXXX XXXX'",
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gInputFieldStatus',
                  description: 'defaultStatus / error / warning / success.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gInputFieldSize',
                  description: 'small / medium / large / xl.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'required',
                  type: 'bool',
                  description: 'Shows asterisk if true.',
                  defaultValue: 'false',
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
                  description: 'Whether field is read-only.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description: 'Helper text below the field.',
                  defaultValue: "'Enter your 12-digit Aadhaar number'",
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
                  description: 'Callback for trailing icon click.',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gAadhaarInputField(
                  value: value,
                  onValueChange: (v) => setState(() => value = v),
                  label: context.knobs.string(
                    label: 'Label',
                    initialValue: 'Aadhaar Number',
                  ),
                  placeholder: context.knobs.string(
                    label: 'Placeholder',
                    initialValue: 'XXXX XXXX XXXX',
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
                  required: context.knobs.boolean(
                    label: 'Required',
                    initialValue: false,
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
  ],
);

// ── PAN Input Field ──────────────────────────────────────────────────────────

final panInputFieldComponent = WidgetbookComponent(
  name: 'Ux4gPanInputField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        String value = '';
        return StatefulBuilder(
          builder: (ctx, setState) {
            return ComponentDocs(
              name: 'Ux4gPanInputField',
              description:
                  'A specialized input field for PAN Card numbers (10 chars) '
                  'with auto-uppercase enforcement and regex validation (ABCDE1234F).',
              code: '''Ux4gPanInputField(
  value: value,
  onValueChange: (v) => setState(() => value = v),
  label: 'PAN Card Number',
  placeholder: 'ABCDE1234F',
);''',
              props: const [
                PropRow(
                  name: 'value',
                  type: 'String',
                  description: 'Current value.',
                  required: true,
                ),
                PropRow(
                  name: 'onValueChange',
                  type: 'ValueChanged<String>',
                  description: 'Called on text change.',
                  required: true,
                ),
                PropRow(
                  name: 'label',
                  type: 'String?',
                  description: 'Label above the field.',
                  defaultValue: "'PAN Card Number'",
                ),
                PropRow(
                  name: 'placeholder',
                  type: 'String?',
                  description: 'Hint text.',
                  defaultValue: "'ABCDE1234F'",
                ),
                PropRow(
                  name: 'status',
                  type: 'Ux4gInputFieldStatus',
                  description: 'defaultStatus / error / warning / success.',
                  defaultValue: 'defaultStatus',
                ),
                PropRow(
                  name: 'size',
                  type: 'Ux4gInputFieldSize',
                  description: 'small / medium / large / xl.',
                  defaultValue: 'medium',
                ),
                PropRow(
                  name: 'required',
                  type: 'bool',
                  description: 'Shows asterisk if true.',
                  defaultValue: 'false',
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
                  description: 'Whether field is read-only.',
                  defaultValue: 'false',
                ),
                PropRow(
                  name: 'caption',
                  type: 'String?',
                  description: 'Helper text below the field.',
                  defaultValue: "'Enter your 10-character PAN number'",
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
                  description: 'Callback for trailing icon click.',
                ),
              ],
              child: SizedBox(
                width: 320,
                child: Ux4gPanInputField(
                  value: value,
                  onValueChange: (v) => setState(() => value = v),
                  label: context.knobs.string(
                    label: 'Label',
                    initialValue: 'PAN Card Number',
                  ),
                  placeholder: context.knobs.string(
                    label: 'Placeholder',
                    initialValue: 'ABCDE1234F',
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
                  required: context.knobs.boolean(
                    label: 'Required',
                    initialValue: false,
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
  ],
);
