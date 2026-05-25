import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../foundation/dimensions.dart';

class Ux4gAccordion extends StatelessWidget {
  final String title;
  final bool expanded;
  final bool enabled;
  final ValueChanged<bool>? onExpandedChange;
  final Color? backgroundColor;
  final Color? contentBackgroundColor;
  final Color? collapsedBorderColor;
  final Color? expandedBorderColor;
  final Color? titleColor;
  final Color? disabledTitleColor;
  final Color? iconColor;
  final Color? disabledIconColor;
  final Widget child;

  const Ux4gAccordion({
    super.key,
    required this.title,
    required this.child,
    this.expanded = false,
    this.enabled = true,
    this.onExpandedChange,
    this.backgroundColor,
    this.contentBackgroundColor,
    this.collapsedBorderColor,
    this.expandedBorderColor,
    this.titleColor,
    this.disabledTitleColor,
    this.iconColor,
    this.disabledIconColor,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();
    
    final resolvedCollapsedBorderColor = collapsedBorderColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.12);
    final resolvedExpandedBorderColor = expandedBorderColor ?? (ux4gColors?.primary ?? materialTheme.colorScheme.primary);
    final resolvedTitleColor = titleColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface);
    final resolvedDisabledTitleColor = disabledTitleColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38);
    final resolvedIconColor = iconColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface);
    final resolvedDisabledIconColor = disabledIconColor ?? (ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface).withValues(alpha: 0.38);

    final borderColor = !enabled
        ? Colors.transparent
        : expanded
        ? resolvedExpandedBorderColor
        : resolvedCollapsedBorderColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: backgroundColor ?? (ux4gColors?.surface ?? materialTheme.colorScheme.surface),
          child: InkWell(
            onTap: enabled ? () => onExpandedChange?.call(!expanded) : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Ux4gSpace.space12,
                vertical: Ux4gSpace.space8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: enabled ? Ux4gBorderWidth.thin : Ux4gBorderWidth.none,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: (ux4gTypography?.lL_default ?? materialTheme.textTheme.labelLarge ?? const TextStyle()).copyWith(
                        color: enabled ? resolvedTitleColor : resolvedDisabledTitleColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: Ux4gSpace.space8),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: Ux4gSpace.space16,
                      color: enabled ? resolvedIconColor : resolvedDisabledIconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: expanded && enabled
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: Ux4gSpace.space12,
                      left: Ux4gSpace.space12,
                      right: Ux4gSpace.space12,
                    ),
                    color: contentBackgroundColor ?? (ux4gColors?.surface ?? materialTheme.colorScheme.surface),
                    child: child,
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

class Ux4gAccordionItem {
  final String title;
  final bool enabled;

  const Ux4gAccordionItem({required this.title, this.enabled = true});
}

class Ux4gAccordionGroup extends StatelessWidget {
  final List<Ux4gAccordionItem> items;
  final int? expandedIndex;
  final ValueChanged<int?>? onExpandedIndexChange;
  final double itemSpacing;
  final Widget Function(int index, Ux4gAccordionItem item) contentBuilder;

  const Ux4gAccordionGroup({
    super.key,
    required this.items,
    required this.contentBuilder,
    this.expandedIndex,
    this.onExpandedIndexChange,
    this.itemSpacing = Ux4gSpace.space20,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == items.length - 1 ? 0 : itemSpacing,
          ),
          child: Ux4gAccordion(
            title: item.title,
            expanded: expandedIndex == index,
            enabled: item.enabled,
            onExpandedChange: (isExpanded) {
              onExpandedIndexChange?.call(isExpanded ? index : null);
            },
            child: contentBuilder(index, item),
          ),
        );
      }),
    );
  }
}
