import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'biometric_controller.dart';
import 'biometric_state.dart';
import 'biometric_theme.dart';
import 'device_check_screen.dart';
import 'face_alignment_overlay.dart';

/// Camera preview screen that handles ALL states from device-ready through
/// success/failure, matching the reference design.
///
/// Phases:
/// 1. Device check overlay — camera bg + device check card + "Start" button
/// 2. Active detection — oval overlay + instructions
/// 3. Verifying — blurred/glow overlay + spinner
/// 4. Success — green oval + check badge + verified info
/// 5. Failure — red oval + X badge + retry buttons
class CameraCaptureScreen extends StatelessWidget {
  final BiometricController controller;
  final VoidCallback? onAlternateVerify;
  final VoidCallback? onDismiss;
  final void Function(BiometricVerificationResult)? onSuccess;

  const CameraCaptureScreen({
    super.key,
    required this.controller,
    this.onAlternateVerify,
    this.onDismiss,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final cam = controller.cameraController;
        final state = controller.state;

        // Camera not ready: show loading
        if (cam == null || !cam.value.isInitialized) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: colors.primary),
                  const SizedBox(height: 16),
                  Text(
                    'Initializing camera...',
                    style: theme.typography.body.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final isDeviceCheckPhase =
            state == BiometricFlowState.deviceReady ||
            state == BiometricFlowState.checkingDevice;
        final isActiveCapture = _isActiveCapture(state);
        final isTerminal =
            state == BiometricFlowState.verificationSuccess ||
            state == BiometricFlowState.verificationFailed;

        return ClipRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Camera preview
              _CameraPreviewFitted(controller: cam),

              // Phase 1: Device check overlay
              if (isDeviceCheckPhase)
                _DeviceCheckOverlay(
                  controller: controller,
                  theme: theme,
                  colors: colors,
                ),

              // Phase 2-5: Face alignment overlay (detection, verifying, success, failure)
              if (isActiveCapture || isTerminal)
                FaceAlignmentOverlay(
                  visualState: _mapVisualState(state),
                  instructionText: _instructionText(state, controller),
                  subText: _subText(state, controller),
                  instructionIcon: _instructionIcon(state, controller),
                  instructionIconColor: _instructionIconColor(
                    state,
                    colors,
                    controller,
                  ),
                  showTopBadge: true,
                  attemptCount: controller.attemptCount,
                  maxAttempts: controller.maxAttempts,
                  verifiedName: controller.verificationResult?.maskedName,
                  maskedAadhaar: controller.verificationResult?.maskedPhone,
                  failureReason: controller.failureReason,
                  onContinue: () {
                  if (controller.verificationResult != null && onSuccess != null) {
                    onSuccess!(controller.verificationResult!);
                  }
                },
                  onRetry: () => controller.retry(),
                  onAlternateVerify: onAlternateVerify,
                ),
            ],
          ),
        );
      },
    );
  }

  bool _isActiveCapture(BiometricFlowState state) {
    return state == BiometricFlowState.cameraReady ||
        state == BiometricFlowState.detectingFace ||
        state == BiometricFlowState.aligningFace ||
        state == BiometricFlowState.checkingLighting ||
        state == BiometricFlowState.checkingLiveness ||
        state == BiometricFlowState.blinkRequired ||
        state == BiometricFlowState.blinkDetected ||
        state == BiometricFlowState.capturingImage ||
        state == BiometricFlowState.processingVerification;
  }

  OvalVisualState _mapVisualState(BiometricFlowState state) {
    return switch (state) {
      BiometricFlowState.cameraReady ||
      BiometricFlowState.detectingFace ||
      BiometricFlowState.checkingLighting => OvalVisualState.positioning,
      BiometricFlowState.aligningFace => _alignmentVisual(
        controller.lastAnalysis?.alignment,
      ),
      BiometricFlowState.blinkDetected ||
      BiometricFlowState.checkingLiveness ||
      BiometricFlowState.capturingImage => OvalVisualState.aligned,
      BiometricFlowState.blinkRequired => OvalVisualState.blink,
      BiometricFlowState.processingVerification => OvalVisualState.verifying,
      BiometricFlowState.verificationSuccess => OvalVisualState.success,
      BiometricFlowState.verificationFailed => OvalVisualState.failure,
      _ => OvalVisualState.positioning,
    };
  }

  OvalVisualState _alignmentVisual(FaceAlignmentStatus? alignment) {
    if (alignment == FaceAlignmentStatus.aligned) {
      return OvalVisualState.aligned;
    }
    return OvalVisualState.positioning;
  }

  String _instructionText(BiometricFlowState state, BiometricController ctrl) {
    return switch (state) {
      BiometricFlowState.cameraReady ||
      BiometricFlowState.detectingFace => 'Position your face in the oval',
      BiometricFlowState.aligningFace => _alignmentInstruction(ctrl),
      BiometricFlowState.checkingLighting => _lightingInstruction(ctrl),
      BiometricFlowState.blinkRequired => 'Please blink now',
      BiometricFlowState.blinkDetected => 'Hold still...',
      BiometricFlowState.checkingLiveness => 'Turn slightly to your left',
      BiometricFlowState.capturingImage => 'Hold still...',
      BiometricFlowState.processingVerification => 'Verifying with UIDAI',
      BiometricFlowState.verificationSuccess => 'Identity verified',
      BiometricFlowState.verificationFailed => _failureTitle(
        ctrl.failureReason,
      ),
      _ => 'Position your face in the oval',
    };
  }

  String _alignmentInstruction(BiometricController ctrl) {
    final alignment = ctrl.lastAnalysis?.alignment;
    return switch (alignment) {
      FaceAlignmentStatus.noFace => 'Position your face in the oval',
      FaceAlignmentStatus.tooFar => 'Move closer to the camera',
      FaceAlignmentStatus.tooClose => 'Move back slightly',
      FaceAlignmentStatus.offCenter => 'Position your face in the oval',
      FaceAlignmentStatus.multipleFaces => 'Only one face allowed',
      FaceAlignmentStatus.aligned => 'Hold still...',
      null => 'Position your face in the oval',
    };
  }

  String _lightingInstruction(BiometricController ctrl) {
    final lighting = ctrl.lastAnalysis?.lighting;
    return switch (lighting) {
      LightingStatus.tooLow => 'Move to a brighter area',
      LightingStatus.overExposed => 'Reduce backlight',
      _ => 'Checking lighting...',
    };
  }

  String _failureTitle(VerificationFailureReason? reason) {
    return switch (reason) {
      VerificationFailureReason.livenessFailed => 'Liveness check failed',
      VerificationFailureReason.faceNotDetected => 'Face not detected',
      VerificationFailureReason.faceNotMatched =>
        'Face does not match Aadhaar records',
      VerificationFailureReason.verificationTimeout => 'Verification timed out',
      VerificationFailureReason.networkError => 'Cannot connect to UIDAI',
      VerificationFailureReason.serverError => 'Server error',
      VerificationFailureReason.lowConfidence =>
        'Face does not match Aadhaar records',
      _ => 'Verification failed',
    };
  }

  String? _subText(BiometricFlowState state, BiometricController ctrl) {
    return switch (state) {
      BiometricFlowState.processingVerification => 'Do not move',
      BiometricFlowState.verificationFailed => _failureSubText(
        ctrl.failureReason,
      ),
      _ => null,
    };
  }

  String? _failureSubText(VerificationFailureReason? reason) {
    return switch (reason) {
      VerificationFailureReason.livenessFailed => 'Please try again',
      VerificationFailureReason.faceNotMatched => 'Please try again',
      VerificationFailureReason.verificationTimeout => 'Try again',
      VerificationFailureReason.networkError => 'Check your connection',
      _ => 'Please try again',
    };
  }

  IconData? _instructionIcon(
    BiometricFlowState state,
    BiometricController ctrl,
  ) {
    return switch (state) {
      BiometricFlowState.cameraReady ||
      BiometricFlowState.detectingFace => Icons.face_retouching_natural,
      BiometricFlowState.aligningFace => _alignmentIcon(
        ctrl.lastAnalysis?.alignment,
      ),
      BiometricFlowState.checkingLighting => _lightingIcon(
        ctrl.lastAnalysis?.lighting,
      ),
      BiometricFlowState.blinkRequired => Icons.visibility_outlined,
      BiometricFlowState.blinkDetected ||
      BiometricFlowState.capturingImage => Icons.pan_tool_outlined,
      BiometricFlowState.checkingLiveness => Icons.arrow_back,
      BiometricFlowState.processingVerification => null, // spinner
      BiometricFlowState.verificationSuccess => Icons.check_circle_outline,
      BiometricFlowState.verificationFailed => _failureIcon(ctrl.failureReason),
      _ => Icons.face_retouching_natural,
    };
  }

  IconData _alignmentIcon(FaceAlignmentStatus? alignment) {
    return switch (alignment) {
      FaceAlignmentStatus.tooFar => Icons.expand_more,
      FaceAlignmentStatus.tooClose => Icons.expand_less,
      _ => Icons.face_retouching_natural,
    };
  }

  IconData _lightingIcon(LightingStatus? lighting) {
    return switch (lighting) {
      LightingStatus.tooLow => Icons.wb_sunny_outlined,
      _ => Icons.wb_sunny_outlined,
    };
  }

  IconData _failureIcon(VerificationFailureReason? reason) {
    return switch (reason) {
      VerificationFailureReason.livenessFailed => Icons.warning_amber_rounded,
      VerificationFailureReason.faceNotMatched => Icons.error_outline,
      VerificationFailureReason.verificationTimeout => Icons.timer_off_outlined,
      VerificationFailureReason.networkError => Icons.wifi_off_outlined,
      _ => Icons.warning_amber_rounded,
    };
  }

  Color? _instructionIconColor(
    BiometricFlowState state,
    BiometricColors colors,
    BiometricController ctrl,
  ) {
    return switch (state) {
      BiometricFlowState.blinkRequired => colors.ovalBlink,
      BiometricFlowState.blinkDetected ||
      BiometricFlowState.capturingImage => colors.warning,
      BiometricFlowState.checkingLighting => colors.warning,
      BiometricFlowState.aligningFace => _alignmentIconColor(
        ctrl.lastAnalysis?.alignment,
        colors,
      ),
      BiometricFlowState.verificationSuccess => colors.success,
      BiometricFlowState.verificationFailed => _failureIconColor(
        ctrl.failureReason,
        colors,
      ),
      _ => null,
    };
  }

  Color? _alignmentIconColor(
    FaceAlignmentStatus? alignment,
    BiometricColors colors,
  ) {
    return switch (alignment) {
      FaceAlignmentStatus.tooFar ||
      FaceAlignmentStatus.tooClose => colors.warning,
      _ => null,
    };
  }

  Color _failureIconColor(
    VerificationFailureReason? reason,
    BiometricColors colors,
  ) {
    return switch (reason) {
      VerificationFailureReason.livenessFailed => colors.warning,
      VerificationFailureReason.faceNotMatched => colors.warning,
      VerificationFailureReason.networkError => colors.warning,
      _ => colors.warning,
    };
  }
}

// ─── Device Check Overlay Phase ─────────────────────────────────────────────

class _DeviceCheckOverlay extends StatelessWidget {
  final BiometricController controller;
  final BiometricThemeData theme;
  final BiometricColors colors;

  const _DeviceCheckOverlay({
    required this.controller,
    required this.theme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final allPassed = controller.state == BiometricFlowState.deviceReady;

    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: SafeArea(
        child: Column(
          children: [
            // Device check card (floating, compact)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: DeviceCheckScreen(
                controller: controller,
                compact: true,
                onProceed: () {}, // Handled by bottom button
              ),
            ),

            const Spacer(),

            // Start Face Verification button
            if (allPassed)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => controller.startDetection(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(theme.buttonRadius),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Start Face Verification',
                      style: theme.typography.button,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Camera Preview ─────────────────────────────────────────────────────────

/// Fits the camera preview to fill the available space.
class _CameraPreviewFitted extends StatelessWidget {
  final CameraController controller;

  const _CameraPreviewFitted({required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentAspect = constraints.maxWidth / constraints.maxHeight;
        var scale = parentAspect * controller.value.aspectRatio;

        // Prevent scaling down to ensure the preview covers the screen.
        if (scale < 1) scale = 1 / scale;

        return Transform.scale(
          scale: scale,
          child: Center(child: CameraPreview(controller)),
        );
      },
    );
  }
}
