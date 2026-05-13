import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

/// Service responsible for managing the device camera.
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isStreaming = false;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isStreaming => _isStreaming;

  /// Discover available cameras and find the front camera.
  Future<CameraDescription?> _getFrontCamera() async {
    _cameras ??= await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) return null;
    try {
      return _cameras!.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
      );
    } catch (_) {
      return null;
    }
  }

  /// Check if a front camera is available.
  Future<bool> isCameraAvailable() async {
    final cam = await _getFrontCamera();
    return cam != null;
  }

  /// Initialize the front camera.
  Future<void> initialize() async {
    final cam = await _getFrontCamera();
    if (cam == null) throw Exception('No front camera available');

    _controller = CameraController(
      cam,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: defaultTargetPlatform == TargetPlatform.iOS
          ? ImageFormatGroup.bgra8888
          : ImageFormatGroup.nv21,
    );

    await _controller!.initialize();
    _isInitialized = true;
  }

  /// Start the image stream. Callback receives each frame.
  void startImageStream(void Function(CameraImage image) onImage) {
    if (_controller == null || !_isInitialized || _isStreaming) return;
    _controller!.startImageStream(onImage);
    _isStreaming = true;
  }

  /// Stop the image stream.
  Future<void> stopImageStream() async {
    if (!_isStreaming || _controller == null) return;
    try {
      await _controller!.stopImageStream();
    } catch (_) {}
    _isStreaming = false;
  }

  /// Pause the camera preview stream.
  Future<void> pausePreview() async {
    if (_controller == null || !_isInitialized) return;
    try {
      await _controller!.pausePreview();
    } catch (_) {}
  }

  /// Resume the camera preview stream.
  Future<void> resumePreview() async {
    if (_controller == null || !_isInitialized) return;
    try {
      await _controller!.resumePreview();
    } catch (_) {}
  }

  /// Take a picture and return the bytes.
  Future<Uint8List?> captureImage() async {
    if (_controller == null || !_isInitialized) return null;
    if (_isStreaming) await stopImageStream();
    final file = await _controller!.takePicture();
    return file.readAsBytes();
  }

  /// Dispose the camera controller.
  Future<void> dispose() async {
    if (_isStreaming) await stopImageStream();
    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isStreaming = false;
  }
}
