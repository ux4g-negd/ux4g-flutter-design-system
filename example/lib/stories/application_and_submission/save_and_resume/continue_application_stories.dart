import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _bg = Color(0xFFFAFAFA);
const Color _cardBg = Color(0xFFF4F3FF);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final continueApplicationComponent = WidgetbookComponent(
  name: 'Continue Application',
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
            ? _continueApplicationCardCode
            : _continueApplicationDefaultCode;
        final child = variant == 'Card style'
            ? const _ContinueApplicationCardMockup()
            : const _ContinueApplicationMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Continue Application',
          description:
              'A pattern showing the user\'s saved application progress with step-by-step status, '
              'allowing them to continue from where they left off or start fresh.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Step status model
// ───────────────────────────────────────────────────────────────────────

enum _StepStatus { completed, inProgress, notStarted }

class _StepData {
  final String title;
  final String subtitle;
  final _StepStatus status;

  const _StepData({
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

const List<_StepData> _steps = [
  _StepData(
    title: 'Eligibility check',
    subtitle: 'Completed',
    status: _StepStatus.completed,
  ),
  _StepData(
    title: 'Personal information',
    subtitle: 'Completed',
    status: _StepStatus.completed,
  ),
  _StepData(
    title: 'Upload documents',
    subtitle: 'In progress · 1 of 4 uploaded',
    status: _StepStatus.inProgress,
  ),
  _StepData(
    title: 'Review',
    subtitle: 'Not started',
    status: _StepStatus.notStarted,
  ),
  _StepData(
    title: 'Submit',
    subtitle: 'Not started',
    status: _StepStatus.notStarted,
  ),
];

// ───────────────────────────────────────────────────────────────────────
// Shared step list widget
// ───────────────────────────────────────────────────────────────────────

class _ProgressStepList extends StatelessWidget {
  const _ProgressStepList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_steps.length, (index) {
        final step = _steps[index];
        return Padding(
          padding: EdgeInsets.only(bottom: index < _steps.length - 1 ? 20 : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status indicator
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step.status == _StepStatus.completed
                      ? const Color(0xFF16A34A)
                      : step.status == _StepStatus.inProgress
                      ? Colors.white
                      : Colors.white,
                  border: Border.all(
                    color: step.status == _StepStatus.completed
                        ? const Color(0xFF16A34A)
                        : step.status == _StepStatus.inProgress
                        ? const Color(0xFFD1D5DB)
                        : const Color(0xFFE5E7EB),
                    width: step.status == _StepStatus.inProgress ? 2 : 1.5,
                  ),
                ),
                child: step.status == _StepStatus.completed
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
              const SizedBox(width: 14),
              // Step text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: step.status == _StepStatus.notStarted
                            ? const Color(0xFF9CA3AF)
                            : _titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      step.subtitle,
                      style: const TextStyle(fontSize: 13, color: _subtleText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _continueApplicationDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContinueApplicationScreen extends StatelessWidget {
  const ContinueApplicationScreen({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Continue your\napplication?',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Income Certificate · Started 10 Apr 2026',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Your progress',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 20),

                    // Progress steps list with status indicators
                    // ... (step items with completed/in-progress/not-started states)

                    const SizedBox(height: 28),
                    const Text(
                      'Last saved 10 Apr 2026 at 3:12 PM',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
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
                  Ux4gButton(text: 'Continue from Step 3', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Start fresh', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity),
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

const _continueApplicationCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContinueApplicationCardScreen extends StatelessWidget {
  const ContinueApplicationCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Column(
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

            // Card Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Continue your\napplication?',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Income Certificate · Started 10 Apr 2026',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Your progress',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 20),

                      // Progress steps list with status indicators
                      // ... (step items with completed/in-progress/not-started states)

                      const SizedBox(height: 28),
                      const Text(
                        'Last saved 10 Apr 2026 at 3:12 PM',
                        style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
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
                  Ux4gButton(text: 'Continue from Step 3', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Start fresh', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity),
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

class _ContinueApplicationMockup extends StatelessWidget {
  const _ContinueApplicationMockup();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
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
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Continue your\napplication?',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: _titleColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Income Certificate · Started 10 Apr 2026',
                      style: TextStyle(fontSize: 14, color: _subtleText),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Your progress',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _ProgressStepList(),
                    const SizedBox(height: 28),
                    const Text(
                      'Last saved 10 Apr 2026 at 3:12 PM',
                      style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
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
                  Ux4gButton(
                    text: 'Continue from Step 3',
                    onPressed: () {},
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Start fresh',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                    contentColor: primaryColor,
                    borderColor: primaryColor,
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

class _ContinueApplicationCardMockup extends StatelessWidget {
  const _ContinueApplicationCardMockup();

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
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

              // Card Content
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
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Continue your\napplication?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: _titleColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Income Certificate · Started 10 Apr 2026',
                          style: TextStyle(fontSize: 14, color: _subtleText),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Your progress',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _titleColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _ProgressStepList(),
                        const SizedBox(height: 28),
                        const Text(
                          'Last saved 10 Apr 2026 at 3:12 PM',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9CA3AF),
                          ),
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
                      text: 'Continue from Step 3',
                      onPressed: () {},
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 12),
                    Ux4gButton(
                      text: 'Start fresh',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      width: double.infinity,
                      contentColor: primaryColor,
                      borderColor: primaryColor,
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
