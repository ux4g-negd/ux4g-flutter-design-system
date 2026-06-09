import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);

final discardDraftDialogComponent = WidgetbookComponent(
  name: 'Discard Draft Dialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Discard Draft Dialog',
          description:
              'A destructive confirmation dialog shown when the user wants to discard their saved draft '
              'and start the application from scratch. This action cannot be undone.',
          code: _discardDraftDialogCode,
          center: true,
          child: const _DiscardDraftDialogMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _discardDraftDialogCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void showDiscardDraftDialog(BuildContext context) {
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
              'Discard draft?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your saved progress will be deleted.\nThis cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4),
            ),
            const SizedBox(height: 24),
            Ux4gButton(
              text: 'Discard and start again',
              onPressed: () => Navigator.pop(context),
              size: Ux4gButtonSize.large,
              width: double.infinity,
              backgroundColor: const Color(0xFFDC2626),
            ),
            const SizedBox(height: 12),
            Ux4gButton(
              text: 'Keep my draft',
              onPressed: () => Navigator.pop(context),
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.large,
              width: double.infinity,
              contentColor: const Color(0xFF6B7280),
              borderColor: const Color(0xFFD1D5DB),
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

class _DiscardDraftDialogMockup extends StatelessWidget {
  const _DiscardDraftDialogMockup();

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
                'Discard draft?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your saved progress will be deleted.\nThis cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
              ),
              const SizedBox(height: 24),
              Ux4gButton(
                text: 'Discard and start again',
                onPressed: () {},
                size: Ux4gButtonSize.large,
                width: double.infinity,
                backgroundColor: const Color(0xFFDC2626),
              ),
              const SizedBox(height: 12),
              Ux4gButton(
                text: 'Keep my draft',
                onPressed: () {},
                variant: Ux4gButtonVariant.outline,
                size: Ux4gButtonSize.large,
                width: double.infinity,
                contentColor: const Color(0xFF6B7280),
                borderColor: const Color(0xFFD1D5DB),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
