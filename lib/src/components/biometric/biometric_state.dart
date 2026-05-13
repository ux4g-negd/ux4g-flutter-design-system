/// All possible states of the biometric verification flow.
enum BiometricFlowState {
  /// Initial state before anything starts.
  initial,

  /// Running device readiness checks.
  checkingDevice,

  /// All device checks passed.
  deviceReady,

  /// Requesting camera/permissions.
  requestingPermission,

  /// Permission denied by user.
  permissionDenied,

  /// Camera initialized and streaming.
  cameraReady,

  /// Actively looking for a face in frame.
  detectingFace,

  /// Face detected, guiding alignment into oval.
  aligningFace,

  /// Checking ambient lighting conditions.
  checkingLighting,

  /// Checking liveness (blink / head movement).
  checkingLiveness,

  /// Waiting for user to blink.
  blinkRequired,

  /// Blink detected, continuing.
  blinkDetected,

  /// Capturing the face image.
  capturingImage,

  /// Sending image to verification API.
  processingVerification,

  /// Verification succeeded.
  verificationSuccess,

  /// Verification failed.
  verificationFailed,

  /// An unrecoverable error occurred.
  error,
}

/// Result of a single device check.
enum DeviceCheckStatus { pending, checking, passed, failed }

/// Individual device check item.
class DeviceCheckItem {
  final String label;
  final String description;
  final DeviceCheckStatus status;
  final String? errorMessage;
  final String passedText;
  final String failedText;
  final String? helperText;

  const DeviceCheckItem({
    required this.label,
    required this.description,
    this.status = DeviceCheckStatus.pending,
    this.errorMessage,
    this.passedText = 'Sufficient',
    this.failedText = 'Not detected',
    this.helperText,
  });

  DeviceCheckItem copyWith({
    String? label,
    String? description,
    DeviceCheckStatus? status,
    String? errorMessage,
    String? passedText,
    String? failedText,
    String? helperText,
  }) {
    return DeviceCheckItem(
      label: label ?? this.label,
      description: description ?? this.description,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      passedText: passedText ?? this.passedText,
      failedText: failedText ?? this.failedText,
      helperText: helperText ?? this.helperText,
    );
  }
}

/// Face alignment guidance.
enum FaceAlignmentStatus {
  noFace,
  tooFar,
  tooClose,
  offCenter,
  multipleFaces,
  aligned,
}

/// Lighting condition.
enum LightingStatus { unknown, tooLow, overExposed, good }

/// Liveness check step.
enum LivenessStep {
  waitingForBlink,
  blinkDetected,
  headMovement,
  passed,
  failed,
}

/// Result from the verification API (mock or real).
class BiometricVerificationResult {
  final bool success;
  final String? userId;
  final String? maskedName;
  final String? maskedPhone;
  final String? message;
  final String? errorCode;
  final double? confidenceScore;

  const BiometricVerificationResult({
    required this.success,
    this.userId,
    this.maskedName,
    this.maskedPhone,
    this.message,
    this.errorCode,
    this.confidenceScore,
  });
}

/// Failure reasons for the verification.
enum VerificationFailureReason {
  livenessFailed,
  faceNotDetected,
  faceNotMatched,
  verificationTimeout,
  networkError,
  serverError,
  lowConfidence,
  unknown,
}
