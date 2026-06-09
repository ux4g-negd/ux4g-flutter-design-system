import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

enum Ux4gStepperOrientation { horizontal, vertical }

enum Ux4gStepperLineStyle { solid, dashed }

class Ux4gStepItem {
  final String title;
  final String? description;
  final String? statusLabel;
  final bool isError;

  const Ux4gStepItem({
    required this.title,
    this.description,
    this.statusLabel,
    this.isError = false,
  });
}

class Ux4gStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // 1-indexed
  final Ux4gStepperOrientation orientation;
  final Ux4gStepperLineStyle lineStyle;
  final List<Ux4gStepItem> steps;

  const Ux4gStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.orientation = Ux4gStepperOrientation.horizontal,
    this.lineStyle = Ux4gStepperLineStyle.solid,
    this.steps = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == Ux4gStepperOrientation.horizontal) {
      return _buildHorizontalStepper(context);
    } else {
      return _buildVerticalStepper(context);
    }
  }

  Widget _buildHorizontalStepper(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(totalSteps, (index) {
            final stepIndex = index + 1;
            final isCompleted = currentStep > stepIndex;
            final isActive = currentStep == stepIndex;
            final isPending = currentStep < stepIndex;
            final stepData = steps.length > index ? steps[index] : null;

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: index == 0
                            ? const SizedBox()
                            : _buildLine(context, currentStep > index),
                      ),
                      _buildStepIcon(
                        context,
                        stepIndex,
                        isCompleted,
                        isActive,
                        isPending,
                        stepData?.isError ?? false,
                      ),
                      Expanded(
                        child: index == totalSteps - 1
                            ? const SizedBox()
                            : _buildLine(context, currentStep > stepIndex),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildLabels(
                      context,
                      stepData,
                      stepIndex,
                      isPending,
                      isCompleted,
                      isActive,
                      true,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildVerticalStepper(BuildContext context) {
    return Column(
      children: List.generate(totalSteps, (index) {
        final stepIndex = index + 1;
        final isCompleted = currentStep > stepIndex;
        final isActive = currentStep == stepIndex;
        final isPending = currentStep < stepIndex;
        final stepData = steps.length > index ? steps[index] : null;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildStepIcon(
                    context,
                    stepIndex,
                    isCompleted,
                    isActive,
                    isPending,
                    stepData?.isError ?? false,
                  ),
                  if (index < totalSteps - 1)
                    Expanded(
                      child: _buildLine(context, isCompleted, isVertical: true),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: index < totalSteps - 1 ? 24 : 0,
                  ),
                  child: _buildLabels(
                    context,
                    stepData,
                    stepIndex,
                    isPending,
                    isCompleted,
                    isActive,
                    false,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepIcon(
    BuildContext context,
    int index,
    bool isCompleted,
    bool isActive,
    bool isPending,
    bool isError,
  ) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary =
        ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;

    Color bgColor = Colors.transparent;
    Color borderColor = onSurface.withValues(alpha: 0.2);
    Widget content = Text(
      index.toString(),
      style: (ux4gTypography?.lM_default ?? materialTheme.textTheme.labelMedium)
          ?.copyWith(
            color: onSurface.withValues(alpha: 0.3),
            fontWeight: FontWeight.bold,
          ),
    );

    if (isError) {
      borderColor = error;
      content = Icon(Icons.error_outline, color: error, size: 20);
    } else if (isCompleted) {
      bgColor = primary;
      borderColor = primary;
      content = Icon(Icons.check, color: onPrimary, size: 20);
    } else if (isActive) {
      borderColor = primary;
      content = Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: (isActive || isPending || isError)
            ? Border.all(color: borderColor, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: content,
    );
  }

  Widget _buildLine(
    BuildContext context,
    bool isCompleted, {
    bool isVertical = false,
  }) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    final color = isCompleted ? primary : onSurface.withValues(alpha: 0.2);

    return CustomPaint(
      painter: _StepperLinePainter(
        color: color,
        style: lineStyle,
        isVertical: isVertical,
      ),
      child: isVertical
          ? const SizedBox(width: 2, height: double.infinity)
          : const SizedBox(height: 2, width: double.infinity),
    );
  }

  Widget _buildLabels(
    BuildContext context,
    Ux4gStepItem? data,
    int index,
    bool isPending,
    bool isCompleted,
    bool isActive,
    bool centered,
  ) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final success = ux4gColors?.success ?? Colors.green;

    final align = centered ? TextAlign.center : TextAlign.start;

    final titleColor = isPending
        ? onSurface.withValues(alpha: 0.4)
        : (data?.isError ?? false ? error : onSurface);
    final statusText =
        data?.statusLabel ??
        (data?.isError == true
            ? "Error"
            : (isCompleted ? "Completed" : (isActive ? "In progress" : null)));
    final statusColor = data?.isError == true
        ? error
        : (isCompleted
              ? success
              : (isActive ? primary : onSurface.withValues(alpha: 0.4)));

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          data?.title ?? "Step $index",
          style:
              (ux4gTypography?.lL_strong ??
                      materialTheme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ))
                  ?.copyWith(color: titleColor),
          textAlign: align,
        ),
        if (data?.description != null)
          Text(
            data!.description!,
            style:
                (ux4gTypography?.lM_default ??
                        materialTheme.textTheme.labelMedium)
                    ?.copyWith(color: onSurface.withValues(alpha: 0.4)),
            textAlign: align,
          ),
        if (statusText != null)
          Text(
            statusText,
            style:
                (ux4gTypography?.lS_strong ??
                        materialTheme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ))
                    ?.copyWith(color: statusColor),
            textAlign: align,
          ),
      ],
    );
  }
}

class _StepperLinePainter extends CustomPainter {
  final Color color;
  final Ux4gStepperLineStyle style;
  final bool isVertical;

  _StepperLinePainter({
    required this.color,
    required this.style,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (style == Ux4gStepperLineStyle.dashed) {
      double dashWidth = 8, dashSpace = 4, current = 0;
      if (isVertical) {
        while (current < size.height) {
          canvas.drawLine(
            Offset(size.width / 2, current),
            Offset(size.width / 2, current + dashWidth),
            paint,
          );
          current += dashWidth + dashSpace;
        }
      } else {
        while (current < size.width) {
          canvas.drawLine(
            Offset(current, size.height / 2),
            Offset(current + dashWidth, size.height / 2),
            paint,
          );
          current += dashWidth + dashSpace;
        }
      }
    } else {
      if (isVertical) {
        canvas.drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(0, size.height / 2),
          Offset(size.width, size.height / 2),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
