import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);

final confirmAppointmentComponent = WidgetbookComponent(
  name: 'Confirm Appointment',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Confirm Appointment',
          description:
              'Appointment confirmation screen with booking details summary, '
              'timer warning, and confirm/change slot actions.',
          code: _confirmAppointmentCode,
          center: true,
          child: const _ConfirmAppointmentMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _confirmAppointmentCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text('Confirm appointment', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Review before confirming. Slot not reserved until confirmed.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Details card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFA391FF)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _DetailRow(label: 'Date & time', value: 'Thu, 18 Apr 2026 · 11:00 – 11:30 AM'),
                          const SizedBox(height: 16),
                          _DetailRow(label: 'Advocate', value: 'Adv. M. Sharma · Family Law'),
                          const SizedBox(height: 16),
                          _DetailRow(label: 'Office', value: 'Block C, Room 12, District Legal Services Authority, Pune'),
                          const SizedBox(height: 16),
                          _DetailRow(label: 'Consultation type', value: 'In-person · 30 minutes'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Warning
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Slot held for 5 minutes — confirm soon.',
                        style: TextStyle(fontSize: 13, color: Color(0xFFB45309)),
                        textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 16),
                    // Confirm button
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Confirm booking',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                        backgroundColor: const Color(0xFF4A2BC2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Choose different slot
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Choose different slot',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        contentColor: const Color(0xFF432CBB),
                        borderColor: const Color(0xFFE5E7EB),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, color: Color(0xFF111827))),
      ],
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _ConfirmAppointmentMockup extends StatelessWidget {
  const _ConfirmAppointmentMockup();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: _primaryColor,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'National Services Portal',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Confirm appointment',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Review before confirming. Slot not reserved until confirmed.',
                        style: TextStyle(fontSize: 13, color: _subtleText),
                      ),
                      const SizedBox(height: 24),

                      // Details card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F3FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFA391FF)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _DetailItem(label: 'Date & time', value: 'Thu, 18 Apr 2026 · 11:00 – 11:30 AM'),
                            SizedBox(height: 16),
                            _DetailItem(label: 'Advocate', value: 'Adv. M. Sharma · Family Law'),
                            SizedBox(height: 16),
                            _DetailItem(label: 'Office', value: 'Block C, Room 12, District Legal Services Authority, Pune'),
                            SizedBox(height: 16),
                            _DetailItem(label: 'Consultation type', value: 'In-person · 30 minutes'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Warning banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE7BF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Slot held for 5 minutes — confirm soon.',
                          style: TextStyle(fontSize: 13, color: Color(0xFFAD4E00)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirm button
                      SizedBox(
                        width: double.infinity,
                        child: Ux4gButton(
                          text: 'Confirm booking',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.primary,
                          size: Ux4gButtonSize.large,
                          backgroundColor: const Color(0xFF4A2BC2),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Choose different slot button
                      SizedBox(
                        width: double.infinity,
                        child: Ux4gButton(
                          text: 'Choose different slot',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.outline,
                          size: Ux4gButtonSize.large,
                          contentColor: _primaryColor,
                          borderColor: const Color(0xFFA391FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _subtleText)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, color: _titleColor)),
      ],
    );
  }
}
