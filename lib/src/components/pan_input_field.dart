import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_field.dart';

/// A specialized input field for Permanent Account Number (PAN) cards.
/// It includes auto-uppercase enforcement and regex-based validation (ABCDE1234F).
class Ux4gPanInputField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final Ux4gInputFieldSize size;
  final Ux4gInputFieldStatus status;
  final String? label;
  final bool required;
  final String? placeholder;
  final String? caption;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final bool enabled;
  final bool readOnly;

  const Ux4gPanInputField({
    super.key,
    required this.value,
    required this.onValueChange,
    this.size = Ux4gInputFieldSize.medium,
    this.status = Ux4gInputFieldStatus.defaultStatus,
    this.label = 'PAN Card Number',
    this.required = false,
    this.placeholder = 'ABCDE1234F',
    this.caption = 'Enter your 10-character PAN number',
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.enabled = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Ux4gInputField(
      value: value,
      onValueChange: onValueChange,
      size: size,
      type: Ux4gInputFieldType.text,
      status: status,
      label: label,
      required: required,
      placeholder: placeholder,
      caption: caption,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      onTrailingIconPressed: onTrailingIconPressed,
      enabled: enabled,
      readOnly: readOnly,
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        _UpperCaseTextFormatter(),
      ],
    );
  }

  /// Static utility to validate PAN number using Regex.
  /// Format: 5 Letters, 4 Digits, 1 Letter (e.g., ABCDE1234F)
  static bool validatePan(String pan) {
    final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegex.hasMatch(pan.toUpperCase());
  }
}

/// Formatter to force all input to uppercase.
class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
