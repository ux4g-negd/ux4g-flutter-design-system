import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';
import 'loader.dart';

enum Ux4gSearchFieldVariant { basicSearch, searchWithSubmit, autocomplete }

enum Ux4gSearchFieldSize {
  small(32),
  medium(40),
  large(48),
  xl(56);

  final double height;
  const Ux4gSearchFieldSize(this.height);
}

enum Ux4gSearchFieldStatus { defaultStatus, error, warning, success }

enum Ux4gSearchFieldButtonStyle { filled, tonal }

class Ux4gSearchField extends StatefulWidget {
  final String value;
  final ValueChanged<String> onValueChange;
  final Ux4gSearchFieldVariant variant;
  final Ux4gSearchFieldSize size;
  final Ux4gSearchFieldStatus status;
  final Ux4gSearchFieldButtonStyle buttonStyle;
  final String? label;
  final String? placeholder;
  final String? caption;
  final List<String> options;
  final bool showVoiceIcon;
  final bool showClearIcon;
  final bool isLoading;
  final VoidCallback? onVoiceClick;
  final VoidCallback? onClearClick;
  final ValueChanged<String>? onSubmitClick;
  final ValueChanged<String>? onOptionSelected;
  final bool enabled;
  final bool readOnly;

  const Ux4gSearchField({
    super.key,
    required this.value,
    required this.onValueChange,
    this.variant = Ux4gSearchFieldVariant.basicSearch,
    this.size = Ux4gSearchFieldSize.medium,
    this.status = Ux4gSearchFieldStatus.defaultStatus,
    this.buttonStyle = Ux4gSearchFieldButtonStyle.filled,
    this.label,
    this.placeholder,
    this.caption,
    this.options = const [],
    this.showVoiceIcon = true,
    this.showClearIcon = true,
    this.isLoading = false,
    this.onVoiceClick,
    this.onClearClick,
    this.onSubmitClick,
    this.onOptionSelected,
    this.enabled = true,
    this.readOnly = false,
  });

  @override
  State<Ux4gSearchField> createState() => _Ux4gSearchFieldState();
}

class _Ux4gSearchFieldState extends State<Ux4gSearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late TextEditingController _controller;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  final GlobalKey _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
      if (_focusNode.hasFocus && widget.variant == Ux4gSearchFieldVariant.autocomplete) {
        _showAutocomplete();
      } else {
        _hideAutocomplete();
      }
    });
  }

  @override
  void didUpdateWidget(Ux4gSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
    if (_isFocused && widget.variant == Ux4gSearchFieldVariant.autocomplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _hideAutocomplete();
    super.dispose();
  }

  void _showAutocomplete() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideAutocomplete() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final renderBox = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
        final width = renderBox?.size.width ?? 0;

        // Android logic: only visible if focused AND variant is Autocomplete AND value is not empty
        final isVisible = _isFocused && widget.variant == Ux4gSearchFieldVariant.autocomplete && widget.value.isNotEmpty;

        if (!isVisible) return const SizedBox.shrink();

        return Positioned(
          width: width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, widget.size.height + 4),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
              clipBehavior: Clip.antiAlias,
              color: Ux4gTheme.colors(context).surface,
              child: _buildAutocompleteList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAutocompleteList() {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Searching for '${widget.value}'", style: typography.bM_default),
          const SizedBox(height: 16),
          if (widget.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Ux4gLoader(size: 24),
              ),
            )
          else if (widget.options.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "No results found",
                  style: typography.bM_default.copyWith(color: colors.onSurface.withValues(alpha: 0.5)),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final option = widget.options[index];
                  return InkWell(
                    onTap: () {
                      widget.onOptionSelected?.call(option);
                      widget.onValueChange(option);
                      _focusNode.unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        option,
                        style: typography.bM_default.copyWith(color: colors.onSurface.withValues(alpha: 0.8)),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final isSubmitVariant = widget.variant == Ux4gSearchFieldVariant.searchWithSubmit;
    final inputShape = isSubmitVariant
        ? const BorderRadius.only(
            topLeft: Radius.circular(Ux4gRadius.radius8),
            bottomLeft: Radius.circular(Ux4gRadius.radius8),
          )
        : BorderRadius.circular(Ux4gRadius.radius8);

    final borderColor = _getBorderColor(colors);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: typography.bM_strong.copyWith(color: _getLabelColor(colors))),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            Expanded(
              child: CompositedTransformTarget(
                key: _fieldKey,
                link: _layerLink,
                child: Container(
                  height: widget.size.height,
                  decoration: BoxDecoration(
                    color: widget.enabled ? colors.surface : colors.onSurface.withValues(alpha: 0.05),
                    borderRadius: inputShape,
                    border: Border.all(color: borderColor, width: _isFocused ? 2 : 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20, color: colors.onSurface.withValues(alpha: 0.5)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onChanged: widget.onValueChange,
                          onSubmitted: widget.onSubmitClick,
                          enabled: widget.enabled,
                          readOnly: widget.readOnly,
                          style: typography.bM_default.copyWith(color: widget.enabled ? colors.onSurface : colors.onSurface.withValues(alpha: 0.4)),
                          decoration: InputDecoration(
                            hintText: widget.placeholder,
                            hintStyle: typography.bM_default.copyWith(color: colors.onSurface.withValues(alpha: 0.4)),
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (widget.isLoading && widget.variant != Ux4gSearchFieldVariant.autocomplete) ...[
                        const SizedBox(width: 8),
                        const Ux4gLoader(size: 16),
                      ],
                      if (widget.showVoiceIcon) ...[
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: widget.onVoiceClick,
                          child: Icon(Icons.mic, size: 20, color: colors.onSurface.withValues(alpha: 0.5)),
                        ),
                      ],
                      if (widget.showClearIcon && widget.value.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: widget.onClearClick ?? () => widget.onValueChange(""),
                          child: Icon(Icons.close, size: 20, color: colors.onSurface.withValues(alpha: 0.5)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (isSubmitVariant)
              Container(
                height: widget.size.height,
                width: widget.size.height,
                decoration: BoxDecoration(
                  color: widget.buttonStyle == Ux4gSearchFieldButtonStyle.filled ? colors.primary : colors.primary.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(Ux4gRadius.radius8),
                    bottomRight: Radius.circular(Ux4gRadius.radius8),
                  ),
                ),
                child: InkWell(
                  onTap: () => widget.onSubmitClick?.call(widget.value),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: widget.buttonStyle == Ux4gSearchFieldButtonStyle.filled ? colors.onPrimary : colors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (widget.caption != null || widget.status == Ux4gSearchFieldStatus.error) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(_getStatusIcon() ?? Icons.info_outline, size: 14, color: _getCaptionColor(colors)),
              const SizedBox(width: 6),
              Text(widget.caption ?? "", style: typography.bXS_default.copyWith(color: _getCaptionColor(colors))),
            ],
          ),
        ],
      ],
    );
  }

  Color _getBorderColor(Ux4gColors colors) {
    if (!widget.enabled) return colors.onSurface.withValues(alpha: 0.3);
    if (_isFocused && widget.variant == Ux4gSearchFieldVariant.autocomplete) return colors.primary;
    return switch (widget.status) {
      Ux4gSearchFieldStatus.error => colors.error,
      Ux4gSearchFieldStatus.warning => colors.warning,
      Ux4gSearchFieldStatus.success => colors.success,
      Ux4gSearchFieldStatus.defaultStatus => _isFocused ? colors.primary : colors.onSurface.withValues(alpha: 0.3),
    };
  }

  Color _getLabelColor(Ux4gColors colors) {
    if (!widget.enabled) return colors.onSurface.withValues(alpha: 0.4);
    return switch (widget.status) {
      Ux4gSearchFieldStatus.error => colors.error,
      Ux4gSearchFieldStatus.warning => colors.warning,
      Ux4gSearchFieldStatus.success => colors.success,
      Ux4gSearchFieldStatus.defaultStatus => _isFocused ? colors.primary : colors.onBackground,
    };
  }

  Color _getCaptionColor(Ux4gColors colors) {
    if (!widget.enabled) return colors.onSurface.withValues(alpha: 0.4);
    return switch (widget.status) {
      Ux4gSearchFieldStatus.error => colors.error,
      Ux4gSearchFieldStatus.warning => colors.warning,
      Ux4gSearchFieldStatus.success => colors.success,
      Ux4gSearchFieldStatus.defaultStatus => colors.onSurface.withValues(alpha: 0.6),
    };
  }

  IconData? _getStatusIcon() {
    return switch (widget.status) {
      Ux4gSearchFieldStatus.error => Icons.error,
      Ux4gSearchFieldStatus.warning => Icons.warning,
      Ux4gSearchFieldStatus.success => Icons.check_circle,
      Ux4gSearchFieldStatus.defaultStatus => null,
    };
  }
}
