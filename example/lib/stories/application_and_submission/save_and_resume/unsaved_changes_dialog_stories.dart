import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);

final unsavedChangesDialogComponent = WidgetbookComponent(
  name: 'Unsaved Changes Dialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Unsaved Changes Dialog',
          description:
              'A confirmation dialog shown when the user attempts to leave a page with unsaved changes, '
              'offering options to save draft or leave without saving.',
          code: _unsavedChangesDialogCode,
          center: true,
          child: const _UnsavedChangesDialogMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _unsavedChangesDialogCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void showUnsavedChangesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Unsaved changes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 12),
            const Text(
              'If you leave now, changes since your last save will be lost.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4),
            ),
            const SizedBox(height: 24),
            Ux4gButton(
              text: 'Save draft and leave',
              onPressed: () => Navigator.pop(context),
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Leave without saving',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFDC2626)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _UnsavedChangesDialogMockup extends StatelessWidget {
  const _UnsavedChangesDialogMockup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Unsaved changes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'If you leave now, changes since your last save will be lost.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
              ),
              const SizedBox(height: 24),
              Ux4gButton(
                text: 'Save draft and leave',
                onPressed: () {},
                size: Ux4gButtonSize.large,
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              const Text(
                'Leave without saving',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFDC2626),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
