import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _greenColor = Color(0xFF16A34A);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final applicationSubmittedComponent = WidgetbookComponent(
  name: 'Application Submitted',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description:
              'Switch between the standard flat layout and the card-style layout.',
        );

        final code = variant == 'Card style'
            ? _applicationSubmittedCardCode
            : _applicationSubmittedDefaultCode;
        final child = variant == 'Card style'
            ? const _ApplicationSubmittedCardMockup()
            : const _ApplicationSubmittedMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Application Submitted',
          description:
              'A success confirmation screen shown after an application is submitted, '
              'displaying a reference number, next steps timeline, and action buttons.',
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

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFDCFCE7),
      ),
      child: const Icon(Icons.check_circle, color: _greenColor, size: 36),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Ux4gPalette.primary50,
        border: Border.all(color: Ux4gPalette.primary300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Application Reference',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'INC-2026-MH-04127',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _titleColor,
                ),
              ),
              Icon(
                Icons.copy_outlined,
                color: Ux4gPalette.primary300,
                size: 22,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NextStepsTimeline extends StatelessWidget {
  const _NextStepsTimeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What happens next',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 20),
        _TimelineItem(
          number: '1',
          title: 'Document verification',
          subtitle: '3-5 working days',
        ),
        _TimelineItem(
          number: '2',
          title: 'Field inspection (if required)',
          subtitle: 'Inspector will contact you',
        ),
        _TimelineItem(
          number: '3',
          title: 'Certificate issued',
          subtitle: 'Within 30 days · Legal SLA',
          isLast: true,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final bool isLast;

  const _TimelineItem({
    required this.number,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _primaryColor,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13, color: _subtleText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.phone_android, size: 16, color: _subtleText),
        const SizedBox(width: 6),
        const Expanded(
          child: Text(
            'SMS sent to +91\n98765 •••••',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.email_outlined, size: 16, color: _subtleText),
        const SizedBox(width: 6),
        const Expanded(
          child: Text(
            'Email sent to\nr••••@gmail.com',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ux4gButton(
          text: 'Track my application',
          onPressed: () {},
          size: Ux4gButtonSize.large,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        Ux4gButton(
          text: 'Download acknowledgement (PDF)',
          onPressed: () {},
          variant: Ux4gButtonVariant.outline,
          size: Ux4gButtonSize.large,
          width: double.infinity,
          contentColor: _primaryColor,
          borderColor: _primaryColor,
        ),
        const SizedBox(height: 12),
        Ux4gButton(
          text: 'Add to calendar',
          onPressed: () {},
          variant: Ux4gButtonVariant.outline,
          size: Ux4gButtonSize.large,
          width: double.infinity,
          contentColor: _primaryColor,
          borderColor: _primaryColor,
        ),
      ],
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _applicationSubmittedDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationSubmittedScreen extends StatelessWidget {
  const ApplicationSubmittedScreen({super.key});

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
                    // Back link
                    GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, size: 18, color: primaryColor),
                          SizedBox(width: 6),
                          Text('Return to services', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Success icon
                    Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDCFCE7)),
                        child: const Icon(Icons.check_circle, color: greenColor, size: 36),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title
                    const Center(
                      child: Text(
                        'Application Submitted\nSuccessfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Your Income Certificate application is now\nunder review by the Revenue Department.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: subtleText, height: 1.4),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Reference card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2EFFF),
                        border: Border.all(color: const Color(0xFFA391FF)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Application Reference', style: TextStyle(fontSize: 12, color: subtleText)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('INC-2026-MH-04127', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: titleColor)),
                              Icon(Icons.copy_outlined, color: const Color(0xFFA391FF), size: 22),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // What happens next - Journey Timeline
                    Ux4gJourneyTimeline(
                      header: const Ux4gJourneyHeader(title: 'What happens next'),
                      steps: const [
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.current,
                          title: 'Document verification',
                          helpingText: '3-5 working days',
                        ),
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.upcoming,
                          title: 'Field inspection (if required)',
                          helpingText: 'Inspector will contact you',
                        ),
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.upcoming,
                          title: 'Certificate issued',
                          helpingText: 'Within 30 days · Legal SLA',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Notification row
                    Row(
                      children: [
                        const Icon(Icons.phone_android, size: 16, color: subtleText),
                        const SizedBox(width: 6),
                        const Expanded(child: Text('SMS sent to +91\n98765 •••••', style: TextStyle(fontSize: 12, color: subtleText))),
                        const SizedBox(width: 16),
                        const Icon(Icons.email_outlined, size: 16, color: subtleText),
                        const SizedBox(width: 6),
                        const Expanded(child: Text('Email sent to\nr••••@gmail.com', style: TextStyle(fontSize: 12, color: subtleText))),
                      ],
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
                  Ux4gButton(text: 'Track my application', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Download acknowledgement (PDF)', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Add to calendar', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
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

const _applicationSubmittedCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationSubmittedCardScreen extends StatelessWidget {
  const ApplicationSubmittedCardScreen({super.key});

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
                      // Back link
                      GestureDetector(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back, size: 18, color: primaryColor),
                            SizedBox(width: 6),
                            Text('Return to services', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: primaryColor)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Success icon
                      Center(
                        child: Container(
                          width: 56, height: 56,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFDCFCE7)),
                          child: const Icon(Icons.check_circle, color: greenColor, size: 36),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Title
                      const Center(
                        child: Text(
                          'Application Submitted\nSuccessfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Your Income Certificate application is now\nunder review by the Revenue Department.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: subtleText, height: 1.4),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Reference card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Application Reference', style: TextStyle(fontSize: 12, color: subtleText)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('INC-2026-MH-04127', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: titleColor)),
                                Icon(Icons.copy_outlined, color: const Color(0xFFA391FF), size: 22),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // What happens next - Journey Timeline
                      Ux4gJourneyTimeline(
                        header: const Ux4gJourneyHeader(title: 'What happens next'),
                        steps: const [
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.current,
                            title: 'Document verification',
                            helpingText: '3-5 working days',
                          ),
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.upcoming,
                            title: 'Field inspection (if required)',
                            helpingText: 'Inspector will contact you',
                          ),
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.upcoming,
                            title: 'Certificate issued',
                            helpingText: 'Within 30 days · Legal SLA',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Notification row
                      Row(
                        children: [
                          const Icon(Icons.phone_android, size: 16, color: subtleText),
                          const SizedBox(width: 6),
                          const Expanded(child: Text('SMS sent to +91\n98765 •••••', style: TextStyle(fontSize: 12, color: subtleText))),
                          const SizedBox(width: 16),
                          const Icon(Icons.email_outlined, size: 16, color: subtleText),
                          const SizedBox(width: 6),
                          const Expanded(child: Text('Email sent to\nr••••@gmail.com', style: TextStyle(fontSize: 12, color: subtleText))),
                        ],
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
                  Ux4gButton(text: 'Track my application', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Download acknowledgement (PDF)', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Add to calendar', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
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

class _ApplicationSubmittedMockup extends StatelessWidget {
  const _ApplicationSubmittedMockup();

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
                  errorBuilder: (c, e, s) => const Icon(
                    Icons.account_balance,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 1),
                Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 1),
                SvgPicture.asset(
                  _unionLogoPath,
                  height: 32,
                  errorBuilder: (c, e, s) =>
                      const Icon(Icons.blur_on, size: 32, color: Colors.blue),
                ),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back link
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: _primaryColor,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Return to services',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Success icon
                    const Center(child: _SuccessIcon()),
                    const SizedBox(height: 20),

                    // Title
                    const Center(
                      child: Text(
                        'Application Submitted\nSuccessfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Your Income Certificate application is now\nunder review by the Revenue Department.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: _subtleText,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Reference card
                    const _ReferenceCard(),
                    const SizedBox(height: 28),

                    // Next steps timeline
                    const _NextStepsTimeline(),
                    const SizedBox(height: 24),

                    // Notification row
                    const _NotificationRow(),
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const _ActionButtons(),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Powered by -',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 6),
                  Image.asset(
                    _digitalIndiaLogoPath,
                    height: 24,
                    errorBuilder: (c, e, s) => const Text(
                      'Digital India',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
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

class _ApplicationSubmittedCardMockup extends StatelessWidget {
  const _ApplicationSubmittedCardMockup();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
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
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.account_balance,
                            size: 32,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 1),
                        Container(
                          height: 32,
                          width: 1,
                          color: const Color(0xFFD1D5DB),
                        ),
                        const SizedBox(width: 1),
                        SvgPicture.asset(
                          _unionLogoPath,
                          height: 32,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.blur_on,
                            size: 32,
                            color: Colors.blue,
                          ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back link
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: _primaryColor,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Return to services',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Success icon
                        const Center(child: _SuccessIcon()),
                        const SizedBox(height: 20),

                        // Title
                        const Center(
                          child: Text(
                            'Application Submitted\nSuccessfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _titleColor,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'Your Income Certificate application is now\nunder review by the Revenue Department.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Reference card
                        const _ReferenceCard(),
                        const SizedBox(height: 28),

                        // Next steps timeline
                        const _NextStepsTimeline(),
                        const SizedBox(height: 24),

                        // Notification row
                        const _NotificationRow(),
                      ],
                    ),
                  ),
                ),
              ),

              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: const _ActionButtons(),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Powered by -',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      _digitalIndiaLogoPath,
                      height: 24,
                      errorBuilder: (c, e, s) => const Text(
                        'Digital India',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
}
