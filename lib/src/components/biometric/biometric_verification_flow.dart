import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'biometric_controller.dart';
import 'biometric_state.dart';
import 'biometric_theme.dart';
import 'camera_capture_screen.dart';
import 'device_check_screen.dart';
import 'identity_consent_screen.dart';

/// Main entry-point widget for the biometric verification flow.
///
/// Manages the complete lifecycle: device checks → camera → face detection →
/// liveness → verification → success/failure.
///
/// ```dart
/// BiometricVerificationFlow(
///   onSuccess: (result) {
///     print('Verified: ${result.maskedName}');
///   },
///   onFailure: (reason, message) {
///     print('Failed: $reason');
///   },
///   enableBlinkCheck: true,
///   enableLightingCheck: true,
///   enableLiveness: true,
/// )
/// ```
class BiometricVerificationFlow extends StatefulWidget {
  /// Called when verification succeeds.
  final void Function(BiometricVerificationResult result)? onSuccess;

  /// Called when verification fails.
  final void Function(VerificationFailureReason reason, String? message)?
  onFailure;

  /// Called when user dismisses the flow.
  final VoidCallback? onDismiss;

  /// Called when user taps "Verify with OTP instead".
  final VoidCallback? onAlternateVerify;

  /// Custom verification API callback. If null, uses mock service.
  final Future<BiometricVerificationResult> Function(Uint8List imageBytes)?
  onVerify;

  /// Whether to require blink detection.
  final bool enableBlinkCheck;

  /// Whether to check lighting conditions.
  final bool enableLightingCheck;

  /// Whether to require basic liveness (blink + head movement).
  final bool enableLiveness;

  /// Theme customization.
  final BiometricThemeData? theme;

  /// Maximum verification attempts before lockout.
  final int maxAttempts;

  /// Lockout duration after max attempts exceeded.
  final Duration lockoutDuration;

  /// Whether mock service should simulate success (for testing).
  final bool mockSuccess;

  /// Verification timeout duration.
  final Duration verificationTimeout;

  const BiometricVerificationFlow({
    super.key,
    this.onSuccess,
    this.onFailure,
    this.onDismiss,
    this.onAlternateVerify,
    this.onVerify,
    this.enableBlinkCheck = true,
    this.enableLightingCheck = true,
    this.enableLiveness = true,
    this.theme,
    this.maxAttempts = 2,
    this.lockoutDuration = const Duration(minutes: 30),
    this.mockSuccess = true,
    this.verificationTimeout = const Duration(seconds: 30),
  });

  @override
  State<BiometricVerificationFlow> createState() =>
      _BiometricVerificationFlowState();
}

class _BiometricVerificationFlowState extends State<BiometricVerificationFlow>
    with WidgetsBindingObserver {
  late BiometricController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = BiometricController(
      onVerify: widget.onVerify,
      enableBlinkCheck: widget.enableBlinkCheck,
      enableLightingCheck: widget.enableLightingCheck,
      enableLiveness: widget.enableLiveness,
      verificationTimeout: widget.verificationTimeout,
      maxAttempts: widget.maxAttempts,
      lockoutDuration: widget.lockoutDuration,
      mockSuccess: widget.mockSuccess,
    );

    _controller.addListener(_onStateChange);
  }

  void _onStateChange() {
    final state = _controller.state;

    if (state == BiometricFlowState.verificationSuccess) {
      // Auto-exit is removed so user can see the success card.
      // Success callback is now triggered by the Continue button.
    }

    if (state == BiometricFlowState.verificationFailed) {
      widget.onFailure?.call(
        _controller.failureReason ?? VerificationFailureReason.unknown,
        _controller.errorMessage,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.resume();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onStateChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = widget.theme ?? const BiometricThemeData();

    return BiometricTheme(
      data: themeData,
      child: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return AnimatedSwitcher(
            duration: themeData.animationDuration,
            child: _buildCurrentScreen(),
          );
        },
      ),
    );
  }

  Widget _buildCurrentScreen() {
    final state = _controller.state;

    switch (state) {
      // Phase 1: Identity consent
      case BiometricFlowState.initial:
        return IdentityConsentScreen(
          key: const ValueKey('consent'),
          onAllow: () => _controller.startDeviceChecks(),
          onDecline: widget.onAlternateVerify,
        );

      // Phase 2: Permission request
      case BiometricFlowState.requestingPermission:
      case BiometricFlowState.permissionDenied:
        return _PermissionScreen(
          key: const ValueKey('permission'),
          controller: _controller,
        );

      // Phase 3: Device checks (full screen — camera not yet ready)
      case BiometricFlowState.checkingDevice:
        if (!_controller.isCameraInitialized) {
          return DeviceCheckScreen(
            key: const ValueKey('deviceCheck'),
            controller: _controller,
            onProceed: () => _controller.startDetection(),
          );
        }
        // Camera already init — fall through to camera screen
        return CameraCaptureScreen(
          key: const ValueKey('camera'),
          controller: _controller,
          onAlternateVerify: widget.onAlternateVerify,
          onDismiss: widget.onDismiss,
          onSuccess: widget.onSuccess,
        );

      // Phase 4+: Everything on camera screen
      case BiometricFlowState.deviceReady:
      case BiometricFlowState.cameraReady:
      case BiometricFlowState.detectingFace:
      case BiometricFlowState.aligningFace:
      case BiometricFlowState.checkingLighting:
      case BiometricFlowState.checkingLiveness:
      case BiometricFlowState.blinkRequired:
      case BiometricFlowState.blinkDetected:
      case BiometricFlowState.capturingImage:
      case BiometricFlowState.processingVerification:
      case BiometricFlowState.verificationSuccess:
      case BiometricFlowState.verificationFailed:
        return CameraCaptureScreen(
          key: const ValueKey('camera'),
          controller: _controller,
          onAlternateVerify: widget.onAlternateVerify,
          onDismiss: widget.onDismiss,
          onSuccess: widget.onSuccess,
        );

      case BiometricFlowState.error:
        return CameraCaptureScreen(
          key: const ValueKey('cameraError'),
          controller: _controller,
          onAlternateVerify: widget.onAlternateVerify,
          onDismiss: widget.onDismiss,
          onSuccess: widget.onSuccess,
        );
    }
  }
}

// ─── Permission denied screen ───────────────────────────────────────────────

class _PermissionScreen extends StatelessWidget {
  final BiometricController controller;

  const _PermissionScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return Container(
      color: colors.surface,
      child: SafeArea(
        child: Padding(
          padding: theme.screenPadding,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Allow camera access to continue.',
                  style: theme.typography.title.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'If blocked, go to browser Settings >\nPrivacy > Camera > Allow for this site.',
                  style: theme.typography.body.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Since user needs to interact with the browser/system dialog or settings,
                // we provide a retry button to check permission again.
                TextButton(
                  onPressed: () => controller.startCamera(),
                  child: Text(
                    'Try again',
                    style: theme.typography.button.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
