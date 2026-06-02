import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _greenColor = Color(0xFF16A34A);
const Color _primaryColor = Color(0xFF432CBB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final draftExpiryUploadComponent = WidgetbookComponent(
  name: 'Draft Expiry Upload',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the standard flat layout and the card-style layout.',
        );

        final code = variant == 'Card style'
            ? _draftExpiryUploadCardCode
            : _draftExpiryUploadDefaultCode;
        final child = variant == 'Card style'
            ? const _DraftExpiryUploadCardMockup()
            : const _DraftExpiryUploadMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Draft Expiry Upload',
          description:
              'A pattern showing document upload with a draft expiry warning banner, '
              'allowing users to complete uploads before their saved draft expires.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Shared widgets
// ───────────────────────────────────────────────────────────────────────

class _ExpiryBanner extends StatelessWidget {
  const _ExpiryBanner();

  @override
  Widget build(BuildContext context) {
    return Ux4gStatusBanner(
      variant: Ux4gBannerVariant.warningLight,
      title: 'Your draft expires in 5 days',
      margin: EdgeInsets.zero,
      leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
      titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500, fontSize: 13),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      trailingIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEDD5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text('16 Apr', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF9A3412))),
      ),
    );
  }
}

class _UploadedDocItem extends StatelessWidget {
  const _UploadedDocItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        border: Border.all(color: const Color(0xFFBBF7D0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: _greenColor),
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aadhaar Card', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _titleColor)),
                    SizedBox(height: 4),
                    Text('aadhaar_card.pdf · 1.2 MB · Uploaded just now', style: TextStyle(fontSize: 13, color: _subtleText)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                  child: const Text('View', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                  child: const Text('Re-upload', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingDocItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isRequired;
  final bool showDigiLocker;

  const _PendingDocItem({
    required this.title,
    required this.subtitle,
    this.isRequired = true,
    this.showDigiLocker = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _titleColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isRequired ? const Color(0xFFFEE2E2) : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isRequired ? 'Required' : 'Optional',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isRequired ? const Color(0xFFDC2626) : const Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: _subtleText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ux4gButton(
                  text: 'Upload',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.outline,
                  size: Ux4gButtonSize.small,
                  contentColor: _primaryColor,
                  borderColor: _primaryColor,
                ),
                if (showDigiLocker) ...[
                  const SizedBox(height: 8),
                  Ux4gButton(
                    text: 'Fetch from DigiLocker',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.small,
                    contentColor: _subtleText,
                    borderColor: const Color(0xFFD1D5DB),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentList extends StatelessWidget {
  const _DocumentList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _UploadedDocItem(),
        SizedBox(height: 16),
        _PendingDocItem(
          title: 'Proof of Income',
          subtitle: 'Salary slip or income tax return',
          isRequired: true,
          showDigiLocker: true,
        ),
        SizedBox(height: 16),
        _PendingDocItem(
          title: 'Residence proof',
          subtitle: 'Electricity bill, gas bill or ration card',
          isRequired: true,
          showDigiLocker: true,
        ),
        SizedBox(height: 16),
        _PendingDocItem(
          title: 'Caste certificate',
          subtitle: 'SC/ST/OBC applicants only',
          isRequired: false,
          showDigiLocker: false,
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _draftExpiryUploadDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DraftExpiryUploadScreen extends StatelessWidget {
  const DraftExpiryUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const greenColor = Color(0xFF16A34A);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);

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

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Draft expiry warning banner
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Your draft expires in 5 days',
                      margin: EdgeInsets.zero,
                      leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                      titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500, fontSize: 13),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      trailingWidget: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(4)),
                        child: const Text('16 Apr', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF9A3412))),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Stepper
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Title
                    const Text(
                      'Upload documents',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'PDF or JPG, max 5 MB each. Self-attested.',
                      style: TextStyle(fontSize: 14, color: subtleText),
                    ),
                    const SizedBox(height: 20),

                    // Required count
                    const Text(
                      'Required documents — 1 of 4 uploaded',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor),
                    ),
                    const SizedBox(height: 20),

                    // Uploaded document card (green background)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        border: Border.all(color: const Color(0xFFBBF7D0)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 28, height: 28,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: greenColor),
                                child: const Icon(Icons.check, color: Colors.white, size: 16),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Aadhaar Card', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                                    SizedBox(height: 4),
                                    Text('aadhaar_card.pdf · 1.2 MB · Uploaded just now', style: TextStyle(fontSize: 13, color: subtleText)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('View', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: titleColor)),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('Re-upload', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: titleColor)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pending: Proof of Income
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                              const SizedBox(width: 12),
                              const Text('Proof of Income', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(4)),
                                child: const Text('Required', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFDC2626))),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('Salary slip or income tax return', style: TextStyle(fontSize: 13, color: subtleText))),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                                const SizedBox(height: 8),
                                Ux4gButton(text: 'Fetch from DigiLocker', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: subtleText, borderColor: const Color(0xFFD1D5DB)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pending: Residence proof
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                              const SizedBox(width: 12),
                              const Text('Residence proof', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(4)),
                                child: const Text('Required', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFDC2626))),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('Electricity bill, gas bill or ration card', style: TextStyle(fontSize: 13, color: subtleText))),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                                const SizedBox(height: 8),
                                Ux4gButton(text: 'Fetch from DigiLocker', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: subtleText, borderColor: const Color(0xFFD1D5DB)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Optional: Caste certificate
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                              const SizedBox(width: 12),
                              const Text('Caste certificate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(4)),
                                child: const Text('Optional', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('SC/ST/OBC applicants only', style: TextStyle(fontSize: 13, color: subtleText))),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Disclaimer
                    const Text(
                      'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                      style: TextStyle(fontSize: 12, color: subtleText, height: 1.4),
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
                  Ux4gButton(text: 'Save draft', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: const Color(0xFF6B7280), borderColor: const Color(0xFFD1D5DB)),
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
""";

const _draftExpiryUploadCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DraftExpiryUploadCardScreen extends StatelessWidget {
  const DraftExpiryUploadCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const greenColor = Color(0xFF16A34A);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header with white background
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

            // White card with all content inside
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Draft expiry warning banner inside card
                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.warningLight,
                        title: 'Your draft expires in 5 days',
                        margin: EdgeInsets.zero,
                        leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                        titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500, fontSize: 13),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        trailingWidget: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(4)),
                          child: const Text('16 Apr', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF9A3412))),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Stepper inside card
                      Ux4gStepper(
                        totalSteps: 4,
                        currentStep: 3,
                        stepSize: 20,
                        steps: const [
                          Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                          Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                          Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                          Ux4gStepItem(title: ''),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Title
                      const Text(
                        'Upload documents',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'PDF or JPG, max 5 MB each. Self-attested.',
                        style: TextStyle(fontSize: 14, color: subtleText),
                      ),
                      const SizedBox(height: 20),

                      // Required count
                      const Text(
                        'Required documents — 1 of 4 uploaded',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: primaryColor),
                      ),
                      const SizedBox(height: 20),

                      // Uploaded document card (green background)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          border: Border.all(color: const Color(0xFFBBF7D0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 28, height: 28,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: greenColor),
                                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Aadhaar Card', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                                      SizedBox(height: 4),
                                      Text('aadhaar_card.pdf · 1.2 MB · Uploaded just now', style: TextStyle(fontSize: 13, color: subtleText)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                                    child: const Text('View', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: titleColor)),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                    decoration: BoxDecoration(border: Border.all(color: const Color(0xFFD1D5DB)), borderRadius: BorderRadius.circular(6)),
                                    child: const Text('Re-upload', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: titleColor)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Pending: Proof of Income
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                                const SizedBox(width: 12),
                                const Text('Proof of Income', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Required', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFDC2626))),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('Salary slip or income tax return', style: TextStyle(fontSize: 13, color: subtleText))),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                                  const SizedBox(height: 8),
                                  Ux4gButton(text: 'Fetch from DigiLocker', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: subtleText, borderColor: const Color(0xFFD1D5DB)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Pending: Residence proof
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                                const SizedBox(width: 12),
                                const Text('Residence proof', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Required', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFDC2626))),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('Electricity bill, gas bill or ration card', style: TextStyle(fontSize: 13, color: subtleText))),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                                  const SizedBox(height: 8),
                                  Ux4gButton(text: 'Fetch from DigiLocker', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: subtleText, borderColor: const Color(0xFFD1D5DB)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Optional: Caste certificate
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE5E7EB)), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5))),
                                const SizedBox(width: 12),
                                const Text('Caste certificate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: titleColor)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(4)),
                                  child: const Text('Optional', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(left: 40, top: 4), child: Text('SC/ST/OBC applicants only', style: TextStyle(fontSize: 13, color: subtleText))),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Ux4gButton(text: 'Upload', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, contentColor: primaryColor, borderColor: primaryColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Disclaimer
                      const Text(
                        'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                        style: TextStyle(fontSize: 12, color: subtleText, height: 1.4),
                      ),
                    ],
                  ),
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
                  Ux4gButton(text: 'Save draft', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: const Color(0xFF6B7280), borderColor: const Color(0xFFD1D5DB)),
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
""";

// ───────────────────────────────────────────────────────────────────────
// Mockups
// ───────────────────────────────────────────────────────────────────────

class _DraftExpiryUploadMockup extends StatelessWidget {
  const _DraftExpiryUploadMockup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset(
                  _nationalEmblemLogoPath,
                  height: 40,
                  errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey),
                ),
                const SizedBox(width: 1),
                Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 1),
                SvgPicture.asset(
                  _unionLogoPath,
                  height: 32,
                  errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue),
                ),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expiry banner
                    const _ExpiryBanner(),
                    const SizedBox(height: 20),

                    // Stepper
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Title
                    const Text(
                      'Upload documents',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'PDF or JPG, max 5 MB each. Self-attested.',
                      style: TextStyle(fontSize: 14, color: _subtleText),
                    ),
                    const SizedBox(height: 20),

                    // Required count
                    const Text(
                      'Required documents — 1 of 4 uploaded',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                    ),
                    const SizedBox(height: 20),

                    // Document list
                    const _DocumentList(),
                    const SizedBox(height: 24),

                    // Disclaimer
                    const Text(
                      'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                      style: TextStyle(fontSize: 12, color: _subtleText, height: 1.4),
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
                  Ux4gButton(
                    text: 'Continue',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Save draft',
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

            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 6),
                  Image.asset(
                    _digitalIndiaLogoPath,
                    height: 24,
                    errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraftExpiryUploadCardMockup extends StatelessWidget {
  const _DraftExpiryUploadCardMockup();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 6)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        backgroundColor: _cardBg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with white background
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Ux4gAppHeader(
                      variant: Ux4gAppHeaderVariant.light,
                      title: '',
                      leadingWidgets: [
                        SvgPicture.asset(
                          _nationalEmblemLogoPath,
                          height: 40,
                          errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey),
                        ),
                        const SizedBox(width: 1),
                        Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                        const SizedBox(width: 1),
                        SvgPicture.asset(
                          _unionLogoPath,
                          height: 32,
                          errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue),
                        ),
                      ],
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                  ],
                ),
              ),

              // White card with all content inside
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expiry banner inside card
                        const _ExpiryBanner(),
                        const SizedBox(height: 20),

                        // Stepper inside card
                        Ux4gStepper(
                          totalSteps: 4,
                          currentStep: 3,
                          stepSize: 20,
                          steps: const [
                            Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                            Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF4B5563))),
                            Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                            Ux4gStepItem(title: ''),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Title
                        const Text(
                          'Upload documents',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'PDF or JPG, max 5 MB each. Self-attested.',
                          style: TextStyle(fontSize: 14, color: _subtleText),
                        ),
                        const SizedBox(height: 20),

                        // Required count
                        const Text(
                          'Required documents — 1 of 4 uploaded',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _primaryColor),
                        ),
                        const SizedBox(height: 20),

                        // Document list
                        const _DocumentList(),
                        const SizedBox(height: 24),

                        // Disclaimer
                        const Text(
                          'All documents must be self-attested. AI flags quality issues; officers make the final call.',
                          style: TextStyle(fontSize: 12, color: _subtleText, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                      text: 'Save draft',
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

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    const SizedBox(height: 6),
                    Image.asset(
                      _digitalIndiaLogoPath,
                      height: 24,
                      errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
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
