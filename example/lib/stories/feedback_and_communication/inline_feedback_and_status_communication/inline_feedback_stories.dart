import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _successGreen = Color(0xFF16A34A);

final inlineFeedbackComponent = WidgetbookComponent(
  name: 'Inline Feedback',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.object.dropdown<String>(
          label: 'Variant',
          options: ['Default', 'Card Style'],
          initialOption: 'Default',
        );
        final isCard = variant == 'Card Style';

        return ComponentDocs(
          mobileMockup: true,
          name: 'Inline Feedback ($variant)',
          description: isCard
              ? 'Form input with inline validation feedback inside a card container. '
                'Shows a success message below the input field with a light purple card background.'
              : 'Form input with inline validation feedback. '
                'Shows a success message below the input field on white background.',
          code: isCard ? _inlineFeedbackCardCode : _inlineFeedbackDefaultCode,
          center: true,
          child: _InlineFeedbackMockup(
            variant: isCard ? _CardVariant.cardStyle : _CardVariant.defaultStyle,
          ),
        );
      },
    ),
  ],
);

enum _CardVariant { defaultStyle, cardStyle }

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class InlineFeedbackScreen extends StatelessWidget {
  const InlineFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header with logos
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(height: 32, child: Ux4gDivider(orientation: Ux4gDividerOrientation.vertical, color: const Color(0xFFD1D5DB))),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back
              Row(
                children: [
                  Icon(Icons.arrow_back, size: 16, color: Color(0xFF432CBB)),
                  const SizedBox(width: 4),
                  Text('Back', style: TextStyle(fontSize: 14, color: Color(0xFF432CBB))),
                ],
              ),
              const SizedBox(height: 20),
              Text('Enter your Annual Income', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('Enter your total annual household income for FY 2025–2026 to verify eligibility.',
                style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
              const SizedBox(height: 20),
              Text('Income Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              // Input field
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF16A34A)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('₹  2,50,000', style: TextStyle(fontSize: 15, color: Color(0xFF111827))),
              ),
              const SizedBox(height: 8),
              // Success feedback
              Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: Color(0xFF16A34A)),
                  const SizedBox(width: 6),
                  Text('Amount format looks correct', style: TextStyle(fontSize: 13, color: Color(0xFF16A34A))),
                ],
              ),
              const Spacer(),
              // Continue button
              SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Continue',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.primary,
                  size: Ux4gButtonSize.large,
                  backgroundColor: const Color(0xFF4A2BC2),
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
""";

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — the form content sits inside a light purple card.
class InlineFeedbackCardScreen extends StatelessWidget {
  const InlineFeedbackCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back
                      Row(
                        children: [
                          Icon(Icons.arrow_back, size: 16, color: Color(0xFF432CBB)),
                          const SizedBox(width: 4),
                          Text('Back', style: TextStyle(fontSize: 14, color: Color(0xFF432CBB))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Enter your Annual Income', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Enter your total annual household income for FY 2025–2026 to verify eligibility.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      Text('Income Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      // Input field
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF16A34A)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('₹  2,50,000', style: TextStyle(fontSize: 15, color: Color(0xFF111827))),
                      ),
                      const SizedBox(height: 8),
                      // Success feedback
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: Color(0xFF16A34A)),
                          const SizedBox(width: 6),
                          Text('Amount format looks correct', style: TextStyle(fontSize: 13, color: Color(0xFF16A34A))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Continue button at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Continue',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.primary,
                  size: Ux4gButtonSize.large,
                  backgroundColor: const Color(0xFF4A2BC2),
                ),
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

class _InlineFeedbackMockup extends StatelessWidget {
  final _CardVariant variant;

  const _InlineFeedbackMockup({this.variant = _CardVariant.defaultStyle});

  @override
  Widget build(BuildContext context) {
    final isCard = variant == _CardVariant.cardStyle;

    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header with logos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                    const SizedBox(width: 8),
                    SizedBox(height: 32, child: Ux4gDivider(orientation: Ux4gDividerOrientation.vertical, color: const Color(0xFFD1D5DB))),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/Union.svg', height: 32),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: isCard ? _buildCardContent() : _buildDefaultContent(),
                ),
              ),

              // Continue button at bottom
              if (isCard)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                      backgroundColor: const Color(0xFF4A2BC2),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back link
        Row(
          children: [
            const Icon(Icons.arrow_back, size: 16, color: _primaryColor),
            const SizedBox(width: 4),
            Text('Back', style: TextStyle(fontSize: 14, color: _primaryColor)),
          ],
        ),
        const SizedBox(height: 20),

        // Title
        const Text(
          'Enter your Annual Income',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),

        // Description
        const Text(
          'Enter your total annual household income for FY 2025–2026 to verify eligibility.',
          style: TextStyle(fontSize: 13, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Label
        const Text(
          'Income Amount',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor),
        ),
        const SizedBox(height: 8),

        // Input field with green border (success state)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: _successGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '₹  2,50,000',
            style: TextStyle(fontSize: 15, color: _titleColor),
          ),
        ),
        const SizedBox(height: 8),

        // Success inline feedback
        const Row(
          children: [
            Icon(Icons.check_circle, size: 16, color: _successGreen),
            SizedBox(width: 6),
            Text(
              'Amount format looks correct',
              style: TextStyle(fontSize: 13, color: _successGreen),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormFields(),
        const Spacer(),
        // Continue button
        SizedBox(
          width: double.infinity,
          child: Ux4gButton(
            text: 'Continue',
            onPressed: () {},
            variant: Ux4gButtonVariant.primary,
            size: Ux4gButtonSize.large,
            backgroundColor: const Color(0xFF4A2BC2),
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildFormFields(),
    );
  }
}
