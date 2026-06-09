import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/component_docs.dart';

const Color _bg = Color(0xFFFAFAFA);
const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final documentScanUploadComponent = WidgetbookComponent(
  name: 'Document scan & upload',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive Preview',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Layout Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
        );

        final isCardStyle = variant == 'Card style';
        final code = isCardStyle
            ? _documentUploadCardCode
            : _documentUploadDefaultCode;

        return ComponentDocs(
          mobileMockup: true,
          name: 'Document scan & upload',
          description:
              'A pattern for scanning and uploading multiple documents with status indicators and DigiLocker integration.',
          code: code,
          center: true,
          child: isCardStyle
              ? const _DocumentUploadCardMockup()
              : const _DocumentUploadMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Shared helpers
// ───────────────────────────────────────────────────────────────────────

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 760,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _documentUploadDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 1),
                Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 1),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stepper
                    Ux4gStepper(
                      totalSteps: 4, currentStep: 3, stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    const Text('Upload documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    const SizedBox(height: 8),
                    const Text('PDF or JPG, max 5 MB each. Self-attested.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),

                    const Text('Required documents — 1 of 4 uploaded', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                    const SizedBox(height: 24),

                    // Aadhaar Card (Uploaded)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDCFCE7)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Aadhaar Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                                    const SizedBox(height: 4),
                                    const Text('aadhaar_card.pdf · 1.2 MB · Uploaded just now', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Ux4gButton(text: 'View', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 100),
                              const SizedBox(width: 12),
                              Ux4gButton(text: 'Re-upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 120),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Proof of Income
                    _DocumentItem(
                      title: 'Proof of Income',
                      subtitle: 'Salary slip or income tax return',
                      badge: 'Required',
                      badgeColor: const Color(0xFFFEE2E2),
                      badgeTextColor: const Color(0xFF991B1B),
                    ),
                    const SizedBox(height: 24),

                    // Residence Proof
                    _DocumentItem(
                      title: 'Residence proof',
                      subtitle: 'Electricity bill, gas bill or ration card',
                      badge: 'Required',
                      badgeColor: const Color(0xFFFEE2E2),
                      badgeTextColor: const Color(0xFF991B1B),
                    ),
                    const SizedBox(height: 24),

                    // Caste Certificate
                    _DocumentItem(
                      title: 'Caste certificate',
                      subtitle: 'SC/ST/OBC applicants only',
                      badge: 'Optional',
                      badgeColor: const Color(0xFFF3F4F6),
                      badgeTextColor: const Color(0xFF374151),
                      showDigiLocker: false,
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                    ),
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String title, subtitle, badge;
  final Color badgeColor, badgeTextColor;
  final bool showDigiLocker;

  const _DocumentItem({
    required this.title, required this.subtitle, required this.badge,
    required this.badgeColor, required this.badgeTextColor,
    this.showDigiLocker = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFD1D5DB)))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                          child: Text(badge, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: badgeTextColor)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Ux4gButton(text: 'Upload', onPressed: () {}, size: Ux4gButtonSize.small, width: 100),
          if (showDigiLocker) ...[
            const SizedBox(height: 12),
            Ux4gButton(text: 'Fetch from DigiLocker', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 220),
          ],
        ],
      ),
    );
  }
}
""";

const _documentUploadCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentUploadCardScreen extends StatelessWidget {
  const DocumentUploadCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Ux4gAppHeader(
                    variant: Ux4gAppHeaderVariant.light,
                    leadingWidgets: [
                      SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                      const SizedBox(width: 1),
                      Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                      const SizedBox(width: 1),
                      SvgPicture.asset('assets/Union.svg', height: 32),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFE5E7EB)),
                ],
              ),
            ),

            // Card Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Ux4gStepper(
                        totalSteps: 4, currentStep: 3, stepSize: 20,
                        steps: const [
                          Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: ''),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text('Upload documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                      const SizedBox(height: 8),
                      const Text('PDF or JPG, max 5 MB each.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563))),
                      const SizedBox(height: 24),

                      _DocumentItem(title: 'Aadhaar Card', subtitle: 'Self-attested copy', badge: 'Required', badgeColor: Color(0xFFFEE2E2), badgeTextColor: Color(0xFF991B1B)),
                      const SizedBox(height: 16),
                      _DocumentItem(title: 'Residence proof', subtitle: 'Electricity bill or Ration card', badge: 'Required', badgeColor: Color(0xFFFEE2E2), badgeTextColor: Color(0xFF991B1B)),
                    ],
                  ),
                ),
              ),
            ),

            // Actions & Footer
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Column(
                children: [
                  Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockups
// ───────────────────────────────────────────────────────────────────────

class _DocumentUploadMockup extends StatelessWidget {
  const _DocumentUploadMockup();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    return _PhoneFrame(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingWidgets: [
                  SvgPicture.asset(_nationalEmblemLogoPath, height: 40),
                  const SizedBox(width: 1),
                  Container(
                    height: 32,
                    width: 1,
                    color: const Color(0xFFD1D5DB),
                  ),
                  const SizedBox(width: 1),
                  SvgPicture.asset(_unionLogoPath, height: 32),
                ],
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Ux4gStepper(
                        totalSteps: 4,
                        currentStep: 3,
                        stepSize: 20,
                        steps: const [
                          Ux4gStepItem(
                            title: 'Eligibility',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(
                            title: 'Personal',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(
                            title: 'Documents',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(title: ''),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Upload documents',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'PDF or JPG, max 5 MB each. Self-attested.',
                        style: TextStyle(fontSize: 15, color: _subtleText),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Required documents — 1 of 4 uploaded',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Aadhaar Card (Uploaded)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCFCE7)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF16A34A),
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Aadhaar Card',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: _titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'aadhaar_card.pdf · 1.2 MB · Uploaded just now',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: _subtleText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Ux4gButton(
                                  text: 'View',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.outline,
                                  size: Ux4gButtonSize.small,
                                  width: 100,
                                ),
                                const SizedBox(width: 12),
                                Ux4gButton(
                                  text: 'Re-upload',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.outline,
                                  size: Ux4gButtonSize.small,
                                  width: 120,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _MockDocumentItem(
                        title: 'Proof of Income',
                        subtitle: 'Salary slip or income tax return',
                        badge: 'Required',
                        badgeColor: const Color(0xFFFEE2E2),
                        badgeTextColor: const Color(0xFF991B1B),
                      ),
                      const SizedBox(height: 24),

                      _MockDocumentItem(
                        title: 'Residence proof',
                        subtitle: 'Electricity bill, gas bill or ration card',
                        badge: 'Required',
                        badgeColor: const Color(0xFFFEE2E2),
                        badgeTextColor: const Color(0xFF991B1B),
                      ),
                      const SizedBox(height: 24),

                      _MockDocumentItem(
                        title: 'Caste certificate',
                        subtitle: 'SC/ST/OBC applicants only',
                        badge: 'Optional',
                        badgeColor: const Color(0xFFF3F4F6),
                        badgeTextColor: const Color(0xFF374151),
                        showDigiLocker: false,
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 12),
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                      contentColor: primaryColor,
                      borderColor: primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Powered by -',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(_digitalIndiaLogoPath, height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentUploadCardMockup extends StatelessWidget {
  const _DocumentUploadCardMockup();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    return _PhoneFrame(
      child: Scaffold(
        backgroundColor: _cardBg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Ux4gAppHeader(
                      variant: Ux4gAppHeaderVariant.light,
                      title: '',
                      leadingWidgets: [
                        SvgPicture.asset(_nationalEmblemLogoPath, height: 40),
                        const SizedBox(width: 1),
                        Container(
                          height: 32,
                          width: 1,
                          color: const Color(0xFFD1D5DB),
                        ),
                        const SizedBox(width: 1),
                        SvgPicture.asset(_unionLogoPath, height: 32),
                      ],
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Ux4gStepper(
                          totalSteps: 4,
                          currentStep: 3,
                          stepSize: 20,
                          steps: const [
                            Ux4gStepItem(
                              title: 'Eligibility',
                              titleStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Ux4gStepItem(
                              title: 'Personal',
                              titleStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Ux4gStepItem(
                              title: 'Documents',
                              titleStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Ux4gStepItem(title: ''),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Upload documents',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: _titleColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'PDF or JPG, max 5 MB each.',
                          style: TextStyle(fontSize: 15, color: _subtleText),
                        ),
                        const SizedBox(height: 24),

                        _MockDocumentItem(
                          title: 'Aadhaar Card',
                          subtitle: 'Self-attested copy',
                          badge: 'Required',
                          badgeColor: const Color(0xFFFEE2E2),
                          badgeTextColor: const Color(0xFF991B1B),
                        ),
                        const SizedBox(height: 16),
                        _MockDocumentItem(
                          title: 'Residence proof',
                          subtitle: 'Electricity bill or Ration card',
                          badge: 'Required',
                          badgeColor: const Color(0xFFFEE2E2),
                          badgeTextColor: const Color(0xFF991B1B),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 12),
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                      contentColor: primaryColor,
                      borderColor: primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Powered by -',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(_digitalIndiaLogoPath, height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockDocumentItem extends StatelessWidget {
  final String title, subtitle, badge;
  final Color badgeColor, badgeTextColor;
  final bool showDigiLocker;

  const _MockDocumentItem({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.badgeTextColor,
    this.showDigiLocker = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD1D5DB)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: badgeTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Ux4gButton(
            text: 'Upload',
            onPressed: () {},
            size: Ux4gButtonSize.small,
            width: 100,
          ),
          if (showDigiLocker) ...[
            const SizedBox(height: 12),
            Ux4gButton(
              text: 'Fetch from DigiLocker',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.small,
              width: 220,
            ),
          ],
        ],
      ),
    );
  }
}
