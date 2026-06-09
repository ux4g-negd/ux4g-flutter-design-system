import re

file_path = r'lib/stories/application_and_submission/journey_progress_indicator/journey_progress_indicator_stories.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# I will define the new code string and new build method and do a full replacement using regex or string splitting.

# To simplify, I'll parse the file into three parts: 
# 1. Before _journeyProgressIndicatorCode
# 2. _journeyProgressIndicatorCode definition
# 3. Everything after, up to the build method
# 4. The build method itself

# Since the file is reasonably sized, I can construct the new strings.

new_code_string = r"""const String _journeyProgressIndicatorCode = '''
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class JourneyProgressIndicatorMockup extends StatefulWidget {
  const JourneyProgressIndicatorMockup({super.key});

  @override
  State<JourneyProgressIndicatorMockup> createState() => _JourneyProgressIndicatorMockupState();
}

class _JourneyProgressIndicatorMockupState extends State<JourneyProgressIndicatorMockup> {
  String _fullName = '';
  String _panNumber = '';
  bool _acceptTerms = false;

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
                    // Journey Progress Indicator (Stepper)
                    Ux4gStepper(
                      totalSteps: 4,
                      currentStep: 3,
                      steps: const [
                        Ux4gStepItem(title: '', statusLabel: ''),
                        Ux4gStepItem(title: '', statusLabel: ''),
                        Ux4gStepItem(
                          title: 'Documents', 
                          statusLabel: '',
                          titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                        ),
                        Ux4gStepItem(title: '', statusLabel: ''),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // White Card for Form Content
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            size: Ux4gInputFieldSize.large,
                          ),
                          const SizedBox(height: 24),

                          Ux4gInputField(
                            label: 'PAN number',
                            value: _panNumber,
                            onValueChange: (val) => setState(() => _panNumber = val),
                            placeholder: '',
                            size: Ux4gInputFieldSize.large,
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
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
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
''';"""

new_build_method = r"""  @override
  Widget build(BuildContext context) {
    return ComponentDocs(
      componentName: 'Journey Progress Indicator',
      componentDescription: 'A progress stepper component indicating the current stage of a multi-step journey, used primarily in application and submission flows. The Card style variant wraps the form content in a white card over a light purple background.',
      codeSnippet: _journeyProgressIndicatorCode,
      mockupBuilder: (context) {
        return AspectRatio(
          aspectRatio: 360 / 760,
          child: Scaffold(
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
                          // Journey Progress Indicator (Stepper) inline
                          Ux4gStepper(
                            totalSteps: 4,
                            currentStep: 3,
                            steps: const [
                              Ux4gStepItem(title: '', statusLabel: ''),
                              Ux4gStepItem(title: '', statusLabel: ''),
                              Ux4gStepItem(
                                title: 'Documents', 
                                statusLabel: '',
                                titleStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
                              ),
                              Ux4gStepItem(title: '', statusLabel: ''),
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
                                  size: Ux4gInputFieldSize.large,
                                ),
                                const SizedBox(height: 24),

                                Ux4gInputField(
                                  label: 'PAN number',
                                  value: _panNumber,
                                  onValueChange: (val) => setState(() => _panNumber = val),
                                  placeholder: '',
                                  size: Ux4gInputFieldSize.large,
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
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Back',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
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
          ),
        );
      },
    );
  }
}
"""

# Replace the code string
pattern_code_string = re.compile(r"const String _journeyProgressIndicatorCode = '''(.*?)''';", re.DOTALL)
content = pattern_code_string.sub(new_code_string.strip(), content)

# Replace the build method
pattern_build_method = re.compile(r"  @override\n  Widget build\(BuildContext context\) \{(.*?)\n\}\n", re.DOTALL)
content = pattern_build_method.sub(new_build_method.strip() + '\n', content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print("Rewrote journey_progress_indicator_stories.dart successfully.")
