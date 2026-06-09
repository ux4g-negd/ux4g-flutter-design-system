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

final documentUploadSuccessComponent = WidgetbookComponent(
  name: 'Document upload success',
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
        final code = isCardStyle ? _documentUploadSuccessCardCode : _documentUploadSuccessDefaultCode;

        return ComponentDocs(
          mobileMockup: true,
          name: 'Document upload success',
          description: 'A pattern showing the completed state where all required documents are successfully uploaded.',
          code: code,
          center: true,
          child: isCardStyle ? const _DocumentUploadSuccessCardMockup() : const _DocumentUploadSuccessMockup(),
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

const _documentUploadSuccessDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentUploadSuccessScreen extends StatelessWidget {
  const DocumentUploadSuccessScreen({super.key});

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

                    const Text('All 4 documents uploaded', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                    const SizedBox(height: 16),

                    // Success Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDCFCE7)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('All required documents uploaded.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF166534))),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Success', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF166534))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Document Cards
                    _UploadedItem(title: 'Aadhaar Card', fileName: 'aadhaar_card.pdf', size: '1.2 MB'),
                    const SizedBox(height: 16),
                    _UploadedItem(title: 'Proof of Income', fileName: 'income_proof.pdf', size: '1.8 MB'),
                    const SizedBox(height: 16),
                    _UploadedItem(title: 'Residence proof', fileName: 'electricity_bill.jpg', size: '920 KB'),
                    const SizedBox(height: 16),
                    _UploadedItem(title: 'Caste certificate', fileName: 'caste_cert.pdf', size: '1.1 MB'),

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
                  Ux4gButton(text: 'Proceed to review', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
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

class _UploadedItem extends StatelessWidget {
  final String title, fileName, size;
  const _UploadedItem({required this.title, required this.fileName, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                    const SizedBox(height: 4),
                    Text('$fileName · $size · Uploaded just now', style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
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
    );
  }
}
""";

const _documentUploadSuccessCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentUploadSuccessCardScreen extends StatelessWidget {
  const DocumentUploadSuccessCardScreen({super.key});

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
                      const Text('Upload documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2)),
                      const SizedBox(height: 8),
                      const Text('All required documents uploaded.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563), height: 1.4)),
                      const SizedBox(height: 32),

                      _UploadedItem(title: 'Aadhaar Card', fileName: 'aadhaar_card.pdf', size: '1.2 MB'),
                      const SizedBox(height: 16),
                      _UploadedItem(title: 'Residence proof', fileName: 'electricity_bill.jpg', size: '920 KB'),
                    ],
                  ),
                ),
              ),
            ),

            // Actions & Footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Ux4gButton(text: 'Proceed to review', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
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

class _UploadedItem extends StatelessWidget {
  final String title, fileName, size;
  const _UploadedItem({required this.title, required this.fileName, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                    const SizedBox(height: 4),
                    Text('$fileName · $size · Uploaded', style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Ux4gButton(text: 'View', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 80),
              const SizedBox(width: 12),
              Ux4gButton(text: 'Re-upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 110),
            ],
          ),
        ],
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockups
// ───────────────────────────────────────────────────────────────────────

class _DocumentUploadSuccessMockup extends StatelessWidget {
  const _DocumentUploadSuccessMockup();

  @override
  Widget build(BuildContext context) {
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
                  Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                  const SizedBox(width: 1),
                  SvgPicture.asset(_unionLogoPath, height: 32),
                ],
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                      const Text('Upload documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor)),
                      const SizedBox(height: 8),
                      const Text('PDF or JPG, max 5 MB each. Self-attested.', style: TextStyle(fontSize: 15, color: _subtleText)),
                      const SizedBox(height: 24),
                      const Text('All 4 documents uploaded', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _titleColor)),
                      const SizedBox(height: 16),

                      // Success Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFDCFCE7)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('All required documents uploaded.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF166534))),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(4)),
                                    child: const Text('Success', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF166534))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      const _UploadedMockItem(title: 'Aadhaar Card', fileName: 'aadhaar_card.pdf', size: '1.2 MB'),
                      const SizedBox(height: 16),
                      const _UploadedMockItem(title: 'Proof of Income', fileName: 'income_proof.pdf', size: '1.8 MB'),
                      const SizedBox(height: 16),
                      const _UploadedMockItem(title: 'Residence proof', fileName: 'electricity_bill.jpg', size: '920 KB'),
                      const SizedBox(height: 16),
                      const _UploadedMockItem(title: 'Caste certificate', fileName: 'caste_cert.pdf', size: '1.1 MB'),

                      const SizedBox(height: 32),
                      const Text(
                        'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Ux4gButton(text: 'Proceed to review', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
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

class _DocumentUploadSuccessCardMockup extends StatelessWidget {
  const _DocumentUploadSuccessCardMockup();

  @override
  Widget build(BuildContext context) {
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
                        Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
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
                        const Text('Upload documents', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2)),
                        const SizedBox(height: 8),
                        const Text('All required documents uploaded.', style: TextStyle(fontSize: 15, color: _subtleText, height: 1.4)),
                        const SizedBox(height: 32),

                        const _UploadedMockItem(title: 'Aadhaar Card', fileName: 'aadhaar_card.pdf', size: '1.2 MB'),
                        const SizedBox(height: 16),
                        const _UploadedMockItem(title: 'Residence proof', fileName: 'electricity_bill.jpg', size: '920 KB'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Ux4gButton(text: 'Proceed to review', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
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

class _UploadedMockItem extends StatelessWidget {
  final String title, fileName, size;
  const _UploadedMockItem({required this.title, required this.fileName, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                    const SizedBox(height: 4),
                    Text('$fileName · $size · Uploaded just now', style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Ux4gButton(text: 'View', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 80),
              const SizedBox(width: 12),
              Ux4gButton(text: 'Re-upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, width: 110),
            ],
          ),
        ],
      ),
    );
  }
}
