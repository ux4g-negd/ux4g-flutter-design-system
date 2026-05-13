import 'package:flutter/material.dart';
import 'biometric_controller.dart';
import 'biometric_state.dart';
import 'biometric_theme.dart';
import 'device_check_card.dart';

/// Device check card matching the reference design.
///
/// Can be used as a standalone full-screen or as a floating card overlay.
/// Shows "Device Check" title, check rows, helper text, and proceed button.
class DeviceCheckScreen extends StatefulWidget {
  final BiometricController controller;
  final VoidCallback onProceed;

  /// If true, renders as a compact floating card (for camera overlay).
  final bool compact;

  const DeviceCheckScreen({
    super.key,
    required this.controller,
    required this.onProceed,
    this.compact = false,
  });

  @override
  State<DeviceCheckScreen> createState() => _DeviceCheckScreenState();
}

class _DeviceCheckScreenState extends State<DeviceCheckScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.state == BiometricFlowState.initial ||
          widget.controller.deviceChecks.isEmpty) {
        widget.controller.startDeviceChecks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final checks = widget.controller.deviceChecks;
        final allPassed =
            widget.controller.state == BiometricFlowState.deviceReady;
        final hasFailed = checks.any(
          (c) => c.status == DeviceCheckStatus.failed,
        );

        // Collect helper texts from failed items
        final helperTexts = checks
            .where(
              (c) =>
                  c.status == DeviceCheckStatus.failed && c.helperText != null,
            )
            .map((c) => c.helperText!)
            .toList();

        final card = Container(
          padding: EdgeInsets.all(widget.compact ? 16 : 20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(theme.cardRadius),
            border: Border.all(color: colors.onSurface.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Device Check',
                style: theme.typography.title.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),

              // Check rows
              ...List.generate(
                checks.length,
                (i) => DeviceCheckCard(item: checks[i], index: i),
              ),

              // Helper text for failures
              if (hasFailed && helperTexts.isNotEmpty) ...[
                const SizedBox(height: 4),
                ...helperTexts.map(
                  (text) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      text,
                      style: theme.typography.caption.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],

              // Proceed button (only when all passed)
              if (allPassed) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: widget.onProceed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.success,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'All systems ready — proceed to verify',
                          style: theme.typography.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );

        if (widget.compact) return card;

        // Full-screen layout
        return Container(
          color: colors.cardBackground,
          child: SafeArea(
            child: Center(
              child: Padding(padding: theme.screenPadding, child: card),
            ),
          ),
        );
      },
    );
  }
}
