import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';
import 'input_field.dart';

enum Ux4gTextAreaSize { small, large }

enum Ux4gTextAreaMinHeight {
  small(80),
  medium(120),
  large(160);

  final double height;
  const Ux4gTextAreaMinHeight(this.height);
}

class Ux4gTextArea extends StatefulWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final Ux4gTextAreaSize size;
  final Ux4gTextAreaMinHeight minHeight;
  final Ux4gInputFieldStatus status;
  final String? label;
  final bool required;
  final String? placeholder;
  final String? caption;
  final bool showCaptionIcon;
  final IconData? trailingIconLabel;
  final String? characterCountText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;

  const Ux4gTextArea({
    super.key,
    required this.value,
    required this.onValueChange,
    this.size = Ux4gTextAreaSize.large,
    this.minHeight = Ux4gTextAreaMinHeight.medium,
    this.status = Ux4gInputFieldStatus.defaultStatus,
    this.label,
    this.required = false,
    this.placeholder,
    this.caption,
    this.showCaptionIcon = true,
    this.trailingIconLabel,
    this.characterCountText,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
  });

  @override
  State<Ux4gTextArea> createState() => _Ux4gTextAreaState();
}

class _Ux4gTextAreaState extends State<Ux4gTextArea> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    
    // Listen to changes to notify parent
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_controller.text != widget.value) {
      widget.onValueChange(_controller.text);
    }
  }

  @override
  void didUpdateWidget(Ux4gTextArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      // Remove listener to prevent circular calls
      _controller.removeListener(_onTextChanged);
      
      final selection = _controller.selection;
      _controller.text = widget.value;
      
      if (selection.isValid && selection.baseOffset <= widget.value.length) {
        _controller.selection = selection;
      } else {
        _controller.selection = TextSelection.collapsed(offset: widget.value.length);
      }
      
      // Re-add listener
      _controller.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final onBackground = ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;
    final errorColor = ux4gColors?.error ?? materialTheme.colorScheme.error;

    final bM_default = ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle(fontSize: 16);
    final bM_strong = ux4gTypography?.bM_strong ?? materialTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
    final bXS_default = ux4gTypography?.bXS_default ?? materialTheme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    final bS_default = ux4gTypography?.bS_default ?? materialTheme.textTheme.bodySmall ?? const TextStyle(fontSize: 14);

    final borderColor = _getBorderColor(materialTheme, ux4gColors);
    final bgColor = widget.enabled ? surface : onSurface.withValues(alpha: 0.05);
    final textColor = widget.enabled ? onBackground : onSurface.withValues(alpha: 0.4);
    final labelColor = _getLabelColor(materialTheme, ux4gColors);
    final captionColor = _getCaptionColor(materialTheme, ux4gColors);

    final contentPadding = widget.size == Ux4gTextAreaSize.large ? 16.0 : 12.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            children: [
              Text(widget.label!, style: bM_strong.copyWith(color: labelColor)),
              if (widget.required) ...[
                const SizedBox(width: 4),
                Text("*", style: bM_strong.copyWith(color: errorColor)),
              ],
              if (widget.trailingIconLabel != null) ...[
                const SizedBox(width: 4),
                Icon(widget.trailingIconLabel, size: 16, color: onSurface.withValues(alpha: 0.5)),
              ],
            ],
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: () {
            if (widget.enabled && !widget.readOnly) {
              _focusNode.requestFocus();
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            constraints: BoxConstraints(minHeight: widget.minHeight.height),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
              border: Border.all(color: borderColor, width: 1),
            ),
            padding: EdgeInsets.all(contentPadding),
            child: Stack(
              children: [
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  maxLines: null,
                  maxLength: widget.maxLength,
                  style: bM_default.copyWith(color: textColor),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: bM_default.copyWith(color: onSurface.withValues(alpha: 0.4)),
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    counterText: "", // Hide default counter
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.characterCountText != null)
                        Text(
                          widget.characterCountText!,
                          style: bXS_default.copyWith(color: onSurface.withValues(alpha: 0.5)),
                        ),
                      const SizedBox(width: 4),
                      Text(
                        "◢",
                        style: bS_default.copyWith(
                          color: onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.caption != null || widget.status == Ux4gInputFieldStatus.error) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              if (widget.showCaptionIcon) ...[
                Icon(_getStatusIcon() ?? Icons.info_outline, size: 14, color: captionColor),
                const SizedBox(width: 6),
              ],
              Text(widget.caption ?? "", style: bXS_default.copyWith(color: captionColor)),
            ],
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(ThemeData materialTheme, Ux4gColors? ux4gColors) {
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final success = ux4gColors?.success ?? Colors.green;

    if (!widget.enabled) return onSurface.withValues(alpha: 0.3);
    return switch (widget.status) {
      Ux4gInputFieldStatus.error => error,
      Ux4gInputFieldStatus.warning => warning,
      Ux4gInputFieldStatus.success => success,
      Ux4gInputFieldStatus.defaultStatus => onSurface.withValues(alpha: 0.3),
    };
  }

  Color _getLabelColor(ThemeData materialTheme, Ux4gColors? ux4gColors) {
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final onBackground = ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final success = ux4gColors?.success ?? Colors.green;

    if (!widget.enabled) return onSurface.withValues(alpha: 0.4);
    return switch (widget.status) {
      Ux4gInputFieldStatus.error => error,
      Ux4gInputFieldStatus.warning => warning,
      Ux4gInputFieldStatus.success => success,
      Ux4gInputFieldStatus.defaultStatus => onBackground,
    };
  }

  Color _getCaptionColor(ThemeData materialTheme, Ux4gColors? ux4gColors) {
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final success = ux4gColors?.success ?? Colors.green;

    if (!widget.enabled) return onSurface.withValues(alpha: 0.4);
    return switch (widget.status) {
      Ux4gInputFieldStatus.error => error,
      Ux4gInputFieldStatus.warning => warning,
      Ux4gInputFieldStatus.success => success,
      Ux4gInputFieldStatus.defaultStatus => onSurface.withValues(alpha: 0.6),
    };
  }

  IconData? _getStatusIcon() {
    return switch (widget.status) {
      Ux4gInputFieldStatus.error => Icons.error,
      Ux4gInputFieldStatus.warning => Icons.warning,
      Ux4gInputFieldStatus.success => Icons.check_circle,
      Ux4gInputFieldStatus.defaultStatus => null,
    };
  }
}
