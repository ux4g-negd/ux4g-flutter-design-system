import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import '../widgets/component_docs.dart';

// ── Asset paths (copied into example/assets/) ──────────────────────────
const _nationalEmblemPath = 'assets/national_amblam_logo.svg';
const _unionLogoPath = 'assets/Union.svg';
const _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

// ── Shared design tokens used across all Consent patterns ───────────────
const _bg = Color(0xFFFAFAFA);
const _border = Color(0xFFE5E7EB);
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF6B7280);
const _mutedText = Color(0xFF9CA3AF);

// ───────────────────────────────────────────────────────────────────────
// Consent Capture pattern
// ───────────────────────────────────────────────────────────────────────

final consentCaptureComponent = WidgetbookComponent(
  name: 'Consent Capture',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the standard flat layout and the card-style layout on a soft-purple background.',
        );

        final code = variant == 'Card style' ? _consentCaptureCardCode : _consentCaptureCode;
        final child = variant == 'Card style' ? const _ConsentCaptureCardMockup() : const _ConsentCaptureMobileMockup();

        return ComponentDocs(
          name: 'Consent Capture',
          description: 'Pattern for capturing user consent to share data and optionally receive updates. '
              'Use the [Variant] knob on the right to toggle layouts. Mobile-sized layout (360px).',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Shared helpers
// ───────────────────────────────────────────────────────────────────────

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child});
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
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ConsentHeader extends StatelessWidget {
  const _ConsentHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ux4gAppHeader(
          variant: Ux4gAppHeaderVariant.light,
          title: '',
          leadingWidgets: [
            SvgPicture.asset(_nationalEmblemPath, height: 32),
            Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
            SvgPicture.asset(_unionLogoPath, height: 32),
          ],
          actions: [
            Ux4gAppHeaderAction(
              customWidget: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
          horizontalPadding: 16,
          leadingSpacing: 12,
        ),
        const Divider(height: 1, thickness: 1, color: _border),
      ],
    );
  }
}

class _ConsentFooter extends StatelessWidget {
  const _ConsentFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: _mutedText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Image.asset(_digitalIndiaLogoPath, height: 22),
        ],
      ),
    );
  }
}

/// Custom data card builder matching the exact mockup style.
Widget _buildDataCard({
  required String title,
  required String purpose,
  required String retention,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _titleColor,
              ),
            ),
            const Ux4gTag(
              text: 'Required',
              customBackgroundColor: Color(0xFFFFF0F0),
              customContentColor: Color(0xFF8A1A16),
              shape: Ux4gTagShape.rectangular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Purpose · $purpose',
          style: const TextStyle(
            fontSize: 13,
            color: _subtleText,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Retention · $retention',
          style: const TextStyle(
            fontSize: 13,
            color: _subtleText,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────
// Flat Layout Mockup
// ───────────────────────────────────────────────────────────────────────

class _ConsentCaptureMobileMockup extends StatefulWidget {
  const _ConsentCaptureMobileMockup();

  @override
  State<_ConsentCaptureMobileMockup> createState() => _ConsentCaptureMobileMockupState();
}

class _ConsentCaptureMobileMockupState extends State<_ConsentCaptureMobileMockup> {
  bool _isInfoConsentGiven = true;
  bool _isEmailUpdatesConsentGiven = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Shield icon indicator
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEF2F6),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shield_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Headline
                  const Text(
                    'Your Data, Your Control',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  const Text(
                    'To process your Income Certificate application, the Revenue Department will use the following data:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Data cards
                  _buildDataCard(
                    title: 'Aadhaar Number',
                    purpose: 'Identity verification',
                    retention: '7 years',
                  ),
                  const SizedBox(height: 12),
                  _buildDataCard(
                    title: 'Address',
                    purpose: 'Record keeping',
                    retention: '7 years',
                  ),
                  const SizedBox(height: 12),
                  _buildDataCard(
                    title: 'Email',
                    purpose: 'Status updates',
                    retention: '1 year',
                  ),
                  const SizedBox(height: 24),

                  const Divider(height: 1, color: _border),
                  const SizedBox(height: 20),

                  // Checkboxes
                  Ux4gCheckbox(
                    value: _isInfoConsentGiven,
                    onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
                    label: 'I consent to sharing the required information listed above',
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  Ux4gCheckbox(
                    value: _isEmailUpdatesConsentGiven,
                    onChanged: (val) => setState(() => _isEmailUpdatesConsentGiven = val ?? false),
                    label: 'I also consent to receiving email updates regarding my application',
                    isRequired: false,
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  Ux4gButton(
                    text: 'Proceed',
                    onPressed: _isInfoConsentGiven == true ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 4),
                  Ux4gButton(
                    text: 'Decline and exit',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const _ConsentFooter(),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Card Style Layout Mockup
// ───────────────────────────────────────────────────────────────────────

class _ConsentCaptureCardMockup extends StatefulWidget {
  const _ConsentCaptureCardMockup();

  @override
  State<_ConsentCaptureCardMockup> createState() => _ConsentCaptureCardMockupState();
}

class _ConsentCaptureCardMockupState extends State<_ConsentCaptureCardMockup> {
  bool _isInfoConsentGiven = true;
  bool _isEmailUpdatesConsentGiven = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF), // Soft purple/blue card style bg
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Shield icon indicator
                            Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF2F6),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.shield_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Headline
                            const Text(
                              'Your Data, Your Control',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Description
                            const Text(
                              'To process your Income Certificate application, the Revenue Department will use the following data:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Data cards
                            _buildDataCard(
                              title: 'Aadhaar Number',
                              purpose: 'Identity verification',
                              retention: '7 years',
                            ),
                            const SizedBox(height: 12),
                            _buildDataCard(
                              title: 'Address',
                              purpose: 'Record keeping',
                              retention: '7 years',
                            ),
                            const SizedBox(height: 12),
                            _buildDataCard(
                              title: 'Email',
                              purpose: 'Status updates',
                              retention: '1 year',
                            ),
                            const SizedBox(height: 20),

                            const Divider(height: 1, color: _border),
                            const SizedBox(height: 16),

                            // Checkboxes
                            Ux4gCheckbox(
                              value: _isInfoConsentGiven,
                              onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
                              label: 'I consent to sharing the required information listed above',
                              isRequired: true,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: _isEmailUpdatesConsentGiven,
                              onChanged: (val) => setState(() => _isEmailUpdatesConsentGiven = val ?? false),
                              label: 'I also consent to receiving email updates regarding my application',
                              isRequired: false,
                            ),
                            const SizedBox(height: 20),

                            // Actions
                            Ux4gButton(
                              text: 'Proceed',
                              onPressed: _isInfoConsentGiven == true ? () {} : null,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 4),
                            Ux4gButton(
                              text: 'Decline and exit',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.ghost,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const _ConsentFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Snippets
// ───────────────────────────────────────────────────────────────────────

const _consentCaptureCode = r'''// Consent Capture – Flat Layout
Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // Shield Icon Indicator
    Container(
      width: 56, height: 56,
      decoration: BoxDecoration(color: Color(0xFFEEF2F6), shape: BoxShape.circle),
      child: Icon(Icons.shield_outlined, color: primaryColor, size: 28),
    ),
    SizedBox(height: 16),

    // Headline & Subtitle
    Text('Your Data, Your Control', style: titleStyle),
    Text('To process your Income Certificate application, the Revenue Department...', style: subtitleStyle),
    SizedBox(height: 24),

    // Aadhaar Data Card
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Aadhaar Number', style: boldTitleStyle),
              Ux4gTag(
                text: 'Required',
                customBackgroundColor: Color(0xFFFFF0F0),
                customContentColor: Color(0xFF8A1A16),
                shape: Ux4gTagShape.rectangular,
              ),
            ],
          ),
          SizedBox(height: 6),
          Text('Purpose · Identity verification', style: TextStyle(height: 1.25)),
          SizedBox(height: 2),
          Text('Retention · 7 years', style: TextStyle(height: 1.25)),
        ],
      ),
    ),
    // ... Repeat for Address and Email Cards

    SizedBox(height: 24),
    Divider(height: 1),
    SizedBox(height: 20),

    // Checkboxes
    Ux4gCheckbox(
      value: _isInfoConsentGiven,
      onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
      label: 'I consent to sharing the required information listed above',
      isRequired: true,
    ),
    Ux4gCheckbox(
      value: _isEmailUpdatesConsentGiven,
      onChanged: (val) => setState(() => _isEmailUpdatesConsentGiven = val ?? false),
      label: 'I also consent to receiving email updates regarding my application',
      isRequired: false,
    ),
    SizedBox(height: 24),

    // Actions
    Ux4gButton(
      text: 'Proceed',
      onPressed: _isInfoConsentGiven ? () {} : null,
      size: Ux4gButtonSize.large,
      width: double.infinity,
    ),
    Ux4gButton(
      text: 'Decline and exit',
      onPressed: () {},
      variant: Ux4gButtonVariant.ghost,
      size: Ux4gButtonSize.large,
      width: double.infinity,
    ),
  ],
)''';

const _consentCaptureCardCode = r'''// Consent Capture – Card Style Layout
Container(
  color: Color(0xFFE9E5FF), // Soft purple/blue background
  child: Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Shield Icon, Headline, Subtitle,
                // Data cards, Checkboxes, Proceed/Decline actions
              ],
            ),
          ),
        ),
      ),
      _BrandFooter(),
    ],
  ),
)''';
