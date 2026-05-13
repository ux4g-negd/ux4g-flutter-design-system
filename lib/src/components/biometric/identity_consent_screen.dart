import 'package:flutter/material.dart';
import 'biometric_theme.dart';

/// Initial consent screen shown before biometric verification begins.
///
/// Matches the reference design: shield icon, title, description,
/// "Allow and verify" button, "Decline - Verify with OTP instead" button.
class IdentityConsentScreen extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback? onDecline;

  const IdentityConsentScreen({
    super.key,
    required this.onAllow,
    this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BiometricTheme.of(context);
    final colors = theme.colors;

    return Container(
      color: colors.surface,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: theme.screenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Shield icon
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.primary.withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 36,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Identity Verification',
                  style: theme.typography.headline.copyWith(
                    color: colors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Your face will be matched against your Aadhaar photo. No biometric data is stored on this device.',
                    style: theme.typography.body.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Allow and verify button
                SizedBox(
                  width: 260,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onAllow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(theme.buttonRadius),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Allow and verify',
                      style: theme.typography.button,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Decline button
                if (onDecline != null)
                  SizedBox(
                    width: 260,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: onDecline,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.primary,
                        side: BorderSide(
                          color: colors.primary.withValues(alpha: 0.4),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            theme.buttonRadius,
                          ),
                        ),
                      ),
                      child: Text(
                        'Decline - Verify with OTP instead',
                        style: theme.typography.button.copyWith(
                          color: colors.primary,
                          fontSize: 14,
                        ),
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
