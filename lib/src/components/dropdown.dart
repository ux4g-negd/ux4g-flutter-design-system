import 'package:flutter/material.dart';
import '../foundation/dimensions.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'chips.dart';

enum Ux4gDropdownFilterType { contains, startsWith, startsWithPerTerm }

enum Ux4gDropdownSize { s, m, l }

enum Ux4gDropdownMode { single, multi }

enum Ux4gDropdownStatus { defaultStatus, error, disabled }

class Ux4gDropdownOption {
  final String id;
  final String label;
  final IconData? leadingIcon;

  const Ux4gDropdownOption({
    required this.id,
    required this.label,
    this.leadingIcon,
  });
}

// ── ACTION DROPDOWN ──────────────────────────────────────────────────────────

class Ux4gActionDropdownOption {
  final String id;
  final String label;
  final bool showTrailingArrow;

  const Ux4gActionDropdownOption({
    required this.id,
    required this.label,
    this.showTrailingArrow = true,
  });
}

typedef Ux4gDropdownTriggerBuilder =
    Widget Function(BuildContext context, VoidCallback toggleDropdown);

class Ux4gActionDropdown extends StatefulWidget {
  final List<Ux4gActionDropdownOption> options;
  final ValueChanged<Ux4gActionDropdownOption> onOptionClick;
  final Ux4gDropdownTriggerBuilder triggerBuilder;

  const Ux4gActionDropdown({
    super.key,
    required this.options,
    required this.onOptionClick,
    required this.triggerBuilder,
  });

  @override
  State<Ux4gActionDropdown> createState() => _Ux4gActionDropdownState();
}

class _Ux4gActionDropdownState extends State<Ux4gActionDropdown> {
  bool _isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    if (_isExpanded) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isExpanded = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isExpanded = false);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final renderBox = this.context.findRenderObject() as RenderBox?;
        final size = renderBox?.hasSize == true ? renderBox!.size : Size.zero;

        return Stack(
          children: [
            GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(),
            ),
            Positioned(
              width: 200,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
                  color:
                      Theme.of(context).extension<Ux4gColors>()?.surface ??
                      Theme.of(context).colorScheme.surface,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: widget.options.length,
                      itemBuilder: (context, index) {
                        final option = widget.options[index];
                        final typography = Theme.of(
                          context,
                        ).extension<Ux4gTypography>();
                        return ListTile(
                          dense: true,
                          title: Text(
                            option.label,
                            style:
                                typography?.lL_default ??
                                Theme.of(context).textTheme.labelLarge,
                          ),
                          trailing: option.showTrailingArrow
                              ? const Icon(Icons.keyboard_arrow_right, size: 20)
                              : null,
                          onTap: () {
                            _closeDropdown();
                            widget.onOptionClick(option);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.triggerBuilder(context, _toggleDropdown),
    );
  }
}

// ── SELECTION DROPDOWN ────────────────────────────────────────────────────────

class Ux4gSelectionDropdown extends StatefulWidget {
  final List<Ux4gDropdownOption> options;
  final List<String> selectedOptionIds;
  final ValueChanged<List<String>> onSelectionChange;
  final String? label;
  final String? description;
  final String placeholder;
  final Ux4gDropdownSize size;
  final Ux4gDropdownMode mode;
  final Ux4gDropdownStatus status;
  final bool searchEnabled;
  final Ux4gDropdownFilterType filterType;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;
  final IconData? leadingIcon;

  const Ux4gSelectionDropdown({
    super.key,
    required this.options,
    required this.selectedOptionIds,
    required this.onSelectionChange,
    this.label,
    this.description,
    this.placeholder = "Please select..",
    this.size = Ux4gDropdownSize.m,
    this.mode = Ux4gDropdownMode.single,
    this.status = Ux4gDropdownStatus.defaultStatus,
    this.searchEnabled = false,
    this.filterType = Ux4gDropdownFilterType.contains,
    this.labelTextStyle,
    this.valueTextStyle,
    this.leadingIcon,
  });

  @override
  State<Ux4gSelectionDropdown> createState() => _Ux4gSelectionDropdownState();
}

class _Ux4gSelectionDropdownState extends State<Ux4gSelectionDropdown> {
  bool _isExpanded = false;
  String _searchQuery = "";
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void didUpdateWidget(Ux4gSelectionDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOptionIds != oldWidget.selectedOptionIds) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
    }
  }

  void _toggleDropdown() {
    if (widget.status == Ux4gDropdownStatus.disabled) return;
    if (_isExpanded) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isExpanded = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isExpanded = false;
      _searchQuery = "";
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final renderBox =
            _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
        final size = renderBox?.hasSize == true ? renderBox!.size : Size.zero;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeDropdown,
                behavior: HitTestBehavior.opaque,
                child: Container(color: Colors.transparent),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 4),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
                color:
                    Theme.of(context).extension<Ux4gColors>()?.surface ??
                    Theme.of(context).colorScheme.surface,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: size.width,
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: _buildDropdownList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdownList() {
    final filteredOptions = widget.options.where((option) {
      if (!widget.searchEnabled || _searchQuery.isEmpty) return true;
      final query = _searchQuery.trim().toLowerCase();
      if (query.isEmpty) return true;
      final label = option.label.toLowerCase();

      return switch (widget.filterType) {
        Ux4gDropdownFilterType.contains => label.contains(query),
        Ux4gDropdownFilterType.startsWith => label.startsWith(query),
        Ux4gDropdownFilterType.startsWithPerTerm => () {
          final queryTerms = query.split(' ').where((t) => t.isNotEmpty);
          final labelTerms = label.split(' ').where((t) => t.isNotEmpty);
          return queryTerms.every(
            (qTerm) => labelTerms.any((lTerm) => lTerm.startsWith(qTerm)),
          );
        }(),
      };
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.searchEnabled)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Start typing..",
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (val) {
                _searchQuery = val;
                _overlayEntry?.markNeedsBuild();
              },
            ),
          ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: filteredOptions.length,
            itemBuilder: (context, index) {
              final option = filteredOptions[index];
              final isSelected = widget.selectedOptionIds.contains(option.id);
              final uxColors = Theme.of(context).extension<Ux4gColors>();
              final uxTypography = Theme.of(
                context,
              ).extension<Ux4gTypography>();
              final materialTheme = Theme.of(context);

              return InkWell(
                onTap: () => _handleSelection(option.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (widget.mode == Ux4gDropdownMode.multi) ...[
                        IgnorePointer(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (_) {},
                              activeColor:
                                  uxColors?.primary ??
                                  materialTheme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ] else if (option.leadingIcon != null) ...[
                        Icon(option.leadingIcon, size: 20),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        child: Text(
                          option.label,
                          style:
                              (uxTypography?.lL_default ??
                                      materialTheme.textTheme.labelLarge)
                                  ?.copyWith(
                                    color: isSelected
                                        ? (uxColors?.primary ??
                                              materialTheme.colorScheme.primary)
                                        : null,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : null,
                                  ),
                        ),
                      ),
                      if (widget.mode == Ux4gDropdownMode.single && isSelected)
                        Icon(
                          Icons.check,
                          color:
                              uxColors?.primary ??
                              materialTheme.colorScheme.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleSelection(String id) {
    if (widget.mode == Ux4gDropdownMode.single) {
      widget.onSelectionChange([id]);
      _closeDropdown();
    } else {
      final newSelection = List<String>.from(widget.selectedOptionIds);
      if (newSelection.contains(id)) {
        newSelection.remove(id);
      } else {
        newSelection.add(id);
      }
      widget.onSelectionChange(newSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uxColors = Theme.of(context).extension<Ux4gColors>();
    final uxTypography = Theme.of(context).extension<Ux4gTypography>();
    final materialTheme = Theme.of(context);

    final (minHeight, verticalPadding) = switch (widget.size) {
      Ux4gDropdownSize.s => (32.0, 6.0),
      Ux4gDropdownSize.m => (40.0, 8.0),
      Ux4gDropdownSize.l => (48.0, 12.0),
    };

    final textStyle = switch (widget.size) {
      Ux4gDropdownSize.s =>
        uxTypography?.lM_default ?? materialTheme.textTheme.labelMedium,
      Ux4gDropdownSize.m =>
        uxTypography?.lL_default ?? materialTheme.textTheme.labelLarge,
      Ux4gDropdownSize.l =>
        uxTypography?.lXL_default ?? materialTheme.textTheme.labelLarge,
    };

    final borderColor = switch (widget.status) {
      Ux4gDropdownStatus.disabled =>
        (uxColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
          alpha: 0.2,
        ),
      Ux4gDropdownStatus.error =>
        uxColors?.error ?? materialTheme.colorScheme.error,
      Ux4gDropdownStatus.defaultStatus =>
        _isExpanded
            ? (uxColors?.primary ?? materialTheme.colorScheme.primary)
            : (uxColors?.onSurface ?? materialTheme.colorScheme.onSurface)
                  .withValues(alpha: 0.2),
    };

    final descriptionColor = widget.status == Ux4gDropdownStatus.error
        ? (uxColors?.error ?? materialTheme.colorScheme.error)
        : (uxColors?.onSurface ?? materialTheme.colorScheme.onSurface)
              .withValues(alpha: 0.7);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style:
                widget.labelTextStyle ??
                (uxTypography?.hS_default ??
                        materialTheme.textTheme.headlineSmall)
                    ?.copyWith(
                      color: widget.status == Ux4gDropdownStatus.disabled
                          ? (uxColors?.onSurface ??
                                    materialTheme.colorScheme.onSurface)
                                .withValues(alpha: 0.38)
                          : (uxColors?.onSurface ??
                                materialTheme.colorScheme.onSurface),
                    ),
          ),
          const SizedBox(height: Ux4gSpace.space4),
        ],
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _dropdownKey,
            onTap: _toggleDropdown,
            child: Container(
              constraints: BoxConstraints(minHeight: minHeight),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: verticalPadding,
              ),
              decoration: BoxDecoration(
                color: widget.status == Ux4gDropdownStatus.disabled
                    ? (uxColors?.onSurface ??
                              materialTheme.colorScheme.onSurface)
                          .withValues(alpha: 0.04)
                    : (uxColors?.surface ?? materialTheme.colorScheme.surface),
                borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: [
                  if (widget.leadingIcon != null) ...[
                    Icon(
                      widget.leadingIcon,
                      size: 20,
                      color:
                          (uxColors?.onSurface ??
                                  materialTheme.colorScheme.onSurface)
                              .withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: widget.selectedOptionIds.isEmpty
                        ? Text(
                            widget.placeholder,
                            style: (textStyle ?? const TextStyle()).copyWith(
                              color:
                                  (uxColors?.onSurface ??
                                          materialTheme.colorScheme.onSurface)
                                      .withValues(alpha: 0.38),
                            ),
                          )
                        : (widget.mode == Ux4gDropdownMode.single
                              ? Text(
                                  widget.options
                                      .firstWhere(
                                        (o) =>
                                            o.id ==
                                            widget.selectedOptionIds.first,
                                      )
                                      .label,
                                  style: widget.valueTextStyle ?? textStyle,
                                )
                              : Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: widget.selectedOptionIds.map((id) {
                                    final opt = widget.options.firstWhere(
                                      (o) => o.id == id,
                                    );
                                    return Ux4gInputChip(
                                      text: opt.label,
                                      onDismiss: () => _handleSelection(id),
                                      leadingContent: opt.leadingIcon != null
                                          ? Icon(opt.leadingIcon, size: 14)
                                          : null,
                                    );
                                  }).toList(),
                                )),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color:
                        (uxColors?.onSurface ??
                                materialTheme.colorScheme.onSurface)
                            .withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.description != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                widget.status == Ux4gDropdownStatus.error
                    ? Icons.error_outline
                    : Icons.info_outline,
                size: 16,
                color: descriptionColor,
              ),
              const SizedBox(width: 4),
              Text(
                widget.description!,
                style:
                    (uxTypography?.lS_default ??
                            materialTheme.textTheme.labelSmall)
                        ?.copyWith(color: descriptionColor),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
