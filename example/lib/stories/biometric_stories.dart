import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

import '../widgets/component_docs.dart';

// ── Biometric Verification ────────────────────────────────────────────────────

final biometricComponent = WidgetbookComponent(
  name: 'BiometricVerificationFlow',
  useCases: [
    // ── 1. Success Flow ──────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Simulate Success Flow',
      builder: (context) => ComponentDocs(
        name: 'BiometricVerificationFlow — Success',
        description:
            'Full biometric verification lifecycle: device checks → camera → '
            'face detection → liveness → verification → success screen. '
            'Uses the built-in mock service (mockSuccess: true) for preview. '
            'On a real device, replace onVerify with your API call.',
        code: '''// Wrap in a full-screen Scaffold
Scaffold(
  body: BiometricVerificationFlow(
    enableBlinkCheck: true,
    enableLightingCheck: true,
    enableLiveness: true,
    maxAttempts: 3,
    mockSuccess: true,        // remove in production
    onSuccess: (result) {
      print('Verified: \${result.maskedName}');
    },
    onFailure: (reason, message) {
      // handled internally — shows retry UI
    },
    onDismiss: () => Navigator.of(context).pop(),
    onAlternateVerify: () {
      // navigate to OTP flow
    },
  ),
);''',
        props: const [
          PropRow(name: 'onSuccess', type: 'void Function(BiometricVerificationResult)?', description: 'Called when face verification succeeds. Result contains maskedName, maskedPhone, confidenceScore.'),
          PropRow(name: 'onFailure', type: 'void Function(VerificationFailureReason, String?)?', description: 'Called on unrecoverable failure. Reasons: livenessFailed, faceNotMatched, networkError, etc.'),
          PropRow(name: 'onDismiss', type: 'VoidCallback?', description: 'Called when user closes the flow.'),
          PropRow(name: 'onAlternateVerify', type: 'VoidCallback?', description: 'Called when user taps "Verify with OTP instead".'),
          PropRow(name: 'onVerify', type: 'Future<BiometricVerificationResult> Function(Uint8List)?', description: 'Custom API callback. Pass null to use mock service.'),
          PropRow(name: 'enableBlinkCheck', type: 'bool', description: 'Require blink detection for liveness.', defaultValue: 'true'),
          PropRow(name: 'enableLightingCheck', type: 'bool', description: 'Check ambient lighting before capture.', defaultValue: 'true'),
          PropRow(name: 'enableLiveness', type: 'bool', description: 'Require liveness (blink + head movement).', defaultValue: 'true'),
          PropRow(name: 'maxAttempts', type: 'int', description: 'Max verification attempts before lockout.', defaultValue: '2'),
          PropRow(name: 'lockoutDuration', type: 'Duration', description: 'Duration of lockout after max attempts.', defaultValue: 'Duration(minutes: 30)'),
          PropRow(name: 'mockSuccess', type: 'bool', description: 'Mock service returns success. For testing only.', defaultValue: 'true'),
          PropRow(name: 'verificationTimeout', type: 'Duration', description: 'Timeout for the entire verification process.', defaultValue: 'Duration(seconds: 30)'),
          PropRow(name: 'theme', type: 'BiometricThemeData?', description: 'Custom colors, typography, radii. Falls back to default purple theme.'),
        ],
        center: false,
        child: _BiometricFlowPreview(mockSuccess: true),
      ),
    ),

    // ── 2. Failure Flow ──────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Simulate Failure Flow',
      builder: (context) => ComponentDocs(
        name: 'BiometricVerificationFlow — Failure',
        description:
            'Same flow with mockSuccess: false — the verification API returns '
            'a failure, triggering the retry/lockout logic. After maxAttempts '
            'the user sees an OTP fallback option.',
        code: '''BiometricVerificationFlow(
  enableBlinkCheck: true,
  enableLightingCheck: true,
  enableLiveness: true,
  maxAttempts: 2,
  mockSuccess: false,     // simulate failure
  lockoutDuration: const Duration(minutes: 30),
  onSuccess: (result) { ... },
  onFailure: (reason, message) { ... },
  onDismiss: () => Navigator.of(context).pop(),
  onAlternateVerify: () { /* navigate to OTP */ },
);''',
        center: false,
        child: _BiometricFlowPreview(mockSuccess: false),
      ),
    ),

    // ── 3. Consent Screen (standalone) ───────────────────────────────────
    WidgetbookUseCase(
      name: 'Identity Consent Screen',
      builder: (context) => ComponentDocs(
        name: 'IdentityConsentScreen',
        description:
            'The first screen shown in the flow. Displays a shield icon, '
            'privacy notice about Aadhaar matching, and two CTAs: '
            '"Allow and verify" and "Verify with OTP instead".',
        code: '''// Standalone usage
BiometricTheme(
  data: const BiometricThemeData(),
  child: IdentityConsentScreen(
    onAllow: () {
      // proceed to device checks
    },
    onDecline: () {
      // switch to OTP
    },
  ),
);''',
        child: SizedBox(
          width: 360,
          height: 420,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BiometricTheme(
              data: const BiometricThemeData(),
              child: IdentityConsentScreen(
                onAllow: () {},
                onDecline: () {},
              ),
            ),
          ),
        ),
      ),
    ),

    // ── 4. Device Check Screen (standalone) ──────────────────────────────
    WidgetbookUseCase(
      name: 'Device Check Screen',
      builder: (context) => ComponentDocs(
        name: 'DeviceCheckScreen',
        description:
            'Runs three async checks (camera, network, lighting) with animated '
            'status indicators. "Proceed" button activates once all checks pass.',
        code: '''final controller = BiometricController();

BiometricTheme(
  data: const BiometricThemeData(),
  child: DeviceCheckScreen(
    controller: controller,
    onProceed: () {
      // move to camera capture
    },
  ),
);''',
        child: SizedBox(
          width: 360,
          height: 480,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BiometricTheme(
              data: const BiometricThemeData(),
              child: DeviceCheckScreen(
                controller: BiometricController(),
                onProceed: () {},
              ),
            ),
          ),
        ),
      ),
    ),

    // ── 5. Custom Theme ──────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Custom Theme',
      builder: (context) => ComponentDocs(
        name: 'BiometricVerificationFlow — Custom Theme',
        description:
            'Pass a BiometricThemeData to customise colors, corner radii, '
            'typography, and animation timing across the entire flow.',
        code: '''BiometricVerificationFlow(
  mockSuccess: true,
  theme: BiometricThemeData(
    colors: BiometricColors(
      primary: Color(0xFF0057FF),
      success: Color(0xFF00C48C),
      ovalActive: Color(0xFF00C48C),
    ),
    cardRadius: 20,
    buttonRadius: 8,
  ),
  onSuccess: (result) { ... },
  onDismiss: () => Navigator.of(context).pop(),
);''',
        center: false,
        child: _BiometricFlowPreview(
          mockSuccess: true,
          theme: const BiometricThemeData(
            colors: BiometricColors(
              primary: Color(0xFF0057FF),
              success: Color(0xFF00C48C),
              ovalActive: Color(0xFF00C48C),
            ),
            cardRadius: 20,
            buttonRadius: 8,
          ),
        ),
      ),
    ),
  ],
);

// ─────────────────────────────────────────────────────────────────────────────
// Internal preview widget — renders the flow inside a phone-sized container
// ─────────────────────────────────────────────────────────────────────────────

class _BiometricFlowPreview extends StatefulWidget {
  const _BiometricFlowPreview({
    required this.mockSuccess,
    this.theme,
  });

  final bool mockSuccess;
  final BiometricThemeData? theme;

  @override
  State<_BiometricFlowPreview> createState() => _BiometricFlowPreviewState();
}

class _BiometricFlowPreviewState extends State<_BiometricFlowPreview> {
  bool _launched = false;
  String? _resultMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Phone-frame container
          Container(
            width: 360,
            height: 640,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD1D5DB), width: 1.5),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: _launched
                ? BiometricVerificationFlow(
                    mockSuccess: widget.mockSuccess,
                    theme: widget.theme,
                    enableBlinkCheck: true,
                    enableLightingCheck: true,
                    enableLiveness: true,
                    maxAttempts: 3,
                    onSuccess: (result) {
                      setState(() {
                        _launched = false;
                        _resultMessage =
                            '✓ Verified: ${result.maskedName ?? "Success"}';
                      });
                    },
                    onFailure: (reason, message) {
                      setState(() {
                        _launched = false;
                        _resultMessage = '✗ Failed: ${reason.name}';
                      });
                    },
                    onDismiss: () => setState(() => _launched = false),
                    onAlternateVerify: () {
                      setState(() {
                        _launched = false;
                        _resultMessage = '→ Redirected to OTP flow';
                      });
                    },
                  )
                : _LaunchCard(
                    mockSuccess: widget.mockSuccess,
                    resultMessage: _resultMessage,
                    onLaunch: () => setState(() {
                      _launched = true;
                      _resultMessage = null;
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}

class _LaunchCard extends StatelessWidget {
  const _LaunchCard({
    required this.mockSuccess,
    required this.onLaunch,
    this.resultMessage,
  });

  final bool mockSuccess;
  final String? resultMessage;
  final VoidCallback onLaunch;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F9FC),
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6A4EFF).withValues(alpha: 0.12),
            ),
            child: const Icon(
              Icons.face_retouching_natural,
              size: 36,
              color: Color(0xFF6A4EFF),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Biometric Verification',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            mockSuccess
                ? 'Mock mode: simulates a successful verification flow'
                : 'Mock mode: simulates a failed verification flow',
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            textAlign: TextAlign.center,
          ),
          if (resultMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: resultMessage!.startsWith('✓')
                    ? const Color(0xFFDCFCE7)
                    : resultMessage!.startsWith('→')
                        ? const Color(0xFFE0F2FE)
                        : const Color(0xFFFFE4E6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                resultMessage!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: resultMessage!.startsWith('✓')
                      ? const Color(0xFF166534)
                      : resultMessage!.startsWith('→')
                          ? const Color(0xFF075985)
                          : const Color(0xFF991B1B),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onLaunch,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(
                'Launch Flow',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A4EFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
