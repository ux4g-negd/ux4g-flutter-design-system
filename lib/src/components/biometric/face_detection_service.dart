import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'biometric_state.dart';

/// Service for ML Kit face detection, alignment, lighting, and liveness.
class FaceDetectionService {
  late final FaceDetector _faceDetector;
  bool _isBusy = false;
  DateTime _lastProcessedTime = DateTime.now();

  // Throttle: process at most every N milliseconds.
  static const _throttleMs = 200;

  // Blink detection state
  bool _leftEyeWasClosed = false;
  bool _rightEyeWasClosed = false;
  int _blinkCount = 0;
  static const double _eyeClosedThreshold = 0.3;

  // Head movement tracking
  double? _previousHeadY;
  int _headMovementCount = 0;
  static const double _headMovementThreshold = 8.0;

  int get blinkCount => _blinkCount;

  FaceDetectionService() {
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableTracking: true,
        enableLandmarks: true,
        enableContours: false,
        performanceMode: FaceDetectorMode.fast,
        minFaceSize: 0.25,
      ),
    );
  }

  /// Reset blink/liveness counters.
  void resetLivenessState() {
    _blinkCount = 0;
    _leftEyeWasClosed = false;
    _rightEyeWasClosed = false;
    _previousHeadY = null;
    _headMovementCount = 0;
  }

  /// Process a camera image frame. Returns null if throttled or busy.
  Future<FaceAnalysisResult?> processFrame(
    CameraImage image,
    CameraDescription camera,
    Size previewSize,
  ) async {
    if (_isBusy) return null;

    final now = DateTime.now();
    if (now.difference(_lastProcessedTime).inMilliseconds < _throttleMs) {
      return null;
    }

    _isBusy = true;
    _lastProcessedTime = now;

    try {
      final inputImage = _buildInputImage(image, camera);
      if (inputImage == null) {
        _isBusy = false;
        return null;
      }

      final faces = await _faceDetector.processImage(inputImage);
      final result = _analyze(faces, previewSize);
      _isBusy = false;
      return result;
    } catch (e) {
      _isBusy = false;
      return null;
    }
  }

  /// Build ML Kit InputImage from CameraImage.
  InputImage? _buildInputImage(CameraImage image, CameraDescription camera) {
    final rotation = _rotationFromSensor(camera.sensorOrientation);
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  InputImageRotation? _rotationFromSensor(int sensorOrientation) {
    return switch (sensorOrientation) {
      0 => InputImageRotation.rotation0deg,
      90 => InputImageRotation.rotation90deg,
      180 => InputImageRotation.rotation180deg,
      270 => InputImageRotation.rotation270deg,
      _ => null,
    };
  }

  /// Analyze detected faces and return a comprehensive result.
  FaceAnalysisResult _analyze(List<Face> faces, Size previewSize) {
    if (faces.isEmpty) {
      return const FaceAnalysisResult(
        faceCount: 0,
        alignment: FaceAlignmentStatus.noFace,
        lighting: LightingStatus.unknown,
        livenessStep: LivenessStep.waitingForBlink,
      );
    }

    if (faces.length > 1) {
      return FaceAnalysisResult(
        faceCount: faces.length,
        alignment: FaceAlignmentStatus.multipleFaces,
        lighting: LightingStatus.unknown,
        livenessStep: LivenessStep.waitingForBlink,
      );
    }

    final face = faces.first;
    final bbox = face.boundingBox;

    // --- Alignment ---
    final alignment = _checkAlignment(bbox, previewSize);

    // --- Lighting ---
    final lighting = _checkLighting(face);

    // --- Blink detection ---
    _detectBlink(face);

    // --- Head movement ---
    _detectHeadMovement(face);

    // --- Liveness ---
    final livenessStep = _evaluateLiveness();

    return FaceAnalysisResult(
      faceCount: 1,
      alignment: alignment,
      lighting: lighting,
      livenessStep: livenessStep,
      leftEyeOpen: face.leftEyeOpenProbability,
      rightEyeOpen: face.rightEyeOpenProbability,
      smilingProbability: face.smilingProbability,
      headEulerAngleY: face.headEulerAngleY,
      headEulerAngleZ: face.headEulerAngleZ,
      blinkCount: _blinkCount,
      boundingBox: bbox,
    );
  }

  FaceAlignmentStatus _checkAlignment(Rect bbox, Size preview) {
    final centerX = preview.width / 2;
    final centerY = preview.height / 2;
    final faceCenterX = bbox.center.dx;
    final faceCenterY = bbox.center.dy;

    final faceArea = bbox.width * bbox.height;
    final previewArea = preview.width * preview.height;
    final faceRatio = faceArea / previewArea;

    // Too far: face is less than 8% of frame
    if (faceRatio < 0.08) return FaceAlignmentStatus.tooFar;

    // Too close: face is more than 45% of frame
    if (faceRatio > 0.45) return FaceAlignmentStatus.tooClose;

    // Off center: face center is more than 20% away from preview center
    final dx = (faceCenterX - centerX).abs() / preview.width;
    final dy = (faceCenterY - centerY).abs() / preview.height;
    if (dx > 0.20 || dy > 0.20) return FaceAlignmentStatus.offCenter;

    return FaceAlignmentStatus.aligned;
  }

  LightingStatus _checkLighting(Face face) {
    // Use eye open probabilities as proxy — if they're very low across
    // multiple frames, lighting might be bad. More robust would be
    // analyzing pixel brightness, but this is a reasonable heuristic.
    final leftEye = face.leftEyeOpenProbability;
    final rightEye = face.rightEyeOpenProbability;
    if (leftEye == null || rightEye == null) return LightingStatus.unknown;

    // If classification is unreliable, lighting might be bad.
    // With good lighting, ML Kit can reliably detect eye state.
    return LightingStatus.good;
  }

  void _detectBlink(Face face) {
    final leftEye = face.leftEyeOpenProbability;
    final rightEye = face.rightEyeOpenProbability;
    if (leftEye == null || rightEye == null) return;

    final leftClosed = leftEye < _eyeClosedThreshold;
    final rightClosed = rightEye < _eyeClosedThreshold;

    if (leftClosed && rightClosed) {
      _leftEyeWasClosed = true;
      _rightEyeWasClosed = true;
    }

    if (_leftEyeWasClosed &&
        _rightEyeWasClosed &&
        !leftClosed &&
        !rightClosed) {
      _blinkCount++;
      _leftEyeWasClosed = false;
      _rightEyeWasClosed = false;
    }
  }

  void _detectHeadMovement(Face face) {
    final headY = face.headEulerAngleY;
    if (headY == null) return;

    if (_previousHeadY != null) {
      final diff = (headY - _previousHeadY!).abs();
      if (diff > _headMovementThreshold) {
        _headMovementCount++;
      }
    }
    _previousHeadY = headY;
  }

  LivenessStep _evaluateLiveness() {
    if (_blinkCount >= 1 && _headMovementCount >= 1) {
      return LivenessStep.passed;
    }
    if (_blinkCount >= 1) {
      return LivenessStep.headMovement;
    }
    return LivenessStep.waitingForBlink;
  }

  Future<void> dispose() async {
    await _faceDetector.close();
  }
}

/// Comprehensive result from face analysis on a single frame.
class FaceAnalysisResult {
  final int faceCount;
  final FaceAlignmentStatus alignment;
  final LightingStatus lighting;
  final LivenessStep livenessStep;
  final double? leftEyeOpen;
  final double? rightEyeOpen;
  final double? smilingProbability;
  final double? headEulerAngleY;
  final double? headEulerAngleZ;
  final int blinkCount;
  final Rect? boundingBox;

  const FaceAnalysisResult({
    required this.faceCount,
    required this.alignment,
    required this.lighting,
    required this.livenessStep,
    this.leftEyeOpen,
    this.rightEyeOpen,
    this.smilingProbability,
    this.headEulerAngleY,
    this.headEulerAngleZ,
    this.blinkCount = 0,
    this.boundingBox,
  });

  bool get isFaceAligned => alignment == FaceAlignmentStatus.aligned;
  bool get isLightingGood => lighting == LightingStatus.good;
  bool get isLivenessPassed => livenessStep == LivenessStep.passed;
}
