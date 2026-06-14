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






bool _isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;






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
          options: ['Default', 'Card style'],
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
        color: (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
  _ConsentHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Ux4gAppHeader(
          variant: Ux4gAppHeaderVariant.light,
          title: '',
          leadingWidgets: [
            SvgPicture.asset(
              _nationalEmblemPath,
              height: 32,
              colorFilter: _isDark(context)
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
            Container(
              width: 1,
              height: 28,
              color: _isDark(context)
                  ? Ux4gPalette.neutral600
                  : _isDark(context)
                  ? Ux4gPalette.neutral600
                  : (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300),
            ),
            SvgPicture.asset(
              _unionLogoPath,
              height: 32,
              colorFilter: ColorFilter.mode(
                _isDark(context)
                    ? Ux4gPalette.primary300
                    : Ux4gPalette.primary600,
                BlendMode.srcIn,
              ),
            ),
          ],
          actions: [
            Ux4gAppHeaderAction(
              customWidget: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isDark(context)
                        ? Ux4gPalette.neutral700
                        : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                  ),
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
        Divider(height: 1, thickness: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
        ],
      ),
    );
  }
}

/// Custom data card builder matching the exact mockup style.
Widget _buildDataCard({
  required BuildContext context,
  required String title,
  required String purpose,
  required String retention,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
              ),
            ),
            Ux4gTag(
              text: 'Required',
              customBackgroundColor: _isDark(context)
                  ? Ux4gPalette.red900
                  : _isDark(context)
                  ? Ux4gPalette.red900
                  : const Color(0xFFFFF0F0),
              customContentColor: _isDark(context)
                  ? Ux4gPalette.red300
                  : _isDark(context)
                  ? Ux4gPalette.red300
                  : const Color(0xFF8A1A16),
              shape: Ux4gTagShape.rectangular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Purpose · $purpose',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Retention · $retention',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
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
          _ConsentHeader(),
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
                    decoration: BoxDecoration(
                      color: _isDark(context)
                          ? Ux4gPalette.gray800
                          : _isDark(context)
                          ? Ux4gPalette.gray800
                          : const Color(0xFFEEF2F6),
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
                  SizedBox(height: 16),

                  // Headline
                  Text(
                    'Your Data, Your Control',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Data cards
                  _buildDataCard(
                    context: context,
                    title: 'Aadhaar Number',
                    purpose: 'Identity verification',
                    retention: '7 years',
                  ),
                  SizedBox(height: 12),
                  _buildDataCard(
                    context: context,
                    title: 'Address',
                    purpose: 'Record keeping',
                    retention: '7 years',
                  ),
                  SizedBox(height: 12),
                  _buildDataCard(
                    context: context,
                    title: 'Email',
                    purpose: 'Status updates',
                    retention: '1 year',
                  ),
                  SizedBox(height: 24),

                  Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                  SizedBox(height: 20),

                  // Checkboxes
                  Ux4gCheckbox(
                    value: _isInfoConsentGiven,
                    onChanged: (val) =>
                        setState(() => _isInfoConsentGiven = val ?? false),
                    label:
                        'I consent to sharing the required information listed above',
                    isRequired: true,
                  ),
                  SizedBox(height: 8),
                  Ux4gCheckbox(
                    value: _isEmailUpdatesConsentGiven,
                    onChanged: (val) => setState(
                      () => _isEmailUpdatesConsentGiven = val ?? false,
                    ),
                    label:
                        'I also consent to receiving email updates regarding my application',
                    isRequired: false,
                  ),
                  SizedBox(height: 24),

                  // Actions
                  Ux4gButton(
                    text: 'Proceed',
                    onPressed: _isInfoConsentGiven == true ? () {} : null,
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
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100), // Soft purple/blue card style bg
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                              decoration: BoxDecoration(
                                color: _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : const Color(0xFFEEF2F6),
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
                            SizedBox(height: 16),

                            // Headline
                            Text(
                              'Your Data, Your Control',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Data cards
                            _buildDataCard(
                              context: context,
                              title: 'Aadhaar Number',
                              purpose: 'Identity verification',
                              retention: '7 years',
                            ),
                            SizedBox(height: 12),
                            _buildDataCard(
                              context: context,
                              title: 'Address',
                              purpose: 'Record keeping',
                              retention: '7 years',
                            ),
                            SizedBox(height: 12),
                            _buildDataCard(
                              context: context,
                              title: 'Email',
                              purpose: 'Status updates',
                              retention: '1 year',
                            ),
                            SizedBox(height: 20),

                            Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                            SizedBox(height: 16),

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
                            SizedBox(height: 8),
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
                            SizedBox(height: 20),

                            // Actions
                            Ux4gButton(
                              text: 'Proceed',
                              onPressed: _isInfoConsentGiven == true
                                  ? () {}
                                  : null,
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

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
                color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Identity verification', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Address Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Record keeping', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. Email Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Status updates', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
              color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary900 : _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple/blue card style bg
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                          color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Identity verification', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Record keeping', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. Email Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Status updates', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                      color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
          options: ['Default', 'Card style'],
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
          _ConsentHeader(),
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
                    decoration: BoxDecoration(
                      color: _isDark(context)
                          ? Ux4gPalette.gray800
                          : _isDark(context)
                          ? Ux4gPalette.gray800
                          : const Color(0xFFEEF2F6),
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
                  SizedBox(height: 16),

                  // Headline
                  Text(
                    'Your Data, Your Control',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Data cards
                  _buildDataCard(
                    context: context,
                    title: 'Aadhaar Number',
                    purpose: 'Identity verification',
                    retention: '7 years',
                  ),
                  SizedBox(height: 12),
                  _buildDataCard(
                    context: context,
                    title: 'Address',
                    purpose: 'Record keeping',
                    retention: '7 years',
                  ),
                  SizedBox(height: 12),
                  _buildDataCard(
                    context: context,
                    title: 'Email',
                    purpose: 'Status updates',
                    retention: '1 year',
                  ),
                  SizedBox(height: 24),

                  Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                  SizedBox(height: 20),

                  if (!_isInfoConsentGiven) ...[
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title:
                          'Consent not given. You cannot proceed without consenting.',
                      leadingIcon: Icon(
                        Icons.warning_amber_rounded,
                        color: _isDark(context)
                            ? Ux4gPalette.orange400
                            : _isDark(context)
                            ? Ux4gPalette.orange300
                            : const Color(0xFFC2410C),
                        size: 20,
                      ),
                      titleStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _isDark(context)
                            ? Ux4gPalette.orange400
                            : _isDark(context)
                            ? Ux4gPalette.orange300
                            : const Color(0xFFC2410C),
                      ),
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    SizedBox(height: 16),
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
                  SizedBox(height: 8),
                  Ux4gCheckbox(
                    value: _isEmailUpdatesConsentGiven,
                    onChanged: (val) => setState(
                      () => _isEmailUpdatesConsentGiven = val ?? false,
                    ),
                    label:
                        'I also consent to receiving email updates regarding my application',
                    isRequired: false,
                  ),
                  SizedBox(height: 24),

                  // Actions
                  Ux4gButton(
                    text: 'Proceed',
                    onPressed: _isInfoConsentGiven == true ? () {} : null,
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
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                              decoration: BoxDecoration(
                                color: _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : const Color(0xFFEEF2F6),
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
                            SizedBox(height: 16),

                            // Headline
                            Text(
                              'Your Data, Your Control',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Data cards
                            _buildDataCard(
                              context: context,
                              title: 'Aadhaar Number',
                              purpose: 'Identity verification',
                              retention: '7 years',
                            ),
                            SizedBox(height: 12),
                            _buildDataCard(
                              context: context,
                              title: 'Address',
                              purpose: 'Record keeping',
                              retention: '7 years',
                            ),
                            SizedBox(height: 12),
                            _buildDataCard(
                              context: context,
                              title: 'Email',
                              purpose: 'Status updates',
                              retention: '1 year',
                            ),
                            SizedBox(height: 20),

                            Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
                            SizedBox(height: 16),

                            if (!_isInfoConsentGiven) ...[
                              Ux4gStatusBanner(
                                variant: Ux4gBannerVariant.warningLight,
                                title:
                                    'Consent not given. You cannot proceed without consenting.',
                                leadingIcon: Icon(
                                  Icons.warning_amber_rounded,
                                  color: _isDark(context)
                                      ? Ux4gPalette.orange400
                                      : _isDark(context)
                                      ? Ux4gPalette.orange300
                                      : const Color(0xFFC2410C),
                                  size: 20,
                                ),
                                titleStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: _isDark(context)
                                      ? Ux4gPalette.orange400
                                      : _isDark(context)
                                      ? Ux4gPalette.orange300
                                      : const Color(0xFFC2410C),
                                ),
                                margin: EdgeInsets.zero,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              SizedBox(height: 16),
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
                            SizedBox(height: 8),
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
                            SizedBox(height: 20),

                            // Actions
                            Ux4gButton(
                              text: 'Proceed',
                              onPressed: _isInfoConsentGiven == true
                                  ? () {}
                                  : null,
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

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
                color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Identity verification', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Address Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Record keeping', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. Email Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Purpose · Status updates', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Retention · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
            SizedBox(height: 20),

            if (!_isInfoConsentGiven) ...[
              Ux4gStatusBanner(
                variant: Ux4gBannerVariant.warningLight,
                title: 'Consent not given. You cannot proceed without consenting.',
                leadingIcon: Icon(
                  Icons.warning_amber_rounded,
                  color: _isDark(context) ? Ux4gPalette.orange400 : _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800,
                  size: 20,
                ),
                titleStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _isDark(context) ? Ux4gPalette.orange400 : _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800,
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
              color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary900 : _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple/blue card style bg
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                          color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Identity verification', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Address Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Record keeping', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 7 years', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. Email Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Purpose · Status updates', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Retention · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                      SizedBox(height: 16),

                      if (!_isInfoConsentGiven) ...[
                        Ux4gStatusBanner(
                          variant: Ux4gBannerVariant.warningLight,
                          title: 'Consent not given. You cannot proceed without consenting.',
                          leadingIcon: Icon(
                            Icons.warning_amber_rounded,
                            color: _isDark(context) ? Ux4gPalette.orange400 : _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800,
                            size: 20,
                          ),
                          titleStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _isDark(context) ? Ux4gPalette.orange400 : _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange800,
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
                      color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
          options: ['Default', 'Card style'],
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
          _ConsentHeader(),
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
                    decoration: BoxDecoration(
                      color: _isDark(context)
                          ? Ux4gPalette.gray800
                          : _isDark(context)
                          ? Ux4gPalette.gray800
                          : const Color(0xFFEEF2F6),
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
                  SizedBox(height: 16),

                  // Headline
                  Text(
                    'Your Data, Your Control',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Consents cards
                  _buildManagementCard(
                    context: context,
                    title: 'Aadhaar Number',
                    dateVersion: '10 Apr 2026, 14:34 · v2.1',
                    isActive: _isAadhaarActive,
                    onToggle: () =>
                        setState(() => _isAadhaarActive = !_isAadhaarActive),
                  ),
                  SizedBox(height: 12),
                  _buildManagementCard(
                    context: context,
                    title: 'Address',
                    dateVersion: '02 Jan 2026, 09:15 · v1.8',
                    isActive: _isAddressActive,
                    onToggle: () =>
                        setState(() => _isAddressActive = !_isAddressActive),
                  ),
                  SizedBox(height: 12),
                  _buildManagementCard(
                    context: context,
                    title: 'Email',
                    dateVersion: '15 Sep 2025, 11:02 · v1.6',
                    isActive: _isEmailActive,
                    onToggle: () =>
                        setState(() => _isEmailActive = !_isEmailActive),
                  ),
                  SizedBox(height: 20),

                  // Download history link
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Download consent history (PDF)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                              decoration: BoxDecoration(
                                color: _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : _isDark(context)
                                    ? Ux4gPalette.gray800
                                    : const Color(0xFFEEF2F6),
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
                            SizedBox(height: 16),

                            // Headline
                            Text(
                              'Your Data, Your Control',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Consents cards
                            _buildManagementCard(
                              context: context,
                              title: 'Aadhaar Number',
                              dateVersion: '10 Apr 2026, 14:34 · v2.1',
                              isActive: _isAadhaarActive,
                              onToggle: () => setState(
                                () => _isAadhaarActive = !_isAadhaarActive,
                              ),
                            ),
                            SizedBox(height: 12),
                            _buildManagementCard(
                              context: context,
                              title: 'Address',
                              dateVersion: '02 Jan 2026, 09:15 · v1.8',
                              isActive: _isAddressActive,
                              onToggle: () => setState(
                                () => _isAddressActive = !_isAddressActive,
                              ),
                            ),
                            SizedBox(height: 12),
                            _buildManagementCard(
                              context: context,
                              title: 'Email',
                              dateVersion: '15 Sep 2025, 11:02 · v1.6',
                              isActive: _isEmailActive,
                              onToggle: () => setState(
                                () => _isEmailActive = !_isEmailActive,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Download history link
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Download consent history (PDF)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
  required BuildContext context,
  required String title,
  required String dateVersion,
  required bool isActive,
  required VoidCallback onToggle,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
              ),
            ),
            Ux4gTag(
              text: isActive ? 'Active' : 'Withdrawn',
              customBackgroundColor: isActive
                  ? (_isDark(context)
                        ? Ux4gPalette.green900
                        : _isDark(context)
                        ? Ux4gPalette.green900
                        : const Color(0xFFDCFCE7))
                  : _isDark(context)
                  ? Ux4gPalette.red900
                  : const Color(0xFFFFF0F0),
              customContentColor: isActive
                  ? (_isDark(context)
                        ? Ux4gPalette.green300
                        : _isDark(context)
                        ? Ux4gPalette.green300
                        : const Color(0xFF166534))
                  : _isDark(context)
                  ? Ux4gPalette.red300
                  : const Color(0xFF8A1A16),
              shape: Ux4gTagShape.rectangular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          dateVersion,
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
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
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Theme.of(context).colorScheme.primary,
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

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
                color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
            ),
            SizedBox(height: 16),

            // Headline
            Text(
              'Your Data, Your Control',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24),

            // 1. Aadhaar Number Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Aadhaar Number',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: _isAadhaarActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isAadhaarActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isAadhaarActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('10 Apr 2026, 14:34 · v2.1', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isAadhaarActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: _isAddressActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isAddressActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isAddressActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('02 Jan 2026, 09:15 · v1.8', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isAddressActive = !_isAddressActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isAddressActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: _isEmailActive ? 'Active' : 'Withdrawn',
                        customBackgroundColor: _isEmailActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isEmailActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.rectangular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('15 Sep 2025, 11:02 · v1.6', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () => setState(() => _isEmailActive = !_isEmailActive),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_isEmailActive ? 'Withdraw' : 'Restore',
                          style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
              color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary, size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary900 : _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple/blue card style bg
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                          color: _isDark(context) ? Ux4gPalette.gray800 : _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.primary, size: 28),
                      ),
                      SizedBox(height: 16),

                      // Headline
                      Text(
                        'Your Data, Your Control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Aadhaar Number Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Aadhaar Number',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: _isAadhaarActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isAadhaarActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isAadhaarActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('10 Apr 2026, 14:34 · v2.1', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isAadhaarActive = !_isAadhaarActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isAadhaarActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: _isAddressActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isAddressActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isAddressActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('02 Jan 2026, 09:15 · v1.8', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isAddressActive = !_isAddressActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isAddressActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: _isEmailActive ? 'Active' : 'Withdrawn',
                                  customBackgroundColor: _isEmailActive ? (_isDark(context) ? Ux4gPalette.green900 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50) : _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isEmailActive ? (_isDark(context) ? Ux4gPalette.green300 : _isDark(context) ? Ux4gPalette.green400 : Ux4gPalette.green800) : _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.rectangular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('15 Sep 2025, 11:02 · v1.6', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () => setState(() => _isEmailActive = !_isEmailActive),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_isEmailActive ? 'Withdraw' : 'Restore',
                                    style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
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
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                      color: (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
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
          options: ['Default', 'Card style'],
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
          _ConsentHeader(),
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
                      decoration: BoxDecoration(
                        color: _isDark(context)
                            ? Ux4gPalette.gray800
                            : const Color(0xFFEEF2F6),
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
                  SizedBox(height: 16),

                  // Headline
                  Center(
                    child: Text(
                      'Your Data, Your Control',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                          color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                        ),
                      ),
                      SizedBox(height: 8),
                      Ux4gTag(
                        text: 'DPDP Act 2023',
                        customBackgroundColor: _isDark(context)
                            ? Ux4gPalette.primary900
                            : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
                        customContentColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                        shape: Ux4gTagShape.circular,
                        size: Ux4gTagSize.m,
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
                      color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                    ),
                  ),
                  SizedBox(height: 8),

                  // Description
                  Text(
                    'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                    style: TextStyle(
                      fontSize: 14,
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sharing cards
                  _buildSharingCard(
context: context,
                    title: 'Bank of India',
                    shared: 'Aadhaar, Name',
                    purpose: 'Account matching',
                    duration: '1 year',
                    isRequired: true,
                  ),
                  SizedBox(height: 12),
                  _buildSharingCard(
context: context,
                    title: 'Payment Corp',
                    shared: 'Transaction ID',
                    purpose: 'Payment processing',
                    duration: '90 days',
                    isRequired: true,
                  ),
                  SizedBox(height: 12),
                  _buildSharingCard(
context: context,
                    title: 'SMS Gateway',
                    shared: 'Mobile Number',
                    purpose: 'Status alerts',
                    duration: 'Scheme duration',
                    isRequired: false,
                  ),
                  SizedBox(height: 20),

                  // Warning banner
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title:
                        'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                    leadingIcon: Icon(
                      Icons.error,
                      color: _isDark(context)
                          ? Ux4gPalette.orange300
                          : const Color(0xFFD97706),
                      size: 22,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _isDark(context)
                          ? Ux4gPalette.orange300
                          : const Color(0xFFB45309),
                    ),
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  SizedBox(height: 24),

                  Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
                    contentColor: _isDark(context)
                        ? Ux4gPalette.neutral400
                        : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                    borderColor: _isDark(context)
                        ? Ux4gPalette.neutral600
                        : (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300),
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  SizedBox(height: 16),
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
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                                decoration: BoxDecoration(
                                  color: _isDark(context)
                                      ? Ux4gPalette.gray800
                                      : const Color(0xFFEEF2F6),
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
                            SizedBox(height: 16),

                            // Headline
                            Center(
                              child: Text(
                                'Your Data, Your Control',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                    color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Ux4gTag(
                                  text: 'DPDP Act 2023',
                                  customBackgroundColor: _isDark(context)
                                      ? Ux4gPalette.primary900
                                      : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
                                  customContentColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                                  shape: Ux4gTagShape.circular,
                                  size: Ux4gTagSize.m,
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
                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              ),
                            ),
                            SizedBox(height: 8),

                            // Description
                            Text(
                              'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                              style: TextStyle(
                                fontSize: 13,
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Sharing cards
                            _buildSharingCard(
context: context,
                              title: 'Bank of India',
                              shared: 'Aadhaar, Name',
                              purpose: 'Account matching',
                              duration: '1 year',
                              isRequired: true,
                            ),
                            SizedBox(height: 12),
                            _buildSharingCard(
context: context,
                              title: 'Payment Corp',
                              shared: 'Transaction ID',
                              purpose: 'Payment processing',
                              duration: '90 days',
                              isRequired: true,
                            ),
                            SizedBox(height: 12),
                            _buildSharingCard(
context: context,
                              title: 'SMS Gateway',
                              shared: 'Mobile Number',
                              purpose: 'Status alerts',
                              duration: 'Scheme duration',
                              isRequired: false,
                            ),
                            SizedBox(height: 20),

                            // Warning banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.warningLight,
                              title:
                                  'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                              leadingIcon: Icon(
                                Icons.error,
                                color: _isDark(context)
                                    ? Ux4gPalette.orange300
                                    : const Color(0xFFD97706),
                                size: 22,
                              ),
                              titleStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _isDark(context)
                                    ? Ux4gPalette.orange300
                                    : const Color(0xFFB45309),
                              ),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            SizedBox(height: 20),

                            Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
                              contentColor: _isDark(context)
                                  ? Ux4gPalette.neutral400
                                  : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral700),
                              borderColor: _isDark(context)
                                  ? Ux4gPalette.neutral600
                                  : (_isDark(context) ? Ux4gPalette.neutral600 : Ux4gPalette.neutral300),
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
  required BuildContext context,
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
      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
              ),
            ),
            Ux4gTag(
              text: isRequired ? 'Required' : 'Optional',
              customBackgroundColor: isRequired
                  ? _isDark(context)
                        ? Ux4gPalette.red900
                        : const Color(0xFFFFF0F0)
                  : _isDark(context)
                  ? Ux4gPalette.gray800
                  : const Color(0xFFF3F4F6),
              customContentColor: isRequired
                  ? _isDark(context)
                        ? Ux4gPalette.red300
                        : const Color(0xFF8A1A16)
                  : _isDark(context)
                  ? Ux4gPalette.neutral400
                  : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
              shape: Ux4gTagShape.circular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Data shared · $shared',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Purpose · $purpose',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Duration · $duration',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

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
                  color: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.shield_outlined, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 28),
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
                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                    color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                  ),
                ),
                SizedBox(height: 8),
                Ux4gTag(
                  text: 'DPDP Act 2023',
                  customBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                  customContentColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
              style: TextStyle(fontSize: 14, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.4),
            ),
            SizedBox(height: 20),

            // 1. Bank of India Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bank of India',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Aadhaar, Name', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Account matching', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Payment Corp Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Corp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Required',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                        customContentColor: _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Transaction ID', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Payment processing', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · 90 days', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. SMS Gateway Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SMS Gateway',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Optional',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                        customContentColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Mobile Number', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Purpose · Status alerts', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Duration · Scheme duration', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
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
                color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange600,
                size: 22,
              ),
              titleStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange700,
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            SizedBox(height: 24),

            Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
              contentColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
              borderColor: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300,
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
              color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400,
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple/blue card style bg
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                            color: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.shield_outlined, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 28),
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
                            color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                              color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                            ),
                          ),
                          SizedBox(height: 8),
                          Ux4gTag(
                            text: 'DPDP Act 2023',
                            customBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                            customContentColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
                          color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'To enable Direct Benefit Transfer for PM Kisan, the Agriculture Department will share your details with the following third parties.',
                        style: TextStyle(
                          fontSize: 13,
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Bank of India Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Aadhaar, Name', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Account matching', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · 1 year', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Payment Corp Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Required',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Transaction ID', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Payment processing', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · 90 days', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. SMS Gateway Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SMS Gateway',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Optional',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                                  customContentColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Mobile Number', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Purpose · Status alerts', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Duration · Scheme duration', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
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
                          color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange600,
                          size: 22,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange700,
                        ),
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                        contentColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                        borderColor: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300,
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
                      color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400,
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
          options: ['Default', 'Card style'],
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
          _ConsentHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline
                  Text(
                    'Manage Your Data Sharing Consents',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                      color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                    ),
                  ),
                  SizedBox(height: 8),

                  // Description
                  Text(
                    'You can review and withdraw optional consents below.',
                    style: TextStyle(
                      fontSize: 14,
                      color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                      height: 1.45,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sharing cards
                  _buildDataSharingManagementCard(context: context, 
                    title: 'Bank of India',
                    shared: 'Aadhaar, Name',
                    status: 'Required',
                  ),
                  SizedBox(height: 12),
                  _buildDataSharingManagementCard(context: context, 
                    title: 'Payment Corp',
                    shared: 'Transaction ID',
                    status: 'Required',
                  ),
                  SizedBox(height: 12),
                  _buildDataSharingManagementCard(context: context, 
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
                  SizedBox(height: 20),

                  // Warning banner
                  Ux4gStatusBanner(
                    variant: Ux4gBannerVariant.warningLight,
                    title:
                        'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                    leadingIcon: Icon(
                      Icons.error,
                      color: _isDark(context)
                          ? Ux4gPalette.orange300
                          : const Color(0xFFD97706),
                      size: 22,
                    ),
                    titleStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _isDark(context)
                          ? Ux4gPalette.orange300
                          : const Color(0xFFB45309),
                    ),
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  SizedBox(height: 20),

                  Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                            Text(
                              'Manage Your Data Sharing Consents',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              ),
                            ),
                            SizedBox(height: 8),

                            // Description
                            Text(
                              'You can review and withdraw optional consents below.',
                              style: TextStyle(
                                fontSize: 13,
                                color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Sharing cards
                            _buildDataSharingManagementCard(context: context, 
                              title: 'Bank of India',
                              shared: 'Aadhaar, Name',
                              status: 'Required',
                            ),
                            SizedBox(height: 12),
                            _buildDataSharingManagementCard(context: context, 
                              title: 'Payment Corp',
                              shared: 'Transaction ID',
                              status: 'Required',
                            ),
                            SizedBox(height: 12),
                            _buildDataSharingManagementCard(context: context, 
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
                            SizedBox(height: 20),

                            // Warning banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.warningLight,
                              title:
                                  'Required consents cannot be withdrawn as they are necessary for the scheme to function.',
                              leadingIcon: Icon(
                                Icons.error,
                                color: _isDark(context)
                                    ? Ux4gPalette.orange300
                                    : const Color(0xFFD97706),
                                size: 22,
                              ),
                              titleStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: _isDark(context)
                                    ? Ux4gPalette.orange300
                                    : const Color(0xFFB45309),
                              ),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            SizedBox(height: 20),

                            Divider(height: 1, color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
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
  required BuildContext context,
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
      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
              ),
            ),
            Ux4gTag(
              text: isWithdrawn ? 'Withdrawn' : 'Active',
              customBackgroundColor: isWithdrawn
                  ? _isDark(context)
                        ? Ux4gPalette.gray800
                        : const Color(0xFFF3F4F6)
                  : _isDark(context)
                  ? Ux4gPalette.green900
                  : (_isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50),
              customContentColor: isWithdrawn
                  ? _isDark(context)
                        ? Ux4gPalette.neutral400
                        : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600)
                  : _isDark(context)
                  ? Ux4gPalette.green300
                  : (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
              shape: Ux4gTagShape.circular,
              size: Ux4gTagSize.m,
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Data shared · $shared',
          style: TextStyle(
            fontSize: 13,
            color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.w400,
            height: 1.25,
          ),
        ),
        if (status != null) ...[
          SizedBox(height: 2),
          Text(
            'Status · $status',
            style: TextStyle(
              fontSize: 13,
              color: (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
              fontWeight: FontWeight.w400,
              height: 1.25,
            ),
          ),
        ],
        if (isOptional) ...[
          SizedBox(height: 8),
          GestureDetector(
            onTap: onWithdrawToggle,
            child: Text(
              isWithdrawn ? 'Undo' : 'Withdraw',
              style: TextStyle(
                fontSize: 14,
                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

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
                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
              ),
            ),
            SizedBox(height: 8),

            // Description
            Text(
              'You can review and withdraw optional consents below.',
              style: TextStyle(
                fontSize: 14,
                color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                height: 1.45,
              ),
            ),
            SizedBox(height: 20),

            // 1. Bank of India Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bank of India',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Active',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                        customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Aadhaar, Name', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Status · Required', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 2. Payment Corp Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Corp',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: 'Active',
                        customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                        customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Transaction ID', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 2),
                  Text('Status · Required', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                ],
              ),
            ),
            SizedBox(height: 12),

            // 3. SMS Gateway Card (Optional)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SMS Gateway',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      ),
                      Ux4gTag(
                        text: _isSmsGatewayWithdrawn ? 'Withdrawn' : 'Active',
                        customBackgroundColor: _isSmsGatewayWithdrawn ? _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                        customContentColor: _isSmsGatewayWithdrawn ? _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                        shape: Ux4gTagShape.circular,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text('Data shared · Mobile Number', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSmsGatewayWithdrawn = !_isSmsGatewayWithdrawn;
                      });
                    },
                    child: Text(
                      _isSmsGatewayWithdrawn ? 'Undo' : 'Withdraw',
                      style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), fontWeight: FontWeight.w600),
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
                color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange600,
                size: 22,
              ),
              titleStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange700,
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            SizedBox(height: 20),

            Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
              color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400,
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, thickness: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple/blue bg
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                          color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
                          color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Description
                      Text(
                        'You can review and withdraw optional consents below.',
                        style: TextStyle(
                          fontSize: 13,
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

                      // 1. Bank of India Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Aadhaar, Name', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Status · Required', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 2. Payment Corp Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Transaction ID', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 2),
                            Text('Status · Required', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // 3. SMS Gateway Card (Optional)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SMS Gateway',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: _isSmsGatewayWithdrawn ? 'Withdrawn' : 'Active',
                                  customBackgroundColor: _isSmsGatewayWithdrawn ? _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100 : _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                                  customContentColor: _isSmsGatewayWithdrawn ? _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600 : _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Text('Data shared · Mobile Number', style: TextStyle(color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, height: 1.25)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSmsGatewayWithdrawn = !_isSmsGatewayWithdrawn;
                                });
                              },
                              child: Text(
                                _isSmsGatewayWithdrawn ? 'Undo' : 'Withdraw',
                                style: TextStyle(fontSize: 14, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), fontWeight: FontWeight.w600),
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
                          color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange600,
                          size: 22,
                        ),
                        titleStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _isDark(context) ? Ux4gPalette.orange300 : Ux4gPalette.orange700,
                        ),
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      SizedBox(height: 20),

                      Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                      color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400,
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
              color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage Your Data Sharing Consents',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _isDark(context)
                          ? Colors.white
                          : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Scheme: PM Kisan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                    ),
                  ),
                  SizedBox(height: 12),
                  // Mock cards representing background items
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isDark(context)
                          ? Ux4gPalette.gray900
                          : (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isDark(context)
                            ? Ux4gPalette.neutral700
                            : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isDark(context)
                          ? Ux4gPalette.gray900
                          : (_isDark(context) ? Ux4gPalette.gray900 : Ux4gPalette.gray100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isDark(context)
                            ? Ux4gPalette.neutral700
                            : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                      ),
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
                backgroundColor: _isDark(context)
                    ? Ux4gPalette.gray900
                    : Colors.white,
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
                      SizedBox(height: 8),
                      // Centered warning icon in a soft peach/amber circle
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: Color(
                            0xFFFFEBD5,
                          ), // Soft peach/amber matching mockup
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.warning_rounded, // Solid warning triangle
                            color: Color(
                              0xFFEA580C,
                            ), // Vivid warning orange/amber
                            size: 38,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Centered title
                      Text(
                        'Withdraw Consent?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: _isDark(context)
                              ? Colors.white
                              : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Centered description
                      Text(
                        'Withdrawing consent for SMS Gateway will stop sending status alerts to your mobile number. This will not affect your PM Kisan bank transfers.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.5,
                          color: _isDark(context)
                              ? Ux4gPalette.neutral400
                              : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 28),
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
                      SizedBox(height: 8),
                      // Cancel button
                      Ux4gButton(
                        text: 'Cancel',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        contentColor: _isDark(context)
                            ? Colors.white
                            : const Color(0xFF1F2937),
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      SizedBox(height: 16),
                      // Footer disclaimer
                      Text(
                        'You can re-enable this consent at any time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: _isDark(context)
                              ? Ux4gPalette.neutral400
                              : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
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
    backgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
          SizedBox(height: 8),
          // Centered warning icon in a soft peach/amber circle
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: _isDark(context) ? Ux4gPalette.orange900 : Ux4gPalette.orange50,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.warning_rounded,
                color: _isDark(context) ? Ux4gPalette.orange400 : Ux4gPalette.orange600,
                size: 38,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Centered title
          Text(
            'Withdraw Consent?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
            ),
          ),
          SizedBox(height: 12),
          // Centered description
          Text(
            'Withdrawing consent for SMS Gateway will stop sending status alerts to your mobile number. This will not affect your PM Kisan bank transfers.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
              height: 1.45,
            ),
          ),
          SizedBox(height: 28),
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
          SizedBox(height: 8),
          // Cancel button
          Ux4gButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            variant: Ux4gButtonVariant.ghost,
            contentColor: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray800,
            size: Ux4gButtonSize.large,
            width: double.infinity,
          ),
          SizedBox(height: 16),
          // Footer disclaimer
          Text(
            'You can re-enable this consent at any time.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8),
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
          options: ['Default', 'Card style'],
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    // Scrollable Content
    Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Consent History',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A complete audit trail of all your data sharing consents for government schemes.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

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
                    unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                    unselectedBorderColor: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200,
                    unselectedTextColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                  ),
                  SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-Kisan',
                    selected: true,
                    borderRadius: 8.0,
                    onClick: () {},
                    selectedBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                    selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                    selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                  ),
                  SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-MKSSY',
                    selected: false,
                    borderRadius: 8.0,
                    onClick: () {},
                    unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                    unselectedBorderColor: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200,
                    unselectedTextColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                  ),
                  SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PMAY',
                    selected: true,
                    borderRadius: 8.0,
                    onClick: () {},
                    selectedBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                    selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                    selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                  ),
                  SizedBox(width: 8),
                  Ux4gChoiceChip(
                    text: 'PM-Ajay',
                    selected: false,
                    borderRadius: 8.0,
                    onClick: () {},
                    unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                    unselectedBorderColor: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200,
                    unselectedTextColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

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
                      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                            Text(
                              'Bank of India',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                              ),
                            ),
                            Ux4gTag(
                              text: 'Active',
                              customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                              customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Aadhaar, Name',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '12 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Card 2: Payment Corp
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                            Text(
                              'Payment Corp',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                              ),
                            ),
                            Ux4gTag(
                              text: 'Active',
                              customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                              customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Transaction ID',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '12 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Card 3: SMS Gateway
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                            Text(
                              'SMS Gateway',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                              ),
                            ),
                            Ux4gTag(
                              text: 'Withdrawn',
                              customBackgroundColor: _isDark(context) ? Ux4gPalette.red900 : Ux4gPalette.red50,
                              customContentColor: _isDark(context) ? Ux4gPalette.red300 : Ux4gPalette.red800,
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PM Kisan',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '15 Jan 2024',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Card 4: Housing Board
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                            Text(
                              'Housing Board',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                              ),
                            ),
                            Ux4gTag(
                              text: 'Expired',
                              customBackgroundColor: _isDark(context) ? Ux4gPalette.gray800 : Ux4gPalette.gray100,
                              customContentColor: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray800,
                              shape: Ux4gTagShape.circular,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Scheme',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'PMAY',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Data',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                'Address, Income',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'Given',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text('· ', style: TextStyle(fontSize: 13.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold)),
                            Expanded(
                              child: Text(
                                '03 Mar 2023',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
            SizedBox(height: 8),

            // Footer / Navigation Actions
            Center(
              child: Column(
                children: [
                  Text(
                    'Showing 4 of 4 consents',
                    style: TextStyle(
                      fontSize: 13,
                      color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Download Consent History (PDF)',
                      style: TextStyle(
                        fontSize: 14,
                        color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16,
                        color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
          Text(
            'Powered by -',
            style: TextStyle(
              fontSize: 11,
              color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400,
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
        statusColor: _isDark(context)
            ? Ux4gPalette.green900
            : (_isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50),
        textColor: _isDark(context)
            ? Ux4gPalette.green300
            : (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
      ),
      _ConsentHistoryItem(
        title: 'Payment Corp',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Transaction ID',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: _isDark(context)
            ? Ux4gPalette.green900
            : (_isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50),
        textColor: _isDark(context)
            ? Ux4gPalette.green300
            : (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
      ),
      _ConsentHistoryItem(
        title: 'SMS Gateway',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Mobile Number',
        givenDate: '15 Jan 2024',
        status: 'Withdrawn',
        statusColor: _isDark(context)
            ? Ux4gPalette.red900
            : const Color(0xFFFCE8E6),
        textColor: _isDark(context)
            ? Ux4gPalette.red300
            : const Color(0xFFC5221F),
      ),
      _ConsentHistoryItem(
        title: 'Housing Board',
        scheme: 'PMAY',
        filterKey: 'PMAY',
        dataShared: 'Address, Income',
        givenDate: '03 Mar 2023',
        status: 'Expired',
        statusColor: _isDark(context)
            ? Ux4gPalette.gray800
            : const Color(0xFFF1F3F4),
        textColor: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray800,
      ),
    ];

    final displayedConsents = allConsents.where((item) {
      if (_selectedFilters.contains('All')) return true;
      return _selectedFilters.contains(item.filterKey);
    }).toList();

    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
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
                        Text(
                          'Consent History',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _isDark(context)
                                ? Colors.white
                                : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'A complete audit trail of all your data sharing consents for government schemes.',
                          style: TextStyle(
                            fontSize: 14,
                            color: _isDark(context)
                                ? Ux4gPalette.neutral400
                                : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                          SizedBox(width: 8),
                          _buildFilterChip('PM-Kisan'),
                          SizedBox(width: 8),
                          _buildFilterChip('PM-MKSSY'),
                          SizedBox(width: 8),
                          _buildFilterChip('PMAY'),
                          SizedBox(width: 8),
                          _buildFilterChip('PM-Ajay'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: displayedConsents.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                'No consents found for the selected filters.',
                                style: TextStyle(
                                  color: _isDark(context)
                                      ? Ux4gPalette.neutral400
                                      : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                ),
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
                                    color: _isDark(context)
                                        ? Ux4gPalette.gray900
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _isDark(context)
                                          ? Ux4gPalette.neutral700
                                          : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: _isDark(context)
                                                  ? Colors.white
                                                  : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                      SizedBox(height: 10),
                                      _buildCardRow('Scheme', item.scheme),
                                      SizedBox(height: 4),
                                      _buildCardRow('Data', item.dataShared),
                                      SizedBox(height: 4),
                                      _buildCardRow('Given', item.givenDate),
                                      SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'View',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
                          style: TextStyle(
                            fontSize: 13,
                            color: _isDark(context)
                                ? Ux4gPalette.neutral400
                                : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Download Consent History (PDF)',
                            style: TextStyle(
                              fontSize: 14,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
                Text(
                  'Powered by -',
                  style: TextStyle(
                    fontSize: 11,
                    color: _isDark(context)
                        ? Ux4gPalette.neutral500
                        : (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
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
      selectedBackgroundColor: _isDark(context)
          ? Ux4gPalette.primary900
          : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
      selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
      selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
      unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,

      unselectedBorderColor: _isDark(context)
          ? Ux4gPalette.neutral700
          : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
      unselectedTextColor: _isDark(context)
          ? Ux4gPalette.neutral400
          : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
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
            style: TextStyle(
              fontSize: 13.5,
              color: _isDark(context)
                  ? Ux4gPalette.neutral400
                  : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          '· ',
          style: TextStyle(
            fontSize: 13.5,
            color: _isDark(context)
                ? Ux4gPalette.neutral400
                : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.5,
              color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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
        statusColor: _isDark(context)
            ? Ux4gPalette.green900
            : (_isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50),
        textColor: _isDark(context)
            ? Ux4gPalette.green300
            : (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
      ),
      _ConsentHistoryItem(
        title: 'Payment Corp',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Transaction ID',
        givenDate: '12 Jan 2024',
        status: 'Active',
        statusColor: _isDark(context)
            ? Ux4gPalette.green900
            : (_isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50),
        textColor: _isDark(context)
            ? Ux4gPalette.green300
            : (_isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700),
      ),
      _ConsentHistoryItem(
        title: 'SMS Gateway',
        scheme: 'PM Kisan',
        filterKey: 'PM-Kisan',
        dataShared: 'Mobile Number',
        givenDate: '15 Jan 2024',
        status: 'Withdrawn',
        statusColor: _isDark(context)
            ? Ux4gPalette.red900
            : const Color(0xFFFCE8E6),
        textColor: _isDark(context)
            ? Ux4gPalette.red300
            : const Color(0xFFC5221F),
      ),
      _ConsentHistoryItem(
        title: 'Housing Board',
        scheme: 'PMAY',
        filterKey: 'PMAY',
        dataShared: 'Address, Income',
        givenDate: '03 Mar 2023',
        status: 'Expired',
        statusColor: _isDark(context)
            ? Ux4gPalette.gray800
            : const Color(0xFFF1F3F4),
        textColor: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray800,
      ),
    ];

    final displayedConsents = allConsents.where((item) {
      if (_selectedFilters.contains('All')) return true;
      return _selectedFilters.contains(item.filterKey);
    }).toList();

    return _PhoneFrame(
      child: Column(
        children: [
          _ConsentHeader(),
          Expanded(
            child: Container(
              color: _isDark(context)
                  ? Ux4gPalette.primary900
                  : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _isDark(context)
                              ? Ux4gPalette.gray900
                              : Colors.white,
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
                            Text(
                              'Consent History',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: _isDark(context)
                                    ? Colors.white
                                    : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                letterSpacing: -0.3,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'A complete audit trail of all your data sharing consents for government schemes.',
                              style: TextStyle(
                                fontSize: 13,
                                color: _isDark(context)
                                    ? Ux4gPalette.neutral400
                                    : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                height: 1.45,
                              ),
                            ),
                            SizedBox(height: 20),
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
                                    SizedBox(width: 8),
                                    _buildFilterChip('PM-Kisan'),
                                    SizedBox(width: 8),
                                    _buildFilterChip('PM-MKSSY'),
                                    SizedBox(width: 8),
                                    _buildFilterChip('PMAY'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            if (displayedConsents.isEmpty)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40),
                                  child: Text(
                                    'No consents found.',
                                    style: TextStyle(
                                      color: _isDark(context)
                                          ? Ux4gPalette.neutral400
                                          : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                    ),
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
                                        color: _isDark(context)
                                            ? Ux4gPalette.gray900
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: _isDark(context)
                                              ? Ux4gPalette.neutral700
                                              : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
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
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: _isDark(context)
                                                      ? Colors.white
                                                      : (_isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
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
                                          SizedBox(height: 8),
                                          _buildCardRow('Scheme', item.scheme),
                                          SizedBox(height: 4),
                                          _buildCardRow(
                                            'Data',
                                            item.dataShared,
                                          ),
                                          SizedBox(height: 4),
                                          _buildCardRow(
                                            'Given',
                                            item.givenDate,
                                          ),
                                          SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              'View',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
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
                            SizedBox(height: 12),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Showing ${displayedConsents.length} of ${allConsents.length} consents',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _isDark(context)
                                          ? Ux4gPalette.neutral400
                                          : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Download Consent History (PDF)',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
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
                        Text(
                          'Powered by -',
                          style: TextStyle(
                            fontSize: 11,
                            color: _isDark(context)
                                ? Ux4gPalette.neutral500
                                : (_isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 6),
                        Image.asset(
            _digitalIndiaLogoPath,
            height: 22,
            color: _isDark(context) ? Colors.white : null,
          ),
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
      selectedBackgroundColor: _isDark(context)
          ? Ux4gPalette.primary900
          : (_isDark(context) ? Ux4gPalette.primary900 : Ux4gPalette.primary100),
      selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
      selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
      unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,

      unselectedBorderColor: _isDark(context)
          ? Ux4gPalette.neutral700
          : (_isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
      unselectedTextColor: _isDark(context)
          ? Ux4gPalette.neutral400
          : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral600),
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
            style: TextStyle(
              fontSize: 12.5,
              color: _isDark(context)
                  ? Ux4gPalette.neutral400
                  : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          '· ',
          style: TextStyle(
            fontSize: 12.5,
            color: _isDark(context)
                ? Ux4gPalette.neutral400
                : (_isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
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

  _ConsentHistoryItem({
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
        Container(width: 1, height: 28, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral300),
        SvgPicture.asset('assets/Union.svg', height: 32),
      ],
      actions: [
        Ux4gAppHeaderAction(
          customWidget: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(Icons.menu, color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600), size: 20),
            ),
          ),
        ),
      ],
      horizontalPadding: 16,
      leadingSpacing: 12,
    ),
    Divider(height: 1, color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),

    Expanded(
      child: Container(
        color: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100, // Soft purple background
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
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
                      Text(
                        'Consent History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A complete audit trail of all your data sharing consents for government schemes.',
                        style: TextStyle(
                          fontSize: 13,
                          color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500,
                          height: 1.45,
                        ),
                      ),
                      SizedBox(height: 20),

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
                              unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                              unselectedTextColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.gray900,
                              unselectedBorderColor: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200,
                            ),
                            SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PM-Kisan',
                              selected: true,
                              borderRadius: 8.0,
                              onClick: () {},
                              selectedBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                              selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                            ),
                            SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PM-MKSSY',
                              selected: false,
                              borderRadius: 8.0,
                              onClick: () {},
                              unselectedBackgroundColor: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                              unselectedTextColor: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.gray900,
                              unselectedBorderColor: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200,
                            ),
                            SizedBox(width: 8),
                            Ux4gChoiceChip(
                              text: 'PMAY',
                              selected: true,
                              borderRadius: 8.0,
                              onClick: () {},
                              selectedBackgroundColor: _isDark(context) ? Ux4gPalette.primary800 : Ux4gPalette.primary100,
                              selectedBorderColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                              selectedTextColor: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Card 1: Bank of India
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank of India',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _ConsentRow(label: 'Scheme', value: 'PM Kisan'),
                            SizedBox(height: 4),
                            _ConsentRow(label: 'Data', value: 'Aadhaar, Name'),
                            SizedBox(height: 4),
                            _ConsentRow(label: 'Given', value: '12 Jan 2024'),
                            SizedBox(height: 8),
                            Text(
                              'View',
                              style: TextStyle(
                                fontSize: 13,
                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),

                      // Card 2: Payment Corp
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _isDark(context) ? Ux4gPalette.gray900 : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _isDark(context) ? Ux4gPalette.neutral800 : Ux4gPalette.neutral200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Corp',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900),
                                ),
                                Ux4gTag(
                                  text: 'Active',
                                  customBackgroundColor: _isDark(context) ? Ux4gPalette.green900 : Ux4gPalette.green50,
                                  customContentColor: _isDark(context) ? Ux4gPalette.green300 : Ux4gPalette.green700,
                                  shape: Ux4gTagShape.circular,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _ConsentRow(label: 'Scheme', value: 'PM Kisan'),
                            SizedBox(height: 4),
                            _ConsentRow(label: 'Data', value: 'Transaction ID'),
                            SizedBox(height: 4),
                            _ConsentRow(label: 'Given', value: '12 Jan 2024'),
                            SizedBox(height: 8),
                            Text(
                              'View',
                              style: TextStyle(
                                fontSize: 13,
                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Footer Actions
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Showing 4 of 4 consents',
                              style: TextStyle(fontSize: 12, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Download Consent History (PDF)',
                              style: TextStyle(
                                fontSize: 13,
                                color: (_isDark(context) ? Ux4gPalette.primary300 : Ux4gPalette.primary600),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 24),
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
                  Text(
                    'Powered by -',
                    style: TextStyle(fontSize: 11, color: _isDark(context) ? Ux4gPalette.neutral500 : Ux4gPalette.neutral400, fontWeight: FontWeight.w500),
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
)

// Helper widget for Consent History code strings
class _ConsentRow extends StatelessWidget {
  final String label;
  final String value;

  _ConsentRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: TextStyle(fontSize: 12.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.w500),
          ),
        ),
        Text(
          '· ',
          style: TextStyle(fontSize: 12.5, color: _isDark(context) ? Ux4gPalette.neutral400 : Ux4gPalette.neutral500, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12.5, color: _isDark(context) ? Ux4gPalette.neutral50 : Ux4gPalette.gray900, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}''';
