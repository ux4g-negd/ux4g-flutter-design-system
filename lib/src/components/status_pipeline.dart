import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';

// ─── Enums ──────────────────────────────────────────────────────────────────

/// Orientation of the status pipeline.
enum Ux4gPipelineOrientation { vertical, horizontal }

/// State of a pipeline step.
enum Ux4gPipelineStepState {
  /// Completed step — green circle with check icon.
  completed,

  /// Current/active step — blue circle with inner ring.
  current,

  /// Upcoming step — gray circle with step number.
  upcoming,

  /// Error/failed step — red circle with exclamation icon.
  error,

  /// Warning step — orange circle with warning icon.
  warning,
}

/// Size presets for the pipeline.
enum Ux4gPipelineSize {
  /// Small — 20px circle, 2px line.
  s,

  /// Medium — 32px circle, 3px line.
  m,

  /// Large — 40px circle, 3px line.
  l,
}

// ─── Step Model ─────────────────────────────────────────────────────────────

/// Data model for a single pipeline step.
class Ux4gPipelineStep {
  /// Label text (e.g., "Submitted", "Verification").
  final String? label;

  /// Description text (e.g., "5 Apr", "In progress").
  final String? description;

  /// Step state — controls icon, color, and line style.
  final Ux4gPipelineStepState state;

  /// Custom icon widget to display inside the circle (overrides default).
  final Widget? customIcon;

  /// Custom color for the step circle (overrides state color).
  final Color? customColor;

  const Ux4gPipelineStep({
    this.label,
    this.description,
    this.state = Ux4gPipelineStepState.upcoming,
    this.customIcon,
    this.customColor,
  });
}

// ─── Status Pipeline ────────────────────────────────────────────────────────

/// A status pipeline component that displays steps connected by lines.
///
/// Supports both vertical and horizontal orientations. Each step can be in a
/// different state (completed, current, upcoming, error, warning) which
/// controls its appearance automatically.
///
/// ```dart
/// Ux4gStatusPipeline(
///   orientation: Ux4gPipelineOrientation.vertical,
///   size: Ux4gPipelineSize.m,
///   currentStep: 1,
///   steps: [
///     Ux4gPipelineStep(label: 'Submitted', description: '5 Apr'),
///     Ux4gPipelineStep(label: 'Verification', description: 'In progress'),
///     Ux4gPipelineStep(label: 'Inspection', description: 'Est. 10 Apr'),
///     Ux4gPipelineStep(label: 'Decision', description: 'Est. 18 Apr'),
///     Ux4gPipelineStep(label: 'Issued', description: 'Est. 20 Apr'),
///   ],
/// )
/// ```
class Ux4gStatusPipeline extends StatelessWidget {
  /// Steps to display.
  final List<Ux4gPipelineStep> steps;

  /// Current active step index (0-based). Steps before this are completed,
  /// the step at this index is current, steps after are upcoming.
  /// Set to -1 to rely purely on each step's individual [state].
  final int currentStep;

  /// Orientation — vertical or horizontal.
  final Ux4gPipelineOrientation orientation;

  /// Size preset.
  final Ux4gPipelineSize size;

  /// Whether to show labels.
  final bool showLabels;

  /// Whether to show descriptions.
  final bool showDescriptions;

  /// Thickness of completed/active lines (overrides default).
  final double? activeLineWidth;

  /// Thickness of upcoming lines (overrides default).
  final double? inactiveLineWidth;

  /// Color for completed steps and lines (overrides default green).
  final Color? completedColor;

  /// Color for current step (overrides default primary/blue).
  final Color? currentColor;

  /// Color for upcoming steps and lines (overrides default gray).
  final Color? upcomingColor;

  /// Color for error steps (overrides default red).
  final Color? errorColor;

  /// Color for warning steps (overrides default orange).
  final Color? warningColor;

  /// Custom line color for completed segments.
  final Color? completedLineColor;

  /// Custom line color for upcoming segments.
  final Color? upcomingLineColor;

  /// Spacing between step indicator and label text.
  final double? labelSpacing;

  /// Custom circle size override.
  final double? circleSize;

  const Ux4gStatusPipeline({
    super.key,
    required this.steps,
    this.currentStep = 0,
    this.orientation = Ux4gPipelineOrientation.vertical,
    this.size = Ux4gPipelineSize.m,
    this.showLabels = true,
    this.showDescriptions = true,
    this.activeLineWidth,
    this.inactiveLineWidth,
    this.completedColor,
    this.currentColor,
    this.upcomingColor,
    this.errorColor,
    this.warningColor,
    this.completedLineColor,
    this.upcomingLineColor,
    this.labelSpacing,
    this.circleSize,
  });

  // ── Resolved sizes ──

  double get _circleSize {
    if (circleSize != null) return circleSize!;
    return switch (size) {
      Ux4gPipelineSize.s => 20.0,
      Ux4gPipelineSize.m => 32.0,
      Ux4gPipelineSize.l => 40.0,
    };
  }

  double get _activeLineW {
    if (activeLineWidth != null) return activeLineWidth!;
    return switch (size) {
      Ux4gPipelineSize.s => 2.0,
      Ux4gPipelineSize.m => 3.0,
      Ux4gPipelineSize.l => 3.0,
    };
  }

  double get _inactiveLineW {
    if (inactiveLineWidth != null) return inactiveLineWidth!;
    return switch (size) {
      Ux4gPipelineSize.s => 1.0,
      Ux4gPipelineSize.m => 2.0,
      Ux4gPipelineSize.l => 2.0,
    };
  }

  double get _iconSize {
    return switch (size) {
      Ux4gPipelineSize.s => 12.0,
      Ux4gPipelineSize.m => 18.0,
      Ux4gPipelineSize.l => 22.0,
    };
  }

  double get _fontSize {
    return switch (size) {
      Ux4gPipelineSize.s => 10.0,
      Ux4gPipelineSize.m => 12.0,
      Ux4gPipelineSize.l => 14.0,
    };
  }

  // ── Resolve step state from currentStep index ──

  Ux4gPipelineStepState _resolveState(int index) {
    final step = steps[index];
    // If currentStep is -1, use individual step states
    if (currentStep < 0) return step.state;

    // If step has explicit error/warning, keep it
    if (step.state == Ux4gPipelineStepState.error ||
        step.state == Ux4gPipelineStepState.warning) {
      return step.state;
    }

    if (index < currentStep) return Ux4gPipelineStepState.completed;
    if (index == currentStep) return Ux4gPipelineStepState.current;
    return Ux4gPipelineStepState.upcoming;
  }

  // ── State colors ──

  Color _stepColor(Ux4gPipelineStepState state, Ux4gColors colors) {
    return switch (state) {
      Ux4gPipelineStepState.completed => completedColor ?? colors.success,
      Ux4gPipelineStepState.current => currentColor ?? colors.primary,
      Ux4gPipelineStepState.upcoming =>
        upcomingColor ?? colors.onSurface.withValues(alpha: 0.3),
      Ux4gPipelineStepState.error => errorColor ?? colors.error,
      Ux4gPipelineStepState.warning => warningColor ?? colors.warning,
    };
  }

  Color _lineColor(Ux4gPipelineStepState fromState, Ux4gColors colors) {
    final isActive = fromState == Ux4gPipelineStepState.completed;
    if (isActive) return completedLineColor ?? colors.success;
    return upcomingLineColor ?? colors.onSurface.withValues(alpha: 0.15);
  }

  double _lineWidth(Ux4gPipelineStepState fromState) {
    final isActive = fromState == Ux4gPipelineStepState.completed;
    return isActive ? _activeLineW : _inactiveLineW;
  }

  @override
  Widget build(BuildContext context) {
    if (orientation == Ux4gPipelineOrientation.vertical) {
      return _buildVertical(context);
    }
    return _buildHorizontal(context);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // VERTICAL
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildVertical(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++)
          _buildVerticalStep(i, colors, typography),
      ],
    );
  }

  Widget _buildVerticalStep(
    int index,
    Ux4gColors colors,
    Ux4gTypography typography,
  ) {
    final step = steps[index];
    final state = _resolveState(index);
    final isLast = index == steps.length - 1;
    final hasLabel = showLabels && step.label != null;
    final hasDesc = showDescriptions && step.description != null;
    final spacing = labelSpacing ?? Ux4gSpace.space12;

    // Line height — taller when there's text
    final lineSegmentHeight = (hasLabel || hasDesc) ? 28.0 : 24.0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Indicator column (circle + line) ──
          SizedBox(
            width: _circleSize,
            child: Column(
              children: [
                _StepCircle(
                  state: state,
                  index: index,
                  size: _circleSize,
                  iconSize: _iconSize,
                  fontSize: _fontSize,
                  color: step.customColor ?? _stepColor(state, colors),
                  customIcon: step.customIcon,
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: Container(
                        width: _lineWidth(state),
                        constraints: BoxConstraints(
                          minHeight: lineSegmentHeight,
                        ),
                        color: _lineColor(state, colors),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ── Label + description ──
          if (hasLabel || hasDesc) ...[
            SizedBox(width: spacing),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : Ux4gSpace.space4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Center label with circle
                    if (hasLabel)
                      SizedBox(
                        height: _circleSize,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            step.label!,
                            style: _labelStyle(state, typography, colors),
                          ),
                        ),
                      ),
                    if (hasDesc) ...[
                      const SizedBox(height: Ux4gSpace.space2),
                      Text(
                        step.description!,
                        style: _descStyle(state, typography, colors),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // HORIZONTAL
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildHorizontal(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Row of circles + lines ──
        Row(
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              _StepCircle(
                state: _resolveState(i),
                index: i,
                size: _circleSize,
                iconSize: _iconSize,
                fontSize: _fontSize,
                color:
                    steps[i].customColor ??
                    _stepColor(_resolveState(i), colors),
                customIcon: steps[i].customIcon,
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: _lineWidth(_resolveState(i)),
                    color: _lineColor(_resolveState(i), colors),
                  ),
                ),
            ],
          ],
        ),

        // ── Labels row ──
        if (showLabels && steps.any((s) => s.label != null)) ...[
          SizedBox(height: labelSpacing ?? Ux4gSpace.space8),
          Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                SizedBox(
                  width: _circleSize,
                  child: steps[i].label != null
                      ? Text(
                          steps[i].label!,
                          style: _labelStyle(
                            _resolveState(i),
                            typography,
                            colors,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )
                      : const SizedBox.shrink(),
                ),
                if (i < steps.length - 1) const Expanded(child: SizedBox()),
              ],
            ],
          ),
        ],

        // ── Descriptions row ──
        if (showDescriptions && steps.any((s) => s.description != null)) ...[
          const SizedBox(height: Ux4gSpace.space2),
          Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                SizedBox(
                  width: _circleSize,
                  child: steps[i].description != null
                      ? Text(
                          steps[i].description!,
                          style: _descStyle(
                            _resolveState(i),
                            typography,
                            colors,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )
                      : const SizedBox.shrink(),
                ),
                if (i < steps.length - 1) const Expanded(child: SizedBox()),
              ],
            ],
          ),
        ],
      ],
    );
  }

  // ── Text styles ──

  TextStyle _labelStyle(
    Ux4gPipelineStepState state,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    final isActive =
        state == Ux4gPipelineStepState.completed ||
        state == Ux4gPipelineStepState.current;
    final baseStyle = size == Ux4gPipelineSize.s
        ? typography.bXS_strong
        : size == Ux4gPipelineSize.m
        ? typography.bS_strong
        : typography.bM_strong;
    return baseStyle.copyWith(
      color: isActive
          ? colors.onSurface
          : colors.onSurface.withValues(alpha: 0.45),
    );
  }

  TextStyle _descStyle(
    Ux4gPipelineStepState state,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    final isActive =
        state == Ux4gPipelineStepState.completed ||
        state == Ux4gPipelineStepState.current;
    final baseStyle = size == Ux4gPipelineSize.s
        ? typography.bXS_default
        : size == Ux4gPipelineSize.m
        ? typography.bXS_default
        : typography.bS_default;
    return baseStyle.copyWith(
      color: isActive
          ? colors.onSurface.withValues(alpha: 0.6)
          : colors.onSurface.withValues(alpha: 0.35),
    );
  }
}

// ─── Step Circle Widget ─────────────────────────────────────────────────────

class _StepCircle extends StatelessWidget {
  final Ux4gPipelineStepState state;
  final int index;
  final double size;
  final double iconSize;
  final double fontSize;
  final Color color;
  final Widget? customIcon;

  const _StepCircle({
    required this.state,
    required this.index,
    required this.size,
    required this.iconSize,
    required this.fontSize,
    required this.color,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);

    if (customIcon != null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: customIcon!),
      );
    }

    return switch (state) {
      Ux4gPipelineStepState.completed => _buildFilled(
        Icons.check,
        color,
        colors.onSuccess,
      ),
      Ux4gPipelineStepState.current => _buildCurrent(color, colors.surface),
      Ux4gPipelineStepState.upcoming => _buildUpcoming(color),
      Ux4gPipelineStepState.error => _buildOutlined(color),
      Ux4gPipelineStepState.warning => _buildOutlined(color),
    };
  }

  /// Filled circle with icon (completed).
  Widget _buildFilled(IconData icon, Color bg, Color fg) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Center(
        child: Icon(icon, size: iconSize, color: fg),
      ),
    );
  }

  /// Current step — thick colored ring with surface-colored center.
  Widget _buildCurrent(Color activeColor, Color surfaceColor) {
    final innerSize = size * 0.55;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            color: surfaceColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  /// Upcoming step — outlined circle with number.
  Widget _buildUpcoming(Color borderColor) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: borderColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
    );
  }

  /// Error/warning — outlined circle with step number.
  Widget _buildOutlined(Color outlineColor) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: outlineColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: outlineColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
    );
  }
}
