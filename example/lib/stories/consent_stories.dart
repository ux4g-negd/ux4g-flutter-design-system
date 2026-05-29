
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
          description: 'Switch between the standard flat layout and the card-style layout with warning banner.',
        );

        final code = variant == 'Card style' ? _consentCaptureWarningCardCode : _consentCaptureWarningCode;
        final child = variant == 'Card style' ? const _ConsentCaptureWarningCardMockup() : const _ConsentCaptureWarningMobileMockup();

        return ComponentDocs(
          name: 'Consent Capture (Consent Not Given)',
          description: 'Pattern showing the error state when the required consent is not selected. '
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
  State<_ConsentCaptureWarningMobileMockup> createState() => _ConsentCaptureWarningMobileMockupState();
}

class _ConsentCaptureWarningMobileMockupState extends State<_ConsentCaptureWarningMobileMockup> {
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
                      title: 'Consent not given. You cannot proceed without consenting.',
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    const SizedBox(height: 16),
                  ],

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

class _ConsentCaptureWarningCardMockup extends StatefulWidget {
  const _ConsentCaptureWarningCardMockup();

  @override
  State<_ConsentCaptureWarningCardMockup> createState() => _ConsentCaptureWarningCardMockupState();
}

class _ConsentCaptureWarningCardMockupState extends State<_ConsentCaptureWarningCardMockup> {
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
                                title: 'Consent not given. You cannot proceed without consenting.',
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
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              const SizedBox(height: 16),
                            ],

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
// Source Code Snippets for Consent Not Given
// ───────────────────────────────────────────────────────────────────────

const _consentCaptureWarningCode = r'''// Consent Capture – Flat Layout (Consent Not Given)
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

const _consentCaptureWarningCardCode = r'''// Consent Capture – Card Style Layout (Consent Not Given)
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
          description: 'Switch between the standard flat layout and the card-style layout for managing active/withdrawn consents.',
        );

        final code = variant == 'Card style' ? _consentManagementCardCode : _consentManagementCode;
        final child = variant == 'Card style' ? const _ConsentManagementCardMockup() : const _ConsentManagementMobileMockup();

        return ComponentDocs(
          name: 'Consent Management',
          description: 'Pattern for viewing consent history, downloading PDF records, and toggling (withdrawing/restoring) active consents.',
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
  State<_ConsentManagementMobileMockup> createState() => _ConsentManagementMobileMockupState();
}

class _ConsentManagementMobileMockupState extends State<_ConsentManagementMobileMockup> {
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
                    onToggle: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                  ),
                  const SizedBox(height: 12),
                  _buildManagementCard(
                    title: 'Address',
                    dateVersion: '02 Jan 2026, 09:15 · v1.8',
                    isActive: _isAddressActive,
                    onToggle: () => setState(() => _isAddressActive = !_isAddressActive),
                  ),
                  const SizedBox(height: 12),
                  _buildManagementCard(
                    title: 'Email',
                    dateVersion: '15 Sep 2025, 11:02 · v1.6',
                    isActive: _isEmailActive,
                    onToggle: () => setState(() => _isEmailActive = !_isEmailActive),
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
  State<_ConsentManagementCardMockup> createState() => _ConsentManagementCardMockupState();
}

class _ConsentManagementCardMockupState extends State<_ConsentManagementCardMockup> {
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
                              onToggle: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                            ),
                            const SizedBox(height: 12),
                            _buildManagementCard(
                              title: 'Address',
                              dateVersion: '02 Jan 2026, 09:15 · v1.8',
                              isActive: _isAddressActive,
                              onToggle: () => setState(() => _isAddressActive = !_isAddressActive),
                            ),
                            const SizedBox(height: 12),
                            _buildManagementCard(
                              title: 'Email',
                              dateVersion: '15 Sep 2025, 11:02 · v1.6',
                              isActive: _isEmailActive,
                              onToggle: () => setState(() => _isEmailActive = !_isEmailActive),
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
              customBackgroundColor: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFFF0F0),
              customContentColor: isActive ? const Color(0xFF166534) : const Color(0xFF8A1A16),
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
    ),
  ],
)''';
