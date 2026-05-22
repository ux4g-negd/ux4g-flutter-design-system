import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';
import 'tag.dart';

// ─── Step State ─────────────────────────────────────────────────────────────

/// State of a journey step.
enum Ux4gJourneyStepState {
  /// Completed step — filled circle with check icon, primary colored line.
  completed,

  /// Current/active step — outlined filled circle, primary colored.
  current,

  /// Upcoming step — gray outlined circle, gray line.
  upcoming,
}

// ─── Step Card Content ──────────────────────────────────────────────────────

/// Optional status indicator shown inside a step card.
class Ux4gJourneyStepStatus {
  /// Status text (e.g., "2 days remaining").
  final String text;

  /// Color of the status dot.
  final Color? dotColor;

  /// Optional badge/tag text (e.g., "Pending").
  final String? badgeText;

  /// Badge background color.
  final Color? badgeColor;

  /// Badge text color.
  final Color? badgeTextColor;

  const Ux4gJourneyStepStatus({
    required this.text,
    this.dotColor,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
  });
}

/// Data model for a single step in the journey timeline.
class Ux4gJourneyStep {
  /// State of this step (completed, current, upcoming).
  final Ux4gJourneyStepState state;

  /// Date text shown at the top-left of the card.
  final String? date;

  /// Tag text shown at the top-right of the card.
  final String? tag;

  /// Title text.
  final String title;

  /// Optional helping/description text below the title.
  final String? helpingText;

  /// Optional icon below the title (e.g., link icon).
  final IconData? icon;

  /// Optional icon color.
  final Color? iconColor;

  /// Optional status indicator with dot + badge.
  final Ux4gJourneyStepStatus? status;

  /// Optional custom content widget below the title area.
  final Widget? customContent;

  const Ux4gJourneyStep({
    this.state = Ux4gJourneyStepState.upcoming,
    this.date,
    this.tag,
    required this.title,
    this.helpingText,
    this.icon,
    this.iconColor,
    this.status,
    this.customContent,
  });
}

// ─── Journey Timeline Header ────────────────────────────────────────────────

/// Header data for the journey timeline.
class Ux4gJourneyHeader {
  /// Title text.
  final String title;

  /// Description text below the title.
  final String? description;

  /// Optional trailing icon.
  final IconData? icon;

  /// Callback when trailing icon is tapped.
  final VoidCallback? onIconPressed;

  const Ux4gJourneyHeader({
    required this.title,
    this.description,
    this.icon,
    this.onIconPressed,
  });
}

// ─── Main Component ─────────────────────────────────────────────────────────

/// Orientation for the journey timeline.
enum Ux4gJourneyOrientation { vertical, horizontal }

/// A journey timeline component that displays steps in a vertical or horizontal timeline.
///
/// Each step shows a circle indicator connected by lines, with a card
/// containing date, tag, title, and optional content.
///
/// Fully dynamic: user can set any number of steps, current state,
/// and customize card content per step.
class Ux4gJourneyTimeline extends StatelessWidget {
  /// List of journey steps.
  final List<Ux4gJourneyStep> steps;

  /// Optional header above the timeline.
  final Ux4gJourneyHeader? header;

  /// Current step index (0-based). Steps before this are completed,
  /// this index is current, and after are upcoming.
  /// If null, uses each step's individual [state].
  final int? currentStep;

  /// Timeline orientation.
  final Ux4gJourneyOrientation orientation;

  /// Size of the step indicator circle.
  final double indicatorSize;

  /// Width of the connecting line.
  final double lineWidth;

  /// Spacing between the indicator and the card.
  final double indicatorCardSpacing;

  /// Vertical spacing between step cards (vertical) or horizontal spacing (horizontal).
  final double stepSpacing;

  /// Color for completed/current indicators and lines.
  final Color? activeColor;

  /// Color for upcoming indicators and lines.
  final Color? inactiveColor;

  /// Card border radius.
  final double cardBorderRadius;

  /// Card padding.
  final EdgeInsetsGeometry? cardPadding;

  /// Card background color.
  final Color? cardColor;

  /// Card border color.
  final Color? cardBorderColor;

  const Ux4gJourneyTimeline({
    super.key,
    required this.steps,
    this.header,
    this.currentStep,
    this.orientation = Ux4gJourneyOrientation.vertical,
    this.indicatorSize = 20,
    this.lineWidth = 3,
    this.indicatorCardSpacing = Ux4gSpace.space12,
    this.stepSpacing = Ux4gSpace.space12,
    this.activeColor,
    this.inactiveColor,
    this.cardBorderRadius = Ux4gRadius.radius8,
    this.cardPadding,
    this.cardColor,
    this.cardBorderColor,
  });

  Ux4gJourneyStepState _resolveState(int index) {
    if (currentStep != null) {
      if (index < currentStep!) return Ux4gJourneyStepState.completed;
      if (index == currentStep!) return Ux4gJourneyStepState.current;
      return Ux4gJourneyStepState.upcoming;
    }
    return steps[index].state;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final resolvedActiveColor = activeColor ?? colors.primary;
    final resolvedInactiveColor =
        inactiveColor ?? colors.onSurface.withValues(alpha: 0.25);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        if (header != null) ...[
          _JourneyHeaderWidget(
            header: header!,
            typography: typography,
            colors: colors,
          ),
          const SizedBox(height: Ux4gSpace.space16),
        ],

        // Orientation
        if (orientation == Ux4gJourneyOrientation.vertical)
          _buildVertical(
            resolvedActiveColor,
            resolvedInactiveColor,
            typography,
            colors,
          )
        else
          _buildHorizontal(
            resolvedActiveColor,
            resolvedInactiveColor,
            typography,
            colors,
          ),
      ],
    );
  }

  Widget _buildVertical(
    Color activeColor,
    Color inactiveColor,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < steps.length; i++)
          _JourneyStepRow(
            step: steps[i],
            state: _resolveState(i),
            isFirst: i == 0,
            isLast: i == steps.length - 1,
            nextState: i < steps.length - 1 ? _resolveState(i + 1) : null,
            indicatorSize: indicatorSize,
            lineWidth: lineWidth,
            indicatorCardSpacing: indicatorCardSpacing,
            stepSpacing: i < steps.length - 1 ? stepSpacing : 0,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            cardBorderRadius: cardBorderRadius,
            cardPadding: cardPadding,
            cardColor: cardColor,
            cardBorderColor: cardBorderColor,
            typography: typography,
            colors: colors,
          ),
      ],
    );
  }

  Widget _buildHorizontal(
    Color activeColor,
    Color inactiveColor,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    final activeIndex =
        currentStep ??
        steps.indexWhere((s) => s.state == Ux4gJourneyStepState.current);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Horizontal stepper row
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              _StepIndicator(
                state: _resolveState(i),
                size: indicatorSize,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              if (i < steps.length - 1) ...[
                SizedBox(width: stepSpacing * 0.5),
                Expanded(
                  child: Container(
                    height: lineWidth,
                    color: _resolveState(i) == Ux4gJourneyStepState.completed
                        ? activeColor
                        : inactiveColor,
                  ),
                ),
                SizedBox(width: stepSpacing * 0.5),
              ],
            ],
          ],
        ),

        // Card below the active step
        if (activeIndex >= 0 && activeIndex < steps.length) ...[
          SizedBox(height: indicatorCardSpacing),
          _JourneyStepCard(
            step: steps[activeIndex],
            state: _resolveState(activeIndex),
            borderRadius: cardBorderRadius,
            padding: cardPadding,
            cardColor: cardColor,
            cardBorderColor: cardBorderColor,
            typography: typography,
            colors: colors,
          ),
        ],
      ],
    );
  }
}

// ─── Header Widget ──────────────────────────────────────────────────────────

class _JourneyHeaderWidget extends StatelessWidget {
  final Ux4gJourneyHeader header;
  final Ux4gTypography typography;
  final Ux4gColors colors;

  const _JourneyHeaderWidget({
    required this.header,
    required this.typography,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    header.title,
                    style: typography.tS_strong.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                  if (header.icon != null) ...[
                    const SizedBox(width: Ux4gSpace.space8),
                    GestureDetector(
                      onTap: header.onIconPressed,
                      child: Icon(
                        header.icon,
                        size: 20,
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
              if (header.description != null) ...[
                const SizedBox(height: Ux4gSpace.space4),
                Text(
                  header.description!,
                  style: typography.bS_default.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Step Row ───────────────────────────────────────────────────────────────

class _JourneyStepRow extends StatelessWidget {
  final Ux4gJourneyStep step;
  final Ux4gJourneyStepState state;
  final bool isFirst;
  final bool isLast;
  final Ux4gJourneyStepState? nextState;
  final double indicatorSize;
  final double lineWidth;
  final double indicatorCardSpacing;
  final double stepSpacing;
  final Color activeColor;
  final Color inactiveColor;
  final double cardBorderRadius;
  final EdgeInsetsGeometry? cardPadding;
  final Color? cardColor;
  final Color? cardBorderColor;
  final Ux4gTypography typography;
  final Ux4gColors colors;

  const _JourneyStepRow({
    required this.step,
    required this.state,
    required this.isFirst,
    required this.isLast,
    required this.nextState,
    required this.indicatorSize,
    required this.lineWidth,
    required this.indicatorCardSpacing,
    required this.stepSpacing,
    required this.activeColor,
    required this.inactiveColor,
    required this.cardBorderRadius,
    required this.cardPadding,
    required this.cardColor,
    required this.cardBorderColor,
    required this.typography,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Indicator column (top line + circle + bottom line)
          SizedBox(
            width: indicatorSize,
            child: Column(
              children: [
                // Top line (connects to previous step)
                if (!isFirst)
                  Expanded(
                    child: Container(width: lineWidth, color: _topLineColor()),
                  )
                else
                  const Expanded(child: SizedBox()),

                // Circle indicator (centered)
                _StepIndicator(
                  state: state,
                  size: indicatorSize,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                ),

                // Bottom line (connects to next step)
                if (!isLast)
                  Expanded(
                    child: Container(width: lineWidth, color: _lineColor()),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),

          SizedBox(width: indicatorCardSpacing),

          // Card + bottom spacing
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: stepSpacing),
              child: _JourneyStepCard(
                step: step,
                state: state,
                borderRadius: cardBorderRadius,
                padding: cardPadding,
                cardColor: cardColor,
                cardBorderColor: cardBorderColor,
                typography: typography,
                colors: colors,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _topLineColor() {
    // Top line: colored if previous step was completed
    if (state == Ux4gJourneyStepState.completed ||
        state == Ux4gJourneyStepState.current) {
      return activeColor;
    }
    return inactiveColor;
  }

  Color _lineColor() {
    // Line below: colored if current step is completed or current
    if (state == Ux4gJourneyStepState.completed) return activeColor;
    return inactiveColor;
  }
}

// ─── Step Indicator ─────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final Ux4gJourneyStepState state;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const _StepIndicator({
    required this.state,
    required this.size,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    switch (state) {
      case Ux4gJourneyStepState.completed:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
          child: Icon(Icons.check, size: size * 0.6, color: colors.surface),
        );

      case Ux4gJourneyStepState.current:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: activeColor, width: 2.5),
          ),
          child: Center(
            child: Container(
              width: size * 0.45,
              height: size * 0.45,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );

      case Ux4gJourneyStepState.upcoming:
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: inactiveColor, width: 1.5),
          ),
        );
    }
  }
}

// ─── Step Card ──────────────────────────────────────────────────────────────

class _JourneyStepCard extends StatelessWidget {
  final Ux4gJourneyStep step;
  final Ux4gJourneyStepState state;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? cardColor;
  final Color? cardBorderColor;
  final Ux4gTypography typography;
  final Ux4gColors colors;

  const _JourneyStepCard({
    required this.step,
    required this.state,
    required this.borderRadius,
    required this.padding,
    required this.cardColor,
    required this.cardBorderColor,
    required this.typography,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isUpcoming = state == Ux4gJourneyStepState.upcoming;
    final textOpacity = isUpcoming ? 0.5 : 1.0;

    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: Ux4gSpace.space16,
            vertical: Ux4gSpace.space12,
          ),
      decoration: BoxDecoration(
        color: cardColor ?? colors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: cardBorderColor ?? colors.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Date + Tag row
          if (step.date != null || step.tag != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (step.date != null)
                  Text(
                    step.date!,
                    style: typography.bXS_default.copyWith(
                      color: colors.onSurface.withValues(
                        alpha: isUpcoming ? 0.4 : 0.6,
                      ),
                    ),
                  ),
                if (step.tag != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Ux4gSpace.space8,
                      vertical: Ux4gSpace.space2,
                    ),
                    decoration: BoxDecoration(
                      color: colors.onSurface.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(Ux4gRadius.radius4),
                    ),
                    child: Text(
                      step.tag!,
                      style: typography.bXS_default.copyWith(
                        color: colors.onSurface.withValues(
                          alpha: isUpcoming ? 0.4 : 0.6,
                        ),
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),

          // Title
          if (step.date != null || step.tag != null)
            const SizedBox(height: Ux4gSpace.space6),
          Text(
            step.title,
            style: typography.tS_strong.copyWith(
              color: colors.onSurface.withValues(alpha: textOpacity),
              fontSize: 14,
            ),
          ),

          // Helping text
          if (step.helpingText != null) ...[
            const SizedBox(height: Ux4gSpace.space4),
            Text(
              step.helpingText!,
              style: typography.bXS_default.copyWith(
                color: colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],

          // Icon
          if (step.icon != null) ...[
            const SizedBox(height: Ux4gSpace.space6),
            Icon(
              step.icon,
              size: 18,
              color:
                  step.iconColor ??
                  colors.primary.withValues(alpha: isUpcoming ? 0.4 : 1.0),
            ),
          ],

          // Status indicator
          if (step.status != null) ...[
            const SizedBox(height: Ux4gSpace.space8),
            Ux4gUnifiedPillTag(
              size: Ux4gTagSize.l,
              customBorderRadius: BorderRadius.circular(Ux4gRadius.radius8),
              segments: [
                Ux4gPillSegment(
                  text: step.status!.text,
                  leading: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: step.status!.dotColor ?? colors.warning,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                if (step.status!.badgeText != null)
                  Ux4gPillSegment(
                    text: step.status!.badgeText!,
                    bold: true,
                    textColor:
                        step.status!.badgeTextColor ?? colors.warning,
                  ),
              ],
            ),
          ],

          // Custom content
          if (step.customContent != null) ...[
            const SizedBox(height: Ux4gSpace.space8),
            step.customContent!,
          ],
        ],
      ),
    );
  }
}
