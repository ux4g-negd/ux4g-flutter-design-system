import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _errorRed = Color(0xFFDC2626);

final inlineFeedbackErrorComponent = WidgetbookComponent(
  name: 'Inline Feedback Error',
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
          name: 'Inline Feedback Error ($variant)',
          description: isCard
              ? 'Form input with inline error validation feedback inside a card container. '
                'Shows an error message below the input field with a light purple card background.'
              : 'Form input with inline error validation feedback. '
                'Shows an error message below the input field when validation fails.',
          code: isCard ? _inlineFeedbackErrorCardCode : _inlineFeedbackErrorCode,
          center: true,
          child: _InlineFeedbackErrorMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Error
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackErrorCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class InlineFeedbackErrorScreen extends StatelessWidget {
  const InlineFeedbackErrorScreen({super.key});

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
                    // Back button
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      leadingIcon: Icons.arrow_back,
                      contentColor: const Color(0xFF432CBB),
                      size: Ux4gButtonSize.small,
                    ),
                    const SizedBox(height: 20),
                    Text('Enter your Mobile Number',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Provide your mobile number for OTP verification and updates.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Input field with error
                    Ux4gInputField(
                      value: '98765432',
                      onValueChange: (_) {},
                      label: 'Mobile Number',
                      prefixText: '+91',
                      status: Ux4gInputFieldStatus.error,
                      caption: 'Enter a valid 10-digit mobile number',
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
// Source Code String — Error Card Style
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackErrorCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — the form content sits inside a light purple card.
class InlineFeedbackErrorCardScreen extends StatelessWidget {
  const InlineFeedbackErrorCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
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
            Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Ux4gButton(
                        text: 'Back',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        leadingIcon: Icons.arrow_back,
                        contentColor: const Color(0xFF432CBB),
                        size: Ux4gButtonSize.small,
                      ),
                      const SizedBox(height: 20),
                      Text('Enter your Mobile Number',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Provide your mobile number for OTP verification and updates.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      // Input field with error
                      Ux4gInputField(
                        value: '98765432',
                        onValueChange: (_) {},
                        label: 'Mobile Number',
                        prefixText: '+91',
                        status: Ux4gInputFieldStatus.error,
                        caption: 'Enter a valid 10-digit mobile number',
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
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
// Error Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _InlineFeedbackErrorMockup extends StatelessWidget {
  final bool isCard;

  const _InlineFeedbackErrorMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
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
              if (!isCard)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildDefaultContent(),
                  ),
                ),
              if (isCard)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildCardContent(),
                ),

              if (isCard) const Spacer(),

              // Continue button at bottom for card style
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
        // Back button
        Align(
          alignment: Alignment.centerLeft,
          child: Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            leadingIcon: Icons.arrow_back,
            contentColor: _primaryColor,
            size: Ux4gButtonSize.small,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        const Text(
          'Enter your Mobile Number',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),

        // Description
        const Text(
          'Provide your mobile number for OTP verification and updates.',
          style: TextStyle(fontSize: 13, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Input field with error
        Ux4gInputField(
          value: '98765432',
          onValueChange: (_) {},
          label: 'Mobile Number',
          prefixText: '+91',
          status: Ux4gInputFieldStatus.error,
          caption: 'Enter a valid 10-digit mobile number',
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: Ux4gButton(
              text: 'Back',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              leadingIcon: Icons.arrow_back,
              contentColor: _primaryColor,
              size: Ux4gButtonSize.small,
            ),
          ),
          const SizedBox(height: 20),

          // Title
          const Text(
            'Enter your Mobile Number',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
          ),
          const SizedBox(height: 8),

          // Description
          const Text(
            'Provide your mobile number for OTP verification and updates.',
            style: TextStyle(fontSize: 13, color: _subtleText),
          ),
          const SizedBox(height: 20),

          // Input field with error
          Ux4gInputField(
            value: '98765432',
            onValueChange: (_) {},
            label: 'Mobile Number',
            prefixText: '+91',
            status: Ux4gInputFieldStatus.error,
            caption: 'Enter a valid 10-digit mobile number',
          ),
        ],
      ),
    );
  }
}
