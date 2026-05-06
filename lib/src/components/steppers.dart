import 'package:flutter/material.dart';

import '../foundation/colors.dart';
import '../foundation/icons.dart';
import '../theme/theme.dart';

enum StepperOrientation { horizontal, vertical }

enum StepperLineStyle { solid, dashed }

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
  final int currentStep;
  final StepperOrientation orientation;
  final StepperLineStyle lineStyle;
  final List<Ux4gStepItem> steps;

  const Ux4gStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.orientation = StepperOrientation.horizontal,
    this.lineStyle = StepperLineStyle.solid,
    this.steps = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == StepperOrientation.horizontal) {
      return _HorizontalStepper(
        totalSteps: totalSteps,
        currentStep: currentStep,
        lineStyle: lineStyle,
        steps: steps,
      );
    }

    return _VerticalStepper(
      totalSteps: totalSteps,
      currentStep: currentStep,
      lineStyle: lineStyle,
      steps: steps,
    );
  }
}

class _HorizontalStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final StepperLineStyle lineStyle;
  final List<Ux4gStepItem> steps;

  const _HorizontalStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.lineStyle,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(totalSteps, (i) {
              return Expanded(
                child: Row(
                  children: [
                    if (i == 0)
                      const Expanded(child: SizedBox())
                    else
                      Expanded(
                        child: _StepperLine(
                          isCompleted: currentStep > i,
                          orientation: StepperOrientation.horizontal,
                          lineStyle: lineStyle,
                        ),
                      ),
                    const SizedBox(width: 32),
                    if (i == totalSteps - 1)
                      const Expanded(child: SizedBox())
                    else
                      Expanded(
                        child: _StepperLine(
                          isCompleted: currentStep > i + 1,
                          orientation: StepperOrientation.horizontal,
                          lineStyle: lineStyle,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(totalSteps, (i) {
            final stepIndex = i + 1;
            final isCompleted = currentStep > stepIndex;
            final isActive = currentStep == stepIndex;
            final isPending = currentStep < stepIndex;
            final stepData = i < steps.length ? steps[i] : null;

            return Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: Center(
                      child: _StepIcon(
                        stepIndex: stepIndex,
                        isCompleted: isCompleted,
                        isActive: isActive,
                        isPending: isPending,
                        isError: stepData?.isError ?? false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _StepLabels(
                      title: stepData?.title ?? 'Step $stepIndex',
                      description: stepData?.description,
                      statusLabel: stepData?.statusLabel,
                      isCompleted: isCompleted,
                      isActive: isActive,
                      isPending: isPending,
                      isError: stepData?.isError ?? false,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _VerticalStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final StepperLineStyle lineStyle;
  final List<Ux4gStepItem> steps;

  const _VerticalStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.lineStyle,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(totalSteps, (i) {
        final stepIndex = i + 1;
        final isCompleted = currentStep > stepIndex;
        final isActive = currentStep == stepIndex;
        final isPending = currentStep < stepIndex;
        final stepData = i < steps.length ? steps[i] : null;

        return IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _StepIcon(
                      stepIndex: stepIndex,
                      isCompleted: isCompleted,
                      isActive: isActive,
                      isPending: isPending,
                      isError: stepData?.isError ?? false,
                    ),
                    if (i < totalSteps - 1)
                      Expanded(
                        child: _StepperLine(
                          isCompleted: isCompleted,
                          orientation: StepperOrientation.vertical,
                          lineStyle: lineStyle,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    bottom: i < totalSteps - 1 ? 24 : 0,
                  ),
                  child: _StepLabels(
                    title: stepData?.title ?? 'Step $stepIndex',
                    description: stepData?.description,
                    statusLabel: stepData?.statusLabel,
                    isCompleted: isCompleted,
                    isActive: isActive,
                    isPending: isPending,
                    isError: stepData?.isError ?? false,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _StepIcon extends StatelessWidget {
  final int stepIndex;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isError;

  const _StepIcon({
    required this.stepIndex,
    required this.isCompleted,
    required this.isActive,
    required this.isPending,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final backgroundColor = isError
        ? Colors.transparent
        : isCompleted
        ? colors.primary
        : Colors.transparent;
    final borderColor = isError
        ? colors.error
        : isCompleted || isActive
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.2);

    Widget child;
    if (isError) {
      child = Icon(Ux4gIcons.error, size: 20, color: colors.error);
    } else if (isCompleted) {
      child = const Icon(Ux4gIcons.check, size: 20, color: Colors.white);
    } else if (isActive) {
      child = Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: colors.primary,
          shape: BoxShape.circle,
        ),
      );
    } else {
      child = Text(
        '$stepIndex',
        style: typography.lM_default.copyWith(
          color: colors.onSurface.withValues(alpha: 0.3),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: backgroundColor),
      duration: const Duration(milliseconds: 300),
      builder: (context, animatedBackground, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: animatedBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: isActive || isPending ? 2 : 0,
            ),
          ),
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}

class _StepLabels extends StatelessWidget {
  final String title;
  final String? description;
  final String? statusLabel;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isError;
  final TextAlign textAlign;

  const _StepLabels({
    required this.title,
    this.description,
    this.statusLabel,
    required this.isCompleted,
    required this.isActive,
    required this.isPending,
    required this.isError,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final titleColor = isError
        ? colors.error
        : isPending
        ? colors.onSurface.withValues(alpha: 0.4)
        : colors.onSurface;
    final resolvedDescriptionColor = isError
        ? Ux4gPalette.red400
        : colors.onSurface.withValues(alpha: 0.4);
    final resolvedStatus =
        statusLabel ??
        (isError
            ? 'Error'
            : isCompleted
            ? 'Completed'
            : isActive
            ? 'In progress'
            : null);
    final statusColor = isError
        ? colors.error
        : isCompleted
        ? Ux4gPalette.green
        : isActive
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.4);

    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: typography.lL_strong.copyWith(color: titleColor),
          textAlign: textAlign,
        ),
        if (description != null)
          Text(
            description!,
            style: typography.lM_default.copyWith(
              color: resolvedDescriptionColor,
            ),
            textAlign: textAlign,
          ),
        if (resolvedStatus != null)
          Text(
            resolvedStatus,
            style: typography.lS_strong.copyWith(color: statusColor),
            textAlign: textAlign,
          ),
      ],
    );
  }
}

class _StepperLine extends StatelessWidget {
  final bool isCompleted;
  final StepperOrientation orientation;
  final StepperLineStyle lineStyle;

  const _StepperLine({
    required this.isCompleted,
    required this.orientation,
    required this.lineStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final targetColor = isCompleted
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.2);

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: targetColor),
      duration: const Duration(milliseconds: 500),
      builder: (context, animatedColor, _) {
        return CustomPaint(
          painter: _LinePainter(
            color: animatedColor ?? targetColor,
            isDashed: lineStyle == StepperLineStyle.dashed,
            isHorizontal: orientation == StepperOrientation.horizontal,
          ),
          child: SizedBox(
            height: orientation == StepperOrientation.horizontal
                ? 2
                : double.infinity,
            width: orientation == StepperOrientation.vertical
                ? 2
                : double.infinity,
          ),
        );
      },
    );
  }
}

class _LinePainter extends CustomPainter {
  final Color color;
  final bool isDashed;
  final bool isHorizontal;

  const _LinePainter({
    required this.color,
    required this.isDashed,
    required this.isHorizontal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final start = isHorizontal
        ? Offset(0, size.height / 2)
        : Offset(size.width / 2, 0);
    final end = isHorizontal
        ? Offset(size.width, size.height / 2)
        : Offset(size.width / 2, size.height);

    if (!isDashed) {
      canvas.drawLine(start, end, paint);
      return;
    }

    const dashWidth = 12.0;
    const dashSpace = 8.0;
    final distance = (end - start).distance;
    final direction = (end - start) / distance;

    double currentDistance = 0;
    while (currentDistance < distance) {
      final nextDistance = (currentDistance + dashWidth)
          .clamp(0, distance)
          .toDouble();
      canvas.drawLine(
        start + direction * currentDistance,
        start + direction * nextDistance,
        paint,
      );
      currentDistance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return color != oldDelegate.color ||
        isDashed != oldDelegate.isDashed ||
        isHorizontal != oldDelegate.isHorizontal;
  }
}

enum Ux4gCapsuleStepperLayout { linear, rightAligned, centered, split }

class Ux4gCapsuleStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String stepLabel;
  final String? description;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Ux4gCapsuleStepperLayout layout;
  final CrossAxisAlignment labelAlignment;
  final Color? activeColor;
  final Color? inactiveColor;

  const Ux4gCapsuleStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.stepLabel,
    this.description,
    this.onNext = _noop,
    this.onPrevious = _noop,
    this.layout = Ux4gCapsuleStepperLayout.linear,
    this.labelAlignment = CrossAxisAlignment.start,
    this.activeColor,
    this.inactiveColor,
  });

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);

    final resolvedActiveColor = activeColor ?? colors.primary;
    final resolvedInactiveColor =
        inactiveColor ?? colors.onSurface.withValues(alpha: 0.2);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (layout == Ux4gCapsuleStepperLayout.linear)
            _LinearCapsuleStepper(
              totalSteps: totalSteps,
              currentStep: currentStep,
              stepLabel: stepLabel,
              description: description,
              onNext: onNext,
              onPrevious: onPrevious,
              labelAlignment: labelAlignment,
              activeColor: resolvedActiveColor,
              inactiveColor: resolvedInactiveColor,
            )
          else if (layout == Ux4gCapsuleStepperLayout.rightAligned)
            _RightAlignedCapsuleStepper(
              totalSteps: totalSteps,
              currentStep: currentStep,
              stepLabel: stepLabel,
              description: description,
              onNext: onNext,
              onPrevious: onPrevious,
              activeColor: resolvedActiveColor,
              inactiveColor: resolvedInactiveColor,
            )
          else if (layout == Ux4gCapsuleStepperLayout.centered)
            _CenteredCapsuleStepper(
              totalSteps: totalSteps,
              currentStep: currentStep,
              stepLabel: stepLabel,
              description: description,
              onNext: onNext,
              onPrevious: onPrevious,
              activeColor: resolvedActiveColor,
              inactiveColor: resolvedInactiveColor,
            )
          else
            _SplitCapsuleStepper(
              totalSteps: totalSteps,
              currentStep: currentStep,
              stepLabel: stepLabel,
              description: description,
              onNext: onNext,
              onPrevious: onPrevious,
              activeColor: resolvedActiveColor,
              inactiveColor: resolvedInactiveColor,
            ),
        ],
      ),
    );
  }
}

class _CapsuleIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;
  final MainAxisSize mainAxisSize;
  final bool shrinkToFit;

  const _CapsuleIndicator({
    required this.totalSteps,
    required this.currentStep,
    required this.activeColor,
    required this.inactiveColor,
    this.mainAxisSize = MainAxisSize.min,
    this.shrinkToFit = false,
  });

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: mainAxisSize,
      children: List.generate(totalSteps, (i) {
        final isActive = i + 1 == currentStep;

        return Padding(
          padding: EdgeInsets.only(right: i == totalSteps - 1 ? 0 : 8),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: isActive ? 32 : 16),
            duration: const Duration(milliseconds: 300),
            builder: (context, width, _) {
              return TweenAnimationBuilder<Color?>(
                tween: ColorTween(end: isActive ? activeColor : inactiveColor),
                duration: const Duration(milliseconds: 300),
                builder: (context, color, child) {
                  return Container(
                    width: width,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              );
            },
          ),
        );
      }),
    );

    if (!shrinkToFit) {
      return row;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: row,
    );
  }
}

class _StepperIconButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onClick;

  const _StepperIconButton({
    required this.icon,
    required this.enabled,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final contentColor = enabled
        ? colors.primary
        : colors.onSurface.withValues(alpha: 0.3);
    final borderColor = enabled
        ? colors.primary.withValues(alpha: 0.12)
        : colors.onSurface.withValues(alpha: 0.2);

    return GestureDetector(
      onTap: enabled ? onClick : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 20, color: contentColor),
      ),
    );
  }
}

class _LinearCapsuleStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String stepLabel;
  final String? description;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final CrossAxisAlignment labelAlignment;
  final Color activeColor;
  final Color inactiveColor;

  const _LinearCapsuleStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.stepLabel,
    required this.description,
    required this.onNext,
    required this.onPrevious,
    required this.labelAlignment,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);
    final centered = labelAlignment == CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _StepperIconButton(
              icon: Ux4gIcons.arrowLeft,
              enabled: currentStep > 1,
              onClick: onPrevious,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Center(
                child: _CapsuleIndicator(
                  totalSteps: totalSteps,
                  currentStep: currentStep,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  shrinkToFit: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _StepperIconButton(
              icon: Ux4gIcons.arrowRight,
              enabled: currentStep < totalSteps,
              onClick: onNext,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: labelAlignment,
          children: [
            Text(
              'Step $currentStep of $totalSteps',
              style: typography.lM_strong.copyWith(color: colors.onSurface),
              textAlign: centered ? TextAlign.center : TextAlign.start,
            ),
            Text(
              stepLabel,
              style: typography.lL_strong.copyWith(color: colors.primary),
              textAlign: centered ? TextAlign.center : TextAlign.start,
            ),
            if (description != null)
              Text(
                description!,
                style: typography.lM_default.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.5),
                ),
                textAlign: centered ? TextAlign.center : TextAlign.start,
              ),
          ],
        ),
      ],
    );
  }
}

class _RightAlignedCapsuleStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String stepLabel;
  final String? description;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Color activeColor;
  final Color inactiveColor;

  const _RightAlignedCapsuleStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.stepLabel,
    required this.description,
    required this.onNext,
    required this.onPrevious,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _StepperIconButton(
              icon: Ux4gIcons.arrowLeft,
              enabled: currentStep > 1,
              onClick: onPrevious,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Center(
                child: _CapsuleIndicator(
                  totalSteps: totalSteps,
                  currentStep: currentStep,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  shrinkToFit: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            _StepperIconButton(
              icon: Ux4gIcons.arrowRight,
              enabled: currentStep < totalSteps,
              onClick: onNext,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step $currentStep of $totalSteps',
              style: typography.lM_strong.copyWith(color: colors.onSurface),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stepLabel,
                  style: typography.lL_strong.copyWith(color: colors.primary),
                ),
                if (description != null)
                  Text(
                    description!,
                    style: typography.lM_default.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _CenteredCapsuleStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String stepLabel;
  final String? description;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Color activeColor;
  final Color inactiveColor;

  const _CenteredCapsuleStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.stepLabel,
    required this.description,
    required this.onNext,
    required this.onPrevious,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      children: [
        _CapsuleIndicator(
          totalSteps: totalSteps,
          currentStep: currentStep,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _StepperIconButton(
              icon: Ux4gIcons.arrowLeft,
              enabled: currentStep > 1,
              onClick: onPrevious,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Step $currentStep of $totalSteps',
                style: typography.lM_strong.copyWith(color: colors.onSurface),
              ),
            ),
            _StepperIconButton(
              icon: Ux4gIcons.arrowRight,
              enabled: currentStep < totalSteps,
              onClick: onNext,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          stepLabel,
          style: typography.lL_strong.copyWith(color: colors.primary),
          textAlign: TextAlign.center,
        ),
        if (description != null)
          Text(
            description!,
            style: typography.lM_default.copyWith(
              color: colors.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

class _SplitCapsuleStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String stepLabel;
  final String? description;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Color activeColor;
  final Color inactiveColor;

  const _SplitCapsuleStepper({
    required this.totalSteps,
    required this.currentStep,
    required this.stepLabel,
    required this.description,
    required this.onNext,
    required this.onPrevious,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CapsuleIndicator(
          totalSteps: totalSteps,
          currentStep: currentStep,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          mainAxisSize: MainAxisSize.max,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stepLabel,
              style: typography.lL_strong.copyWith(color: colors.primary),
            ),
            Text(
              'Step $currentStep of $totalSteps',
              style: typography.lM_strong.copyWith(color: colors.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: description == null
                  ? const SizedBox()
                  : Text(
                      description!,
                      style: typography.lM_default.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                _StepperIconButton(
                  icon: Ux4gIcons.arrowLeft,
                  enabled: currentStep > 1,
                  onClick: onPrevious,
                ),
                const SizedBox(width: 8),
                _StepperIconButton(
                  icon: Ux4gIcons.arrowRight,
                  enabled: currentStep < totalSteps,
                  onClick: onNext,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
