import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _errorColor = Color(0xFFDC2626);
const Color _errorBg = Color(0xFFFEE2E2);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final couldNotSubmitComponent = WidgetbookComponent(
  name: 'Could Not Submit',
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
            ? _couldNotSubmitCardCode
            : _couldNotSubmitDefaultCode;
        final child = variant == 'Card style'
            ? const _CouldNotSubmitCardMockup()
            : const _CouldNotSubmitMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Could Not Submit',
          description:
              'An error screen shown when the application could not be submitted due to '
              'a network or server error, with options to retry, save draft, or contact support.',
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

class _ErrorIcon extends StatelessWidget {
  const _ErrorIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _errorBg),
      child: const Icon(Icons.error_outline, color: _errorColor, size: 30),
    );
  }
}

class _ErrorToastCard extends StatelessWidget {
  final VoidCallback? onClose;
  const _ErrorToastCard({this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error, color: _errorColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Could not submit',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Network or server issue',
                  style: TextStyle(fontSize: 13, color: _subtleText),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(Icons.close, size: 18, color: _subtleText),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _couldNotSubmitDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouldNotSubmitScreen extends StatelessWidget {
  const CouldNotSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);
    const errorColor = Color(0xFFDC2626);
    const errorBg = Color(0xFFFEE2E2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
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

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // Error icon
                        Center(
                          child: Container(
                            width: 56, height: 56,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: errorBg),
                            child: const Icon(Icons.error_outline, color: errorColor, size: 30),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        const Center(
                          child: Text(
                            'Could Not Submit\nApplication',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'We could not submit your application due to\na network or server error. Your data is saved —\ntry again.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: subtleText, height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 32),

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
                      ],
                    ),
                  ),
                ),

                // Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      Ux4gButton(text: 'Retry submission', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                      const SizedBox(height: 12),
                      Ux4gButton(text: 'Save draft', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text('Contact support', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                        ),
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
                      Image.asset('assets/digital_india_logo.png', height: 24),
                    ],
                  ),
                ),
              ],
            ),

            // Error toast notification
            Positioned(
              left: 16,
              right: 16,
              top: 80,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, -4)),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error, color: errorColor, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Could not submit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                          const SizedBox(height: 4),
                          const Text('Network or server issue', style: TextStyle(fontSize: 13, color: subtleText)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.close, size: 18, color: subtleText),
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

const _couldNotSubmitCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouldNotSubmitCardScreen extends StatelessWidget {
  const CouldNotSubmitCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);
    const errorColor = Color(0xFFDC2626);
    const errorBg = Color(0xFFFEE2E2);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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

                // White card with content
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
                          const SizedBox(height: 32),

                          // Error icon
                          Center(
                            child: Container(
                              width: 56, height: 56,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: errorBg),
                              child: const Icon(Icons.error_outline, color: errorColor, size: 30),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Title
                          const Center(
                            child: Text('Could Not Submit\nApplication', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2)),
                          ),
                          const SizedBox(height: 12),
                          const Center(
                            child: Text('We could not submit your application due to\na network or server error. Your data is saved —\ntry again.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: subtleText, height: 1.4)),
                          ),
                          const SizedBox(height: 32),

                          // Journey Timeline
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
                      Ux4gButton(text: 'Retry submission', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                      const SizedBox(height: 12),
                      Ux4gButton(text: 'Save draft', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text('Contact support', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                        ),
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
                      Image.asset('assets/digital_india_logo.png', height: 24),
                    ],
                  ),
                ),
              ],
            ),

            // Error toast notification
            Positioned(
              left: 16,
              right: 16,
              top: 80,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, -4)),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error, color: errorColor, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Could not submit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                          const SizedBox(height: 4),
                          const Text('Network or server issue', style: TextStyle(fontSize: 13, color: subtleText)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.close, size: 18, color: subtleText),
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
// Mockups
// ───────────────────────────────────────────────────────────────────────

class _CouldNotSubmitMockup extends StatefulWidget {
  const _CouldNotSubmitMockup();

  @override
  State<_CouldNotSubmitMockup> createState() => _CouldNotSubmitMockupState();
}

class _CouldNotSubmitMockupState extends State<_CouldNotSubmitMockup> {
  bool _showToast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
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
                        const SizedBox(height: 32),

                        // Error icon
                        const Center(child: _ErrorIcon()),
                        const SizedBox(height: 20),

                        // Title
                        const Center(
                          child: Text(
                            'Could Not Submit\nApplication',
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
                            'We could not submit your application due to\na network or server error. Your data is saved —\ntry again.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: _subtleText,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // What happens next
                        const Text(
                          'What happens next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _titleColor,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Timeline steps
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
                    ),
                  ),
                ),

                // Actions
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Ux4gButton(
                        text: 'Retry submission',
                        onPressed: () => setState(() => _showToast = true),
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
                        contentColor: _primaryColor,
                        borderColor: _primaryColor,
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Contact support',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _titleColor,
                            ),
                          ),
                        ),
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
                      const Text(
                        'Powered by -',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
                        ),
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

            // Error toast
            if (_showToast)
              Positioned(
                left: 16,
                right: 16,
                top: 80,
                child: _ErrorToastCard(
                  onClose: () => setState(() => _showToast = false),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CouldNotSubmitCardMockup extends StatefulWidget {
  const _CouldNotSubmitCardMockup();

  @override
  State<_CouldNotSubmitCardMockup> createState() =>
      _CouldNotSubmitCardMockupState();
}

class _CouldNotSubmitCardMockupState extends State<_CouldNotSubmitCardMockup> {
  bool _showToast = false;

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
          child: Stack(
            children: [
              Column(
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

                  // White card with content
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
                            const SizedBox(height: 32),

                            // Error icon
                            const Center(child: _ErrorIcon()),
                            const SizedBox(height: 20),

                            // Title
                            const Center(
                              child: Text(
                                'Could Not Submit\nApplication',
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
                                'We could not submit your application due to\na network or server error. Your data is saved —\ntry again.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _subtleText,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // What happens next
                            const Text(
                              'What happens next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _titleColor,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Timeline steps
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
                    child: Column(
                      children: [
                        Ux4gButton(
                          text: 'Retry submission',
                          onPressed: () => setState(() => _showToast = true),
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
                          contentColor: _primaryColor,
                          borderColor: _primaryColor,
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Contact support',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _titleColor,
                              ),
                            ),
                          ),
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
                        const Text(
                          'Powered by -',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                          ),
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

              // Error toast
              if (_showToast)
                Positioned(
                  left: 16,
                  right: 16,
                  top: 80,
                  child: _ErrorToastCard(
                    onClose: () => setState(() => _showToast = false),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Timeline item (local to this file)
// ───────────────────────────────────────────────────────────────────────

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
