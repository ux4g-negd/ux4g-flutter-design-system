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

final governmentFormWithErrorsComponent = WidgetbookComponent(
  name: 'Government form with errors',
  useCases: [
    WidgetbookUseCase(
      name: 'Interactive Preview',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Layout Variant',
          options: const ['Default', 'Card style'],
          initialOption: 'Default',
        );

        final isCardStyle = variant == 'Card style';
        final code = isCardStyle ? _governmentFormErrorsCardCode : _governmentFormErrorsDefaultCode;

        return ComponentDocs(
          mobileMockup: true,
          name: 'Government form with errors',
          description: 'A government form pattern demonstrating field-level validation errors, toggle switches, and customized sliders.',
          code: code,
          center: true,
          child: isCardStyle ? const _GovernmentFormErrorsCardMockup() : const _GovernmentFormErrorsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Shared helpers
// ───────────────────────────────────────────────────────────────────────

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 760,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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

// ───────────────────────────────────────────────────────────────────────
// Source Code Strings
// ───────────────────────────────────────────────────────────────────────

const _governmentFormErrorsDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GovernmentFormErrorsScreen extends StatefulWidget {
  const GovernmentFormErrorsScreen({super.key});

  @override
  State<GovernmentFormErrorsScreen> createState() => _GovernmentFormErrorsScreenState();
}

class _GovernmentFormErrorsScreenState extends State<GovernmentFormErrorsScreen> {
  bool _acceptTerms = true;
  bool _smsUpdates = false;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '+91 98765 43210';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234 5678 9012';
  String? _selectedState;
  double _income = 40;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.successLight,
              title: '',
              backgroundColor: const Color(0xFFF0FDF4),
              borderColor: Colors.transparent,
              actionsAlignment: WrapAlignment.end,
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Color(0xFF065F46), size: 16),
                    const SizedBox(width: 6),
                    const Text('Saved 3:14 PM', style: TextStyle(color: Color(0xFF065F46), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
              width: double.infinity,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Ux4gStepper(
                      totalSteps: 4, currentStep: 2, stepSize: 20,
                      steps: const [
                        Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                        Ux4gStepItem(title: ''),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    const SizedBox(height: 8),
                    const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563))),
                    const SizedBox(height: 32),
                    Ux4gInputField(label: 'Full name', value: _fullName, onValueChange: (val) => setState(() => _fullName = val), size: Ux4gInputFieldSize.medium),
                    const SizedBox(height: 24),
                    Ux4gInputField(label: 'Mobile number', value: _mobileNumber, onValueChange: (val) => setState(() => _mobileNumber = val), size: Ux4gInputFieldSize.medium),
                    const SizedBox(height: 24),
                    Ux4gInputField(
                      label: 'Email address',
                      value: _emailAddress,
                      onValueChange: (val) => setState(() => _emailAddress = val),
                      size: Ux4gInputFieldSize.medium,
                      status: Ux4gInputFieldStatus.error,
                      caption: 'Enter a valid email.',
                    ),
                    const SizedBox(height: 24),
                    Ux4gSelectionDropdown(
                      label: 'State of residence',
                      options: const [Ux4gDropdownOption(id: 'dl', label: 'Delhi'), Ux4gDropdownOption(id: 'mh', label: 'Maharashtra')],
                      selectedOptionIds: _selectedState != null ? [_selectedState!] : [],
                      onSelectionChange: (ids) => setState(() => _selectedState = ids.isNotEmpty ? ids.first : null),
                      placeholder: 'Please select..',
                      size: Ux4gDropdownSize.m,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Annual Income (Lakh ₹) *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const Text('₹3.2 Lakh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                      ],
                    ),
                    Ux4gSlider(label: '', value: _income, onValueChange: (val) => setState(() => _income = val), min: 0, max: 100, steps: 10, showMarksAndValues: true),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Text('Receive SMS updates', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Ux4gToggle(checked: _smsUpdates, onCheckedChange: (v) => setState(() => _smsUpdates = v), size: Ux4gToggleSize.s),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                ],
              ),
            ),
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

const _governmentFormErrorsCardCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GovernmentFormErrorsCardScreen extends StatefulWidget {
  const GovernmentFormErrorsCardScreen({super.key});

  @override
  State<GovernmentFormErrorsCardScreen> createState() => _GovernmentFormErrorsCardScreenState();
}

class _GovernmentFormErrorsCardScreenState extends State<GovernmentFormErrorsCardScreen> {
  bool _acceptTerms = true;
  bool _smsUpdates = false;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '+91 98765 43210';
  String _emailAddress = 'ramesh@example';
  String? _selectedState;
  double _income = 40;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Ux4gAppHeader(
                    variant: Ux4gAppHeaderVariant.light,
                    title: '',
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    Container(
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
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.successLight,
                            title: '',
                            margin: EdgeInsets.zero,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            backgroundColor: const Color(0xFFF0FDF4),
                            borderColor: Colors.transparent,
                            actionsAlignment: WrapAlignment.end,
                            actions: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.check_circle_outline, color: Color(0xFF065F46), size: 16),
                                  const SizedBox(width: 6),
                                  const Text('Saved 3:14 PM', style: TextStyle(color: Color(0xFF065F46), fontSize: 12, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                            width: double.infinity,
                          ),
                          const SizedBox(height: 32),
                          Ux4gStepper(
                            totalSteps: 4, currentStep: 2, stepSize: 20,
                            steps: const [
                              Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                              Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                              Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                              Ux4gStepItem(title: ''),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                          const SizedBox(height: 8),
                          const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563))),
                          const SizedBox(height: 32),
                          Ux4gInputField(label: 'Full name', value: _fullName, onValueChange: (val) => setState(() => _fullName = val), size: Ux4gInputFieldSize.medium),
                          const SizedBox(height: 24),
                          Ux4gInputField(label: 'Email address', value: _emailAddress, onValueChange: (val) => setState(() => _emailAddress = val), size: Ux4gInputFieldSize.medium, status: Ux4gInputFieldStatus.error, caption: 'Enter a valid email.'),
                          const SizedBox(height: 24),
                          Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                ],
              ),
            ),
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

class _GovernmentFormErrorsMockup extends StatefulWidget {
  const _GovernmentFormErrorsMockup({super.key});
  @override
  State<_GovernmentFormErrorsMockup> createState() => _GovernmentFormErrorsMockupState();
}

class _GovernmentFormErrorsMockupState extends State<_GovernmentFormErrorsMockup> {
  bool _acceptTerms = true;
  bool _smsUpdates = false;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '+91 98765 43210';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234 5678 9012';
  String? _selectedState;
  double _income = 40;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    return _PhoneFrame(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingWidgets: [
                  SvgPicture.asset(_nationalEmblemLogoPath, height: 40),
                  const SizedBox(width: 1),
                  Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                  const SizedBox(width: 1),
                  SvgPicture.asset(_unionLogoPath, height: 32),
                ],
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Ux4gStatusBanner(
                variant: Ux4gBannerVariant.successLight,
                title: '',
                backgroundColor: const Color(0xFFF0FDF4),
                borderColor: Colors.transparent,
                actionsAlignment: WrapAlignment.end,
                actions: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_outline, color: Color(0xFF065F46), size: 16),
                      const SizedBox(width: 6),
                      const Text('Saved 3:14 PM', style: TextStyle(color: Color(0xFF065F46), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
                width: double.infinity,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Ux4gStepper(
                        totalSteps: 4, currentStep: 2, stepSize: 20,
                        steps: const [
                          Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          Ux4gStepItem(title: ''),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor)),
                      const SizedBox(height: 8),
                      const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: _subtleText)),
                      const SizedBox(height: 32),
                      Ux4gInputField(label: 'Full name', value: _fullName, onValueChange: (val) => setState(() => _fullName = val), size: Ux4gInputFieldSize.medium),
                      const SizedBox(height: 24),
                      Ux4gInputField(label: 'Mobile number', value: _mobileNumber, onValueChange: (val) => setState(() => _mobileNumber = val), size: Ux4gInputFieldSize.medium),
                      const SizedBox(height: 24),
                      Ux4gInputField(label: 'Email address', value: _emailAddress, onValueChange: (val) => setState(() => _emailAddress = val), size: Ux4gInputFieldSize.medium, status: Ux4gInputFieldStatus.error, caption: 'Enter a valid email.'),
                      const SizedBox(height: 24),
                      Ux4gSelectionDropdown(
                        label: 'State of residence',
                        options: const [Ux4gDropdownOption(id: 'dl', label: 'Delhi'), Ux4gDropdownOption(id: 'mh', label: 'Maharashtra')],
                        selectedOptionIds: _selectedState != null ? [_selectedState!] : [],
                        onSelectionChange: (ids) => setState(() => _selectedState = ids.isNotEmpty ? ids.first : null),
                        placeholder: 'Please select..',
                        size: Ux4gDropdownSize.m,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Annual Income (Lakh ₹) *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          const Text('₹3.2 Lakh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      Ux4gSlider(label: '', value: _income, onValueChange: (val) => setState(() => _income = val), min: 0, max: 100, steps: 10, showMarksAndValues: true),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Text('Receive SMS updates', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Ux4gToggle(checked: _smsUpdates, onCheckedChange: (v) => setState(() => _smsUpdates = v), size: Ux4gToggleSize.s),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                    const SizedBox(height: 12),
                    Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    const SizedBox(height: 6),
                    Image.asset(_digitalIndiaLogoPath, height: 24),
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

class _GovernmentFormErrorsCardMockup extends StatefulWidget {
  const _GovernmentFormErrorsCardMockup({super.key});
  @override
  State<_GovernmentFormErrorsCardMockup> createState() => _GovernmentFormErrorsCardMockupState();
}

class _GovernmentFormErrorsCardMockupState extends State<_GovernmentFormErrorsCardMockup> {
  bool _acceptTerms = true;
  bool _smsUpdates = false;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '+91 98765 43210';
  String _emailAddress = 'ramesh@example';
  String? _selectedState;
  double _income = 40;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF432CBB);
    return _PhoneFrame(
      child: Scaffold(
        backgroundColor: _cardBg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Ux4gAppHeader(
                      variant: Ux4gAppHeaderVariant.light,
                      title: '',
                      leadingWidgets: [
                        SvgPicture.asset(_nationalEmblemLogoPath, height: 40),
                        const SizedBox(width: 1),
                        Container(height: 32, width: 1, color: const Color(0xFFD1D5DB)),
                        const SizedBox(width: 1),
                        SvgPicture.asset(_unionLogoPath, height: 32),
                      ],
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E7EB)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      Container(
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
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.successLight,
                              title: '',
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              backgroundColor: const Color(0xFFF0FDF4),
                              borderColor: Colors.transparent,
                              actionsAlignment: WrapAlignment.end,
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle_outline, color: Color(0xFF065F46), size: 16),
                                    const SizedBox(width: 6),
                                    const Text('Saved 3:14 PM', style: TextStyle(color: Color(0xFF065F46), fontSize: 12, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                              width: double.infinity,
                            ),
                            const SizedBox(height: 32),
                            Ux4gStepper(
                              totalSteps: 4, currentStep: 2, stepSize: 20,
                              steps: const [
                                Ux4gStepItem(title: 'Eligibility', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                Ux4gStepItem(title: 'Personal', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                Ux4gStepItem(title: 'Documents', titleStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                                Ux4gStepItem(title: ''),
                              ],
                            ),
                            const SizedBox(height: 32),
                            const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _titleColor, height: 1.2)),
                            const SizedBox(height: 8),
                            const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: _subtleText, height: 1.4)),
                            const SizedBox(height: 32),
                            Ux4gInputField(label: 'Full name', value: _fullName, onValueChange: (val) => setState(() => _fullName = val), size: Ux4gInputFieldSize.medium, style: const TextStyle(color: Color(0xFF111827))),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text('From Aadhaar · ', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                                const Text('Update via UIDAI', style: TextStyle(fontSize: 12, color: primaryColor, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 4),
                                const Icon(Icons.open_in_new, size: 12, color: primaryColor),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Ux4gInputField(label: 'Mobile number', value: _mobileNumber, onValueChange: (val) => setState(() => _mobileNumber = val), size: Ux4gInputFieldSize.medium),
                            const SizedBox(height: 24),
                            Ux4gInputField(label: 'Email address', value: _emailAddress, onValueChange: (val) => setState(() => _emailAddress = val), size: Ux4gInputFieldSize.medium, status: Ux4gInputFieldStatus.error, caption: 'Enter a valid email.'),
                            const SizedBox(height: 24),
                            Ux4gSelectionDropdown(
                              label: 'State of residence',
                              options: const [Ux4gDropdownOption(id: 'dl', label: 'Delhi'), Ux4gDropdownOption(id: 'mh', label: 'Maharashtra')],
                              selectedOptionIds: _selectedState != null ? [_selectedState!] : [],
                              onSelectionChange: (ids) => setState(() => _selectedState = ids.isNotEmpty ? ids.first : null),
                              placeholder: 'Please select..',
                              size: Ux4gDropdownSize.m,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Annual Income (Lakh ₹) *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                const Text('₹3.2 Lakh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                              ],
                            ),
                            Ux4gSlider(label: '', value: _income, onValueChange: (val) => setState(() => _income = val), min: 0, max: 100, steps: 10, showMarksAndValues: true),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                const Text('Receive SMS updates', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                const Spacer(),
                                Ux4gToggle(checked: _smsUpdates, onCheckedChange: (v) => setState(() => _smsUpdates = v), size: Ux4gToggleSize.s),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                    const SizedBox(height: 12),
                    Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                    const SizedBox(height: 6),
                    Image.asset(_digitalIndiaLogoPath, height: 24),
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
