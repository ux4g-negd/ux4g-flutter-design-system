import 'package:flutter/material.dart';
import 'biometric_state.dart';
import 'biometric_theme.dart';

/// A single device check row matching the reference design.
///
/// Layout: icon | label | spacer | status_icon + status_text
class DeviceCheckCard extends StatelessWidget {
  final DeviceCheckItem item;
  final int index;

  const DeviceCheckCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Left icon
          Icon(
            _iconForLabel(item.label),
            size: 18,
            color: colors.onSurface.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 10),

          // Label
          Expanded(
            child: Text(
              item.label,
              style: theme.typography.body.copyWith(
                color: colors.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),

          // Status indicator
          _buildStatus(item.status, colors, theme),
        ],
      ),
    );
  }

  Widget _buildStatus(
    DeviceCheckStatus status,
    BiometricColors colors,
    BiometricThemeData theme,
  ) {
    return switch (status) {
      DeviceCheckStatus.pending => Text(
        '—',
        style: theme.typography.caption.copyWith(
          color: colors.onSurface.withValues(alpha: 0.3),
        ),
      ),
      DeviceCheckStatus.checking => SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2, color: colors.primary),
      ),
      DeviceCheckStatus.passed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, size: 16, color: colors.success),
          const SizedBox(width: 4),
          Text(
            item.passedText,
            style: theme.typography.caption.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      DeviceCheckStatus.failed => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 16, color: colors.error),
          const SizedBox(width: 4),
          Text(
            item.failedText,
            style: theme.typography.caption.copyWith(
              color: colors.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    };
  }

  IconData _iconForLabel(String label) {
    final lower = label.toLowerCase();
    if (lower.contains('camera')) return Icons.camera_alt_outlined;
    if (lower.contains('lighting') || lower.contains('light')) {
      return Icons.wb_sunny_outlined;
    }
    if (lower.contains('uidai') ||
        lower.contains('connection') ||
        lower.contains('internet')) {
      return Icons.wifi;
    }
    if (lower.contains('permission')) return Icons.lock_outline;
    if (lower.contains('fingerprint')) return Icons.fingerprint;
    if (lower.contains('scanner') || lower.contains('driver')) {
      return Icons.settings_outlined;
    }
    if (lower.contains('sdk')) return Icons.code;
    return Icons.check_circle_outline;
  }
}
