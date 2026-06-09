import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _dangerColor = Color(0xFFDB372D);

final deleteAccountDialogComponent = WidgetbookComponent(
  name: 'Delete Account Dialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Delete Account Dialog',
          description:
              'A destructive confirmation dialog shown when the user taps '
              '"Delete my account". Uses Ux4gModal with isDestructive style.',
          code: _deleteAccountDialogCode,
          center: true,
          child: const _DeleteAccountDialogMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _deleteAccountDialogCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Show the delete account confirmation dialog
void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Ux4gModal(
        onDismiss: () => Navigator.pop(context),
        showHeader: true,
        headerTitle: 'Delete your account?',
        alignment: Ux4gModalAlignment.centered,
        showSubtitle: false,
        showBody: true,
        bodyText:
            'This permanently deletes your account and all associated data. '
            'You will have a 30-day grace period to restore it — after that, '
            'deletion is final and cannot be undone.',
        showDividers: false,
        showFooter: true,
        footerButtons: Ux4gModalFooterButtons.twoButtons,
        footerAlign: Ux4gModalFooterAlign.center,
        isDestructive: true,
        primaryButtonText: 'Delete account',
        secondaryButtonText: 'Cancel',
        showCloseButton: false,
        onPrimaryClick: () {
          // Handle delete
          Navigator.pop(context);
        },
        onSecondaryClick: () => Navigator.pop(context),
      ),
    ),
  );
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _DeleteAccountDialogMockup extends StatelessWidget {
  const _DeleteAccountDialogMockup();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Container(
        width: 360,
        height: 400,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Delete your account?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _titleColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Description
                const Text(
                  'This permanently deletes your account and all associated data. You will have a 30-day grace period to restore it — after that, deletion is final and cannot be undone.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _subtleText,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Delete account button (red filled)
                SizedBox(
                  width: double.infinity,
                  child: Ux4gButton(
                    text: 'Delete account',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.primary,
                    backgroundColor: _dangerColor,
                    contentColor: Colors.white,
                    height: 48,
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel text button
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _titleColor,
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
