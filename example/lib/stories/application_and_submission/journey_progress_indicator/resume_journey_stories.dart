import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);

const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/union.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final resumeJourneyComponent = WidgetbookComponent(
  name: 'Resume Journey',
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
            ? _resumeJourneyCardCode
            : _resumeJourneyDefaultCode;
        final child = variant == 'Card style'
            ? const _ResumeJourneyCardMockup()
            : const _ResumeJourneyMockup();

        return ComponentDocs(
          mobileMockup: true,
          name: 'Resume Journey',
          description: 'A pattern showing an application screen when a user resumes their journey from a previous step, featuring an alert banner and pre-filled data.',
          code: code,
          center: true,
          child: child,
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code
// ───────────────────────────────────────────────────────────────────────

const _resumeJourneyDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResumeJourneyScreen extends StatefulWidget {
  const ResumeJourneyScreen({super.key});

  @override
  State<ResumeJourneyScreen> createState() => _ResumeJourneyScreenState();
}

class _ResumeJourneyScreenState extends State<ResumeJourneyScreen> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _panNumber = 'ABCDE1234F';

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
                  'assets/national_amblam_logo.svg', 
                  height: 40, 
                  errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                ),
                const SizedBox(width: 1),
                Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 1),
                SvgPicture.asset(
                  'assets/union.svg', 
                  height: 32, 
                  errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue)
                ),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(
                          title: 'Documents', 
                          titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                        ),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Resume Alert Banner
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Resuming from Step 3 — review before continuing.',
                      margin: EdgeInsets.zero,
                      leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                      // Custom colors to match image exactly
                      titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    const SizedBox(height: 40),

                    // Title & Subtitle
                    const Text(
                      'Verify your details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Confirm the information below to proceed.',
                      style: TextStyle(fontSize: 15, color: Color(0xFF4B5563), height: 1.4),
                    ),
                    const SizedBox(height: 32),

                    // Form Fields
                    Ux4gInputField(
                      label: 'Full name (as per Aadhaar)',
                      value: _fullName,
                      onValueChange: (val) => setState(() => _fullName = val),
                      placeholder: '',
                      size: Ux4gInputFieldSize.medium,
                      style: const TextStyle(color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 24),

                    Ux4gInputField(
                      label: 'PAN number',
                      value: _panNumber,
                      onValueChange: (val) => setState(() => _panNumber = val),
                      placeholder: '',
                      size: Ux4gInputFieldSize.medium,
                      style: const TextStyle(color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 32),

                    // Checkbox
                    Ux4gCheckbox(
                      label: 'Accept terms and conditions',
                      isRequired: true,
                      value: _acceptTerms,
                      onChanged: (val) => setState(() => _acceptTerms = val ?? false),
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
                    text: 'Continue',
                    onPressed: _acceptTerms ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Back',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                    contentColor: const Color(0xFF6B7280),
                    borderColor: const Color(0xFFD1D5DB),
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
                    'assets/digital_india_logo.png', 
                    height: 24, 
                    errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
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
""";

const _resumeJourneyCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResumeJourneyCardScreen extends StatefulWidget {
  const ResumeJourneyCardScreen({super.key});

  @override
  State<ResumeJourneyCardScreen> createState() => _ResumeJourneyCardScreenState();
}

class _ResumeJourneyCardScreenState extends State<ResumeJourneyCardScreen> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _panNumber = 'ABCDE1234F';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
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
                        'assets/national_amblam_logo.svg', 
                        height: 40, 
                        errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                      ),
                      const SizedBox(width: 1),
                      Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                      const SizedBox(width: 1),
                      SvgPicture.asset(
                        'assets/union.svg', 
                        height: 32, 
                        errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue)
                      ),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFE5E7EB)),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(
                          title: 'Documents', 
                          titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                        ),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // White Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Resume Alert Banner
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.warningLight,
                            title: 'Resuming from Step 3 — review before continuing.',
                            margin: EdgeInsets.zero,
                            leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                            // Custom colors to match image exactly
                            titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          const SizedBox(height: 32),

                          // Title & Subtitle
                          const Text(
                            'Verify your details',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Confirm the information below to proceed.',
                            style: TextStyle(fontSize: 15, color: Color(0xFF4B5563), height: 1.4),
                          ),
                          const SizedBox(height: 32),

                          // Form Fields
                          Ux4gInputField(
                            label: 'Full name (as per Aadhaar)',
                            value: _fullName,
                            onValueChange: (val) => setState(() => _fullName = val),
                            placeholder: '',
                            size: Ux4gInputFieldSize.medium,
                          ),
                          const SizedBox(height: 24),

                          Ux4gInputField(
                            label: 'PAN number',
                            value: _panNumber,
                            onValueChange: (val) => setState(() => _panNumber = val),
                            placeholder: '',
                            size: Ux4gInputFieldSize.medium,
                          ),
                          const SizedBox(height: 32),

                          // Checkbox
                          Ux4gCheckbox(
                            label: 'Accept terms and conditions',
                            isRequired: true,
                            value: _acceptTerms,
                            onChanged: (val) => setState(() => _acceptTerms = val ?? false),
                          ),
                        ],
                      ),
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
                    text: 'Continue',
                    onPressed: _acceptTerms ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Back',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                    contentColor: const Color(0xFF6B7280),
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
                    'assets/digital_india_logo.png', 
                    height: 24, 
                    errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
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
""";

// ───────────────────────────────────────────────────────────────────────
// Mockups
// ───────────────────────────────────────────────────────────────────────

class _ResumeJourneyMockup extends StatefulWidget {
  const _ResumeJourneyMockup();

  @override
  State<_ResumeJourneyMockup> createState() => _ResumeJourneyMockupState();
}

class _ResumeJourneyMockupState extends State<_ResumeJourneyMockup> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _panNumber = 'ABCDE1234F';

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
                  errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                ),
                const SizedBox(width: 1),
                Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                const SizedBox(width: 1),
                SvgPicture.asset(
                  _unionLogoPath, 
                  height: 32, 
                  errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue)
                ),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(
                          title: 'Documents', 
                          titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                        ),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Resume Alert Banner
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.warningLight,
                      title: 'Resuming from Step 3 — review before continuing.',
                      margin: EdgeInsets.zero,
                      leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                      // Custom colors to match image exactly
                      titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    const SizedBox(height: 40),

                    // Title & Subtitle
                    const Text(
                      'Verify your details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Confirm the information below to proceed.',
                      style: TextStyle(fontSize: 15, color: _subtleText, height: 1.4),
                    ),
                    const SizedBox(height: 32),

                    // Form Fields
                    Ux4gInputField(
                      label: 'Full name (as per Aadhaar)',
                      value: _fullName,
                      onValueChange: (val) => setState(() => _fullName = val),
                      placeholder: '',
                      size: Ux4gInputFieldSize.medium,
                      style: const TextStyle(color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 24),

                    Ux4gInputField(
                      label: 'PAN number',
                      value: _panNumber,
                      onValueChange: (val) => setState(() => _panNumber = val),
                      placeholder: '',
                      size: Ux4gInputFieldSize.medium,
                      style: const TextStyle(color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 32),

                    // Checkbox
                    Ux4gCheckbox(
                      label: 'Accept terms and conditions',
                      isRequired: true,
                      value: _acceptTerms,
                      onChanged: (val) => setState(() => _acceptTerms = val ?? false),
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
                    text: 'Continue',
                    onPressed: _acceptTerms ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Back',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.outline,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                    contentColor: const Color(0xFF6B7280),
                    borderColor: const Color(0xFFD1D5DB),
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
                    errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
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

class _ResumeJourneyCardMockup extends StatefulWidget {
  const _ResumeJourneyCardMockup();

  @override
  State<_ResumeJourneyCardMockup> createState() => _ResumeJourneyCardMockupState();
}

class _ResumeJourneyCardMockupState extends State<_ResumeJourneyCardMockup> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _panNumber = 'ABCDE1234F';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
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
                        errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                      ),
                      const SizedBox(width: 1),
                      Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                      const SizedBox(width: 1),
                      SvgPicture.asset(
                        _unionLogoPath, 
                        height: 32, 
                        errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 32, color: Colors.blue)
                      ),
                    ],
                  ),
                  const Divider(height: 1, color: Color(0xFFE5E7EB)),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(title: ''),
                        Ux4gStepItem(
                          title: 'Documents', 
                          titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                        ),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // White Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Resume Alert Banner
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.warningLight,
                            title: 'Resuming from Step 3 — review before continuing.',
                            margin: EdgeInsets.zero,
                            leadingIcon: const Icon(Icons.error, color: Color(0xFFF59E0B), size: 20),
                            // Custom colors to match image exactly
                            titleStyle: const TextStyle(color: Color(0xFFAD530A), fontWeight: FontWeight.w500),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          const SizedBox(height: 32),

                          // Title & Subtitle
                          const Text(
                            'Verify your details',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Confirm the information below to proceed.',
                            style: TextStyle(fontSize: 15, color: _subtleText, height: 1.4),
                          ),
                          const SizedBox(height: 32),

                          // Form Fields
                          Ux4gInputField(
                            label: 'Full name (as per Aadhaar)',
                            value: _fullName,
                            onValueChange: (val) => setState(() => _fullName = val),
                            placeholder: '',
                            size: Ux4gInputFieldSize.medium,
                          ),
                          const SizedBox(height: 24),

                          Ux4gInputField(
                            label: 'PAN number',
                            value: _panNumber,
                            onValueChange: (val) => setState(() => _panNumber = val),
                            placeholder: '',
                            size: Ux4gInputFieldSize.medium,
                          ),
                          const SizedBox(height: 32),

                          // Checkbox
                          Ux4gCheckbox(
                            label: 'Accept terms and conditions',
                            isRequired: true,
                            value: _acceptTerms,
                            onChanged: (val) => setState(() => _acceptTerms = val ?? false),
                          ),
                        ],
                      ),
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
                    text: 'Continue',
                    onPressed: _acceptTerms ? () {} : null,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 12),
                  Ux4gButton(
                    text: 'Back',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.ghost,
                    size: Ux4gButtonSize.large,
                    width: double.infinity,
                    contentColor: const Color(0xFF6B7280),
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
                    errorBuilder: (c, e, s) => const Text('Digital India', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
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
