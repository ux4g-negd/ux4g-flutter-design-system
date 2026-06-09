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

final governmentFormWithMultipleErrorsComponent = WidgetbookComponent(
  name: 'Government form with multiple errors',
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
        final code = isCardStyle
            ? _governmentFormMultipleErrorsCardCode
            : _governmentFormMultipleErrorsDefaultCode;

        return ComponentDocs(
          mobileMockup: true,
          name: 'Government form with multiple errors',
          description:
              'A comprehensive government form pattern showing multiple field-level validation errors, a global error summary banner, and all form field types.',
          code: code,
          center: true,
          child: isCardStyle
              ? const _GovernmentFormMultipleErrorsCardMockup()
              : const _GovernmentFormMultipleErrorsMockup(),
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
            color: Colors.black.withOpacity(0.08),
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

const _governmentFormMultipleErrorsDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GovernmentFormMultipleErrorsScreen extends StatefulWidget {
  const GovernmentFormMultipleErrorsScreen({super.key});

  @override
  State<GovernmentFormMultipleErrorsScreen> createState() => _GovernmentFormMultipleErrorsScreenState();
}

class _GovernmentFormMultipleErrorsScreenState extends State<GovernmentFormMultipleErrorsScreen> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '98765';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234';
  String? _selectedState;
  String? _maritalStatus = 'Married';
  String _reason = '';
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
            // Header
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

            // Saved Success Banner (Content on right)
            Ux4gStatusBanner(
              variant: Ux4gBannerVariant.successLight,
              title: '',
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stepper
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

                    const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2)),
                    const SizedBox(height: 8),
                    const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563), height: 1.4)),
                    const SizedBox(height: 32),

                    // Global Error Banner
                    Ux4gStatusBanner(
                      variant: Ux4gBannerVariant.errorLight,
                      title: '3 fields need your attention. Fix them to continue.',
                      backgroundColor: const Color(0xFFFFF8F8),
                      borderColor: const Color(0xFFFFDADC),
                      actionsAlignment: WrapAlignment.start,
                      titleStyle: const TextStyle(color: Color(0xFF8A1A16), fontSize: 13, fontWeight: FontWeight.w500),
                      actions: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text('Jump to first error', style: TextStyle(color: Color(0xFF8A1A16), fontWeight: FontWeight.w700, fontSize: 14)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Full Name
                    Ux4gInputField(
                      label: 'Full name',
                      value: _fullName,
                      placeholder: 'Enter your full name',
                      onValueChange: (val) => setState(() => _fullName = val),
                      size: Ux4gInputFieldSize.medium,
                      style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                    ),
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

                    // Mobile Number with Error
                    Ux4gInputField(
                      label: 'Mobile number', value: _mobileNumber, placeholder: 'Enter mobile number', 
                      onValueChange: (val) => setState(() => _mobileNumber = val), size: Ux4gInputFieldSize.medium,
                      status: Ux4gInputFieldStatus.error, caption: 'Mobile must be 10 digits.',
                      style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // Email Address with Error
                    Ux4gInputField(
                      label: 'Email address', value: _emailAddress, placeholder: 'Enter email address',
                      onValueChange: (val) => setState(() => _emailAddress = val), size: Ux4gInputFieldSize.medium,
                      status: Ux4gInputFieldStatus.error, caption: 'Enter a valid email.',
                      style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // Aadhaar Number with Error
                    Ux4gInputField(
                      label: 'Aadhaar number', value: _aadhaarNumber, placeholder: 'Enter Aadhaar number',
                      onValueChange: (val) => setState(() => _aadhaarNumber = val), size: Ux4gInputFieldSize.medium,
                      status: Ux4gInputFieldStatus.error, caption: 'Aadhaar must be 12 digits.',
                      style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                    ),
                    const SizedBox(height: 24),

                    // State Dropdown
                    Ux4gSelectionDropdown(
                      label: 'State of residence',
                      options: const [Ux4gDropdownOption(id: 'dl', label: 'Delhi'), Ux4gDropdownOption(id: 'mh', label: 'Maharashtra')],
                      selectedOptionIds: _selectedState != null ? [_selectedState!] : [],
                      onSelectionChange: (ids) => setState(() => _selectedState = ids.isNotEmpty ? ids.first : null),
                      placeholder: 'Please select..',
                      size: Ux4gDropdownSize.m,
                    ),
                    const SizedBox(height: 24),

                    // Marital Status
                    const Text('Your marital status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF374151))),
                    const SizedBox(height: 8),
                    Ux4gRadioButton(value: 'Single', groupValue: _maritalStatus, onChanged: (v) => setState(() => _maritalStatus = v), label: 'Single'),
                    Ux4gRadioButton(value: 'Married', groupValue: _maritalStatus, onChanged: (v) => setState(() => _maritalStatus = v), label: 'Married'),
                    Ux4gRadioButton(value: 'Divorced', groupValue: _maritalStatus, onChanged: (v) => setState(() => _maritalStatus = v), label: 'Divorced or widowed'),
                    Ux4gRadioButton(value: 'Option4', groupValue: _maritalStatus, onChanged: (v) => setState(() => _maritalStatus = v), label: 'Option 4'),
                    const SizedBox(height: 24),

                    // Reason Text Area
                    Ux4gTextArea(label: 'Brief reason (optional)', value: _reason, onValueChange: (v) => setState(() => _reason = v), placeholder: 'Placeholder'),
                    const SizedBox(height: 24),

                    // Annual Income Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Annual Income (Lakh ₹) *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
                        const Text('₹3.2 Lakh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                      ],
                    ),
                    Ux4gSlider(
                      label: null, value: _income, onValueChange: (val) => setState(() => _income = val),
                      min: 0, max: 100, steps: 9, showMarksAndValues: true,
                    ),
                    const SizedBox(height: 32),

                    const Text('Receive application status updates via SMS', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                    const SizedBox(height: 16),

                    Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
                  ],
                ),
              ),
            ),

            // Actions
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

const _governmentFormMultipleErrorsCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GovernmentFormMultipleErrorsCardScreen extends StatefulWidget {
  const GovernmentFormMultipleErrorsCardScreen({super.key});

  @override
  State<GovernmentFormMultipleErrorsCardScreen> createState() => _GovernmentFormMultipleErrorsCardScreenState();
}

class _GovernmentFormMultipleErrorsCardScreenState extends State<GovernmentFormMultipleErrorsCardScreen> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '98765';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234';
  String? _selectedState;
  String? _maritalStatus = 'Married';
  String _reason = '';
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
            // Header
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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  children: [
                    // White Card
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
                          // Saved Success Banner
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

                          // Stepper
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

                          const Text('Personal information', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), height: 1.2)),
                          const SizedBox(height: 8),
                          const Text('Please enter your details.', style: TextStyle(fontSize: 15, color: Color(0xFF4B5563), height: 1.4)),
                          const SizedBox(height: 32),

                          // Global Error Banner
                          Ux4gStatusBanner(
                            variant: Ux4gBannerVariant.errorLight,
                            title: '3 fields need your attention. Fix them to continue.',
                            backgroundColor: const Color(0xFFFFF8F8),
                            borderColor: const Color(0xFFFFDADC),
                            actionsAlignment: WrapAlignment.start,
                            titleStyle: const TextStyle(color: Color(0xFF8A1A16), fontSize: 13, fontWeight: FontWeight.w500),
                            actions: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Jump to first error', style: TextStyle(color: Color(0xFF8A1A16), fontWeight: FontWeight.w700, fontSize: 14)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          Ux4gInputField(
                            label: 'Full name', value: _fullName, placeholder: 'Enter your full name',
                            onValueChange: (val) => setState(() => _fullName = val), size: Ux4gInputFieldSize.medium, 
                            style: const TextStyle(color: Color(0xFF111827), fontSize: 14)
                          ),
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
                          Ux4gInputField(
                            label: 'Mobile number', value: _mobileNumber, placeholder: 'Enter mobile number',
                            onValueChange: (val) => setState(() => _mobileNumber = val), size: Ux4gInputFieldSize.medium,
                            status: Ux4gInputFieldStatus.error, caption: 'Mobile must be 10 digits.',
                            style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Ux4gInputField(
                            label: 'Email address', value: _emailAddress, placeholder: 'Enter email address',
                            onValueChange: (val) => setState(() => _emailAddress = val), size: Ux4gInputFieldSize.medium,
                            status: Ux4gInputFieldStatus.error, caption: 'Enter a valid email.',
                            style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          Ux4gInputField(
                            label: 'Aadhaar number', value: _aadhaarNumber, placeholder: 'Enter Aadhaar number',
                            onValueChange: (val) => setState(() => _aadhaarNumber = val), size: Ux4gInputFieldSize.medium,
                            status: Ux4gInputFieldStatus.error, caption: 'Aadhaar must be 12 digits.',
                            style: const TextStyle(color: Color(0xFF111827), fontSize: 14),
                          ),
                          const SizedBox(height: 32),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Annual Income (Lakh ₹) *', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF374151))),
                              const Text('₹3.2 Lakh', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                            ],
                          ),
                          Ux4gSlider(label: null, value: _income, onValueChange: (v) => setState(() => _income = v), min: 0, max: 100, steps: 9, showMarksAndValues: true),
                          const SizedBox(height: 16),

                          Ux4gCheckbox(label: 'Accept terms and conditions *', isRequired: true, value: _acceptTerms, onChanged: (val) => setState(() => _acceptTerms = val ?? false)),
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
                  Ux4gButton(text: 'Continue', onPressed: () {}, size: Ux4gButtonSize.large, width: double.infinity),
                  const SizedBox(height: 12),
                  Ux4gButton(text: 'Back', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.large, width: double.infinity, contentColor: primaryColor, borderColor: primaryColor),
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

class _GovernmentFormMultipleErrorsMockup extends StatefulWidget {
  const _GovernmentFormMultipleErrorsMockup({super.key});

  @override
  State<_GovernmentFormMultipleErrorsMockup> createState() =>
      _GovernmentFormMultipleErrorsMockupState();
}

class _GovernmentFormMultipleErrorsMockupState
    extends State<_GovernmentFormMultipleErrorsMockup> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '98765';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234';
  String? _selectedState;
  String? _maritalStatus = 'Married';
  String _reason = '';
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
                  Container(
                    height: 32,
                    width: 1,
                    color: const Color(0xFFD1D5DB),
                  ),
                  const SizedBox(width: 1),
                  SvgPicture.asset(_unionLogoPath, height: 32),
                ],
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              Ux4gStatusBanner(
                variant: Ux4gBannerVariant.successLight,
                title: '',
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                backgroundColor: const Color(0xFFF0FDF4),
                borderColor: Colors.transparent,
                actionsAlignment: WrapAlignment.end,
                actions: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF065F46),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Saved 3:14 PM',
                        style: TextStyle(
                          color: Color(0xFF065F46),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
                width: double.infinity,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Ux4gStepper(
                        totalSteps: 4,
                        currentStep: 2,
                        stepSize: 20,
                        steps: const [
                          Ux4gStepItem(
                            title: 'Eligibility',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(
                            title: 'Personal',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(
                            title: 'Documents',
                            titleStyle: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Ux4gStepItem(title: ''),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Personal information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please enter your details.',
                        style: TextStyle(fontSize: 15, color: _subtleText),
                      ),
                      const SizedBox(height: 32),

                      Ux4gStatusBanner(
                        variant: Ux4gBannerVariant.errorLight,
                        title:
                            '3 fields need your attention. Fix them to continue.',
                        backgroundColor: const Color(0xFFFFF8F8),
                        borderColor: const Color(0xFFFFDADC),
                        actionsAlignment: WrapAlignment.start,
                        titleStyle: const TextStyle(
                          color: Color(0xFF8A1A16),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Jump to first error',
                              style: TextStyle(
                                color: Color(0xFF8A1A16),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      Ux4gInputField(
                        label: 'Full name',
                        value: _fullName,
                        placeholder: 'Enter your full name',
                        onValueChange: (val) => setState(() => _fullName = val),
                        size: Ux4gInputFieldSize.medium,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'From Aadhaar · ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const Text(
                            'Update via UIDAI',
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.open_in_new,
                            size: 12,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Ux4gInputField(
                        label: 'Mobile number',
                        value: _mobileNumber,
                        placeholder: 'Enter mobile number',
                        onValueChange: (val) =>
                            setState(() => _mobileNumber = val),
                        size: Ux4gInputFieldSize.medium,
                        status: Ux4gInputFieldStatus.error,
                        caption: 'Mobile must be 10 digits.',
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Ux4gInputField(
                        label: 'Email address',
                        value: _emailAddress,
                        placeholder: 'Enter email address',
                        onValueChange: (val) =>
                            setState(() => _emailAddress = val),
                        size: Ux4gInputFieldSize.medium,
                        status: Ux4gInputFieldStatus.error,
                        caption: 'Enter a valid email.',
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Ux4gInputField(
                        label: 'Aadhaar number',
                        value: _aadhaarNumber,
                        placeholder: 'Enter Aadhaar number',
                        onValueChange: (val) =>
                            setState(() => _aadhaarNumber = val),
                        size: Ux4gInputFieldSize.medium,
                        status: Ux4gInputFieldStatus.error,
                        caption: 'Aadhaar must be 12 digits.',
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Ux4gSelectionDropdown(
                        label: 'State of residence',
                        options: const [
                          Ux4gDropdownOption(id: 'dl', label: 'Delhi'),
                          Ux4gDropdownOption(id: 'mh', label: 'Maharashtra'),
                        ],
                        selectedOptionIds: _selectedState != null
                            ? [_selectedState!]
                            : [],
                        onSelectionChange: (ids) => setState(
                          () => _selectedState = ids.isNotEmpty
                              ? ids.first
                              : null,
                        ),
                        placeholder: 'Please select..',
                        size: Ux4gDropdownSize.m,
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Your marital status',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Ux4gRadioButton(
                        value: 'Single',
                        groupValue: _maritalStatus,
                        onChanged: (v) => setState(() => _maritalStatus = v),
                        label: 'Single',
                      ),
                      Ux4gRadioButton(
                        value: 'Married',
                        groupValue: _maritalStatus,
                        onChanged: (v) => setState(() => _maritalStatus = v),
                        label: 'Married',
                      ),
                      Ux4gRadioButton(
                        value: 'Divorced',
                        groupValue: _maritalStatus,
                        onChanged: (v) => setState(() => _maritalStatus = v),
                        label: 'Divorced or widowed',
                      ),
                      Ux4gRadioButton(
                        value: 'Option4',
                        groupValue: _maritalStatus,
                        onChanged: (v) => setState(() => _maritalStatus = v),
                        label: 'Option 4',
                      ),
                      const SizedBox(height: 24),

                      Ux4gTextArea(
                        label: 'Brief reason (optional)',
                        value: _reason,
                        onValueChange: (v) => setState(() => _reason = v),
                        placeholder: 'Placeholder',
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Annual Income (Lakh ₹) *',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const Text(
                            '₹3.2 Lakh',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ],
                      ),
                      Ux4gSlider(
                        label: null,
                        value: _income,
                        onValueChange: (val) => setState(() => _income = val),
                        min: 0,
                        max: 100,
                        steps: 9,
                        showMarksAndValues: true,
                      ),
                      const SizedBox(height: 32),

                      const Text(
                        'Receive application status updates via SMS',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Ux4gCheckbox(
                        label: 'Accept terms and conditions *',
                        isRequired: true,
                        value: _acceptTerms,
                        onChanged: (val) =>
                            setState(() => _acceptTerms = val ?? false),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
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
                      contentColor: primaryColor,
                      borderColor: primaryColor,
                    ),
                  ],
                ),
              ),
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

class _GovernmentFormMultipleErrorsCardMockup extends StatefulWidget {
  const _GovernmentFormMultipleErrorsCardMockup({super.key});

  @override
  State<_GovernmentFormMultipleErrorsCardMockup> createState() =>
      _GovernmentFormMultipleErrorsCardMockupState();
}

class _GovernmentFormMultipleErrorsCardMockupState
    extends State<_GovernmentFormMultipleErrorsCardMockup> {
  bool _acceptTerms = true;
  String _fullName = 'Ramesh Kumar';
  String _mobileNumber = '98765';
  String _emailAddress = 'ramesh@example';
  String _aadhaarNumber = '1234';
  String? _selectedState;
  String? _maritalStatus = 'Married';
  String _reason = '';
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
                        Container(
                          height: 32,
                          width: 1,
                          color: const Color(0xFFD1D5DB),
                        ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      // White Card
                      Container(
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
                            // Saved Success Banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.successLight,
                              title: '',
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              backgroundColor: const Color(0xFFF0FDF4),
                              borderColor: Colors.transparent,
                              actionsAlignment: WrapAlignment.end,
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0xFF065F46),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'Saved 3:14 PM',
                                      style: TextStyle(
                                        color: Color(0xFF065F46),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              width: double.infinity,
                            ),
                            const SizedBox(height: 32),

                            // Stepper
                            Ux4gStepper(
                              totalSteps: 4,
                              currentStep: 2,
                              stepSize: 20,
                              steps: const [
                                Ux4gStepItem(
                                  title: 'Eligibility',
                                  titleStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Ux4gStepItem(
                                  title: 'Personal',
                                  titleStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Ux4gStepItem(
                                  title: 'Documents',
                                  titleStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Ux4gStepItem(title: ''),
                              ],
                            ),
                            const SizedBox(height: 32),

                            const Text(
                              'Personal information',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Please enter your details.',
                              style: TextStyle(
                                fontSize: 15,
                                color: _subtleText,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Global Error Banner
                            Ux4gStatusBanner(
                              variant: Ux4gBannerVariant.errorLight,
                              title:
                                  '3 fields need your attention. Fix them to continue.',
                              backgroundColor: const Color(0xFFFFF8F8),
                              borderColor: const Color(0xFFFFDADC),
                              actionsAlignment: WrapAlignment.start,
                              titleStyle: const TextStyle(
                                color: Color(0xFF8A1A16),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Jump to first error',
                                    style: TextStyle(
                                      color: Color(0xFF8A1A16),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            Ux4gInputField(
                              label: 'Full name',
                              value: _fullName,
                              placeholder: 'Enter your full name',
                              onValueChange: (val) =>
                                  setState(() => _fullName = val),
                              size: Ux4gInputFieldSize.medium,
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  'From Aadhaar · ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                const Text(
                                  'Update via UIDAI',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.open_in_new,
                                  size: 12,
                                  color: primaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Ux4gInputField(
                              label: 'Mobile number',
                              value: _mobileNumber,
                              placeholder: 'Enter mobile number',
                              onValueChange: (val) =>
                                  setState(() => _mobileNumber = val),
                              size: Ux4gInputFieldSize.medium,
                              status: Ux4gInputFieldStatus.error,
                              caption: 'Mobile must be 10 digits.',
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Ux4gInputField(
                              label: 'Email address',
                              value: _emailAddress,
                              placeholder: 'Enter email address',
                              onValueChange: (val) =>
                                  setState(() => _emailAddress = val),
                              size: Ux4gInputFieldSize.medium,
                              status: Ux4gInputFieldStatus.error,
                              caption: 'Enter a valid email.',
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Ux4gInputField(
                              label: 'Aadhaar number',
                              value: _aadhaarNumber,
                              placeholder: 'Enter Aadhaar number',
                              onValueChange: (val) =>
                                  setState(() => _aadhaarNumber = val),
                              size: Ux4gInputFieldSize.medium,
                              status: Ux4gInputFieldStatus.error,
                              caption: 'Aadhaar must be 12 digits.',
                              style: const TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),

                            Ux4gSelectionDropdown(
                              label: 'State of residence',
                              options: const [
                                Ux4gDropdownOption(id: 'dl', label: 'Delhi'),
                                Ux4gDropdownOption(
                                  id: 'mh',
                                  label: 'Maharashtra',
                                ),
                              ],
                              selectedOptionIds: _selectedState != null
                                  ? [_selectedState!]
                                  : [],
                              onSelectionChange: (ids) => setState(
                                () => _selectedState = ids.isNotEmpty
                                    ? ids.first
                                    : null,
                              ),
                              placeholder: 'Please select..',
                              size: Ux4gDropdownSize.m,
                            ),
                            const SizedBox(height: 24),

                            const Text(
                              'Your marital status',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Ux4gRadioButton(
                              value: 'Single',
                              groupValue: _maritalStatus,
                              onChanged: (v) =>
                                  setState(() => _maritalStatus = v),
                              label: 'Single',
                            ),
                            Ux4gRadioButton(
                              value: 'Married',
                              groupValue: _maritalStatus,
                              onChanged: (v) =>
                                  setState(() => _maritalStatus = v),
                              label: 'Married',
                            ),
                            Ux4gRadioButton(
                              value: 'Divorced',
                              groupValue: _maritalStatus,
                              onChanged: (v) =>
                                  setState(() => _maritalStatus = v),
                              label: 'Divorced or widowed',
                            ),
                            Ux4gRadioButton(
                              value: 'Option4',
                              groupValue: _maritalStatus,
                              onChanged: (v) =>
                                  setState(() => _maritalStatus = v),
                              label: 'Option 4',
                            ),
                            const SizedBox(height: 24),

                            Ux4gTextArea(
                              label: 'Brief reason (optional)',
                              value: _reason,
                              onValueChange: (v) => setState(() => _reason = v),
                              placeholder: 'Placeholder',
                            ),
                            const SizedBox(height: 24),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Annual Income (Lakh ₹) *',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                                const Text(
                                  '₹3.2 Lakh',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                            Ux4gSlider(
                              label: null,
                              value: _income,
                              onValueChange: (val) =>
                                  setState(() => _income = val),
                              min: 0,
                              max: 100,
                              steps: 9,
                              showMarksAndValues: true,
                            ),
                            const SizedBox(height: 32),

                            Ux4gCheckbox(
                              label: 'Accept terms and conditions *',
                              isRequired: true,
                              value: _acceptTerms,
                              onChanged: (val) =>
                                  setState(() => _acceptTerms = val ?? false),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    Ux4gButton(
                      text: 'Continue',
                      onPressed: () {},
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
                      contentColor: primaryColor,
                      borderColor: primaryColor,
                    ),
                  ],
                ),
              ),
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
