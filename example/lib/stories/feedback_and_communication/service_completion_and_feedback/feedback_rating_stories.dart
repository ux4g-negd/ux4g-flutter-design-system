import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _primaryColor = Color(0xFF432CBB);

// ── Component ────────────────────────────────────────────────────────────

final feedbackRatingComponent = WidgetbookComponent(
  name: 'Rate Your Experience',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card Style'],
          initialOption: 'Default',
          description:
              'Switch between the standard layout and the card-style layout '
              'with a light purple background.',
        );

        final isCard = variant == 'Card Style';

        return ComponentDocs(
          mobileMockup: true,
          name: 'Rate Your Experience ($variant)',
          description: isCard
              ? 'Feedback rating form using Ux4gFeedbackForm inside a card '
                'container with light purple background.'
              : 'Feedback rating form using Ux4gFeedbackForm on a white background.',
          code: isCard ? _feedbackRatingCardCode : _feedbackRatingDefaultCode,
          center: true,
          child: _FeedbackRatingMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _feedbackRatingDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class FeedbackRatingScreen extends StatelessWidget {
  const FeedbackRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            // Gov bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  Text('🇮🇳', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.open_in_new, size: 12, color: Colors.white),
                  const Spacer(),
                  Icon(Icons.accessibility_new, size: 18, color: Colors.white),
                ],
              ),
            ),
            // Feedback form using Ux4gFeedbackForm
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Ux4gFeedbackForm(
                  improvementOptions: const [
                    'Content accuracy',
                    'Visual design',
                    'Visual design',
                  ],
                  commentPlaceholder:
                      'Please provide your valuable feedback on how we can improve our portal for you.',
                  onSubmit: (rating, chip, comment) {},
                  onSkip: () {},
                ),
              ),
            ),
            // Powered by Digital India
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  const SizedBox(width: 4),
                  Image.asset('assets/digital_india_logo.png', height: 20),
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
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _feedbackRatingCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — feedback form inside a white card on purple background.
class FeedbackRatingCardScreen extends StatelessWidget {
  const FeedbackRatingCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            // Gov bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  Text('🇮🇳', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                  const SizedBox(width: 4),
                  Icon(Icons.open_in_new, size: 12, color: Colors.white),
                  const Spacer(),
                  Icon(Icons.accessibility_new, size: 18, color: Colors.white),
                ],
              ),
            ),
            // White card with Ux4gFeedbackForm
            Padding(
              padding: const EdgeInsets.all(16),
              child: Ux4gCard(
                backgroundColor: Colors.white,
                cornerRadius: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Ux4gFeedbackForm(
                    improvementOptions: const [
                      'Content accuracy',
                      'Visual design',
                      'Visual design',
                    ],
                    commentPlaceholder:
                        'Please provide your valuable feedback on how we can improve our portal for you.',
                    onSubmit: (rating, chip, comment) {},
                    onSkip: () {},
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Powered by Digital India
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  const SizedBox(width: 4),
                  Image.asset('assets/digital_india_logo.png', height: 20),
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
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _FeedbackRatingMockup extends StatelessWidget {
  final bool isCard;

  const _FeedbackRatingMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header using Ux4gAppHeader
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingWidgets: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),

              // Gov bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Image.asset('assets/india_flag.png', height: 14, width: 22,
                        errorBuilder: (_, __, ___) => const Text('🇮🇳', style: TextStyle(fontSize: 14))),
                    const SizedBox(width: 8),
                    const Text('Government of India',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 11, color: Colors.white),
                    const Spacer(),
                    const Icon(Icons.accessibility_new, size: 16, color: Colors.white),
                  ],
                ),
              ),

              // Content - using Ux4gFeedbackForm directly
              if (!isCard)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Ux4gFeedbackForm(
                      improvementOptions: const [
                        'Content accuracy',
                        'Visual design',
                        'Visual design',
                      ],
                      commentPlaceholder:
                          'Please provide your valuable feedback on how we can improve our portal for you.',
                      onSubmit: (rating, chip, comment) {},
                      onSkip: () {},
                    ),
                  ),
                ),
              if (isCard)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Ux4gCard(
                      backgroundColor: Colors.white,
                      cornerRadius: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Ux4gFeedbackForm(
                          improvementOptions: const [
                            'Content accuracy',
                            'Visual design',
                            'Visual design',
                          ],
                          commentPlaceholder:
                              'Please provide your valuable feedback on how we can improve our portal for you.',
                          onSubmit: (rating, chip, comment) {},
                          onSkip: () {},
                        ),
                      ),
                    ),
                  ),
                ),

              if (isCard) const SizedBox.shrink(),

              // Powered by
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    const SizedBox(width: 4),
                    Image.asset('assets/digital_india_logo.png', height: 20,
                        errorBuilder: (_, __, ___) => const Text('Digital India',
                            style: TextStyle(fontSize: 10, color: Color(0xFF432CBB)))),
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
