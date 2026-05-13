import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum Ux4gPaginationVariant { defaultVariant, capsule }

enum Ux4gPaginationSize {
  small(10, 8, 32),
  medium(12, 10, 40);

  final double dotSize;
  final double spacing;
  final double arrowSize;
  const Ux4gPaginationSize(this.dotSize, this.spacing, this.arrowSize);
}

class Ux4gPaginationIndicator extends StatelessWidget {
  final int totalPageCount;
  final int currentPageIndex;
  final ValueChanged<int> onPageChange;
  final bool showArrows;
  final Ux4gPaginationVariant variant;
  final Ux4gPaginationSize size;
  final bool enabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveBorderColor;

  const Ux4gPaginationIndicator({
    super.key,
    required this.totalPageCount,
    required this.currentPageIndex,
    required this.onPageChange,
    this.showArrows = true,
    this.variant = Ux4gPaginationVariant.defaultVariant,
    this.size = Ux4gPaginationSize.small,
    this.enabled = true,
    this.activeColor,
    this.inactiveColor,
    this.inactiveBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveInactiveColor = inactiveColor ?? colors.surface;
    final effectiveInactiveBorderColor =
        inactiveBorderColor ?? colors.onSurface.withValues(alpha: 0.3);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showArrows) ...[
          _buildArrow(
            context,
            Icons.chevron_left,
            enabled && currentPageIndex > 0,
            () => onPageChange(currentPageIndex - 1),
            effectiveActiveColor,
          ),
          SizedBox(width: size.spacing),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalPageCount, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index == totalPageCount - 1 ? 0 : size.spacing,
              ),
              child: _buildDot(
                context,
                index == currentPageIndex,
                () => onPageChange(index),
                effectiveActiveColor,
                effectiveInactiveColor,
                effectiveInactiveBorderColor,
              ),
            );
          }),
        ),
        if (showArrows) ...[
          SizedBox(width: size.spacing),
          _buildArrow(
            context,
            Icons.chevron_right,
            enabled && currentPageIndex < totalPageCount - 1,
            () => onPageChange(currentPageIndex + 1),
            effectiveActiveColor,
          ),
        ],
      ],
    );

    if (variant == Ux4gPaginationVariant.capsule) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: effectiveActiveColor.withValues(alpha: 0.12),
          ),
        ),
        child: content,
      );
    }

    return content;
  }

  Widget _buildDot(
    BuildContext context,
    bool isSelected,
    VoidCallback onClick,
    Color activeColor,
    Color inactiveColor,
    Color inactiveBorderColor,
  ) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: enabled ? onClick : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isSelected ? size.dotSize * 2.5 : size.dotSize,
          height: size.dotSize,
          decoration: BoxDecoration(
            color: isSelected
                ? (enabled ? activeColor : activeColor.withValues(alpha: 0.38))
                : inactiveColor,
            borderRadius: BorderRadius.circular(999),
            border: isSelected ? null : Border.all(color: inactiveBorderColor),
          ),
        ),
      ),
    );
  }

  Widget _buildArrow(
    BuildContext context,
    IconData icon,
    bool canClick,
    VoidCallback onClick,
    Color activeColor,
  ) {
    final colors = Ux4gTheme.colors(context);
    return MouseRegion(
      cursor: canClick ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: canClick ? onClick : null,
        child: Container(
          width: size.arrowSize,
          height: size.arrowSize,
          decoration: BoxDecoration(
            color: activeColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: size.arrowSize * 0.5,
            color: canClick ? activeColor : activeColor.withValues(alpha: 0.38),
          ),
        ),
      ),
    );
  }
}
