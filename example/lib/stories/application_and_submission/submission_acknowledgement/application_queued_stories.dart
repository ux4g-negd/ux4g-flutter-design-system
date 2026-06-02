import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final applicationQueuedComponent = WidgetbookComponent(
  name: 'Application Queued',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
          description: 'Switch between the standard flat layout and the card-style layout.',
        );

        final code = variant == 'Card style'
            ? _applicationQueuedCardCode
            : _applicationQueuedDefaultCode;
        final child = variant == 'Card style'
            ? const _ApplicationQueuedCardMockup()
            : const _ApplicationQueuedMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Application Queued',
          description:
              'A pattern shown when the application is queued for submission due to connectivity issues, '
              'with a toast notification and options to retry or save draft.',
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

class _QueuedIcon extends StatelessWidget {
  const _QueuedIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFEDE9FE),
      ),
      child: const Icon(Icons.hourglass_bottom, color: _primaryColor, size: 30),
    );
  }
}

class _ToastCard extends StatelessWidget {
  final VoidCallback? onClose;
  const _ToastCard({this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Icon(Icons.warning_amber_rounded, color: Color(0xFFF59E0B), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Application queued',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Will submit when connection is restored.',
                  style: TextStyle(fontSize: 13, color: _subtleText),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onClose,
                  child: const Text(
                    'Understood',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _primaryColor),
                  ),
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

const _applicationQueuedDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationQueuedScreen extends StatelessWidget {
  const ApplicationQueuedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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

                        // Queued icon
                        Center(
                          child: Container(
                            width: 56, height: 56,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEDE9FE)),
                            child: const Icon(Icons.hourglass_bottom, color: primaryColor, size: 30),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title
                        const Center(
                          child: Text(
                            'Application Queued',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'We\'ll submit your application automatically\nwhen your connection is restored. Your data is\nsaved.',
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
                      Ux4gButton(text: 'Try submitting now', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                      const SizedBox(height: 12),
                      Ux4gButton(text: 'Save draft and exit', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
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

            // Toast notification from bottom
            Positioned(
              left: 16,
              right: 16,
              bottom: 180,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, -4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Color(0xFFF59E0B), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Application queued', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                              const SizedBox(height: 4),
                              const Text('Will submit when connection is restored.', style: TextStyle(fontSize: 13, color: subtleText)),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Understood', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primaryColor)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.close, size: 18, color: subtleText),
                        ),
                      ],
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

const _applicationQueuedCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApplicationQueuedCardScreen extends StatelessWidget {
  const ApplicationQueuedCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    const titleColor = Color(0xFF111827);
    const subtleText = Color(0xFF4B5563);

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

                          // Queued icon
                          Center(
                            child: Container(
                              width: 56, height: 56,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEDE9FE)),
                              child: const Icon(Icons.hourglass_bottom, color: primaryColor, size: 30),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Title
                          const Center(
                            child: Text('Application Queued', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: titleColor, height: 1.2)),
                          ),
                          const SizedBox(height: 12),
                          const Center(
                            child: Text('We\'ll submit your application automatically\nwhen your connection is restored. Your data is\nsaved.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: subtleText, height: 1.4)),
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
                      Ux4gButton(text: 'Try submitting now', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                      const SizedBox(height: 12),
                      Ux4gButton(text: 'Save draft and exit', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
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

            // Toast notification from bottom
            Positioned(
              left: 16,
              right: 16,
              bottom: 180,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 16, offset: const Offset(0, -4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Color(0xFFF59E0B), size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Application queued', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: titleColor)),
                              const SizedBox(height: 4),
                              const Text('Will submit when connection is restored.', style: TextStyle(fontSize: 13, color: subtleText)),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Understood', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: primaryColor)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.close, size: 18, color: subtleText),
                        ),
                      ],
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

class _ApplicationQueuedMockup extends StatefulWidget {
  const _ApplicationQueuedMockup();

  @override
  State<_ApplicationQueuedMockup> createState() => _ApplicationQueuedMockupState();
}

class _ApplicationQueuedMockupState extends State<_ApplicationQueuedMockup> {
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
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back link
                        Row(
                          children: [
                            const Icon(Icons.arrow_back, size: 18, color: _primaryColor),
                            const SizedBox(width: 6),
                            const Text('Return to services', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: _primaryColor)),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Queued icon
                        const Center(child: _QueuedIcon()),
                        const SizedBox(height: 20),

                        // Title
                        const Center(
                          child: Text(
                            'Application Queued',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'We\'ll submit your application automatically\nwhen your connection is restored. Your data is\nsaved.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // What happens next
                        const Text('What happens next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor)),
                        const SizedBox(height: 20),

                        // Timeline steps
                        _TimelineItem(number: '1', title: 'Document verification', subtitle: '3-5 working days'),
                        _TimelineItem(number: '2', title: 'Field inspection (if required)', subtitle: 'Inspector will contact you'),
                        _TimelineItem(number: '3', title: 'Certificate issued', subtitle: 'Within 30 days · Legal SLA', isLast: true),
                      ],
                    ),
                  ),
                ),

                // Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      Ux4gButton(
                        text: 'Try submitting now',
                        onPressed: () => setState(() => _showToast = true),
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      Ux4gButton(
                        text: 'Save draft and exit',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        width: double.infinity,
                        contentColor: _primaryColor,
                        borderColor: _primaryColor,
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
                      Image.asset(
                        _digitalIndiaLogoPath,
                        height: 24,
                        errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Toast from bottom on button tap
            if (_showToast)
              Positioned(
                left: 16,
                right: 16,
                bottom: 180,
                child: _ToastCard(onClose: () => setState(() => _showToast = false)),
              ),
          ],
        ),
      ),
    );
  }
}

class _ApplicationQueuedCardMockup extends StatefulWidget {
  const _ApplicationQueuedCardMockup();

  @override
  State<_ApplicationQueuedCardMockup> createState() => _ApplicationQueuedCardMockupState();
}

class _ApplicationQueuedCardMockupState extends State<_ApplicationQueuedCardMockup> {
  bool _showToast = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 6)),
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
                              errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey),
                            ),
                            const SizedBox(width: 1),
                            Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                            const SizedBox(width: 1),
                            SvgPicture.asset(
                              _unionLogoPath,
                              height: 32,
                              errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue),
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
                            Row(
                              children: [
                                const Icon(Icons.arrow_back, size: 18, color: _primaryColor),
                                const SizedBox(width: 6),
                                const Text('Return to services', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: _primaryColor)),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Queued icon
                            const Center(child: _QueuedIcon()),
                            const SizedBox(height: 20),

                            // Title
                            const Center(
                              child: Text(
                                'Application Queued',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Center(
                              child: Text(
                                'We\'ll submit your application automatically\nwhen your connection is restored. Your data is\nsaved.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // What happens next
                            const Text('What happens next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor)),
                            const SizedBox(height: 20),

                            // Timeline steps
                            _TimelineItem(number: '1', title: 'Document verification', subtitle: '3-5 working days'),
                            _TimelineItem(number: '2', title: 'Field inspection (if required)', subtitle: 'Inspector will contact you'),
                            _TimelineItem(number: '3', title: 'Certificate issued', subtitle: 'Within 30 days · Legal SLA', isLast: true),
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
                        Ux4gButton(
                          text: 'Try submitting now',
                          onPressed: () => setState(() => _showToast = true),
                          size: Ux4gButtonSize.large,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 12),
                        Ux4gButton(
                          text: 'Save draft and exit',
                          onPressed: () {},
                          variant: Ux4gButtonVariant.outline,
                          size: Ux4gButtonSize.large,
                          width: double.infinity,
                          contentColor: _primaryColor,
                          borderColor: _primaryColor,
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
                        Image.asset(
                          _digitalIndiaLogoPath,
                          height: 24,
                          errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Toast from bottom on button tap
              if (_showToast)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 180,
                  child: _ToastCard(onClose: () => setState(() => _showToast = false)),
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
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
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
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: _titleColor),
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
