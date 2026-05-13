import 'package:flutter/material.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'input_field.dart';

// --- Choice Chip ---

enum Ux4gChoiceChipSize { s, m }

class Ux4gChoiceChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onClick;
  final bool enabled;
  final Ux4gChoiceChipSize size;
  final Widget? leadingContent;
  final double borderRadius;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;

  const Ux4gChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onClick,
    this.enabled = true,
    this.size = Ux4gChoiceChipSize.m,
    this.leadingContent,
    this.borderRadius = Ux4gRadius.radius4,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedBorderWidth = 1,
    this.unselectedBorderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final paddingH = size == Ux4gChoiceChipSize.s ? 12.0 : 16.0;
    final paddingV = size == Ux4gChoiceChipSize.s ? 6.0 : 8.0;
    final textStyle = size == Ux4gChoiceChipSize.s
        ? typography.lM_default
        : typography.lL_default;

    final bgColor = selected
        ? (selectedBackgroundColor ?? colors.primary)
        : (unselectedBackgroundColor ?? colors.surface);

    final borderColor = selected
        ? (selectedBorderColor ?? colors.primary)
        : (unselectedBorderColor ?? colors.onSurface.withValues(alpha: 0.2));

    final borderWidth = selected ? selectedBorderWidth : unselectedBorderWidth;

    final textColor = selected
        ? (selectedTextColor ?? colors.onPrimary)
        : (unselectedTextColor ?? colors.onSurface);

    return InkWell(
      onTap: enabled ? onClick : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: paddingH,
            vertical: paddingV,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingContent != null) ...[
                leadingContent!,
                const SizedBox(width: 8),
              ],
              Text(text, style: textStyle.copyWith(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Filter Chip ---

enum Ux4gFilterChipSize { s, m }

class Ux4gFilterChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onClick;
  final bool enabled;
  final Ux4gFilterChipSize size;
  final Widget? leadingContent;
  final double borderRadius;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double selectedBorderWidth;
  final double unselectedBorderWidth;

  const Ux4gFilterChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onClick,
    this.enabled = true,
    this.size = Ux4gFilterChipSize.m,
    this.leadingContent,
    this.borderRadius = Ux4gRadius.radius4,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedBorderWidth = 2,
    this.unselectedBorderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final height = size == Ux4gFilterChipSize.s ? 28.0 : 32.0;
    final paddingH = size == Ux4gFilterChipSize.s ? 12.0 : 16.0;
    final textStyle = size == Ux4gFilterChipSize.s
        ? typography.lM_default
        : typography.lL_default;

    final bgColor = selected
        ? (selectedBackgroundColor ?? colors.primary.withValues(alpha: 0.08))
        : (unselectedBackgroundColor ?? colors.surface);

    final borderColor = selected
        ? (selectedBorderColor ?? colors.primary)
        : (unselectedBorderColor ?? colors.onSurface.withValues(alpha: 0.2));

    final borderWidth = selected ? selectedBorderWidth : unselectedBorderWidth;

    final textColor = selected
        ? (selectedTextColor ?? colors.primary)
        : (unselectedTextColor ?? colors.onSurface);

    return InkWell(
      onTap: enabled ? onClick : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: paddingH),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingContent != null) ...[
                leadingContent!,
                const SizedBox(width: 8),
              ],
              Text(text, style: textStyle.copyWith(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Input Chip ---

enum Ux4gInputChipSize { xs, s, m }

class Ux4gInputChip extends StatelessWidget {
  final String text;
  final VoidCallback onDismiss;
  final bool enabled;
  final Ux4gInputChipSize size;
  final Widget? leadingContent;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double borderWidth;

  const Ux4gInputChip({
    super.key,
    required this.text,
    required this.onDismiss,
    this.enabled = true,
    this.size = Ux4gInputChipSize.m,
    this.leadingContent,
    this.borderRadius = Ux4gRadius.radius4,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final height = switch (size) {
      Ux4gInputChipSize.xs => 20.0,
      Ux4gInputChipSize.s => 28.0,
      Ux4gInputChipSize.m => 32.0,
    };
    final paddingH = switch (size) {
      Ux4gInputChipSize.xs => 8.0,
      Ux4gInputChipSize.s => 12.0,
      Ux4gInputChipSize.m => 16.0,
    };
    final textStyle = switch (size) {
      Ux4gInputChipSize.xs => typography.lS_default,
      Ux4gInputChipSize.s => typography.lM_default,
      Ux4gInputChipSize.m => typography.lL_default,
    };
    final iconSize = size == Ux4gInputChipSize.xs ? 12.0 : 16.0;

    final finalBgColor = backgroundColor ?? colors.surface;
    final finalBorderColor =
        borderColor ?? colors.onSurface.withValues(alpha: 0.2);
    final finalTextColor = textColor ?? colors.onSurface;

    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: paddingH),
        decoration: BoxDecoration(
          color: finalBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: finalBorderColor, width: borderWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingContent != null) ...[
              leadingContent!,
              const SizedBox(width: 8),
            ],
            Text(text, style: textStyle.copyWith(color: finalTextColor)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: enabled ? onDismiss : null,
              child: Icon(
                Icons.close,
                size: iconSize,
                color: finalTextColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Ux4gInputChipField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final ValueChanged<String> onAddChip;
  final String placeholder;
  final Widget? leadingIcon;
  final bool isDropdown;
  final List<String> dropdownOptions;
  final List<Widget> chips;

  const Ux4gInputChipField({
    super.key,
    required this.value,
    required this.onValueChange,
    required this.onAddChip,
    this.placeholder = "Please select..",
    this.leadingIcon,
    this.isDropdown = false,
    this.dropdownOptions = const [],
    this.chips = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDropdown)
          _buildDropdownField(context)
        else
          Ux4gInputField(
            value: value,
            onValueChange: onValueChange,
            placeholder: placeholder,
            leadingIcon: leadingIcon is Icon
                ? (leadingIcon as Icon).icon
                : null,
            onTrailingIconPressed: () {
              if (value.isNotEmpty) {
                onAddChip(value);
                onValueChange("");
              }
            },
            trailingIcon: Icons.add,
          ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chips
                .map(
                  (chip) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: chip,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    return PopupMenuButton<String>(
      onSelected: (val) {
        onAddChip(val);
        onValueChange("");
      },
      itemBuilder: (context) => dropdownOptions
          .map((opt) => PopupMenuItem(value: opt, child: Text(opt)))
          .toList(),
      child: Ux4gInputField(
        value: value,
        onValueChange: onValueChange,
        placeholder: placeholder,
        leadingIcon: leadingIcon is Icon ? (leadingIcon as Icon).icon : null,
        enabled: false, // Click handles by popup
        trailingIcon: Icons.arrow_drop_down,
      ),
    );
  }
}
