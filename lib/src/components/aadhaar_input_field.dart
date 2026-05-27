import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_field.dart';

/// A specialized input field for Aadhaar numbers (12 digits).
/// It includes auto-formatting (XXXX XXXX XXXX), numeric-only input,
/// and built-in validation using the Verhoeff algorithm.
class Ux4gAadhaarInputField extends StatelessWidget {
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

  /// Optional override for the placeholder text style. Forwarded to the
  /// underlying [Ux4gInputField].
  final TextStyle? placeholderStyle;

  /// Optional override for the input value text style.
  final TextStyle? style;

  /// Optional override for the label text style.
  final TextStyle? labelStyle;

  /// Optional override for the caption / helper text style.
  final TextStyle? captionStyle;

  const Ux4gAadhaarInputField({
    super.key,
    required this.value,
    required this.onValueChange,
    this.size = Ux4gInputFieldSize.medium,
    this.status = Ux4gInputFieldStatus.defaultStatus,
    this.label = 'Aadhaar Number',
    this.required = false,
    this.placeholder = 'XXXX XXXX XXXX',
    this.caption = 'Enter your 12-digit Aadhaar number',
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.enabled = true,
    this.readOnly = false,
    this.placeholderStyle,
    this.style,
    this.labelStyle,
    this.captionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Ux4gInputField(
      value: value,
      onValueChange: onValueChange,
      size: size,
      type: Ux4gInputFieldType.number,
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
      maxLength: 14, // 12 digits + 2 spaces
      style: style,
      labelStyle: labelStyle,
      placeholderStyle: placeholderStyle,
      captionStyle: captionStyle,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _AadhaarNumberFormatter(),
      ],
    );
  }

  /// Static utility to validate Aadhaar number using Verhoeff algorithm.
  static bool validateAadhaar(String aadhaar) {
    // Remove spaces
    final cleanAadhaar = aadhaar.replaceAll(' ', '');
    if (cleanAadhaar.length != 12) return false;
    if (RegExp(r'^[01]').hasMatch(cleanAadhaar))
      return false; // Aadhaar doesn't start with 0 or 1

    return _VerhoeffAlgorithm.validate(cleanAadhaar);
  }
}

/// Formatter to insert spaces every 4 digits: XXXX XXXX XXXX
class _AadhaarNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    if (text.length > 12) return oldValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      final index = i + 1;
      if (index % 4 == 0 && index != text.length) {
        buffer.write(' ');
      }
    }

    final formattedText = buffer.toString();
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Verhoeff algorithm for Aadhaar validation.
class _VerhoeffAlgorithm {
  static const List<List<int>> _d = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
  ];

  static const List<List<int>> _p = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
  ];

  static bool validate(String num) {
    int c = 0;
    final List<int> myList = _stringToReversedIntArray(num);

    for (int i = 0; i < myList.length; i++) {
      c = _d[c][_p[i % 8][myList[i]]];
    }

    return c == 0;
  }

  static List<int> _stringToReversedIntArray(String num) {
    final List<int> myArray = [];
    for (int i = 0; i < num.length; i++) {
      myArray.add(int.parse(num[i]));
    }
    return myArray.reversed.toList();
  }
}
