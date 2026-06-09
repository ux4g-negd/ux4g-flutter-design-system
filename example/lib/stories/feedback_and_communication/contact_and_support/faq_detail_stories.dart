import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _primaryColor = Color(0xFF432CBB);
const _dividerColor = Color(0xFFE5E7EB);
const _breadcrumbColor = Color(0xFF6B7280);

const _faqAnswers = [
  'If your application was rejected, you can review the rejection reason in your application details. '
      'You may reapply after addressing the issues mentioned, or file a grievance if you believe the decision was incorrect.',
  'Go to My Applications, select the application, and tap "Upload Documents". '
      'You can upload scanned copies or photos of the required documents. Supported formats: PDF, JPG, PNG (max 5MB each).',
  'Certificate issuance typically takes 7-15 working days after approval. '
      'You will receive an SMS and email notification once your certificate is ready for download.',
  'You can contact the Revenue officer through the Help section in the app, '
      'or visit your nearest Tehsil office during working hours (10 AM - 5 PM, Mon-Fri).',
];

// ── Component ────────────────────────────────────────────────────────────

final faqDetailComponent = WidgetbookComponent(
  name: 'FAQ Detail',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card Style'],
          initialOption: 'Default',
          description:
              'Switch between the standard layout and the card-style layout '
              'with a light purple background.',
        );

        final isCard = variant == 'Card Style';

        return ComponentDocs(
          mobileMockup: true,
          name: 'FAQ Detail ($variant)',
          description: isCard
              ? 'FAQ detail page with breadcrumb, answer content, and related '
                    'questions accordion inside a card with purple background.'
              : 'FAQ detail page with breadcrumb, answer content, and related '
                    'questions accordion on white background.',
          code: isCard ? _faqDetailCardCode : _faqDetailDefaultCode,
          center: true,
          child: _FaqDetailMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _faqDetailDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class FaqDetailScreen extends StatelessWidget {
  const FaqDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            // Gov bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  Text('🇮🇳', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.open_in_new, size: 12, color: Colors.white),
                  const Spacer(),
                  Icon(Icons.accessibility_new, size: 18, color: Colors.white),
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
                    // Breadcrumb
                    Row(
                      children: [
                        Icon(Icons.home, size: 14, color: Color(0xFF6B7280)),
                        const SizedBox(width: 4),
                        Text('Home', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                        Text('  >  ', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                        Text('Help', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                        Text('  >  ', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                        Text('Application Issues',
                            style: TextStyle(fontSize: 13, color: Color(0xFF432CBB), fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('How do I track my application?',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    Text(
                      'Sign in to the portal, open My Applications, and tap your active application. '
                      'The Status Tracker shows every milestone — Submitted, Documents Verified, Under Review, Decision. '
                      'SLA timer shows expected completion date.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    // Related questions accordion
                    Ux4gDivider(color: Color(0xFFE5E7EB)),
                    Ux4gAccordion(
                      title: 'My application was rejected — what next?',
                      collapsedBorderColor: Colors.transparent,
                      expandedBorderColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      contentBackgroundColor: Colors.transparent,
                      child: Text(
                        'If your application was rejected, you can review the rejection reason in your application details. '
                        'You may reapply after addressing the issues mentioned, or file a grievance.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5),
                      ),
                    ),
                    Ux4gDivider(color: Color(0xFFE5E7EB)),
                    Ux4gAccordion(
                      title: 'How do I upload missing documents?',
                      collapsedBorderColor: Colors.transparent,
                      expandedBorderColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      contentBackgroundColor: Colors.transparent,
                      child: Text(
                        'Go to My Applications, select the application, and tap "Upload Documents". '
                        'Supported formats: PDF, JPG, PNG (max 5MB each).',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5),
                      ),
                    ),
                    Ux4gDivider(color: Color(0xFFE5E7EB)),
                    Ux4gAccordion(
                      title: 'When will I receive my certificate?',
                      collapsedBorderColor: Colors.transparent,
                      expandedBorderColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      contentBackgroundColor: Colors.transparent,
                      child: Text(
                        'Certificate issuance typically takes 7-15 working days after approval. '
                        'You will receive an SMS and email notification once ready.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5),
                      ),
                    ),
                    Ux4gDivider(color: Color(0xFFE5E7EB)),
                    Ux4gAccordion(
                      title: 'How do I contact a Revenue officer?',
                      collapsedBorderColor: Colors.transparent,
                      expandedBorderColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      contentBackgroundColor: Colors.transparent,
                      child: Text(
                        'You can contact the Revenue officer through the Help section, '
                        'or visit your nearest Tehsil office (10 AM - 5 PM, Mon-Fri).',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Powered by Digital India
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  const SizedBox(width: 4),
                  Image.asset('assets/digital_india_logo.png', height: 20),
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
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _faqDetailCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — FAQ detail inside a white card on purple background.
class FaqDetailCardScreen extends StatelessWidget {
  const FaqDetailCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            // Gov bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  Text('🇮🇳', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.open_in_new, size: 12, color: Colors.white),
                  const Spacer(),
                  Icon(Icons.accessibility_new, size: 18, color: Colors.white),
                ],
              ),
            ),
            // White card content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Ux4gCard(
                  backgroundColor: Colors.white,
                  cornerRadius: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breadcrumb
                        Row(
                          children: [
                            Icon(Icons.home, size: 14, color: Color(0xFF6B7280)),
                            const SizedBox(width: 4),
                            Text('Home', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            Text('  >  ', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            Text('Help', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            Text('  >  ', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            Text('Application Issues',
                                style: TextStyle(fontSize: 13, color: Color(0xFF432CBB), fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('How do I track my application?',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 12),
                        Text(
                          'Sign in to the portal, open My Applications, and tap your active application. '
                          'The Status Tracker shows every milestone — Submitted, Documents Verified, Under Review, Decision. '
                          'SLA timer shows expected completion date.',
                          style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        // Related questions accordion
                        Ux4gAccordion(
                          items: [
                            Ux4gAccordionItem(title: 'My application was rejected — what next?', content: ''),
                            Ux4gAccordionItem(title: 'How do I upload missing documents?', content: ''),
                            Ux4gAccordionItem(title: 'When will I receive my certificate?', content: ''),
                            Ux4gAccordionItem(title: 'How do I contact a Revenue officer?', content: ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Powered by Digital India
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  const SizedBox(width: 4),
                  Image.asset('assets/digital_india_logo.png', height: 20),
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
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _FaqDetailMockup extends StatelessWidget {
  final bool isCard;

  const _FaqDetailMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingWidgets: [
                  SvgPicture.asset(
                    'assets/national_amblam_logo.svg',
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),

              // Gov bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/india_flag.png',
                      height: 14,
                      width: 22,
                      errorBuilder: (_, __, ___) =>
                          const Text('🇮🇳', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Government of India',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.open_in_new,
                      size: 11,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.accessibility_new,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isCard
                      ? Ux4gCard(
                          backgroundColor: Colors.white,
                          cornerRadius: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildContent(),
                          ),
                        )
                      : _buildContent(),
                ),
              ),

              // Powered by
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Powered by -',
                      style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/digital_india_logo.png',
                      height: 20,
                      errorBuilder: (_, __, ___) => const Text(
                        'Digital India',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF432CBB),
                        ),
                      ),
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

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb
        Row(
          children: const [
            Icon(Icons.home, size: 14, color: _breadcrumbColor),
            SizedBox(width: 4),
            Text(
              'Home',
              style: TextStyle(fontSize: 13, color: _breadcrumbColor),
            ),
            Text(
              '  >  ',
              style: TextStyle(fontSize: 13, color: _breadcrumbColor),
            ),
            Text(
              'Help',
              style: TextStyle(fontSize: 13, color: _breadcrumbColor),
            ),
            Text(
              '  >  ',
              style: TextStyle(fontSize: 13, color: _breadcrumbColor),
            ),
            Text(
              'Application Issues',
              style: TextStyle(
                fontSize: 13,
                color: _primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Title
        const Text(
          'How do I track my application?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 12),

        // Answer
        const Text(
          'Sign in to the portal, open My Applications, and tap your active application. '
          'The Status Tracker shows every milestone — Submitted, Documents Verified, Under Review, Decision. '
          'SLA timer shows expected completion date.',
          style: TextStyle(fontSize: 14, color: _subtleText, height: 1.5),
        ),
        const SizedBox(height: 24),

        // Related questions - Accordion
        _FaqAccordionList(),
      ],
    );
  }
}

// ── FAQ Accordion with divider-only style ────────────────────────────────

const _faqTitles = [
  'My application was rejected — what next?',
  'How do I upload missing documents?',
  'When will I receive my certificate?',
  'How do I contact a Revenue officer?',
];

class _FaqAccordionList extends StatefulWidget {
  @override
  State<_FaqAccordionList> createState() => _FaqAccordionListState();
}

class _FaqAccordionListState extends State<_FaqAccordionList> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_faqTitles.length, (index) {
        return Column(
          children: [
            const Ux4gDivider(color: _dividerColor),
            Ux4gAccordion(
              title: _faqTitles[index],
              expanded: _expandedIndex == index,
              onExpandedChange: (isExpanded) {
                setState(() {
                  _expandedIndex = isExpanded ? index : null;
                });
              },
              collapsedBorderColor: Colors.transparent,
              expandedBorderColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              contentBackgroundColor: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _faqAnswers[index],
                  style: const TextStyle(
                    fontSize: 13,
                    color: _subtleText,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
