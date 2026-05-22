import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../foundation/typography.dart';
import 'buttons.dart';
import 'tag.dart';

/// Data model for detailed information items in the [Ux4gResultRow].
class Ux4gResultDetail {
  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;
  final bool isBold;

  const Ux4gResultDetail({
    required this.label,
    required this.value,
    this.icon,
    this.valueColor,
    this.isBold = false,
  });
}

/// A configurable expandable list item component for search results and application status.
class Ux4gResultRow extends StatefulWidget {
  final String title;
  final String? statusTag;
  final Ux4gTagColor tagColorScheme;
  final List<Ux4gPillSegment>? metadataSegments;
  final String? actionButtonText;
  final VoidCallback? onActionPressed;
  final IconData? actionButtonIcon;
  final Color? actionButtonColor;
  final List<Ux4gResultDetail> details;
  final Widget? expandedChild;
  final int detailsColumns;
  final bool initialExpanded;
  final ValueChanged<bool>? onToggle;
  final bool showBottomDivider;

  const Ux4gResultRow({
    super.key,
    required this.title,
    this.statusTag,
    this.tagColorScheme = Ux4gTagColor.neutral,
    this.metadataSegments,
    this.actionButtonText,
    this.onActionPressed,
    this.actionButtonIcon,
    this.actionButtonColor,
    this.details = const [],
    this.expandedChild,
    this.detailsColumns = 2,
    this.initialExpanded = false,
    this.onToggle,
    this.showBottomDivider = true,
  });

  @override
  State<Ux4gResultRow> createState() => _Ux4gResultRowState();
}

class _Ux4gResultRowState extends State<Ux4gResultRow>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initialExpanded;
  }

  void _handleToggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onToggle?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _handleToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Ux4gSpace.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Content: Title, Tag, Metadata
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: (ux4gTypography?.hM_strong ?? materialTheme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle()).copyWith(
                          color: ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface,
                        ),
                      ),
                      if (widget.statusTag != null) ...[
                        const SizedBox(height: Ux4gSpace.space8),
                        Ux4gTag(
                          text: widget.statusTag!,
                          colorScheme: widget.tagColorScheme,
                          shape: Ux4gTagShape.rectangular,
                          style: Ux4gTagStyle.tonal,
                        ),
                      ],
                      if (widget.metadataSegments != null &&
                          widget.metadataSegments!.isNotEmpty) ...[
                        const SizedBox(height: Ux4gSpace.space8),
                        Ux4gUnifiedPillTag(
                          segments: widget.metadataSegments!,
                          size: Ux4gTagSize.m,
                          backgroundColor: Colors.transparent,
                          borderColor: Colors.transparent,
                          dividerColor: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: Ux4gSpace.space16),

                // Right Content: Action Button, Expand Arrow
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.actionButtonText != null) ...[
                      Ux4gButton(
                        text: widget.actionButtonText!,
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.small,
                        contentColor: widget.actionButtonColor,
                        borderColor: widget.actionButtonColor,
                        leadingIcon: widget.actionButtonIcon,
                        onPressed: widget.onActionPressed ?? () {},
                      ),
                      const SizedBox(width: Ux4gSpace.space12),
                    ],
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Expanded Details
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(bottom: Ux4gSpace.space24),
                    child:
                        widget.expandedChild ??
                        Wrap(
                          runSpacing: Ux4gSpace.space20,
                          children: List.generate(widget.details.length, (
                            index,
                          ) {
                            final detail = widget.details[index];
                            final columnCount =
                                MediaQuery.of(context).size.width > 400
                                ? widget.detailsColumns
                                : 1;
                            return SizedBox(
                              width: columnCount > 1
                                  ? (MediaQuery.of(context).size.width -
                                            Ux4gSpace.space80) /
                                        columnCount
                                  : double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.label,
                                    style: (ux4gTypography?.bS_default ?? materialTheme.textTheme.bodySmall ?? const TextStyle()).copyWith(
                                      color: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Ux4gSpace.space4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (detail.icon != null) ...[
                                        Icon(
                                          detail.icon,
                                          size: 16,
                                          color:
                                              detail.valueColor ??
                                              (ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface),
                                        ),
                                        const SizedBox(width: Ux4gSpace.space4),
                                      ],
                                      Flexible(
                                        child: Text(
                                          detail.value,
                                          style:
                                              (detail.isBold
                                                      ? (ux4gTypography?.bM_strong ?? materialTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) ?? const TextStyle())
                                                      : (ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle()))
                                                  .copyWith(
                                                    color:
                                                        detail.valueColor ??
                                                        (ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface),
                                                  ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                  )
                : const SizedBox.shrink(),
          ),
        ),

        if (widget.showBottomDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.1),
          ),
      ],
    );
  }
}
