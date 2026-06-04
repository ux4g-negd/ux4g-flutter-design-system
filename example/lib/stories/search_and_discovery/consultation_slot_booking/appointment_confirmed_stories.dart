import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);

final appointmentConfirmedComponent = WidgetbookComponent(
  name: 'Appointment Confirmed',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Appointment Confirmed',
          description:
              'Success screen after booking confirmation with reference number, '
              'appointment details, and action buttons.',
          code: _appointmentConfirmedCode,
          center: true,
          child: const _AppointmentConfirmedMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _appointmentConfirmedCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class AppointmentConfirmedScreen extends StatelessWidget {
  const AppointmentConfirmedScreen({super.key});

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Success icon
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check_circle, size: 36, color: Color(0xFF16A34A)),
                    ),
                    const SizedBox(height: 16),
                    Text('Appointment confirmed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Reference  ', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                        Text('APPT-2026-04127', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("We've sent details to your email and SMS.",
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
                          _DetailRow(label: 'Documents to carry', value: 'Aadhaar, case papers, ID proof'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Add to calendar
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Add to calendar',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        contentColor: Color(0xFF432CBB),
                        borderColor: Color(0xFFA391FF),
                        leadingIcon: Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Get directions
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Get directions',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        contentColor: Color(0xFF432CBB),
                        borderColor: Color(0xFFA391FF),
                        leadingIcon: Icons.explore_outlined,
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

class _AppointmentConfirmedMockup extends StatelessWidget {
  const _AppointmentConfirmedMockup();

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
                    children: [
                      const SizedBox(height: 24),

                      // Success icon
                      Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDCFCE7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle, size: 36, color: Color(0xFF16A34A)),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      const Text(
                        'Appointment confirmed',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _titleColor),
                      ),
                      const SizedBox(height: 8),

                      // Reference
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Reference  ', style: TextStyle(fontSize: 13, color: _subtleText)),
                          Text('APPT-2026-04127', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _titleColor)),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      const Text(
                        "We've sent details to your email and SMS.",
                        style: TextStyle(fontSize: 13, color: _subtleText),
                      ),
                      const SizedBox(height: 24),

                      // Details card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
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
                            _DetailItem(label: 'Documents to carry', value: 'Aadhaar, case papers, ID proof'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Add to calendar button
                      SizedBox(
                        width: double.infinity,
                        child: Ux4gButton(
                          text: 'Add to calendar',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.outline,
                          size: Ux4gButtonSize.large,
                          contentColor: _primaryColor,
                          borderColor: const Color(0xFFA391FF),
                          leadingIcon: Icons.calendar_today,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Get directions button
                      SizedBox(
                        width: double.infinity,
                        child: Ux4gButton(
                          text: 'Get directions',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.outline,
                          size: Ux4gButtonSize.large,
                          contentColor: _primaryColor,
                          borderColor: const Color(0xFFA391FF),
                          leadingIcon: Icons.explore_outlined,
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
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF404040))),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF171717))),
      ],
    );
  }
}
