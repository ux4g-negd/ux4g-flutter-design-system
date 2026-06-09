import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);

final inlineFeedbackHintComponent = WidgetbookComponent(
  name: 'Inline Feedback Hint',
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
          name: 'Inline Feedback Hint ($variant)',
          description: isCard
              ? 'Form input with inline hint feedback inside a card container. '
                'Shows a helper message below the input field with a light purple card background.'
              : 'Form input with inline hint feedback. '
                'Shows a helper message below the input field on white background.',
          code: isCard ? _inlineFeedbackHintCardCode : _inlineFeedbackHintCode,
          center: true,
          child: _InlineFeedbackHintMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Hint Default
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackHintCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class InlineFeedbackHintScreen extends StatelessWidget {
  const InlineFeedbackHintScreen({super.key});

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
                    Text('Identity Verification',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Enter your Aadhaar number to auto-fill your personal details.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Input field with hint
                    Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      label: 'Aadhaar Number',
                      placeholder: 'Enter 12-digit Aadhaar number',
                      caption: 'Enter 12 digits — we will prefill your name and address',
                    ),
                    const Spacer(),
                    // Verify button
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Verify',
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
// Source Code String — Hint Card Style
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackHintCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — the form content sits inside a light purple card.
class InlineFeedbackHintCardScreen extends StatelessWidget {
  const InlineFeedbackHintCardScreen({super.key});

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
                      Text('Identity Verification',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Enter your Aadhaar number to auto-fill your personal details.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      // Input field with hint
                      Ux4gInputField(
                        value: '',
                        onValueChange: (_) {},
                        label: 'Aadhaar Number',
                        placeholder: 'Enter 12-digit Aadhaar number',
                        caption: 'Enter 12 digits — we will prefill your name and address',
                      ),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            // Verify button at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Verify',
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
// Hint Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _InlineFeedbackHintMockup extends StatelessWidget {
  final bool isCard;

  const _InlineFeedbackHintMockup({this.isCard = false});

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

              // Verify button at bottom for card style
              if (isCard)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      text: 'Verify',
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
          'Identity Verification',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),

        // Description
        const Text(
          'Enter your Aadhaar number to auto-fill your personal details.',
          style: TextStyle(fontSize: 13, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Input field with hint
        Ux4gInputField(
          value: '',
          onValueChange: (_) {},
          label: 'Aadhaar Number',
          placeholder: 'Enter 12-digit Aadhaar number',
          caption: 'Enter 12 digits — we will prefill your name and address',
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
        // Verify button
        SizedBox(
          width: double.infinity,
          child: Ux4gButton(
            text: 'Verify',
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
            'Identity Verification',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
          ),
          const SizedBox(height: 8),

          // Description
          const Text(
            'Enter your Aadhaar number to auto-fill your personal details.',
            style: TextStyle(fontSize: 13, color: _subtleText),
          ),
          const SizedBox(height: 20),

          // Input field with hint
          Ux4gInputField(
            value: '',
            onValueChange: (_) {},
            label: 'Aadhaar Number',
            placeholder: 'Enter 12-digit Aadhaar number',
            caption: 'Enter 12 digits — we will prefill your name and address',
          ),
        ],
      ),
    );
  }
}
