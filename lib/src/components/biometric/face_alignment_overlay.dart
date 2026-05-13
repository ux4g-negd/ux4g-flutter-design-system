import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'biometric_state.dart';
import 'biometric_theme.dart';

/// The visual state of the oval border on the camera capture screen.
enum OvalVisualState {
  /// White solid border — positioning face.
  positioning,

  /// Green solid border — face aligned / hold still.
  aligned,

  /// Dashed blue/purple border — blink requested.
  blink,

  /// Glow/blur effect — verifying with UIDAI.
  verifying,

  /// Green solid border + green check badge — success.
  success,

  /// Red solid border + red X badge — failure.
  failure,
}

/// Full-screen overlay for the camera capture screen.
///
/// Supports all visual states from the reference images:
/// - Dark overlay with oval cutout
/// - Oval border color/style changes per state
/// - Top: "All systems ready" green pill badge
/// - Bottom: white instruction card with icon + text
/// - Attempt warning cards
/// - Check/X badges on the oval for success/failure
/// - Bottom action buttons for success/failure states
class FaceAlignmentOverlay extends StatefulWidget {
  final OvalVisualState visualState;
  final String instructionText;
  final String? subText;
  final IconData? instructionIcon;
  final Color? instructionIconColor;
  final bool showTopBadge;

  // Attempt tracking
  final int attemptCount;
  final int maxAttempts;

  // Success data
  final String? verifiedName;
  final String? maskedAadhaar;

  // Failure data
  final VerificationFailureReason? failureReason;

  // Callbacks
  final VoidCallback? onContinue;
  final VoidCallback? onRetry;
  final VoidCallback? onAlternateVerify;

  const FaceAlignmentOverlay({
    super.key,
    required this.visualState,
    required this.instructionText,
    this.subText,
    this.instructionIcon,
    this.instructionIconColor,
    this.showTopBadge = true,
    this.attemptCount = 0,
    this.maxAttempts = 2,
    this.verifiedName,
    this.maskedAadhaar,
    this.failureReason,
    this.onContinue,
    this.onRetry,
    this.onAlternateVerify,
  });

  @override
  State<FaceAlignmentOverlay> createState() => _FaceAlignmentOverlayState();
}

class _FaceAlignmentOverlayState extends State<FaceAlignmentOverlay>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _spinnerController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _spinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final ovalW = w * 0.68;
        final ovalH = h * 0.42;
        final ovalCenter = Offset(w / 2, h * 0.38);
        final ovalRect = Rect.fromCenter(
          center: ovalCenter,
          width: ovalW,
          height: ovalH,
        );

        return Stack(
          children: [
            // Dark overlay with oval cutout
            CustomPaint(
              size: Size(w, h),
              painter: _OverlayPainter(
                ovalRect: ovalRect,
                overlayColor: colors.overlay,
                isVerifying: widget.visualState == OvalVisualState.verifying,
              ),
            ),

            // Oval border
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(w, h),
                  painter: _OvalBorderPainter(
                    ovalRect: ovalRect,
                    visualState: widget.visualState,
                    colors: colors,
                    pulseValue: _pulseController.value,
                  ),
                );
              },
            ),

            // Verifying spinner overlay on face
            if (widget.visualState == OvalVisualState.verifying)
              Positioned(
                left: ovalCenter.dx - 20,
                top: ovalCenter.dy + ovalH * 0.15,
                child: RotationTransition(
                  turns: _spinnerController,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: colors.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),

            // Success badge (green check, top-right of oval)
            if (widget.visualState == OvalVisualState.success)
              Positioned(
                left: ovalCenter.dx + (ovalW / 2) * 0.707 - 20,
                top: ovalCenter.dy - (ovalH / 2) * 0.707 - 20,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.success,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 22),
                ),
              ),

            // Failure badge (red X, top-right of oval)
            if (widget.visualState == OvalVisualState.failure)
              Positioned(
                left: ovalCenter.dx + (ovalW / 2) * 0.707 - 20,
                top: ovalCenter.dy - (ovalH / 2) * 0.707 - 20,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.error,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 22),
                ),
              ),

            // Top: "All systems ready" badge
            if (widget.showTopBadge)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colors.statusBadgeBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'All systems ready',
                            style: theme.typography.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Bottom area: instruction card + attempt warning + buttons
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Instruction card
                      _InstructionCard(
                        icon: widget.instructionIcon,
                        iconColor: widget.instructionIconColor,
                        text: widget.instructionText,
                        subText: widget.subText,
                        verifiedName: widget.verifiedName,
                        maskedAadhaar: widget.maskedAadhaar,
                        visualState: widget.visualState,
                        attemptCount: widget.attemptCount,
                        maxAttempts: widget.maxAttempts,
                        isVerifying:
                            widget.visualState == OvalVisualState.verifying,
                        spinnerController: _spinnerController,
                        theme: theme,
                        colors: colors,
                      ),

                      // Action buttons
                      if (widget.visualState == OvalVisualState.success) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: widget.onContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  theme.buttonRadius,
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Continue',
                              style: theme.typography.button,
                            ),
                          ),
                        ),
                      ],

                      if (widget.visualState == OvalVisualState.failure) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: widget.onRetry,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  theme.buttonRadius,
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Try again',
                              style: theme.typography.button,
                            ),
                          ),
                        ),
                        if (widget.onAlternateVerify != null) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: widget.onAlternateVerify,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colors.primary,
                                side: BorderSide(
                                  color: colors.primary.withValues(alpha: 0.4),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    theme.buttonRadius,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Verify with OTP instead',
                                style: theme.typography.button.copyWith(
                                  color: colors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Instruction Card ───────────────────────────────────────────────────────

class _InstructionCard extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String text;
  final String? subText;
  final String? verifiedName;
  final String? maskedAadhaar;
  final int attemptCount;
  final int maxAttempts;
  final OvalVisualState visualState;
  final bool isVerifying;
  final AnimationController spinnerController;
  final BiometricThemeData theme;
  final BiometricColors colors;

  const _InstructionCard({
    this.icon,
    this.iconColor,
    required this.text,
    this.subText,
    this.verifiedName,
    this.maskedAadhaar,
    required this.visualState,
    this.attemptCount = 0,
    this.maxAttempts = 2,
    required this.isVerifying,
    required this.spinnerController,
    required this.theme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: theme.animationDuration,
      child: Container(
        key: ValueKey('$visualState-$text'),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: colors.instructionCardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            if (isVerifying)
              SizedBox(
                width: 28,
                height: 28,
                child: RotationTransition(
                  turns: spinnerController,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: colors.primary,
                  ),
                ),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 28,
                color: iconColor ?? colors.onSurface.withValues(alpha: 0.5),
              ),
            const SizedBox(height: 8),

            // Main text
            Text(
              text,
              style: theme.typography.label.copyWith(
                color: _textColor,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            // Sub text
            if (subText != null) ...[
              const SizedBox(height: 4),
              Text(
                subText!,
                style: theme.typography.caption.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Attempt warning (moved here)
            if (visualState == OvalVisualState.failure && attemptCount > 0) ...[
              const SizedBox(height: 12),
              _AttemptWarning(
                attemptCount: attemptCount,
                maxAttempts: maxAttempts,
                theme: theme,
                colors: colors,
              ),
            ],

            // Verified name + aadhaar
            if (visualState == OvalVisualState.success &&
                verifiedName != null) ...[
              const SizedBox(height: 4),
              Text(
                verifiedName!,
                style: theme.typography.label.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              if (maskedAadhaar != null) ...[
                const SizedBox(height: 2),
                Text(
                  maskedAadhaar!,
                  style: theme.typography.caption.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Color get _textColor {
    return switch (visualState) {
      OvalVisualState.failure => colors.error,
      _ => colors.onSurface.withValues(alpha: 0.8),
    };
  }
}

// ─── Attempt Warning ────────────────────────────────────────────────────────

class _AttemptWarning extends StatelessWidget {
  final int attemptCount;
  final int maxAttempts;
  final BiometricThemeData theme;
  final BiometricColors colors;

  const _AttemptWarning({
    required this.attemptCount,
    required this.maxAttempts,
    required this.theme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = attemptCount >= maxAttempts - 1;
    final bg = isLast ? colors.attemptLastBg : colors.attemptWarningBg;
    final border = isLast
        ? colors.attemptLastBorder
        : colors.attemptWarningBorder;
    final iconColor = isLast ? colors.error : colors.warning;

    final title = isLast
        ? 'Last attempt'
        : 'Attempt $attemptCount of $maxAttempts';
    final subtitle = isLast
        ? 'Account locks for 30 minutes if this fails'
        : '${maxAttempts - attemptCount} more before lockout.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.caption.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.typography.caption.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Painters ───────────────────────────────────────────────────────────────

class _OverlayPainter extends CustomPainter {
  final Rect ovalRect;
  final Color overlayColor;
  final bool isVerifying;

  _OverlayPainter({
    required this.ovalRect,
    required this.overlayColor,
    this.isVerifying = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(ovalRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, Paint()..color = overlayColor);

    // Add glow effect during verification
    if (isVerifying) {
      final glowPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
      canvas.drawOval(ovalRect.inflate(8), glowPaint);
    }
  }

  @override
  bool shouldRepaint(_OverlayPainter old) =>
      ovalRect != old.ovalRect ||
      overlayColor != old.overlayColor ||
      isVerifying != old.isVerifying;
}

class _OvalBorderPainter extends CustomPainter {
  final Rect ovalRect;
  final OvalVisualState visualState;
  final BiometricColors colors;
  final double pulseValue;

  _OvalBorderPainter({
    required this.ovalRect,
    required this.visualState,
    required this.colors,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    switch (visualState) {
      case OvalVisualState.positioning:
        paint
          ..color = colors.ovalGuide.withValues(alpha: 0.6 + (pulseValue * 0.4))
          ..strokeWidth = 3.0;
        canvas.drawOval(ovalRect, paint);

      case OvalVisualState.aligned:
        paint
          ..color = colors.ovalActive
          ..strokeWidth = 3.5;
        canvas.drawOval(ovalRect, paint);

      case OvalVisualState.blink:
        paint
          ..color = colors.ovalBlink
          ..strokeWidth = 3.0;
        _drawDashedOval(canvas, ovalRect, paint, dashLength: 8, gapLength: 6);

      case OvalVisualState.verifying:
        paint
          ..color = colors.ovalGuide.withValues(alpha: 0.5)
          ..strokeWidth = 3.0;
        canvas.drawOval(ovalRect, paint);

      case OvalVisualState.success:
        paint
          ..color = colors.ovalActive
          ..strokeWidth = 4.0;
        canvas.drawOval(ovalRect, paint);

      case OvalVisualState.failure:
        paint
          ..color = colors.ovalError
          ..strokeWidth = 4.0;
        canvas.drawOval(ovalRect, paint);
    }
  }

  void _drawDashedOval(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    double dashLength = 8,
    double gapLength = 5,
  }) {
    final path = Path()..addOval(rect);
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = math.min(distance + dashLength, metric.length);
        final segment = metric.extractPath(distance, end);
        canvas.drawPath(segment, paint);
        distance = end + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(_OvalBorderPainter old) =>
      ovalRect != old.ovalRect ||
      visualState != old.visualState ||
      pulseValue != old.pulseValue;
}
