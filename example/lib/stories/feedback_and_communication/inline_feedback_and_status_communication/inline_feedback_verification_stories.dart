import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);

final inlineFeedbackVerificationComponent = WidgetbookComponent(
  name: 'Inline Feedback Verification',
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
          name: 'Inline Feedback Verification ($variant)',
          description: isCard
              ? 'Document verification progress with timeline inside a card container.'
              : 'Document verification progress with timeline showing real-time status updates.',
          code: isCard ? _verificationCardCode : _verificationDefaultCode,
          center: true,
          child: _VerificationMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _verificationDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
              child: SingleChildScrollView(
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
                    Text('Verifying your Income Certificate Document',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Text(
                      'We are checking your uploaded PDF in real time. Each step below updates as the system completes it — keep this page open until all checks finish.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4),
                    ),
                    const SizedBox(height: 24),

                    // Document card with progress
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text('Income Certificate',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                              ),
                              Ux4gTag(
                                text: 'Verifying',
                                size: Ux4gTagSize.m,
                                style: Ux4gTagStyle.tonal,
                                colorScheme: Ux4gTagColor.warning,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('PDF document · 1.2 MB',
                            style: TextStyle(fontSize: 12, color: Color(0xFF404040))),
                          const SizedBox(height: 8),
                          Text('2 of 3 checks passed — final check in progress',
                            style: TextStyle(fontSize: 12, color: Color(0xFF404040))),
                          const SizedBox(height: 8),
                          Ux4gLinearProgress(
                            value: 0.66,
                            height: 6,
                            color: const Color(0xFF432CBB),
                            trackColor: const Color(0xFFE5E7EB),
                            shape: Ux4gProgressShape.rounded,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Timeline using Ux4gJourneyTimeline
                    Ux4gJourneyTimeline(
                      activeColor: const Color(0xFF432CBB),
                      steps: [
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.completed,
                          date: '22 June 2026',
                          title: 'File format and size within limits',
                          status: Ux4gJourneyStepStatus(
                            text: 'Passed',
                            badgeText: 'Passed',
                            badgeColor: const Color(0xFFDCFCE7),
                            badgeTextColor: const Color(0xFF16A34A),
                          ),
                        ),
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.completed,
                          date: '25 June 2026',
                          title: 'Document is readable and not blurred',
                          status: Ux4gJourneyStepStatus(
                            text: 'Passed',
                            badgeText: 'Passed',
                            badgeColor: const Color(0xFFDCFCE7),
                            badgeTextColor: const Color(0xFF16A34A),
                          ),
                        ),
                        Ux4gJourneyStep(
                          state: Ux4gJourneyStepState.current,
                          date: '31 June 2026',
                          title: 'Figures match the declared income',
                          status: Ux4gJourneyStepStatus(
                            text: 'Verifying',
                            badgeText: 'Verifying',
                            badgeColor: const Color(0xFFFEF3C7),
                            badgeTextColor: const Color(0xFFD97706),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Track Status button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Track Status',
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
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _verificationCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant
class VerificationCardScreen extends StatelessWidget {
  const VerificationCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                      Text('Verifying your Income Certificate Document',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 10),
                      Text(
                        'We are checking your uploaded PDF in real time. Each step below updates as the system completes it — keep this page open until all checks finish.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4),
                      ),
                      const SizedBox(height: 24),

                      // Document card with progress
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Income Certificate',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                ),
                                Ux4gTag(
                                  text: 'Verifying',
                                  size: Ux4gTagSize.m,
                                  style: Ux4gTagStyle.tonal,
                                  colorScheme: Ux4gTagColor.warning,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('PDF document · 1.2 MB',
                              style: TextStyle(fontSize: 12, color: Color(0xFF404040))),
                            const SizedBox(height: 8),
                            Text('2 of 3 checks passed — final check in progress',
                              style: TextStyle(fontSize: 12, color: Color(0xFF404040))),
                            const SizedBox(height: 8),
                            Ux4gLinearProgress(
                              value: 0.66,
                              height: 6,
                              color: const Color(0xFF432CBB),
                              trackColor: const Color(0xFFE5E7EB),
                              shape: Ux4gProgressShape.rounded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Timeline using Ux4gJourneyTimeline
                      Ux4gJourneyTimeline(
                        activeColor: const Color(0xFF432CBB),
                        steps: [
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.completed,
                            date: '22 June 2026',
                            title: 'File format and size within limits',
                            status: Ux4gJourneyStepStatus(
                              text: 'Passed',
                              badgeText: 'Passed',
                              badgeColor: const Color(0xFFDCFCE7),
                              badgeTextColor: const Color(0xFF16A34A),
                            ),
                          ),
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.completed,
                            date: '25 June 2026',
                            title: 'Document is readable and not blurred',
                            status: Ux4gJourneyStepStatus(
                              text: 'Passed',
                              badgeText: 'Passed',
                              badgeColor: const Color(0xFFDCFCE7),
                              badgeTextColor: const Color(0xFF16A34A),
                            ),
                          ),
                          Ux4gJourneyStep(
                            state: Ux4gJourneyStepState.current,
                            date: '31 June 2026',
                            title: 'Figures match the declared income',
                            status: Ux4gJourneyStepStatus(
                              text: 'Verifying',
                              badgeText: 'Verifying',
                              badgeColor: const Color(0xFFFEF3C7),
                              badgeTextColor: const Color(0xFFD97706),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Track Status button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Track Status',
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
// Verification Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _VerificationMockup extends StatelessWidget {
  final bool isCard;

  const _VerificationMockup({this.isCard = false});

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/national_amblam_logo.svg',
                      height: 40,
                    ),
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
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isCard ? _buildCardContent() : _buildDefaultContent(),
                ),
              ),

              // Track Status button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Ux4gButton(
                    text: 'Track Status',
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
          'Verifying your Income Certificate Document',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 10),

        // Description
        const Text(
          'We are checking your uploaded PDF in real time. Each step below updates as the system completes it — keep this page open until all checks finish.',
          style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
        ),
        const SizedBox(height: 24),

        // Document card
        _buildDocumentCard(),
        const SizedBox(height: 20),

        // Timeline using Ux4gJourneyTimeline
        Ux4gJourneyTimeline(
          activeColor: _primaryColor,
          steps: [
            Ux4gJourneyStep(
              state: Ux4gJourneyStepState.completed,
              date: '22 June 2026',
              title: 'File format and size within limits',
              status: Ux4gJourneyStepStatus(
                text: 'Passed',
                badgeText: 'Passed',
                badgeColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                badgePosition: Ux4gJourneyBadgePosition.topRight,
              ),
            ),
            Ux4gJourneyStep(
              state: Ux4gJourneyStepState.completed,
              date: '25 June 2026',
              title: 'Document is readable and not blurred',
              status: Ux4gJourneyStepStatus(
                text: 'Passed',
                badgeText: 'Passed',
                badgeColor: const Color(0xFFDCFCE7),
                badgeTextColor: const Color(0xFF16A34A),
                badgePosition: Ux4gJourneyBadgePosition.topRight,
              ),
            ),
            Ux4gJourneyStep(
              state: Ux4gJourneyStepState.current,
              date: '31 June 2026',
              title: 'Figures match the declared income',
              status: Ux4gJourneyStepStatus(
                text: 'Verifying',
                badgeText: 'Verifying',
                badgeColor: const Color(0xFFFEF3C7),
                badgeTextColor: const Color(0xFFD97706),
                badgePosition: Ux4gJourneyBadgePosition.topRight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row with tag
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Income Certificate',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _titleColor,
                  ),
                ),
              ),
              Ux4gTag(
                text: 'Verifying',
                size: Ux4gTagSize.m,
                style: Ux4gTagStyle.tonal,
                colorScheme: Ux4gTagColor.warning,
                customBorderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'PDF document · 1.2 MB',
            style: TextStyle(fontSize: 12, color: Color(0xFF404040)),
          ),
          const SizedBox(height: 8),
          const Text(
            '2 of 3 checks passed — final check in progress',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 8),
          // Progress bar using Ux4gLinearProgress
          Ux4gLinearProgress(
            value: 0.66,
            height: 6,
            gradientColors: const [
              Color(0xFFFDE68A),
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ],
            trackColor: const Color(0xFFE5E7EB),
            shape: Ux4gProgressShape.rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return _buildFormFields();
  }

  Widget _buildCardContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildFormFields(),
    );
  }
}
