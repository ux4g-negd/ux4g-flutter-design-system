import re

file_path = r'lib/stories/application_and_submission/journey_progress_indicator/journey_progress_indicator_stories.dart'

new_content = r'''import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _primaryColor = Color(0xFF432CBB);
const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _borderColor = Color(0xFFD1D5DB);
const Color _errorColor = Color(0xFFDC2626);

const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _ux4gLogoPath = 'assets/ux4g_logo.svg';
const String _digitalIndiaLogoPath = 'assets/digital_india_logo.png';

final journeyProgressIndicatorComponent = WidgetbookComponent(
  name: 'Journey Progress Indicator',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          name: 'Journey Progress Indicator',
          description: 'A screen with a horizontal progress indicator for multi-step applications.',
          code: _journeyProgressIndicatorCode,
          center: true,
          child: const _JourneyProgressIndicatorMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code
// ───────────────────────────────────────────────────────────────────────

const _journeyProgressIndicatorCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JourneyProgressIndicatorScreen extends StatefulWidget {
  const JourneyProgressIndicatorScreen({super.key});

  @override
  State<JourneyProgressIndicatorScreen> createState() => _JourneyProgressIndicatorScreenState();
}

class _JourneyProgressIndicatorScreenState extends State<JourneyProgressIndicatorScreen> {
  bool _acceptTerms = false;
  String _fullName = '';
  String _panNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with dual logos
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset(
                  'assets/national_amblam_logo.svg', 
                  height: 40, 
                  errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  'assets/ux4g_logo.svg', 
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
                    // Journey Progress Indicator (Stepper) inline
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step 1
                        Container(
                          width: 24, height: 24,
                          decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFF432CBB),
                          ),
                        ),
                        
                        // Step 2
                        Container(
                          width: 24, height: 24,
                          decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle),
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFF432CBB),
                          ),
                        ),
                        
                        // Step 3 (Active)
                        SizedBox(
                          width: 24, height: 24,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                width: 24, height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xFF432CBB), width: 2),
                                ),
                                child: Center(
                                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF432CBB), shape: BoxShape.circle)),
                                ),
                              ),
                              const Positioned(
                                top: 32,
                                child: Text(
                                  'Documents', 
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 3, 
                            margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                            color: const Color(0xFFE5E7EB),
                          ),
                        ),
                        
                        // Step 4
                        Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFD1D5DB), width: 2),
                          ),
                          child: const Center(child: Text('4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF)))),
                        ),
                      ],
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
                    // Gray theme for back button to match image
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

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _JourneyProgressIndicatorMockup extends StatefulWidget {
  const _JourneyProgressIndicatorMockup();

  @override
  State<_JourneyProgressIndicatorMockup> createState() => _JourneyProgressIndicatorMockupState();
}

class _JourneyProgressIndicatorMockupState extends State<_JourneyProgressIndicatorMockup> {
  bool _acceptTerms = false;
  String _fullName = '';
  String _panNumber = '';

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 19.5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Header with dual logos
                Ux4gAppHeader(
                  variant: Ux4gAppHeaderVariant.light,
                  title: '',
                  leadingWidgets: [
                    SvgPicture.asset(
                      _nationalEmblemLogoPath, 
                      height: 40, 
                      errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 32, color: Colors.grey)
                    ),
                    const SizedBox(width: 12),
                    SvgPicture.asset(
                      _ux4gLogoPath, 
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
                        // Journey Progress Indicator (Stepper) inline
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step 1
                            Container(
                              width: 24, height: 24,
                              decoration: const BoxDecoration(color: _primaryColor, shape: BoxShape.circle),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                height: 3, 
                                margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                                color: _primaryColor,
                              ),
                            ),
                            
                            // Step 2
                            Container(
                              width: 24, height: 24,
                              decoration: const BoxDecoration(color: _primaryColor, shape: BoxShape.circle),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                height: 3, 
                                margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                                color: _primaryColor,
                              ),
                            ),
                            
                            // Step 3 (Active)
                            SizedBox(
                              width: 24, height: 24,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    width: 24, height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(color: _primaryColor, width: 2),
                                    ),
                                    child: Center(
                                      child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: _primaryColor, shape: BoxShape.circle)),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 32,
                                    child: Text(
                                      'Documents', 
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _subtleText)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 3, 
                                margin: const EdgeInsets.only(top: 10.5, left: 8, right: 8), 
                                color: const Color(0xFFE5E7EB),
                              ),
                            ),
                            
                            // Step 4
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: _borderColor, width: 2),
                              ),
                              child: const Center(child: Text('4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF)))),
                            ),
                          ],
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
        ),
      ),
    );
  }
}
'''

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)
