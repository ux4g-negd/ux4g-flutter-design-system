import 'dart:ui';
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
          description:
              'Switch between the standard flat layout and the card-style layout on a soft-purple background.',
        );

        final code = variant == 'Card style'
            ? _consentCaptureCardCode
            : _consentCaptureCode;
        final child = variant == 'Card style'
            ? const _ConsentCaptureCardMockup()
            : const _ConsentCaptureMobileMockup();

        return ComponentDocs(
          name: 'Consent Capture',
          description:
              'Pattern for capturing user consent to share data and optionally receive updates. '
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
  State<_ConsentCaptureMobileMockup> createState() =>
      _ConsentCaptureMobileMockupState();
}

class _ConsentCaptureMobileMockupState
    extends State<_ConsentCaptureMobileMockup> {
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
                    onChanged: (val) =>
                        setState(() => _isInfoConsentGiven = val ?? false),
                    label:
                        'I consent to sharing the required information listed above',
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  Ux4gCheckbox(
                    value: _isEmailUpdatesConsentGiven,
                    onChanged: (val) => setState(
                      () => _isEmailUpdatesConsentGiven = val ?? false,
                    ),
                    label:
                        'I also consent to receiving email updates regarding my application',
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
  State<_ConsentCaptureCardMockup> createState() =>
      _ConsentCaptureCardMockupState();
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
                              onChanged: (val) => setState(
                                () => _isInfoConsentGiven = val ?? false,
                              ),
                              label:
                                  'I consent to sharing the required information listed above',
                              isRequired: true,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: _isEmailUpdatesConsentGiven,
                              onChanged: (val) => setState(
                                () =>
                                    _isEmailUpdatesConsentGiven = val ?? false,
                              ),
                              label:
                                  'I also consent to receiving email updates regarding my application',
                              isRequired: false,
                            ),
                            const SizedBox(height: 20),

                            // Actions
                            Ux4gButton(
                              text: 'Proceed',
                              onPressed: _isInfoConsentGiven == true
                                  ? () {}
                                  : null,
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
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shield icon indicator
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFEEF2F6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
                height: 1.2,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'To process your Income Certificate application, the Revenue Department will use the following data:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Identity verification', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Address Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Record keeping', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. Email Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Status updates', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 20),

            // Checkboxes
            Ux4gCheckbox(
              value: _isInfoConsentGiven,
              onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
              label: 'I consent to sharing the required information listed above',
              isRequired: true,
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 4),
            Ux4gButton(
              text: 'Decline and exit',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _consentCaptureCardCode = r'''// Consent Capture – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF), // Soft purple/blue card style bg
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
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
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF2F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'To process your Income Certificate application, the Revenue Department will use the following data:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Identity verification', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Record keeping', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. Email Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Status updates', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: Color(0xFFE5E7EB)),
                      SizedBox(height: 16),

                      // Checkboxes
                      Ux4gCheckbox(
                        value: _isInfoConsentGiven,
                        onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
                        label: 'I consent to sharing the required information listed above',
                        isRequired: true,
                      ),
                      SizedBox(height: 8),
                      Ux4gCheckbox(
                        value: _isEmailUpdatesConsentGiven,
                        onChanged: (val) => setState(() => _isEmailUpdatesConsentGiven = val ?? false),
                        label: 'I also consent to receiving email updates regarding my application',
                        isRequired: false,
                      ),
                      SizedBox(height: 20),

                      // Actions
                      Ux4gButton(
                        text: 'Proceed',
                        onPressed: _isInfoConsentGiven ? () {} : null,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 4),
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
            // Footer
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by -',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Consent Capture (Consent Not Given) pattern
// ───────────────────────────────────────────────────────────────────────

final consentCaptureWithWarningComponent = WidgetbookComponent(
  name: 'Consent Capture (Consent Not Given)',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout with warning banner.',
        );

        final code = variant == 'Card style'
            ? _consentCaptureWarningCardCode
            : _consentCaptureWarningCode;
        final child = variant == 'Card style'
            ? const _ConsentCaptureWarningCardMockup()
            : const _ConsentCaptureWarningMobileMockup();

        return ComponentDocs(
          name: 'Consent Capture (Consent Not Given)',
          description:
              'Pattern showing the error state when the required consent is not selected. '
              'Displays the warning banner and disables the Proceed button.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Mockups for Consent Not Given
// ───────────────────────────────────────────────────────────────────────

class _ConsentCaptureWarningMobileMockup extends StatefulWidget {
  const _ConsentCaptureWarningMobileMockup();

  @override
  State<_ConsentCaptureWarningMobileMockup> createState() =>
      _ConsentCaptureWarningMobileMockupState();
}

class _ConsentCaptureWarningMobileMockupState
    extends State<_ConsentCaptureWarningMobileMockup> {
  bool _isInfoConsentGiven = false;
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

                  if (!_isInfoConsentGiven) ...[
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title:
                          'Consent not given. You cannot proceed without consenting.',
                      leadingIcon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFC2410C),
                        size: 20,
                      ),
                      titleStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC2410C),
                      ),
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Checkboxes
                  Ux4gCheckbox(
                    value: _isInfoConsentGiven,
                    onChanged: (val) =>
                        setState(() => _isInfoConsentGiven = val ?? false),
                    label:
                        'I consent to sharing the required information listed above',
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  Ux4gCheckbox(
                    value: _isEmailUpdatesConsentGiven,
                    onChanged: (val) => setState(
                      () => _isEmailUpdatesConsentGiven = val ?? false,
                    ),
                    label:
                        'I also consent to receiving email updates regarding my application',
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

class _ConsentCaptureWarningCardMockup extends StatefulWidget {
  const _ConsentCaptureWarningCardMockup();

  @override
  State<_ConsentCaptureWarningCardMockup> createState() =>
      _ConsentCaptureWarningCardMockupState();
}

class _ConsentCaptureWarningCardMockupState
    extends State<_ConsentCaptureWarningCardMockup> {
  bool _isInfoConsentGiven = false;
  bool _isEmailUpdatesConsentGiven = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF),
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

                            if (!_isInfoConsentGiven) ...[
                              Ux4gStatusBanner(
                                variant: Ux4gBannerVariant.warningLight,
                                title:
                                    'Consent not given. You cannot proceed without consenting.',
                                leadingIcon: const Icon(
                                  Icons.warning_amber_rounded,
                                  color: Color(0xFFC2410C),
                                  size: 20,
                                ),
                                titleStyle: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFC2410C),
                                ),
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Checkboxes
                            Ux4gCheckbox(
                              value: _isInfoConsentGiven,
                              onChanged: (val) => setState(
                                () => _isInfoConsentGiven = val ?? false,
                              ),
                              label:
                                  'I consent to sharing the required information listed above',
                              isRequired: true,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: _isEmailUpdatesConsentGiven,
                              onChanged: (val) => setState(
                                () =>
                                    _isEmailUpdatesConsentGiven = val ?? false,
                              ),
                              label:
                                  'I also consent to receiving email updates regarding my application',
                              isRequired: false,
                            ),
                            const SizedBox(height: 20),

                            // Actions
                            Ux4gButton(
                              text: 'Proceed',
                              onPressed: _isInfoConsentGiven == true
                                  ? () {}
                                  : null,
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
// Source Code Snippets for Consent Not Given
// ───────────────────────────────────────────────────────────────────────

const _consentCaptureWarningCode =
    r'''// Consent Capture – Flat Layout (Consent Not Given)
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shield icon indicator
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFEEF2F6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
                height: 1.2,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'To process your Income Certificate application, the Revenue Department will use the following data:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Identity verification', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Address Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Record keeping', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. Email Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Status updates', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 20),

            if (!_isInfoConsentGiven) ...[
              Ux4gStatusBanner(
                variant: Ux4gBannerVariant.warningLight,
                title: 'Consent not given. You cannot proceed without consenting.',
                leadingIcon: Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFC2410C),
                  size: 20,
                ),
                titleStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC2410C),
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              SizedBox(height: 16),
            ],

            // Checkboxes
            Ux4gCheckbox(
              value: _isInfoConsentGiven,
              onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
              label: 'I consent to sharing the required information listed above',
              isRequired: true,
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 4),
            Ux4gButton(
              text: 'Decline and exit',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _consentCaptureWarningCardCode =
    r'''// Consent Capture – Card Style Layout (Consent Not Given)
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF), // Soft purple/blue card style bg
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
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
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF2F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'To process your Income Certificate application, the Revenue Department will use the following data:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Identity verification', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Record keeping', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. Email Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Status updates', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: Color(0xFFE5E7EB)),
                      SizedBox(height: 16),

                      if (!_isInfoConsentGiven) ...[
                        Ux4gStatusBanner(
                          variant: Ux4gBannerVariant.warningLight,
                          title: 'Consent not given. You cannot proceed without consenting.',
                          leadingIcon: Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFC2410C),
                            size: 20,
                          ),
                          titleStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFC2410C),
                          ),
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        SizedBox(height: 16),
                      ],

                      // Checkboxes
                      Ux4gCheckbox(
                        value: _isInfoConsentGiven,
                        onChanged: (val) => setState(() => _isInfoConsentGiven = val ?? false),
                        label: 'I consent to sharing the required information listed above',
                        isRequired: true,
                      ),
                      SizedBox(height: 8),
                      Ux4gCheckbox(
                        value: _isEmailUpdatesConsentGiven,
                        onChanged: (val) => setState(() => _isEmailUpdatesConsentGiven = val ?? false),
                        label: 'I also consent to receiving email updates regarding my application',
                        isRequired: false,
                      ),
                      SizedBox(height: 20),

                      // Actions
                      Ux4gButton(
                        text: 'Proceed',
                        onPressed: _isInfoConsentGiven ? () {} : null,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 4),
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
            // Footer
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by -',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Consent Management pattern
// ───────────────────────────────────────────────────────────────────────

final consentManagementComponent = WidgetbookComponent(
  name: 'Consent Management',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout for managing active/withdrawn consents.',
        );

        final code = variant == 'Card style'
            ? _consentManagementCardCode
            : _consentManagementCode;
        final child = variant == 'Card style'
            ? const _ConsentManagementCardMockup()
            : const _ConsentManagementMobileMockup();

        return ComponentDocs(
          name: 'Consent Management',
          description:
              'Pattern for viewing consent history, downloading PDF records, and toggling (withdrawing/restoring) active consents.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Mockups for Consent Management
// ───────────────────────────────────────────────────────────────────────

class _ConsentManagementMobileMockup extends StatefulWidget {
  const _ConsentManagementMobileMockup();

  @override
  State<_ConsentManagementMobileMockup> createState() =>
      _ConsentManagementMobileMockupState();
}

class _ConsentManagementMobileMockupState
    extends State<_ConsentManagementMobileMockup> {
  bool _isAadhaarActive = true;
  bool _isAddressActive = true;
  bool _isEmailActive = false;

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
                    'A complete record of all consents you have given, including date, time, IP address, and policy version. You can withdraw any active consent below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Consents cards
                  _buildManagementCard(
                    title: 'Aadhaar Number',
                    dateVersion: '10 Apr 2026, 14:34 · v2.1',
                    isActive: _isAadhaarActive,
                    onToggle: () =>
                        setState(() => _isAadhaarActive = !_isAadhaarActive),
                  ),
                  const SizedBox(height: 12),
                  _buildManagementCard(
                    title: 'Address',
                    dateVersion: '02 Jan 2026, 09:15 · v1.8',
                    isActive: _isAddressActive,
                    onToggle: () =>
                        setState(() => _isAddressActive = !_isAddressActive),
                  ),
                  const SizedBox(height: 12),
                  _buildManagementCard(
                    title: 'Email',
                    dateVersion: '15 Sep 2025, 11:02 · v1.6',
                    isActive: _isEmailActive,
                    onToggle: () =>
                        setState(() => _isEmailActive = !_isEmailActive),
                  ),
                  const SizedBox(height: 20),

                  // Download history link
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Download consent history (PDF)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6A4EFF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Divider(height: 1, color: _border),
                  const SizedBox(height: 20),

                  // Actions
                  Ux4gButton(
                    text: 'Confirm',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 4),
                  Ux4gButton(
                    text: 'Cancel',
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

class _ConsentManagementCardMockup extends StatefulWidget {
  const _ConsentManagementCardMockup();

  @override
  State<_ConsentManagementCardMockup> createState() =>
      _ConsentManagementCardMockupState();
}

class _ConsentManagementCardMockupState
    extends State<_ConsentManagementCardMockup> {
  bool _isAadhaarActive = true;
  bool _isAddressActive = true;
  bool _isEmailActive = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF),
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
                              'A complete record of all consents you have given, including date, time, IP address, and policy version. You can withdraw any active consent below.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Consents cards
                            _buildManagementCard(
                              title: 'Aadhaar Number',
                              dateVersion: '10 Apr 2026, 14:34 · v2.1',
                              isActive: _isAadhaarActive,
                              onToggle: () => setState(
                                () => _isAadhaarActive = !_isAadhaarActive,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildManagementCard(
                              title: 'Address',
                              dateVersion: '02 Jan 2026, 09:15 · v1.8',
                              isActive: _isAddressActive,
                              onToggle: () => setState(
                                () => _isAddressActive = !_isAddressActive,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildManagementCard(
                              title: 'Email',
                              dateVersion: '15 Sep 2025, 11:02 · v1.6',
                              isActive: _isEmailActive,
                              onToggle: () => setState(
                                () => _isEmailActive = !_isEmailActive,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Download history link
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(4),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Download consent history (PDF)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6A4EFF),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            const Divider(height: 1, color: _border),
                            const SizedBox(height: 16),

                            // Actions
                            Ux4gButton(
                              text: 'Confirm',
                              onPressed: () {},
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 4),
                            Ux4gButton(
                              text: 'Cancel',
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

/// Helper method used by mockups to construct interactive cards.
Widget _buildManagementCard({
  required String title,
  required String dateVersion,
  required bool isActive,
  required VoidCallback onToggle,
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
            Ux4gTag(
              text: isActive ? 'Active' : 'Withdrawn',
              customBackgroundColor: isActive
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFFF0F0),
              customContentColor: isActive
                  ? const Color(0xFF166534)
                  : const Color(0xFF8A1A16),
              shape: Ux4gTagShape.rectangular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          dateVersion,
          style: const TextStyle(
            fontSize: 13,
            color: _subtleText,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isActive ? 'Withdraw' : 'Restore',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6A4EFF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF6A4EFF),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Snippets for Consent Management
// ───────────────────────────────────────────────────────────────────────

const _consentManagementCode = r'''// Consent Management – Flat Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shield icon indicator
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFEEF2F6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
                height: 1.2,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'A complete record of all consents you have given, including date, time, IP address, and policy version. You can withdraw any active consent below.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: _isAadhaarActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isAadhaarActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                        customContentColor: _isAadhaarActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('10 Apr 2026, 14:34 · v2.1', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isAadhaarActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Address Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: _isAddressActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isAddressActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                        customContentColor: _isAddressActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('02 Jan 2026, 09:15 · v1.8', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isAddressActive = !_isAddressActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isAddressActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. Email Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: _isEmailActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isEmailActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                        customContentColor: _isEmailActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('15 Sep 2025, 11:02 · v1.6', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isEmailActive = !_isEmailActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isEmailActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Download PDF link
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Download consent history (PDF)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6A4EFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 20),

            // Actions
            Ux4gButton(
              text: 'Confirm',
              onPressed: () {},
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 4),
            Ux4gButton(
              text: 'Cancel',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _consentManagementCardCode = r'''// Consent Management – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF), // Soft purple/blue card style bg
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
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
                        decoration: BoxDecoration(
                          color: Color(0xFFEEF2F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'A complete record of all consents you have given, including date, time, IP address, and policy version. You can withdraw any active consent below.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: _isAadhaarActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isAadhaarActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                                  customContentColor: _isAadhaarActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('10 Apr 2026, 14:34 · v2.1', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isAadhaarActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: _isAddressActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isAddressActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                                  customContentColor: _isAddressActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('02 Jan 2026, 09:15 · v1.8', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isAddressActive = !_isAddressActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isAddressActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. Email Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: _isEmailActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isEmailActive ? Color(0xFFDCFCE7) : Color(0xFFFFF0F0),
                                  customContentColor: _isEmailActive ? Color(0xFF166534) : Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('15 Sep 2025, 11:02 · v1.6', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isEmailActive = !_isEmailActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isEmailActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Color(0xFF6A4EFF), size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Download PDF link
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              'Download consent history (PDF)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6A4EFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: Color(0xFFE5E7EB)),
                      SizedBox(height: 16),

                      // Actions
                      Ux4gButton(
                        text: 'Confirm',
                        onPressed: () {},
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 4),
                      Ux4gButton(
                        text: 'Cancel',
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
            // Footer
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by -',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Data Sharing Consent pattern
// ───────────────────────────────────────────────────────────────────────

final dataSharingConsentComponent = WidgetbookComponent(
  name: 'Data Sharing Consent',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout for data sharing consent.',
        );

        final code = variant == 'Card style'
            ? _dataSharingConsentCardCode
            : _dataSharingConsentCode;
        final child = variant == 'Card style'
            ? const _DataSharingConsentCardMockup()
            : const _DataSharingConsentMobileMockup();

        return ComponentDocs(
          name: 'Data Sharing Consent',
          description:
              'Pattern for displaying data sharing consent details under the DPDP Act 2023, listing third-party sharing details, warning banners, and Manage/Cancel actions.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Mockups for Data Sharing Consent
// ───────────────────────────────────────────────────────────────────────

class _DataSharingConsentMobileMockup extends StatelessWidget {
  const _DataSharingConsentMobileMockup();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shield icon indicator
                  Center(
                    child: Container(
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
                  ),
                  const SizedBox(height: 16),

                  // Headline
                  const Center(
                    child: Text(
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
                  ),
                  const SizedBox(height: 12),

                  // Title & Badge Row
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Data Sharing Consent',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _titleColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Ux4gTag(
                        text: 'DPDP Act 2023',
                        customBackgroundColor: Color(0xFFE9E5FF),
                        customContentColor: Color(0xFF6A4EFF),
                        shape: Ux4gTagShape.circular,
                        size: Ux4gTagSize.m,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Scheme Info
                  const Text(
                    'Scheme: PM Kisan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6A4EFF),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  const Text(
                    'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sharing cards
                  _buildSharingCard(
                    title: 'Bank of India',
                    shared: 'Aadhaar, Name',
                    purpose: 'Account matching',
                    duration: '1 year',
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildSharingCard(
                    title: 'Payment Corp',
                    shared: 'Transaction ID',
                    purpose: 'Payment processing',
                    duration: '90 days',
                    isRequired: true,
                  ),
                  const SizedBox(height: 12),
                  _buildSharingCard(
                    title: 'SMS Gateway',
                    shared: 'Mobile Number',
                    purpose: 'Status alerts',
                    duration: 'Scheme duration',
                    isRequired: false,
                  ),
                  const SizedBox(height: 20),

                  // Warning banner
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title:
                        'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                    leadingIcon: const Icon(
                      Icons.error,
                      color: Color(0xFFD97706),
                      size: 22,
                    ),
                    titleStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB45309),
                    ),
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Divider(height: 1, color: _border),
                  const SizedBox(height: 20),

                  // Actions
                  Ux4gButton(
                    text: 'Manage',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    leadingIcon: Icons.edit_outlined,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 4),
                  Ux4gButton(
                    text: 'Cancel',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    contentColor: const Color(0xFF374151),
                    borderColor: const Color(0xFFD1D5DB),
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

class _DataSharingConsentCardMockup extends StatelessWidget {
  const _DataSharingConsentCardMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Shield icon indicator
                            Center(
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEEF2F6),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.shield_outlined,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Headline
                            const Center(
                              child: Text(
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
                            ),
                            const SizedBox(height: 12),

                            // Title & Badge Row
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Data Sharing Consent',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: _titleColor,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Ux4gTag(
                                  text: 'DPDP Act 2023',
                                  customBackgroundColor: Color(0xFFE9E5FF),
                                  customContentColor: Color(0xFF6A4EFF),
                                  shape: Ux4gTagShape.circular,
                                  size: Ux4gTagSize.m,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Scheme Info
                            const Text(
                              'Scheme: PM Kisan',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6A4EFF),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Description
                            const Text(
                              'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Sharing cards
                            _buildSharingCard(
                              title: 'Bank of India',
                              shared: 'Aadhaar, Name',
                              purpose: 'Account matching',
                              duration: '1 year',
                              isRequired: true,
                            ),
                            const SizedBox(height: 12),
                            _buildSharingCard(
                              title: 'Payment Corp',
                              shared: 'Transaction ID',
                              purpose: 'Payment processing',
                              duration: '90 days',
                              isRequired: true,
                            ),
                            const SizedBox(height: 12),
                            _buildSharingCard(
                              title: 'SMS Gateway',
                              shared: 'Mobile Number',
                              purpose: 'Status alerts',
                              duration: 'Scheme duration',
                              isRequired: false,
                            ),
                            const SizedBox(height: 20),

                            // Warning banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.warningLight,
                              title:
                                  'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                              leadingIcon: const Icon(
                                Icons.error,
                                color: Color(0xFFD97706),
                                size: 22,
                              ),
                              titleStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB45309),
                              ),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            const SizedBox(height: 20),

                            const Divider(height: 1, color: _border),
                            const SizedBox(height: 16),

                            // Actions
                            Ux4gButton(
                              text: 'Manage',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              leadingIcon: Icons.edit_outlined,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 4),
                            Ux4gButton(
                              text: 'Cancel',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                              contentColor: const Color(0xFF374151),
                              borderColor: const Color(0xFFD1D5DB),
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

/// Helper method used by mockups to build individual sharing cards.
Widget _buildSharingCard({
  required String title,
  required String shared,
  required String purpose,
  required String duration,
  required bool isRequired,
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
            Ux4gTag(
              text: isRequired ? 'Required' : 'Optional',
              customBackgroundColor: isRequired
                  ? const Color(0xFFFFF0F0)
                  : const Color(0xFFF3F4F6),
              customContentColor: isRequired
                  ? const Color(0xFF8A1A16)
                  : const Color(0xFF4B5563),
              shape: Ux4gTagShape.circular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Data shared · $shared',
          style: const TextStyle(
            fontSize: 13,
            color: _subtleText,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 2),
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
          'Duration · $duration',
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
// Source Code Snippets for Data Sharing Consent
// ───────────────────────────────────────────────────────────────────────

const _dataSharingConsentCode = r'''// Data Sharing Consent – Flat Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shield icon indicator
            Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(0xFFEEF2F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
              ),
            ),
            SizedBox(height: 16),

            // Headline
            Center(
              child: Text(
                'Your Data, Your Control',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                  height: 1.2,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(height: 12),

            // Title & Badge Row
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Data Sharing Consent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 8),
                Ux4gTag(
                  text: 'DPDP Act 2023',
                  customBackgroundColor: Color(0xFFE9E5FF),
                  customContentColor: Color(0xFF6A4EFF),
                  shape: Ux4gTagShape.circular,
                ),
              ],
            ),
            SizedBox(height: 12),

            // Scheme Info
            Text(
              'Scheme: PM Kisan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6A4EFF),
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4),
            ),
            SizedBox(height: 20),

            // 1. Bank of India Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bank of India',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Aadhaar, Name', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Account matching', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Payment Corp Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Corp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: Color(0xFFFFF0F0),
                        customContentColor: Color(0xFF8A1A16),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Transaction ID', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Payment processing', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · 90 days', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. SMS Gateway Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SMS Gateway',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Optional',
                        customBackgroundColor: Color(0xFFF3F4F6),
                        customContentColor: Color(0xFF4B5563),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Mobile Number', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Status alerts', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · Scheme duration', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Warning banner
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.warningLight,
              title: 'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
              leadingIcon: Icon(
                Icons.error,
                color: Color(0xFFD97706),
                size: 22,
              ),
              titleStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFFB45309),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 20),

            // Actions
            Ux4gButton(
              text: 'Manage',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              leadingIcon: Icons.edit_outlined,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 4),
            Ux4gButton(
              text: 'Cancel',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              contentColor: Color(0xFF374151),
              borderColor: Color(0xFFD1D5DB),
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _dataSharingConsentCardCode =
    r'''// Data Sharing Consent – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF), // Soft purple/blue card style bg
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shield icon indicator
                      Center(
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEF2F6),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.shield_outlined, color: Color(0xFF6A4EFF), size: 28),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Center(
                        child: Text(
                          'Your Data, Your Control',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Title & Badge Row
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Data Sharing Consent',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                          ),
                          SizedBox(height: 8),
                          Ux4gTag(
                            text: 'DPDP Act 2023',
                            customBackgroundColor: Color(0xFFE9E5FF),
                            customContentColor: Color(0xFF6A4EFF),
                            shape: Ux4gTagShape.circular,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      // Scheme Info
                      Text(
                        'Scheme: PM Kisan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6A4EFF),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Bank of India Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Aadhaar, Name', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Account matching', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · 1 year', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Payment Corp Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: Color(0xFFFFF0F0),
                                  customContentColor: Color(0xFF8A1A16),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Transaction ID', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Payment processing', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · 90 days', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. SMS Gateway Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SMS Gateway',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Optional',
                                  customBackgroundColor: Color(0xFFF3F4F6),
                                  customContentColor: Color(0xFF4B5563),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Mobile Number', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Status alerts', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · Scheme duration', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Warning banner
                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.warningLight,
                        title: 'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                        leadingIcon: Icon(
                          Icons.error,
                          color: Color(0xFFD97706),
                          size: 22,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB45309),
                        ),
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: Color(0xFFE5E7EB)),
                      SizedBox(height: 16),

                      // Actions
                      Ux4gButton(
                        text: 'Manage',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        leadingIcon: Icons.edit_outlined,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 4),
                      Ux4gButton(
                        text: 'Cancel',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        contentColor: Color(0xFF374151),
                        borderColor: Color(0xFFD1D5DB),
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Footer
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by -',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
)''';

// ───────────────────────────────────────────────────────────────────────
// Manage Data Sharing Consents pattern
// ───────────────────────────────────────────────────────────────────────

final dataSharingConsentManagementComponent = WidgetbookComponent(
  name: 'Manage Data Sharing Consents',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout for managing consents.',
        );

        final code = variant == 'Card style'
            ? _manageDataSharingConsentsCardCode
            : _manageDataSharingConsentsCode;
        final child = variant == 'Card style'
            ? const _ManageDataSharingConsentsCardMockup()
            : const _ManageDataSharingConsentsMobileMockup();

        return ComponentDocs(
          name: 'Manage Data Sharing Consents',
          description:
              'Pattern for managing and withdrawing data sharing consents under the DPDP Act 2023.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Mockups for Manage Data Sharing Consents
// ───────────────────────────────────────────────────────────────────────

class _ManageDataSharingConsentsMobileMockup extends StatefulWidget {
  const _ManageDataSharingConsentsMobileMockup();

  @override
  State<_ManageDataSharingConsentsMobileMockup> createState() =>
      _ManageDataSharingConsentsMobileMockupState();
}

class _ManageDataSharingConsentsMobileMockupState
    extends State<_ManageDataSharingConsentsMobileMockup> {
  bool _isSmsGatewayWithdrawn = false;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline
                  const Text(
                    'Manage Your Data Sharing Consents',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _titleColor,
                      height: 1.2,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Scheme Info
                  const Text(
                    'Scheme: PM Kisan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6A4EFF),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  const Text(
                    'You can review and withdraw optional consents below.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _subtleText,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sharing cards
                  _buildDataSharingManagementCard(
                    title: 'Bank of India',
                    shared: 'Aadhaar, Name',
                    status: 'Required',
                  ),
                  const SizedBox(height: 12),
                  _buildDataSharingManagementCard(
                    title: 'Payment Corp',
                    shared: 'Transaction ID',
                    status: 'Required',
                  ),
                  const SizedBox(height: 12),
                  _buildDataSharingManagementCard(
                    title: 'SMS Gateway',
                    shared: 'Mobile Number',
                    isOptional: true,
                    isWithdrawn: _isSmsGatewayWithdrawn,
                    onWithdrawToggle: () {
                      setState(() {
                        _isSmsGatewayWithdrawn = !_isSmsGatewayWithdrawn;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Warning banner
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title:
                        'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                    leadingIcon: const Icon(
                      Icons.error,
                      color: Color(0xFFD97706),
                      size: 22,
                    ),
                    titleStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB45309),
                    ),
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Divider(height: 1, color: _border),
                  const SizedBox(height: 16),

                  // Actions
                  Ux4gButton(
                    text: 'Confirm changes',
                    onPressed: _isSmsGatewayWithdrawn ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 4),
                  Ux4gButton(
                    text: 'Cancel',
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

class _ManageDataSharingConsentsCardMockup extends StatefulWidget {
  const _ManageDataSharingConsentsCardMockup();

  @override
  State<_ManageDataSharingConsentsCardMockup> createState() =>
      _ManageDataSharingConsentsCardMockupState();
}

class _ManageDataSharingConsentsCardMockupState
    extends State<_ManageDataSharingConsentsCardMockup> {
  bool _isSmsGatewayWithdrawn = false;

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Headline
                            const Text(
                              'Manage Your Data Sharing Consents',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Scheme Info
                            const Text(
                              'Scheme: PM Kisan',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF6A4EFF),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Description
                            const Text(
                              'You can review and withdraw optional consents below.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Sharing cards
                            _buildDataSharingManagementCard(
                              title: 'Bank of India',
                              shared: 'Aadhaar, Name',
                              status: 'Required',
                            ),
                            const SizedBox(height: 12),
                            _buildDataSharingManagementCard(
                              title: 'Payment Corp',
                              shared: 'Transaction ID',
                              status: 'Required',
                            ),
                            const SizedBox(height: 12),
                            _buildDataSharingManagementCard(
                              title: 'SMS Gateway',
                              shared: 'Mobile Number',
                              isOptional: true,
                              isWithdrawn: _isSmsGatewayWithdrawn,
                              onWithdrawToggle: () {
                                setState(() {
                                  _isSmsGatewayWithdrawn =
                                      !_isSmsGatewayWithdrawn;
                                });
                              },
                            ),
                            const SizedBox(height: 20),

                            // Warning banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.warningLight,
                              title:
                                  'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                              leadingIcon: const Icon(
                                Icons.error,
                                color: Color(0xFFD97706),
                                size: 22,
                              ),
                              titleStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB45309),
                              ),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            const SizedBox(height: 20),

                            const Divider(height: 1, color: _border),
                            const SizedBox(height: 16),

                            // Actions
                            Ux4gButton(
                              text: 'Confirm changes',
                              onPressed: _isSmsGatewayWithdrawn ? () {} : null,
                              size: Ux4gButtonSize.large,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 4),
                            Ux4gButton(
                              text: 'Cancel',
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

/// Helper method used by mockups to build individual management cards.
Widget _buildDataSharingManagementCard({
  required String title,
  required String shared,
  String? status,
  bool isOptional = false,
  bool isWithdrawn = false,
  VoidCallback? onWithdrawToggle,
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
            Ux4gTag(
              text: isWithdrawn ? 'Withdrawn' : 'Active',
              customBackgroundColor: isWithdrawn
                  ? const Color(0xFFF3F4F6)
                  : const Color(0xFFE6F4EA),
              customContentColor: isWithdrawn
                  ? const Color(0xFF4B5563)
                  : const Color(0xFF137333),
              shape: Ux4gTagShape.circular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Data shared · $shared',
          style: const TextStyle(
            fontSize: 13,
            color: _subtleText,
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        if (status != null) ...[
          const SizedBox(height: 2),
          Text(
            'Status · $status',
            style: const TextStyle(
              fontSize: 13,
              color: _subtleText,
              fontWeight: FontWeight.w400,
              height: 1.25,
            ),
          ),
        ],
        if (isOptional) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onWithdrawToggle,
            child: Text(
              isWithdrawn ? 'Undo' : 'Withdraw',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6A4EFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Snippets for Manage Data Sharing Consents
// ───────────────────────────────────────────────────────────────────────

const _manageDataSharingConsentsCode =
    r'''// Manage Data Sharing Consents – Flat Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline
            Text(
              'Manage Your Data Sharing Consents',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
                height: 1.2,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8),

            // Scheme Info
            Text(
              'Scheme: PM Kisan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6A4EFF),
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'You can review and withdraw optional consents below.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.45,
              ),
            ),
            SizedBox(height: 20),

            // 1. Bank of India Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bank of India',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Active',
                        customBackgroundColor: Color(0xFFE6F4EA),
                        customContentColor: Color(0xFF137333),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Aadhaar, Name', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Status · Required', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Payment Corp Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Corp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: 'Active',
                        customBackgroundColor: Color(0xFFE6F4EA),
                        customContentColor: Color(0xFF137333),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Transaction ID', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 2),
                  Text('Status · Required', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. SMS Gateway Card (Optional)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SMS Gateway',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Ux4gTag(
                        text: _isSmsGatewayWithdrawn ? 'Withdrawn' : 'Active',
                        customBackgroundColor: _isSmsGatewayWithdrawn ? Color(0xFFF3F4F6) : Color(0xFFE6F4EA),
                        customContentColor: _isSmsGatewayWithdrawn ? Color(0xFF4B5563) : Color(0xFF137333),
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Mobile Number', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSmsGatewayWithdrawn = !_isSmsGatewayWithdrawn;
                      });
                    },
                    child: Text(
                      _isSmsGatewayWithdrawn ? 'Undo' : 'Withdraw',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Warning banner
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.warningLight,
              title: 'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
              leadingIcon: Icon(
                Icons.error,
                color: Color(0xFFD97706),
                size: 22,
              ),
              titleStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFFB45309),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            SizedBox(height: 20),

            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 16),

            // Actions
            Ux4gButton(
              text: 'Confirm changes',
              onPressed: _isSmsGatewayWithdrawn ? () {} : null,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 4),
            Ux4gButton(
              text: 'Cancel',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.large,
              width: double.infinity,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ),

    // Footer
    Padding(
      padding: EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

const _manageDataSharingConsentsCardCode =
    r'''// Manage Data Sharing Consents – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: Color(0xFFE9E5FF), // Soft purple/blue bg
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Headline
                      Text(
                        'Manage Your Data Sharing Consents',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          height: 1.2,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Scheme Info
                      Text(
                        'Scheme: PM Kisan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6A4EFF),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'You can review and withdraw optional consents below.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Bank of India Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: Color(0xFFE6F4EA),
                                  customContentColor: Color(0xFF137333),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Aadhaar, Name', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Status · Required', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Payment Corp Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: Color(0xFFE6F4EA),
                                  customContentColor: Color(0xFF137333),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Transaction ID', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 2),
                            Text('Status · Required', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. SMS Gateway Card (Optional)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SMS Gateway',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: _isSmsGatewayWithdrawn ? 'Withdrawn' : 'Active',
                                  customBackgroundColor: _isSmsGatewayWithdrawn ? Color(0xFFF3F4F6) : Color(0xFFE6F4EA),
                                  customContentColor: _isSmsGatewayWithdrawn ? Color(0xFF4B5563) : Color(0xFF137333),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Mobile Number', style: TextStyle(color: Color(0xFF6B7280), height: 1.25)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSmsGatewayWithdrawn = !_isSmsGatewayWithdrawn;
                                });
                              },
                              child: Text(
                                _isSmsGatewayWithdrawn ? 'Undo' : 'Withdraw',
                                style: TextStyle(fontSize: 14, color: Color(0xFF6A4EFF), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Warning banner
                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.warningLight,
                        title: 'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                        leadingIcon: Icon(
                          Icons.error,
                          color: Color(0xFFD97706),
                          size: 22,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFB45309),
                        ),
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: Color(0xFFE5E7EB)),
                      SizedBox(height: 16),

                      // Actions
                      Ux4gButton(
                        text: 'Confirm changes',
                        onPressed: _isSmsGatewayWithdrawn ? () {} : null,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 4),
                      Ux4gButton(
                        text: 'Cancel',
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

            // Footer
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Powered by -',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)''';

// ───────────────────────────────────────────────────────────────────────
// Withdraw Consent Dialog pattern
// ───────────────────────────────────────────────────────────────────────

final withdrawConsentDialogComponent = WidgetbookComponent(
  name: 'Withdraw Consent Dialog',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          name: 'Withdraw Consent Dialog',
          description:
              'A modal dialog pattern used to confirm the withdrawal of data sharing consents.',
          code: _withdrawConsentDialogCode,
          center: true,
          child: const _WithdrawConsentDialogMockup(),
        );
      },
    ),
  ],
);

class _WithdrawConsentDialogMockup extends StatelessWidget {
  const _WithdrawConsentDialogMockup();

  @override
  Widget build(BuildContext context) {
    return _PhoneFrame(
      child: Stack(
        children: [
          // Simulated background content (the Manage Consents screen blurred or dimmed)
          Positioned.fill(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage Your Data Sharing Consents',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Scheme: PM Kisan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6A4EFF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Mock cards representing background items
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Dimmed dialog backdrop using the design system's modal component
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Ux4gModalContent(
                onDismiss: () {},
                backgroundColor: Colors.white,
                cornerRadius: 16,
                alignment: Ux4gModalAlignment.centered,
                showHeader:
                    false, // Custom header inside bodyContent to achieve exact spacing/size
                showCloseButton: false,
                showDividers: false,
                showSubtitle: false,
                showFooter: false,
                showBody: true,
                bodyContent: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      // Centered warning icon in a soft peach/amber circle
                      Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: Color(
                            0xFFFFEBD5,
                          ), // Soft peach/amber matching mockup
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.warning_rounded, // Solid warning triangle
                            color: Color(
                              0xFFEA580C,
                            ), // Vivid warning orange/amber
                            size: 38,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Centered title
                      const Text(
                        'Withdraw Consent?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Centered description
                      const Text(
                        'Withdrawing consent for SMS Gateway will stop sending status alerts to your mobile number. This will not affect your PM Kisan bank transfers.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Color(0xFF4B5563),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Primary action button: Withdraw Consent
                      Ux4gButton(
                        text: 'Withdraw Consent',
                        onPressed: () {},
                        backgroundColor: const Color(
                          0xFF4B2BD9,
                        ), // Deep violet/indigo purple from mockup
                        contentColor: Colors.white,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 8),
                      // Cancel button
                      Ux4gButton(
                        text: 'Cancel',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        contentColor: const Color(0xFF1F2937),
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 16),
                      // Footer disclaimer
                      const Text(
                        'You can re-enable this consent at any time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF4B5563),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _withdrawConsentDialogCode = r'''// Withdraw Consent Dialog Pattern
// Show custom design-system dialog using Ux4gModal
Ux4gModal.show(
  context,
  modal: Ux4gModal(
    onDismiss: () => Navigator.of(context).pop(),
    backgroundColor: Colors.white,
    cornerRadius: 16,
    alignment: Ux4gModalAlignment.centered,
    showHeader: false,
    showCloseButton: false,
    showDividers: false,
    showSubtitle: false,
    showFooter: false,
    bodyContent: Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          // Centered warning icon in a soft peach/amber circle
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBD5),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.warning_rounded,
                color: Color(0xFFEA580C),
                size: 38,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Centered title
          const Text(
            'Withdraw Consent?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          // Centered description
          const Text(
            'Withdrawing consent for SMS Gateway will stop sending status alerts to your mobile number. This will not affect your PM Kisan bank transfers.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              color: Color(0xFF4B5563),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 28),
          // Primary action button: Withdraw Consent
          Ux4gButton(
            text: 'Withdraw Consent',
            onPressed: () {
              Navigator.of(context).pop();
            },
            backgroundColor: const Color(0xFF4B2BD9),
            contentColor: Colors.white,
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          const SizedBox(height: 8),
          // Cancel button
          Ux4gButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            variant: Ux4gButtonVariant.ghost,
            contentColor: const Color(0xFF1F2937),
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          const SizedBox(height: 16),
          // Footer disclaimer
          const Text(
            'You can re-enable this consent at any time.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF4B5563),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  ),
);''';

// ───────────────────────────────────────────────────────────────────────
// Consent History pattern
// ───────────────────────────────────────────────────────────────────────

final consentHistoryComponent = WidgetbookComponent(
  name: 'Consent History',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout on a soft-purple background.',
        );

        final code = variant == 'Card style'
            ? _consentHistoryCardCode
            : _consentHistoryCode;
        final child = variant == 'Card style'
            ? const _ConsentHistoryCardMockup()
            : const _ConsentHistoryMockup();

        return ComponentDocs(
          name: 'Consent History',
          description:
              'A screen pattern displaying all data sharing consents history with scheme filter chips. '
              'Use the [Variant] knob on the right to toggle layouts.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

const _consentHistoryCode = r'''// Consent History Screen Pattern
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
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
            child: const Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    const Divider(height: 1, color: Color(0xFFE5E7EB)),

    // Scrollable Content
    Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Consent History',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A complete audit trail of all your data sharing consents for government schemes.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Horizontal Scrollable Choice Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Ux4gChoiceChip(
                    text: 'All',
                    selected: false,
                    borderRadius: 8.0,
                    onClick: () {},
                    unselectedBackgroundColor: Colors.white,
                    unselectedBorderColor: const Color(0xFFE5E7EB),
                    unselectedTextColor: const Color(0xFF4B5563),
                  ),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-Kisan',
                    selected: true,
                    borderRadius: 8.0,
                    onClick: () {},
                    selectedBackgroundColor: const Color(0xFFE9E5FF),
                    selectedBorderColor: const Color(0xFF6A4EFF),
                    selectedTextColor: const Color(0xFF6A4EFF),
                  ),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-MKSSY',
                    selected: false,
                    borderRadius: 8.0,
                    onClick: () {},
                    unselectedBackgroundColor: Colors.white,
                    unselectedBorderColor: const Color(0xFFE5E7EB),
                    unselectedTextColor: const Color(0xFF4B5563),
                  ),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PMAY',
                    selected: true,
                    borderRadius: 8.0,
                    onClick: () {},
                    selectedBackgroundColor: const Color(0xFFE9E5FF),
                    selectedBorderColor: const Color(0xFF6A4EFF),
                    selectedTextColor: const Color(0xFF6A4EFF),
                  ),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-Ajay',
                    selected: false,
                    borderRadius: 8.0,
                    onClick: () {},
                    unselectedBackgroundColor: Colors.white,
                    unselectedBorderColor: const Color(0xFFE5E7EB),
                    unselectedTextColor: const Color(0xFF4B5563),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Cards List (All inlined for copy-paste)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Card 1: Bank of India
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Bank of India',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Ux4gTag(
                              text: 'Active',
                              customBackgroundColor: const Color(0xFFE6F4EA),
                              customContentColor: const Color(0xFF137333),
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Aadhaar, Name',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '12 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card 2: Payment Corp
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Corp',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Ux4gTag(
                              text: 'Active',
                              customBackgroundColor: const Color(0xFFE6F4EA),
                              customContentColor: const Color(0xFF137333),
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Transaction ID',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '12 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card 3: SMS Gateway
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'SMS Gateway',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Ux4gTag(
                              text: 'Withdrawn',
                              customBackgroundColor: const Color(0xFFFCE8E6),
                              customContentColor: const Color(0xFFC5221F),
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '15 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Card 4: Housing Board
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Housing Board',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Ux4gTag(
                              text: 'Expired',
                              customBackgroundColor: const Color(0xFFF1F3F4),
                              customContentColor: const Color(0xFF3C4043),
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PMAY',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Address, Income',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '03 Mar 2023',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF111827),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Footer / Navigation Actions
            Center(
              child: Column(
                children: [
                  const Text(
                    'Showing 4 of 4 consents',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Download Consent History (PDF)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6A4EFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6A4EFF),
                        fontWeight: FontWeight.w600,
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

    // Footer Logo
    Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Image.asset('assets/digital_india_logo.png', height: 22),
        ],
      ),
    ),
  ],
)''';

class _ConsentHistoryMockup extends StatefulWidget {
  const _ConsentHistoryMockup();

  @override
  State<_ConsentHistoryMockup> createState() => _ConsentHistoryMockupState();
}

class _ConsentHistoryMockupState extends State<_ConsentHistoryMockup> {
  final Set<String> _selectedFilters = {'PM-Kisan', 'PMAY'};

  void _toggleFilter(String filter) {
    setState(() {
      if (filter == 'All') {
        _selectedFilters.clear();
        _selectedFilters.add('All');
      } else {
        _selectedFilters.remove('All');
        if (_selectedFilters.contains(filter)) {
          _selectedFilters.remove(filter);
        } else {
          _selectedFilters.add(filter);
        }
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add('All');
        }
      }
    });
  }

  bool _isChipSelected(String filter) {
    if (filter == 'All') {
      return _selectedFilters.contains('All') || _selectedFilters.isEmpty;
    }
    return _selectedFilters.contains(filter);
  }

  @override
  Widget build(BuildContext context) {
    final allConsents = [
      _ConsentHistoryItem(
        title: 'Bank of India',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Aadhaar, Name',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: const Color(0xFFE6F4EA),
        textColor: const Color(0xFF137333),
      ),
      _ConsentHistoryItem(
        title: 'Payment Corp',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Transaction ID',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: const Color(0xFFE6F4EA),
        textColor: const Color(0xFF137333),
      ),
      _ConsentHistoryItem(
        title: 'SMS Gateway',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Mobile Number',
        givenDate: '15 Jan 2024',
        status: 'Withdrawn',
        statusColor: const Color(0xFFFCE8E6),
        textColor: const Color(0xFFC5221F),
      ),
      _ConsentHistoryItem(
        title: 'Housing Board',
        scheme: 'PMAY',
        filterKey: 'PMAY',
        dataShared: 'Address, Income',
        givenDate: '03 Mar 2023',
        status: 'Expired',
        statusColor: const Color(0xFFF1F3F4),
        textColor: const Color(0xFF3C4043),
      ),
    ];

    final displayedConsents = allConsents.where((item) {
      if (_selectedFilters.contains('All')) return true;
      return _selectedFilters.contains(item.filterKey);
    }).toList();

    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Consent History',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'A complete audit trail of all your data sharing consents for government schemes.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch,
                        PointerDeviceKind.stylus,
                      },
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildFilterChip('All'),
                          const SizedBox(width: 8),
                          _buildFilterChip('PM-Kisan'),
                          const SizedBox(width: 8),
                          _buildFilterChip('PM-MKSSY'),
                          const SizedBox(width: 8),
                          _buildFilterChip('PMAY'),
                          const SizedBox(width: 8),
                          _buildFilterChip('PM-Ajay'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: displayedConsents.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                'No consents found for the selected filters.',
                                style: TextStyle(color: Color(0xFF6B7280)),
                              ),
                            ),
                          )
                        : Column(
                            children: displayedConsents.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.02,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF111827),
                                            ),
                                          ),
                                          Ux4gTag(
                                            text: item.status,
                                            customBackgroundColor:
                                                item.statusColor,
                                            customContentColor: item.textColor,
                                            shape: Ux4gTagShape.circular,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      _buildCardRow('Scheme', item.scheme),
                                      const SizedBox(height: 4),
                                      _buildCardRow('Data', item.dataShared),
                                      const SizedBox(height: 4),
                                      _buildCardRow('Given', item.givenDate),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Text(
                                          'View',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF6A4EFF),
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Showing ${displayedConsents.length} of ${allConsents.length} consents',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Download Consent History (PDF)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6A4EFF),
                              fontWeight: FontWeight.w600,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Powered by -',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Image.asset(_digitalIndiaLogoPath, height: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _isChipSelected(label);
    return Ux4gChoiceChip(
      text: label,
      selected: isSelected,
      borderRadius: 8.0,
      onClick: () => _toggleFilter(label),
      selectedBackgroundColor: const Color(0xFFE9E5FF),
      selectedBorderColor: const Color(0xFF6A4EFF),
      selectedTextColor: const Color(0xFF6A4EFF),
      unselectedBackgroundColor: Colors.white,
      unselectedBorderColor: const Color(0xFFE5E7EB),
      unselectedTextColor: const Color(0xFF4B5563),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(
          '· ',
          style: TextStyle(
            fontSize: 13.5,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              color: Color(0xFF111827),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsentHistoryCardMockup extends StatefulWidget {
  const _ConsentHistoryCardMockup();

  @override
  State<_ConsentHistoryCardMockup> createState() =>
      _ConsentHistoryCardMockupState();
}

class _ConsentHistoryCardMockupState extends State<_ConsentHistoryCardMockup> {
  final Set<String> _selectedFilters = {'PM-Kisan', 'PMAY'};

  void _toggleFilter(String filter) {
    setState(() {
      if (filter == 'All') {
        _selectedFilters.clear();
        _selectedFilters.add('All');
      } else {
        _selectedFilters.remove('All');
        if (_selectedFilters.contains(filter)) {
          _selectedFilters.remove(filter);
        } else {
          _selectedFilters.add(filter);
        }
        if (_selectedFilters.isEmpty) {
          _selectedFilters.add('All');
        }
      }
    });
  }

  bool _isChipSelected(String filter) {
    if (filter == 'All') {
      return _selectedFilters.contains('All') || _selectedFilters.isEmpty;
    }
    return _selectedFilters.contains(filter);
  }

  @override
  Widget build(BuildContext context) {
    final allConsents = [
      _ConsentHistoryItem(
        title: 'Bank of India',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Aadhaar, Name',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: const Color(0xFFE6F4EA),
        textColor: const Color(0xFF137333),
      ),
      _ConsentHistoryItem(
        title: 'Payment Corp',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Transaction ID',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: const Color(0xFFE6F4EA),
        textColor: const Color(0xFF137333),
      ),
      _ConsentHistoryItem(
        title: 'SMS Gateway',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Mobile Number',
        givenDate: '15 Jan 2024',
        status: 'Withdrawn',
        statusColor: const Color(0xFFFCE8E6),
        textColor: const Color(0xFFC5221F),
      ),
      _ConsentHistoryItem(
        title: 'Housing Board',
        scheme: 'PMAY',
        filterKey: 'PMAY',
        dataShared: 'Address, Income',
        givenDate: '03 Mar 2023',
        status: 'Expired',
        statusColor: const Color(0xFFF1F3F4),
        textColor: const Color(0xFF3C4043),
      ),
    ];

    final displayedConsents = allConsents.where((item) {
      if (_selectedFilters.contains('All')) return true;
      return _selectedFilters.contains(item.filterKey);
    }).toList();

    return _PhoneFrame(
      child: Column(
        children: [
          const _ConsentHeader(),
          Expanded(
            child: Container(
              color: const Color(0xFFE9E5FF),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Consent History',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'A complete audit trail of all your data sharing consents for government schemes.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6B7280),
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context)
                                  .copyWith(
                                    dragDevices: {
                                      PointerDeviceKind.mouse,
                                      PointerDeviceKind.touch,
                                      PointerDeviceKind.stylus,
                                    },
                                  ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    _buildFilterChip('All'),
                                    const SizedBox(width: 8),
                                    _buildFilterChip('PM-Kisan'),
                                    const SizedBox(width: 8),
                                    _buildFilterChip('PM-MKSSY'),
                                    const SizedBox(width: 8),
                                    _buildFilterChip('PMAY'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (displayedConsents.isEmpty)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Text(
                                    'No consents found.',
                                    style: TextStyle(color: Color(0xFF6B7280)),
                                  ),
                                ),
                              )
                            else
                              Column(
                                children: displayedConsents.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(0xFFE5E7EB),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.title,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF111827),
                                                ),
                                              ),
                                              Ux4gTag(
                                                text: item.status,
                                                customBackgroundColor:
                                                    item.statusColor,
                                                customContentColor:
                                                    item.textColor,
                                                shape: Ux4gTagShape.circular,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          _buildCardRow('Scheme', item.scheme),
                                          const SizedBox(height: 4),
                                          _buildCardRow(
                                            'Data',
                                            item.dataShared,
                                          ),
                                          const SizedBox(height: 4),
                                          _buildCardRow(
                                            'Given',
                                            item.givenDate,
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Text(
                                              'View',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFF6A4EFF),
                                                fontWeight: FontWeight.w600,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            const SizedBox(height: 12),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Showing ${displayedConsents.length} of ${allConsents.length} consents',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Download Consent History (PDF)',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6A4EFF),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Ux4gButton(
                                    text: 'Back',
                                    onPressed: () {},
                                    variant: Ux4gButtonVariant.ghost,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Powered by -',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Image.asset(_digitalIndiaLogoPath, height: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _isChipSelected(label);
    return Ux4gChoiceChip(
      text: label,
      selected: isSelected,
      borderRadius: 8.0,
      onClick: () => _toggleFilter(label),
      selectedBackgroundColor: const Color(0xFFE9E5FF),
      selectedBorderColor: const Color(0xFF6A4EFF),
      selectedTextColor: const Color(0xFF6A4EFF),
      unselectedBackgroundColor: Colors.white,
      unselectedBorderColor: const Color(0xFFE5E7EB),
      unselectedTextColor: const Color(0xFF4B5563),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(
          '· ',
          style: TextStyle(
            fontSize: 12.5,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF111827),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConsentHistoryItem {
  final String title;
  final String scheme;
  final String filterKey;
  final String dataShared;
  final String givenDate;
  final String status;
  final Color statusColor;
  final Color textColor;

  const _ConsentHistoryItem({
    required this.title,
    required this.scheme,
    required this.filterKey,
    required this.dataShared,
    required this.givenDate,
    required this.status,
    required this.statusColor,
    required this.textColor,
  });
}

const _consentHistoryCardCode = r'''// Consent History – Card Style Layout
Column(
  children: [
    // Header
    Ux4gAppHeader(
      variant: Ux4gAppHeaderVariant.light,
      title: '',
      leadingWidgets: [
        SvgPicture.asset('assets/national_amblam_logo.svg', height: 32),
        Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
        SvgPicture.asset('assets/Union.svg', height: 32),
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
            child: const Center(
              child: Icon(Icons.menu, color: Color(0xFF6A4EFF), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    const Divider(height: 1, color: Color(0xFFE5E7EB)),

    Expanded(
      child: Container(
        color: const Color(0xFFE9E5FF), // Soft purple background
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Consent History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A complete audit trail of all your data sharing consents for government schemes.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Horizontal Scrollable Choice Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Ux4gChoiceChip(
                              text: 'All',
                              selected: false,
                              borderRadius: 8.0,
                              onClick: () {},
                              unselectedBackgroundColor: Colors.white,
                              unselectedBorderColor: const Color(0xFFE5E7EB),
                            ),
                            const SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PM-Kisan',
                              selected: true,
                              borderRadius: 8.0,
                              onClick: () {},
                              selectedBackgroundColor: const Color(0xFFE9E5FF),
                              selectedBorderColor: const Color(0xFF6A4EFF),
                              selectedTextColor: const Color(0xFF6A4EFF),
                            ),
                            const SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PM-MKSSY',
                              selected: false,
                              borderRadius: 8.0,
                              onClick: () {},
                              unselectedBackgroundColor: Colors.white,
                              unselectedBorderColor: const Color(0xFFE5E7EB),
                            ),
                            const SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PMAY',
                              selected: true,
                              borderRadius: 8.0,
                              onClick: () {},
                              selectedBackgroundColor: const Color(0xFFE9E5FF),
                              selectedBorderColor: const Color(0xFF6A4EFF),
                              selectedTextColor: const Color(0xFF6A4EFF),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Card 1: Bank of India
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: const Color(0xFFE6F4EA),
                                  customContentColor: const Color(0xFF137333),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const _ConsentRow(label: 'Scheme', value: 'PM Kisan'),
                            const SizedBox(height: 4),
                            const _ConsentRow(label: 'Data', value: 'Aadhaar, Name'),
                            const SizedBox(height: 4),
                            const _ConsentRow(label: 'Given', value: '12 Jan 2024'),
                            const SizedBox(height: 8),
                            const Text(
                              'View',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6A4EFF),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Card 2: Payment Corp
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: const Color(0xFFE6F4EA),
                                  customContentColor: const Color(0xFF137333),
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const _ConsentRow(label: 'Scheme', value: 'PM Kisan'),
                            const SizedBox(height: 4),
                            const _ConsentRow(label: 'Data', value: 'Transaction ID'),
                            const SizedBox(height: 4),
                            const _ConsentRow(label: 'Given', value: '12 Jan 2024'),
                            const SizedBox(height: 8),
                            const Text(
                              'View',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6A4EFF),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Footer Actions
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Showing 4 of 4 consents',
                              style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Download Consent History (PDF)',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6A4EFF),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Ux4gButton(
                              text: 'Back',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.ghost,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Powered by
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Image.asset('assets/digital_india_logo.png', height: 22),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
)

// Helper widget for Consent History code strings
class _ConsentRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConsentRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12.5, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
        ),
        const Text(
          '· ',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF6B7280), fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12.5, color: Color(0xFF111827), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}''';
