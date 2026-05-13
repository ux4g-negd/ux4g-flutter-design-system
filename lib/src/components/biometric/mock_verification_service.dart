import 'dart:async';
import 'dart:typed_data';
import 'biometric_state.dart';

/// Callback type for verification API.
typedef VerifyCallback =
    Future<BiometricVerificationResult> Function(Uint8List imageBytes);

/// Mock verification service for testing.
/// Replace with real API integration for production.
class MockVerificationService {
  final Duration delay;
  final bool simulateSuccess;

  const MockVerificationService({
    this.delay = const Duration(seconds: 3),
    this.simulateSuccess = true,
  });

  /// Simulate a verification API call.
  Future<BiometricVerificationResult> verify(Uint8List imageBytes) async {
    await Future.delayed(delay);

    if (simulateSuccess) {
      return const BiometricVerificationResult(
        success: true,
        userId: 'USR-2024-001',
        maskedName: 'Mo***ar',
        maskedPhone: '****1234',
        message: 'Identity verified successfully',
        confidenceScore: 0.97,
      );
    } else {
      return const BiometricVerificationResult(
        success: false,
        message: 'Face verification failed',
        errorCode: 'VERIFICATION_FAILED',
        confidenceScore: 0.32,
      );
    }
  }
}
