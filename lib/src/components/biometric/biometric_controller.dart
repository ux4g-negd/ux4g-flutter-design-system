import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'biometric_state.dart';
import 'camera_service.dart';
import 'face_detection_service.dart';
import 'mock_verification_service.dart';

/// Main controller that drives the biometric verification flow.
///
/// Manages device checks, camera, face detection, liveness, and
/// verification API calls. Exposes state via [ChangeNotifier].
class BiometricController extends ChangeNotifier {
  // ── Services ──
  final CameraService _cameraService = CameraService();
  final FaceDetectionService _faceDetectionService = FaceDetectionService();
  final VerifyCallback? onVerify;
  final MockVerificationService _mockService;

  // ── Configuration ──
  final bool enableBlinkCheck;
  final bool enableLightingCheck;
  final bool enableLiveness;
  final Duration verificationTimeout;
  final int maxAttempts;
  final Duration lockoutDuration;

  // ── State ──
  BiometricFlowState _state = BiometricFlowState.initial;
  List<DeviceCheckItem> _deviceChecks = [];
  FaceAnalysisResult? _lastAnalysis;
  BiometricVerificationResult? _verificationResult;
  VerificationFailureReason? _failureReason;
  String _instructionText = '';
  Uint8List? _capturedImage;
  String? _errorMessage;
  int _attemptCount = 0;

  // ── Getters ──
  BiometricFlowState get state => _state;
  List<DeviceCheckItem> get deviceChecks => _deviceChecks;
  FaceAnalysisResult? get lastAnalysis => _lastAnalysis;
  BiometricVerificationResult? get verificationResult => _verificationResult;
  VerificationFailureReason? get failureReason => _failureReason;
  String get instructionText => _instructionText;
  Uint8List? get capturedImage => _capturedImage;
  String? get errorMessage => _errorMessage;
  CameraController? get cameraController => _cameraService.controller;
  bool get isCameraInitialized => _cameraService.isInitialized;
  int get attemptCount => _attemptCount;
  int get remainingAttempts => maxAttempts - _attemptCount;
  bool get isLastAttempt => _attemptCount >= maxAttempts - 1;

  BiometricController({
    this.onVerify,
    this.enableBlinkCheck = true,
    this.enableLightingCheck = true,
    this.enableLiveness = true,
    this.verificationTimeout = const Duration(seconds: 30),
    this.maxAttempts = 3,
    this.lockoutDuration = const Duration(minutes: 30),
    bool mockSuccess = true,
  }) : _mockService = MockVerificationService(simulateSuccess: mockSuccess);

  // ══════════════════════════════════════════════════════════════════════════
  // STATE TRANSITIONS
  // ══════════════════════════════════════════════════════════════════════════

  void _setState(BiometricFlowState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setInstruction(String text) {
    _instructionText = text;
    notifyListeners();
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DEVICE CHECKS
  // ══════════════════════════════════════════════════════════════════════════

  /// Start device readiness checks.
  Future<void> startDeviceChecks() async {
    _setState(BiometricFlowState.checkingDevice);

    _deviceChecks = [
      const DeviceCheckItem(
        label: 'Camera',
        description: 'Checking front camera availability',
        status: DeviceCheckStatus.pending,
        passedText: 'Sufficient',
        failedText: 'Not detected',
      ),
      const DeviceCheckItem(
        label: 'Lighting',
        description: 'Checking ambient lighting',
        status: DeviceCheckStatus.pending,
        passedText: 'Sufficient',
        failedText: 'Not detected',
      ),
      const DeviceCheckItem(
        label: 'Internet connection',
        description: 'Checking network connection',
        status: DeviceCheckStatus.pending,
        passedText: 'Sufficient',
        failedText: 'Not detected',
      ),
      const DeviceCheckItem(
        label: 'Permissions',
        description: 'Checking camera permission',
        status: DeviceCheckStatus.pending,
        passedText: 'Sufficient',
        failedText: 'Not detected',
        helperText: 'Go to browser Settings › Privacy › Camera › Allow.',
      ),
      const DeviceCheckItem(
        label: 'Fingerprint scanner',
        description: 'Checking fingerprint scanner availability',
        status: DeviceCheckStatus.pending,
        passedText: 'Connected',
        failedText: 'Not connected',
        helperText:
            'Fingerprint scanner not detected. Please check connection.',
      ),
    ];
    notifyListeners();

    // Check 1: Camera
    _updateCheck(0, DeviceCheckStatus.checking);
    await Future.delayed(const Duration(milliseconds: 500));
    final hasCam = await _cameraService.isCameraAvailable();
    _updateCheck(
      0,
      hasCam ? DeviceCheckStatus.passed : DeviceCheckStatus.failed,
      errorMessage: hasCam ? null : 'No front camera found',
    );

    // Check 2: Lighting — always pass at this stage (real check during capture)
    _updateCheck(1, DeviceCheckStatus.checking);
    await Future.delayed(const Duration(milliseconds: 400));
    _updateCheck(1, DeviceCheckStatus.passed);

    // Check 3: Internet connection
    _updateCheck(2, DeviceCheckStatus.checking);
    await Future.delayed(const Duration(milliseconds: 400));
    final connectResult = await Connectivity().checkConnectivity();
    final hasInternet =
        connectResult.isNotEmpty &&
        !connectResult.contains(ConnectivityResult.none);
    _updateCheck(
      2,
      hasInternet ? DeviceCheckStatus.passed : DeviceCheckStatus.failed,
      errorMessage: hasInternet ? null : 'No internet connection',
    );

    // Check 4: Permissions
    _updateCheck(3, DeviceCheckStatus.checking);
    await Future.delayed(const Duration(milliseconds: 300));
    var camPermission = await Permission.camera.status;
    var permGranted = camPermission.isGranted || camPermission.isLimited;

    if (!permGranted) {
      final status = await Permission.camera.request();
      permGranted = status.isGranted || status.isLimited;
    }

    _updateCheck(
      3,
      permGranted ? DeviceCheckStatus.passed : DeviceCheckStatus.failed,
      errorMessage: permGranted ? null : 'Camera permission not granted',
    );

    // Check 5: Fingerprint scanner (Dummy check for now, always pass)
    _updateCheck(4, DeviceCheckStatus.checking);
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, you would use a package like local_auth to check
    _updateCheck(4, DeviceCheckStatus.passed);

    final allPassed = _deviceChecks.every(
      (c) => c.status == DeviceCheckStatus.passed,
    );

    if (allPassed) {
      // Also initialize camera so it's ready when user taps Start
      try {
        final permStatus = await Permission.camera.status;
        if (!permStatus.isGranted && !permStatus.isLimited) {
          final granted = await requestCameraPermission();
          if (!granted) return;
        }
        await _cameraService.initialize();
      } catch (_) {
        // Camera init failed — still show deviceReady for check card display
      }
      _setState(BiometricFlowState.deviceReady);
    }
  }

  void _updateCheck(
    int index,
    DeviceCheckStatus status, {
    String? errorMessage,
  }) {
    _deviceChecks[index] = _deviceChecks[index].copyWith(
      status: status,
      errorMessage: errorMessage,
    );
    notifyListeners();
  }

  // ══════════════════════════════════════════════════════════════════════════
  // PERMISSIONS
  // ══════════════════════════════════════════════════════════════════════════

  /// Request camera permission if not already granted.
  Future<bool> requestCameraPermission() async {
    _setState(BiometricFlowState.requestingPermission);
    final status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) {
      return true;
    }
    _setState(BiometricFlowState.permissionDenied);
    return false;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // CAMERA
  // ══════════════════════════════════════════════════════════════════════════

  /// Initialize camera and start processing frames.
  Future<void> startCamera() async {
    try {
      // Request permission first if needed
      final permStatus = await Permission.camera.status;
      if (!permStatus.isGranted && !permStatus.isLimited) {
        final granted = await requestCameraPermission();
        if (!granted) return;
      }

      if (!_cameraService.isInitialized) {
        await _cameraService.initialize();
      }
      _faceDetectionService.resetLivenessState();
      _setState(BiometricFlowState.cameraReady);
      _setInstruction('Position your face in the oval');

      // Short delay before starting stream
      await Future.delayed(const Duration(milliseconds: 300));
      _startProcessing();
    } catch (e) {
      _errorMessage = 'Camera initialization failed: $e';
      _setState(BiometricFlowState.error);
    }
  }

  /// Start face detection from device-ready state (user tapped "Start").
  Future<void> startDetection() async {
    try {
      if (!_cameraService.isInitialized) {
        await _cameraService.initialize();
      }
      _faceDetectionService.resetLivenessState();
      _setState(BiometricFlowState.detectingFace);
      _setInstruction('Position your face in the oval');
      await Future.delayed(const Duration(milliseconds: 300));
      _startProcessing();
    } catch (e) {
      _errorMessage = 'Camera initialization failed: $e';
      _setState(BiometricFlowState.error);
    }
  }

  void _startProcessing() {
    _setState(BiometricFlowState.detectingFace);
    final camera = _cameraService.controller!.description;

    _cameraService.startImageStream((image) {
      _processFrame(image, camera);
    });
  }

  Future<void> _processFrame(
    CameraImage image,
    CameraDescription camera,
  ) async {
    // Don't process if we're past the detection phase
    if (_state == BiometricFlowState.capturingImage ||
        _state == BiometricFlowState.processingVerification ||
        _state == BiometricFlowState.verificationSuccess ||
        _state == BiometricFlowState.verificationFailed) {
      return;
    }

    final previewSize = Size(image.width.toDouble(), image.height.toDouble());

    final result = await _faceDetectionService.processFrame(
      image,
      camera,
      previewSize,
    );
    if (result == null) return;

    _lastAnalysis = result;

    // Update state and instructions based on analysis
    _handleAnalysisResult(result);
  }

  void _handleAnalysisResult(FaceAnalysisResult result) {
    // Face alignment phase
    if (!result.isFaceAligned) {
      _setState(BiometricFlowState.aligningFace);
      switch (result.alignment) {
        case FaceAlignmentStatus.noFace:
          _setInstruction('Position your face in the oval');
        case FaceAlignmentStatus.tooFar:
          _setInstruction('Move closer');
        case FaceAlignmentStatus.tooClose:
          _setInstruction('Move farther away');
        case FaceAlignmentStatus.offCenter:
          _setInstruction('Center your face');
        case FaceAlignmentStatus.multipleFaces:
          _setInstruction('Only one face allowed');
        case FaceAlignmentStatus.aligned:
          break;
      }
      return;
    }

    // Lighting check
    if (enableLightingCheck && !result.isLightingGood) {
      _setState(BiometricFlowState.checkingLighting);
      switch (result.lighting) {
        case LightingStatus.tooLow:
          _setInstruction('Improve lighting');
        case LightingStatus.overExposed:
          _setInstruction('Reduce backlight');
        default:
          break;
      }
      return;
    }

    // Liveness / blink check
    if (enableLiveness || enableBlinkCheck) {
      switch (result.livenessStep) {
        case LivenessStep.waitingForBlink:
          _setState(BiometricFlowState.blinkRequired);
          _setInstruction('Please blink now');
          return;
        case LivenessStep.blinkDetected:
          _setState(BiometricFlowState.blinkDetected);
          _setInstruction('Blink detected ✓');
          return;
        case LivenessStep.headMovement:
          if (enableLiveness) {
            _setState(BiometricFlowState.checkingLiveness);
            _setInstruction('Slowly turn your head');
            return;
          }
          break;
        case LivenessStep.passed:
          break;
        case LivenessStep.failed:
          _failureReason = VerificationFailureReason.livenessFailed;
          _setState(BiometricFlowState.verificationFailed);
          return;
      }
    }

    // All local checks passed — capture image
    if (_state != BiometricFlowState.capturingImage) {
      _setInstruction('Hold still — capturing...');
      _captureAndVerify();
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // CAPTURE & VERIFY
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _captureAndVerify() async {
    _setState(BiometricFlowState.capturingImage);

    try {
      final imageBytes = await _cameraService.captureImage();
      await _cameraService.pausePreview();
      if (imageBytes == null) {
        _failureReason = VerificationFailureReason.faceNotDetected;
        _setState(BiometricFlowState.verificationFailed);
        return;
      }

      _capturedImage = imageBytes;
      _setState(BiometricFlowState.processingVerification);
      _setInstruction('Verifying identity...');

      // Call verification API (real or mock)
      final result = await _verify(imageBytes);
      _verificationResult = result;

      if (result.success) {
        _setState(BiometricFlowState.verificationSuccess);
      } else {
        _failureReason = VerificationFailureReason.lowConfidence;
        _setState(BiometricFlowState.verificationFailed);
      }
    } catch (e) {
      _failureReason = VerificationFailureReason.unknown;
      _errorMessage = e.toString();
      _setState(BiometricFlowState.verificationFailed);
    }
  }

  Future<BiometricVerificationResult> _verify(Uint8List imageBytes) async {
    if (onVerify != null) {
      return onVerify!(imageBytes);
    }
    return _mockService.verify(imageBytes);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // RETRY
  // ══════════════════════════════════════════════════════════════════════════

  /// Reset and retry the verification flow from camera.
  Future<void> retry() async {
    _attemptCount++;
    _lastAnalysis = null;
    _verificationResult = null;
    _failureReason = null;
    _capturedImage = null;
    _errorMessage = null;

    _faceDetectionService.resetLivenessState();

    // Restart detection without disposing camera
    if (_cameraService.isInitialized) {
      await _cameraService.resumePreview();
      _setState(BiometricFlowState.detectingFace);
      _setInstruction('Position your face in the oval');
      await Future.delayed(const Duration(milliseconds: 300));
      _startProcessing();
    } else {
      await startCamera();
    }
  }

  /// Reset everything and go back to device checks.
  Future<void> resetFull() async {
    _lastAnalysis = null;
    _verificationResult = null;
    _failureReason = null;
    _capturedImage = null;
    _errorMessage = null;
    _attemptCount = 0;

    await _cameraService.dispose();
    _faceDetectionService.resetLivenessState();

    _setState(BiometricFlowState.initial);
  }

  // ══════════════════════════════════════════════════════════════════════════
  // PROCEED FROM DEVICE CHECK
  // ══════════════════════════════════════════════════════════════════════════

  /// Called when user taps "Proceed to verify" after device checks pass.
  Future<void> proceedToCapture() async {
    await startCamera();
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LIFECYCLE
  // ══════════════════════════════════════════════════════════════════════════

  /// Pause camera (e.g., app goes to background).
  Future<void> pause() async {
    await _cameraService.stopImageStream();
  }

  /// Resume camera (e.g., app comes to foreground).
  Future<void> resume() async {
    if (_cameraService.isInitialized &&
        (_state == BiometricFlowState.detectingFace ||
            _state == BiometricFlowState.aligningFace ||
            _state == BiometricFlowState.checkingLighting ||
            _state == BiometricFlowState.checkingLiveness ||
            _state == BiometricFlowState.blinkRequired)) {
      _startProcessing();
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _faceDetectionService.dispose();
    super.dispose();
  }
}
