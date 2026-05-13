import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UX4G Flutter Design System',
      debugShowCheckedModeBanner: false,
      theme: Ux4gTheme.themeData(isDark: false),
      darkTheme: Ux4gTheme.themeData(isDark: true),
      home: const ComponentShowcasePage(),
    );
  }
}

class ComponentShowcasePage extends StatefulWidget {
  const ComponentShowcasePage({super.key});

  @override
  State<ComponentShowcasePage> createState() => _ComponentShowcasePageState();
}

class _ComponentShowcasePageState extends State<ComponentShowcasePage> {
  final Ux4gToastHostState _toastHostState = Ux4gToastHostState();
  bool _toastAtTop = true;
  bool _isDark = false;

  // Radio
  int _selectedRadio = 1;

  // Dropdown
  List<String> _singleSelected = ['opt_1'];
  List<String> _multiSelected = ['opt_1', 'opt_3'];
  List<String> _searchableSingleSelected = ['br'];
  List<String> _searchableMultiSelected = ['arp', 'br'];

  // Input
  String _textVal = '';
  String _passVal = '';

  // Search
  String _autocompleteVal = 'm';

  // Slider
  double _slider1 = 50;
  RangeValues _slider2 = const RangeValues(20, 70);
  double _slider3 = 40;
  RangeValues _slider4 = const RangeValues(30, 80);

  // Stepper
  int _currentStep = 2;

  // Pagination
  int _pageIndex = 1;

  // Capsule Stepper
  int _capsuleStep = 1;

  // Checkbox
  bool? _checkbox1 = true;
  bool? _checkbox2 = false;
  bool? _checkbox3; // tristate null = indeterminate

  // Toggle
  bool _toggle1 = true;
  bool _toggle2 = false;

  // Chips
  int _selectedChoiceChip = 0;
  final Set<int> _selectedFilterChips = {0, 2};

  // TextArea
  String _textAreaVal = '';

  // OTP
  String _otpDefault = '';
  String _otpError = '';
  String _otpSuccess = '123456';
  String _otpWarning = '';
  String _otpLocked = '123';
  String _otpCountdown = '';
  bool _otpCountdownExpired = false;

  // Interactive OTP Demo
  String _otpTestValue = '';
  Ux4gOtpInputStatus _otpTestStatus = Ux4gOtpInputStatus.defaultStatus;
  int _otpAttemptsLeft = 3;
  bool _otpIsLocked = false;

  List<Ux4gDropdownOption> get _stateOptions => [
    Ux4gDropdownOption(id: 'ap', label: 'Andhra Pradesh'),
    Ux4gDropdownOption(id: 'arp', label: 'Arunachal Pradesh'),
    Ux4gDropdownOption(id: 'as', label: 'Assam'),
    Ux4gDropdownOption(id: 'br', label: 'Bihar'),
    Ux4gDropdownOption(id: 'cg', label: 'Chhattisgarh'),
    Ux4gDropdownOption(id: 'ga', label: 'Goa'),
    Ux4gDropdownOption(id: 'gj', label: 'Gujarat'),
  ];

  @override
  void dispose() {
    _toastHostState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ux4gTheme(
      isDark: _isDark,
      child: Builder(
        builder: (ctx) {
          final colors = Ux4gTheme.colors(ctx);
          final typography = Ux4gTheme.typography(ctx);

          return Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              backgroundColor: colors.surface,
              title: Text(
                'Ux4g Component Showcase',
                style: typography.hS_strong.copyWith(color: colors.onSurface),
              ),
              actions: [
                Icon(
                  _isDark ? Icons.dark_mode : Icons.light_mode,
                  color: colors.onSurface,
                  size: 18,
                ),
                Switch(
                  value: _isDark,
                  onChanged: (v) => setState(() => _isDark = v),
                  activeTrackColor: colors.primary,
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ─── 1. Profile Avatar ────────────────────────────
                      _sectionTitle('Profile Avatar', typography, colors),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          Ux4gProfileAvatar(
                            size: Ux4gAvatarSize.xl,
                            variant: Ux4gProfileAction.edit,
                            imageUrl:
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                          ),
                          Ux4gProfileAvatar(
                            size: Ux4gAvatarSize.xl,
                            variant: Ux4gProfileAction.camera,
                            initials: 'JD',
                          ),
                          Ux4gProfileAvatar(
                            size: Ux4gAvatarSize.l,
                            variant: Ux4gProfileBadge.verified,
                            imageUrl:
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ─── Avatar Group ─────────────────────────────────
                      _sectionTitle('Avatar Group', typography, colors),
                      const SizedBox(height: 12),
                      Ux4gAvatarGroup(
                        items: [
                          Ux4gAvatarGroupItem(initials: 'AB'),
                          Ux4gAvatarGroupItem(initials: 'CD'),
                          Ux4gAvatarGroupItem(initials: 'EF'),
                          Ux4gAvatarGroupItem(initials: 'GH'),
                          Ux4gAvatarGroupItem(initials: 'IJ'),
                        ],
                        size: Ux4gAvatarSize.m,
                        maxLimit: 3,
                      ),

                      const SizedBox(height: 24),

                      // ─── Status Avatar ────────────────────────────────
                      _sectionTitle('Status Avatar', typography, colors),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          Ux4gStatusAvatar(
                            size: Ux4gAvatarSize.l,
                            variant: Ux4gStatusVariant.online,
                            initials: 'ON',
                          ),
                          Ux4gStatusAvatar(
                            size: Ux4gAvatarSize.l,
                            variant: Ux4gStatusVariant.offline,
                            initials: 'OF',
                          ),
                          Ux4gStatusAvatar(
                            size: Ux4gAvatarSize.l,
                            variant: Ux4gStatusVariant.busy,
                            initials: 'BS',
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // ─── 2. Primary Button ────────────────────────────
                      _showcaseCard(
                        title: 'Primary Button',
                        typography: typography,
                        colors: colors,
                        child: Ux4gButton(
                          onPressed: () {},
                          text: 'Confirm Changes',
                          leadingIcon: Icons.check,
                        ),
                      ),

                      // ─── 3. Outlined Button ───────────────────────────
                      _showcaseCard(
                        title: 'Outlined Button',
                        typography: typography,
                        colors: colors,
                        child: Ux4gButton(
                          onPressed: () {},
                          text: 'Outlined Action',
                          variant: Ux4gButtonVariant.outline,
                        ),
                      ),

                      // ─── 4. Custom Style (Secondary) ──────────────────
                      _showcaseCard(
                        title: 'Custom Style (Secondary)',
                        typography: typography,
                        colors: colors,
                        child: Ux4gButton(
                          onPressed: () {},
                          text: 'Secondary Pill Button',
                          backgroundColor: Ux4gPalette.secondary,
                          contentColor: Ux4gPalette.neutral1000black,
                          borderRadius: 24,
                          elevation: 8,
                        ),
                      ),

                      // ─── 5. Loading State ─────────────────────────────
                      _showcaseCard(
                        title: 'Loading State',
                        typography: typography,
                        colors: colors,
                        child: Ux4gButton(
                          onPressed: () {},
                          text: 'Click Me',
                          isLoading: true,
                        ),
                      ),

                      // ─── 6. Disabled State ────────────────────────────
                      _showcaseCard(
                        title: 'Disabled State',
                        typography: typography,
                        colors: colors,
                        child: Ux4gButton(
                          onPressed: () {},
                          text: 'Disabled Button',
                          enabled: false,
                        ),
                      ),

                      // ─── Button Variants ──────────────────────────────
                      _showcaseCard(
                        title: 'Button Variants',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gButton(
                              onPressed: () {},
                              text: 'Ghost Button',
                              variant: Ux4gButtonVariant.ghost,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () {},
                              text: 'Secondary Button',
                              variant: Ux4gButtonVariant.secondary,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Ux4gIconButton(
                                  icon: Icons.add,
                                  onPressed: () {},
                                ),
                                Ux4gIconButton(
                                  icon: Icons.edit,
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.outline,
                                ),
                                Ux4gIconButton(
                                  icon: Icons.delete,
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.ghost,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── 7. Loaders ───────────────────────────────────
                      _showcaseCard(
                        title: 'Loaders',
                        typography: typography,
                        colors: colors,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Ux4gLoader(
                              size: 40,
                              percentage: 100,
                              color: Ux4gPalette.primary,
                            ),
                            Ux4gLoader(
                              size: 40,
                              percentage: 60,
                              color: Ux4gPalette.secondary,
                            ),
                            Ux4gLoader(
                              size: 40,
                              percentage: 30,
                              color: Ux4gPalette.red,
                            ),
                            Ux4gLoader(
                              size: 40,
                              percentage: 75,
                              color: Ux4gPalette.green,
                            ),
                          ],
                        ),
                      ),

                      // ─── 8. Radio Buttons ─────────────────────────────
                      _showcaseCard(
                        title: 'Radio Buttons',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gRadioButton<int>(
                              value: 1,
                              groupValue: _selectedRadio,
                              onChanged: (v) =>
                                  setState(() => _selectedRadio = v!),
                              label: 'Option 1 (Medium)',
                              size: Ux4gRadioButtonSize.medium,
                            ),
                            const SizedBox(height: 8),
                            Ux4gRadioButton<int>(
                              value: 2,
                              groupValue: _selectedRadio,
                              onChanged: (v) =>
                                  setState(() => _selectedRadio = v!),
                              label: 'Option 2 (Large with Desc)',
                              size: Ux4gRadioButtonSize.large,
                              description: 'Helper text for option 2',
                            ),
                            const SizedBox(height: 8),
                            Ux4gRadioButton<int>(
                              value: 3,
                              groupValue: _selectedRadio,
                              onChanged: (v) =>
                                  setState(() => _selectedRadio = v!),
                              label: 'Option 3 (Disabled)',
                              size: Ux4gRadioButtonSize.medium,
                              enabled: false,
                            ),
                          ],
                        ),
                      ),

                      // ─── 9. Checkbox ──────────────────────────────────
                      _showcaseCard(
                        title: 'Checkboxes',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gCheckbox(
                              value: _checkbox1,
                              onChanged: (v) => setState(() => _checkbox1 = v),
                              label: 'Checked',
                              size: Ux4gCheckboxSize.medium,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: _checkbox2,
                              onChanged: (v) => setState(() => _checkbox2 = v),
                              label: 'Unchecked (with description)',
                              description: 'Helper text here',
                              size: Ux4gCheckboxSize.large,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: _checkbox3,
                              onChanged: (v) => setState(() => _checkbox3 = v),
                              label: 'Indeterminate (tristate)',
                              size: Ux4gCheckboxSize.medium,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCheckbox(
                              value: true,
                              onChanged: (_) {},
                              label: 'Disabled Checked',
                              enabled: false,
                            ),
                          ],
                        ),
                      ),

                      // ─── 10. Toggle ───────────────────────────────────
                      _showcaseCard(
                        title: 'Toggle Switch',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gToggle(
                              checked: _toggle1,
                              onCheckedChange: (v) =>
                                  setState(() => _toggle1 = v),
                              label: 'Notifications',
                              description: 'Receive push notifications',
                              size: Ux4gToggleSize.m,
                              labelPosition: Ux4gToggleLabelPosition.right,
                            ),
                            const SizedBox(height: 12),
                            Ux4gToggle(
                              checked: _toggle2,
                              onCheckedChange: (v) =>
                                  setState(() => _toggle2 = v),
                              label: 'Dark Mode',
                              size: Ux4gToggleSize.l,
                              labelPosition: Ux4gToggleLabelPosition.left,
                            ),
                            const SizedBox(height: 12),
                            Ux4gToggle(
                              checked: true,
                              label: 'Disabled (On)',
                              size: Ux4gToggleSize.s,
                              enabled: false,
                            ),
                          ],
                        ),
                      ),

                      // ─── 11. Dropdown Showcase ────────────────────────
                      _showcaseCard(
                        title: 'Selection Dropdowns',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gSelectionDropdown(
                              options: [
                                Ux4gDropdownOption(
                                  id: 'opt_1',
                                  label: 'Option A',
                                ),
                                Ux4gDropdownOption(
                                  id: 'opt_2',
                                  label: 'Option B',
                                ),
                                Ux4gDropdownOption(
                                  id: 'opt_3',
                                  label: 'Option C',
                                  leadingIcon: Icons.person,
                                ),
                              ],
                              selectedOptionIds: _singleSelected,
                              onSelectionChange: (v) =>
                                  setState(() => _singleSelected = v),
                              label: 'Single Select',
                              description: 'Choose one option',
                              mode: Ux4gDropdownMode.single,
                            ),
                            const SizedBox(height: 16),
                            Ux4gSelectionDropdown(
                              options: [
                                Ux4gDropdownOption(
                                  id: 'opt_1',
                                  label: 'Option A',
                                ),
                                Ux4gDropdownOption(
                                  id: 'opt_2',
                                  label: 'Option B',
                                ),
                                Ux4gDropdownOption(
                                  id: 'opt_3',
                                  label: 'Option C',
                                  leadingIcon: Icons.person,
                                ),
                              ],
                              selectedOptionIds: _multiSelected,
                              onSelectionChange: (v) =>
                                  setState(() => _multiSelected = v),
                              label: 'Multi Select',
                              description: 'Choose multiple options',
                              mode: Ux4gDropdownMode.multi,
                            ),
                          ],
                        ),
                      ),

                      // ─── 12. Searchable Dropdowns ─────────────────────
                      _showcaseCard(
                        title: 'Searchable Selection Dropdowns',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filter: StartsWithPerTerm',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gSelectionDropdown(
                              options: _stateOptions,
                              selectedOptionIds: _searchableSingleSelected,
                              onSelectionChange: (v) =>
                                  setState(() => _searchableSingleSelected = v),
                              label: 'Single - Starts With Word',
                              description: "Typing 'Pra' matches 'Pradesh'",
                              searchEnabled: true,
                              filterType:
                                  Ux4gDropdownFilterType.startsWithPerTerm,
                              mode: Ux4gDropdownMode.single,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Filter: Contains',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gSelectionDropdown(
                              options: _stateOptions,
                              selectedOptionIds: _searchableSingleSelected,
                              onSelectionChange: (v) =>
                                  setState(() => _searchableSingleSelected = v),
                              label: 'Single - Contains',
                              description: "Typing 'esh' matches 'Pradesh'",
                              searchEnabled: true,
                              filterType: Ux4gDropdownFilterType.contains,
                              mode: Ux4gDropdownMode.single,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Multi Select Searchable',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gSelectionDropdown(
                              options: _stateOptions,
                              selectedOptionIds: _searchableMultiSelected,
                              onSelectionChange: (v) =>
                                  setState(() => _searchableMultiSelected = v),
                              label: 'Multi - Contains',
                              description: 'Choose multiple states',
                              searchEnabled: true,
                              filterType: Ux4gDropdownFilterType.contains,
                              mode: Ux4gDropdownMode.multi,
                            ),
                          ],
                        ),
                      ),

                      // ─── 13. Input Field Showcase ─────────────────────
                      _showcaseCard(
                        title: 'Input Fields',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gInputField(
                              value: _textVal,
                              onValueChange: (v) =>
                                  setState(() => _textVal = v),
                              label: 'Default Input',
                              placeholder: 'Placeholder',
                              caption: 'Helper text',
                              required: true,
                              size: Ux4gInputFieldSize.medium,
                            ),
                            const SizedBox(height: 16),
                            Ux4gInputField(
                              value: _textVal,
                              onValueChange: (v) =>
                                  setState(() => _textVal = v),
                              label: 'Error Input',
                              placeholder: 'Placeholder',
                              caption: 'Error subtitle',
                              status: Ux4gInputFieldStatus.error,
                              trailingIcon: Icons.close,
                            ),
                            const SizedBox(height: 16),
                            Ux4gInputField(
                              value: _passVal,
                              onValueChange: (v) =>
                                  setState(() => _passVal = v),
                              label: 'Password',
                              placeholder: 'Enter your password',
                              type: Ux4gInputFieldType.password,
                              showPasswordToggle: true,
                            ),
                            const SizedBox(height: 16),
                            Ux4gInputField(
                              value: _textVal,
                              onValueChange: (v) =>
                                  setState(() => _textVal = v),
                              label: 'Amount',
                              placeholder: '100',
                              prefixText: '\$',
                              postfixText: '.00',
                            ),
                            const SizedBox(height: 16),
                            Ux4gInputField(
                              value: _textVal,
                              onValueChange: (v) =>
                                  setState(() => _textVal = v),
                              label: 'Search',
                              placeholder: 'Search...',
                              leadingIcon: Icons.search,
                            ),
                          ],
                        ),
                      ),

                      // ─── 13b. OTP Input ───────────────────────────────
                      _showcaseCard(
                        title: 'OTP Input',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ─── Interactive Demo ───────────────────────────────
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(Ux4gRadius.radius12),
                                border: Border.all(color: colors.primary.withValues(alpha: 0.1)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Interactive Testing Demo', 
                                          style: typography.lM_strong.copyWith(color: colors.primary)),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _otpTestValue = '';
                                            _otpTestStatus = Ux4gOtpInputStatus.defaultStatus;
                                            _otpAttemptsLeft = 3;
                                            _otpIsLocked = false;
                                          });
                                        },
                                        child: const Text('Reset Demo'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Ux4gOtpInput(
                                    length: 6,
                                    value: _otpTestValue,
                                    enabled: !_otpIsLocked,
                                    status: _otpTestStatus,
                                    label: 'Enter Verification Code (Default OTP is 123456)',
                                    captionVariant: _otpIsLocked
                                        ? Ux4gOtpCaptionVariant.locked
                                        : (_otpTestStatus == Ux4gOtpInputStatus.success
                                            ? Ux4gOtpCaptionVariant.success
                                            : (_otpAttemptsLeft < 3
                                                ? Ux4gOtpCaptionVariant.attemptWithTimer
                                                : Ux4gOtpCaptionVariant.plain)),
                                    captionLeadingText: _otpIsLocked
                                        ? 'Locked for 30:00'
                                        : (_otpAttemptsLeft < 3
                                            ? 'Attempt ${4 - _otpAttemptsLeft} of 3'
                                            : 'Correct code is 123456'),
                                    captionTrailingText: _otpIsLocked ? 'Resend OTP' : null,
                                    onChanged: (v) {
                                      setState(() {
                                        _otpTestValue = v;
                                        // Reset error state when user types again
                                        if (_otpTestStatus == Ux4gOtpInputStatus.error) {
                                          _otpTestStatus = Ux4gOtpInputStatus.defaultStatus;
                                        }
                                      });
                                    },
                                    onCompleted: (v) {
                                      setState(() {
                                        if (v == '123456') {
                                          _otpTestStatus = Ux4gOtpInputStatus.success;
                                        } else {
                                          _otpAttemptsLeft--;
                                          if (_otpAttemptsLeft <= 0) {
                                            _otpIsLocked = true;
                                            _otpTestStatus = Ux4gOtpInputStatus.locked;
                                          } else {
                                            _otpTestStatus = Ux4gOtpInputStatus.error;
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // 4-Digit Demo
                            Ux4gOtpInput(
                              length: 4,
                              value: _otpCountdown,
                              onChanged: (v) => setState(() => _otpCountdown = v),
                              label: '4-Digit Mode',
                              captionVariant: Ux4gOtpCaptionVariant.plain,
                              captionText: 'Demo of 4-box layout with separators',
                            ),
                            const SizedBox(height: 32),
                            
                            // Default
                            Text('Default', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpDefault,
                              onChanged: (v) => setState(() => _otpDefault = v),
                              onCompleted: (v) {},
                              label: 'Label',
                              required: true,
                              labelTrailingIcon: Icons.info_outline,
                              captionVariant: Ux4gOtpCaptionVariant.resendTimer,
                              captionLeadingText: "Didn't receive OTP?",
                              captionTrailingText: 'Resend in 00:30',
                            ),
                            const SizedBox(height: 20),

                            // Resend Action
                            Text('Resend Action', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpDefault,
                              onChanged: (v) => setState(() => _otpDefault = v),
                              captionVariant: Ux4gOtpCaptionVariant.resendAction,
                              captionLeadingText: "Didn't receive OTP?",
                              captionTrailingText: 'Resend OTP',
                              onCaptionTrailingTap: () {},
                            ),
                            const SizedBox(height: 20),

                            // Error / Attempt
                            Text('Error — Attempt 2 of 3', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpError,
                              onChanged: (v) => setState(() => _otpError = v),
                              status: Ux4gOtpInputStatus.error,
                              captionVariant: Ux4gOtpCaptionVariant.attemptWithTimer,
                              captionLeadingText: 'Attempt 2 of 3',
                              captionTrailingText: 'Resend OTP in 00:17',
                            ),
                            const SizedBox(height: 20),

                            // Locked
                            Text('Locked', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpLocked,
                              onChanged: (v) => setState(() => _otpLocked = v),
                              status: Ux4gOtpInputStatus.locked,
                              captionVariant: Ux4gOtpCaptionVariant.locked,
                              captionLeadingText: 'Locked for 28:43',
                              captionTrailingText: 'Resend OTP',
                              onCaptionTrailingTap: () {},
                            ),
                            const SizedBox(height: 20),

                            // Success
                            Text('Success', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpSuccess,
                              onChanged: (v) => setState(() => _otpSuccess = v),
                              status: Ux4gOtpInputStatus.success,
                              captionVariant: Ux4gOtpCaptionVariant.success,
                              captionText: 'Verification successful',
                            ),
                            const SizedBox(height: 20),

                            // Warning
                            Text('Warning', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpWarning,
                              onChanged: (v) => setState(() => _otpWarning = v),
                              status: Ux4gOtpInputStatus.warning,
                              captionVariant: Ux4gOtpCaptionVariant.warning,
                              captionText: 'Warning message',
                            ),
                            const SizedBox(height: 20),

                            // Auto Countdown (30s)
                            Text('Auto Countdown (30s)', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 4,
                              value: _otpCountdown,
                              onChanged: (v) => setState(() => _otpCountdown = v),
                              captionVariant: _otpCountdownExpired
                                  ? Ux4gOtpCaptionVariant.resendAction
                                  : Ux4gOtpCaptionVariant.resendTimer,
                              captionLeadingText: "Didn't receive OTP?",
                              captionTrailingText: _otpCountdownExpired
                                  ? 'Resend OTP'
                                  : 'Resend in',
                              onCaptionTrailingTap: _otpCountdownExpired
                                  ? () => setState(() => _otpCountdownExpired = false)
                                  : null,
                              autoCountdownSeconds: 30,
                              onCountdownComplete:
                                  () => setState(() => _otpCountdownExpired = true),
                            ),
                            const SizedBox(height: 20),

                            // Obscure / Password mode
                            Text('Obscure (Password mode)', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gOtpInput(
                              length: 6,
                              value: _otpDefault,
                              onChanged: (v) => setState(() => _otpDefault = v),
                              obscure: true,
                              captionVariant: Ux4gOtpCaptionVariant.plain,
                              captionText: 'Enter your 6-digit PIN',
                            ),
                          ],
                        ),
                      ),

                      // ─── 14. Text Area ────────────────────────────────
                      _showcaseCard(
                        title: 'Text Area',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gTextArea(
                              value: _textAreaVal,
                              onValueChange: (v) =>
                                  setState(() => _textAreaVal = v),
                              label: 'Description',
                              placeholder: 'Write something...',
                              caption: 'Max 200 characters',
                              maxLength: 200,
                              size: Ux4gTextAreaSize.large,
                              minHeight: Ux4gTextAreaMinHeight.medium,
                            ),
                            const SizedBox(height: 16),
                            Ux4gTextArea(
                              value: 'Read only content',
                              onValueChange: (_) {},
                              label: 'Read Only',
                              readOnly: true,
                              size: Ux4gTextAreaSize.small,
                            ),
                          ],
                        ),
                      ),

                      // ─── 15. Search Field ─────────────────────────────
                      _showcaseCard(
                        title: 'Search Field (Autocomplete)',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Builder(
                              builder: (context) {
                                final data = [
                                  'macbook',
                                  'mobile',
                                  'monitor',
                                  'mouse',
                                  'camera',
                                  'keyboard',
                                ];
                                final filtered = data
                                    .where(
                                      (e) => e.contains(
                                        _autocompleteVal.toLowerCase(),
                                      ),
                                    )
                                    .toList();
                                final isLoading = _autocompleteVal == 'mm';
                                return Ux4gSearchField(
                                  value: _autocompleteVal,
                                  onValueChange: (v) =>
                                      setState(() => _autocompleteVal = v),
                                  variant: Ux4gSearchFieldVariant.autocomplete,
                                  label: 'Search components',
                                  placeholder: 'Search for...',
                                  showVoiceIcon: true,
                                  isLoading: isLoading,
                                  options: isLoading ? [] : filtered,
                                  onOptionSelected: (s) =>
                                      setState(() => _autocompleteVal = s),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Ux4gSearchField(
                              value: '',
                              onValueChange: (_) {},
                              variant: Ux4gSearchFieldVariant.searchWithSubmit,
                              label: 'With Submit Button',
                              placeholder: 'Type and submit...',
                            ),
                          ],
                        ),
                      ),

                      // ─── 16. Tooltip Showcase ─────────────────────────
                      _showcaseCard(
                        title: 'Tooltips (Long-press to show)',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Ux4gTooltip(
                                  tooltipText: 'Top tooltip',
                                  placement: Ux4gTooltipPlacement.top,
                                  child: Ux4gButton(
                                    onPressed: () {},
                                    text: 'Top',
                                    size: Ux4gButtonSize.small,
                                  ),
                                ),
                                Ux4gTooltip(
                                  tooltipText: 'Bottom tooltip',
                                  placement: Ux4gTooltipPlacement.bottom,
                                  child: Ux4gButton(
                                    onPressed: () {},
                                    text: 'Bottom',
                                    size: Ux4gButtonSize.small,
                                  ),
                                ),
                                Ux4gTooltip(
                                  tooltipText: 'With Icon',
                                  placement: Ux4gTooltipPlacement.right,
                                  icon: Icons.info_outline,
                                  child: Ux4gButton(
                                    onPressed: () {},
                                    text: 'Right',
                                    size: Ux4gButtonSize.small,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Ux4gTooltip(
                                  tooltipText: 'Custom Color',
                                  placement: Ux4gTooltipPlacement.left,
                                  backgroundColor: Ux4gPalette.primary,
                                  contentColor: Ux4gPalette.white,
                                  child: Ux4gButton(
                                    onPressed: () {},
                                    text: 'Left',
                                    size: Ux4gButtonSize.small,
                                  ),
                                ),
                                Ux4gTooltip(
                                  tooltipText: 'Top Start',
                                  placement: Ux4gTooltipPlacement.topStart,
                                  icon: Icons.check_circle,
                                  child: Icon(
                                    Icons.info_outline,
                                    color: colors.onBackground,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Rich Tooltips (Long-press)',
                              style: typography.tS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gRichTooltip(
                              tooltipText:
                                  'This is a rich tooltip with a title and an action button. Tap outside or the action to dismiss.',
                              title: 'Rich Tooltip',
                              icon: Icons.info_outline,
                              placement: Ux4gTooltipPlacement.top,
                              action: Ux4gButton(
                                onPressed: () {},
                                text: 'Action',
                                size: Ux4gButtonSize.small,
                              ),
                              child: Ux4gButton(
                                onPressed: () {},
                                text: 'Long Press Me',
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── 17. Divider Showcase ─────────────────────────
                      _showcaseCard(
                        title: 'Dividers',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Horizontal – Solid',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 4),
                            const Ux4gDivider(),
                            const SizedBox(height: 12),
                            Text(
                              'Horizontal – Dashed',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 4),
                            const Ux4gDivider(style: Ux4gDividerStyle.dashed),
                            const SizedBox(height: 12),
                            Text(
                              'Horizontal – Dotted, Primary',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 4),
                            Ux4gDivider(
                              style: Ux4gDividerStyle.dotted,
                              color: Ux4gPalette.primary500,
                              thickness: 1.5,
                            ),
                            const SizedBox(height: 12),
                            Text('With Label', style: typography.lM_default),
                            const SizedBox(height: 4),
                            Ux4gDivider(
                              label: Text(
                                'OR',
                                style: typography.lS_strong.copyWith(
                                  color: Ux4gPalette.neutral500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Vertical Dividers',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 56,
                              child: Row(
                                children: [
                                  Text('Left', style: typography.bM_default),
                                  const SizedBox(width: 8),
                                  const Ux4gDivider(
                                    orientation:
                                        Ux4gDividerOrientation.vertical,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Mid', style: typography.bM_default),
                                  const SizedBox(width: 8),
                                  const Ux4gDivider(
                                    orientation:
                                        Ux4gDividerOrientation.vertical,
                                    style: Ux4gDividerStyle.dashed,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Right', style: typography.bM_default),
                                  const SizedBox(width: 8),
                                  Ux4gDivider(
                                    orientation:
                                        Ux4gDividerOrientation.vertical,
                                    color: Ux4gPalette.primary500,
                                    thickness: 2,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('End', style: typography.bM_default),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── 18. Tags ─────────────────────────────────────
                      _showcaseCard(
                        title: 'Tags',
                        typography: typography,
                        colors: colors,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Ux4gTag(text: 'Neutral'),
                            Ux4gTag(
                              text: 'Brand',
                              colorScheme: Ux4gTagColor.brand,
                            ),
                            Ux4gTag(
                              text: 'Success',
                              colorScheme: Ux4gTagColor.success,
                            ),
                            Ux4gTag(
                              text: 'Warning',
                              colorScheme: Ux4gTagColor.warning,
                            ),
                            Ux4gTag(
                              text: 'Error',
                              colorScheme: Ux4gTagColor.error,
                            ),
                            Ux4gTag(
                              text: 'Info',
                              colorScheme: Ux4gTagColor.info,
                            ),
                            Ux4gTag(
                              text: 'Filled',
                              style: Ux4gTagStyle.filled,
                              colorScheme: Ux4gTagColor.brand,
                            ),
                            Ux4gTag(
                              text: 'Outline',
                              style: Ux4gTagStyle.outline,
                              colorScheme: Ux4gTagColor.error,
                            ),
                            Ux4gTag(
                              text: 'Rectangular',
                              shape: Ux4gTagShape.rectangular,
                              colorScheme: Ux4gTagColor.success,
                            ),
                            Ux4gTag(
                              text: 'Large',
                              size: Ux4gTagSize.l,
                              colorScheme: Ux4gTagColor.info,
                            ),
                            Ux4gTag(
                              text: 'Dismissible',
                              colorScheme: Ux4gTagColor.brand,
                              onDismiss: () {},
                            ),
                          ],
                        ),
                      ),

                      // ─── 19. Badges ───────────────────────────────────
                      _showcaseCard(
                        title: 'Badges',
                        typography: typography,
                        colors: colors,
                        child: Wrap(
                          spacing: 24,
                          runSpacing: 16,
                          children: [
                            Ux4gBadge.dot(
                              child: Icon(
                                Icons.notifications,
                                color: colors.onBackground,
                                size: 28,
                              ),
                            ),
                            Ux4gBadge.count(
                              5,
                              child: Icon(
                                Icons.mail,
                                color: colors.onBackground,
                                size: 28,
                              ),
                            ),
                            Ux4gBadge.count(
                              120,
                              limit: Ux4gBadgeLimit.doubleDigit,
                              child: Icon(
                                Icons.shopping_cart,
                                color: colors.onBackground,
                                size: 28,
                              ),
                            ),
                            Ux4gBadge.label(
                              'New',
                              child: Icon(
                                Icons.star,
                                color: colors.onBackground,
                                size: 28,
                              ),
                            ),
                            Ux4gBadge.icon(
                              Icons.check,
                              child: Icon(
                                Icons.person,
                                color: colors.onBackground,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── 20. Chips ────────────────────────────────────
                      _showcaseCard(
                        title: 'Chips',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Choice Chips', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: List.generate(4, (i) {
                                return Ux4gChoiceChip(
                                  text: 'Choice ${i + 1}',
                                  selected: _selectedChoiceChip == i,
                                  onClick: () =>
                                      setState(() => _selectedChoiceChip = i),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Text('Filter Chips', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: List.generate(4, (i) {
                                return Ux4gFilterChip(
                                  text: 'Filter ${i + 1}',
                                  selected: _selectedFilterChips.contains(i),
                                  onClick: () => setState(() {
                                    if (_selectedFilterChips.contains(i)) {
                                      _selectedFilterChips.remove(i);
                                    } else {
                                      _selectedFilterChips.add(i);
                                    }
                                  }),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Text('Input Chips', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: [
                                Ux4gInputChip(
                                  text: 'Flutter',
                                  onDismiss: () {},
                                ),
                                Ux4gInputChip(text: 'Dart', onDismiss: () {}),
                                Ux4gInputChip(
                                  text: 'Material',
                                  onDismiss: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── 21. Modals ───────────────────────────────────
                      _showcaseCard(
                        title: 'Modals',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gButton(
                              onPressed: () => _showModal(
                                context,
                                Ux4gModal(
                                  onDismiss: () => Navigator.of(context).pop(),
                                  headerImageContent: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF9C6FE0),
                                          Color(0xFFE07BAD),
                                          Color(0xFF7B9FE0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  showHeader: true,
                                  headerTitle: 'Header',
                                  showSubtitle: true,
                                  showBody: true,
                                  showFooter: true,
                                  footerButtons:
                                      Ux4gModalFooterButtons.twoButtons,
                                  footerAlign: Ux4gModalFooterAlign.right,
                                  isDestructive: false,
                                  onPrimaryClick: () =>
                                      Navigator.of(context).pop(),
                                  onSecondaryClick: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                              text: 'Open Default Modal (2 buttons, Left)',
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => _showModal(
                                context,
                                Ux4gModal(
                                  onDismiss: () => Navigator.of(context).pop(),
                                  headerImageContent: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF9C6FE0),
                                          Color(0xFFE07BAD),
                                        ],
                                      ),
                                    ),
                                  ),
                                  showHeader: true,
                                  headerTitle: 'Warning',
                                  showDescription: true,
                                  descriptionText:
                                      'This action cannot be undone.',
                                  alignment: Ux4gModalAlignment.centered,
                                  showSubtitle: true,
                                  subtitleText: 'Delete Item?',
                                  showBody: true,
                                  bodyText:
                                      'Are you sure you want to permanently delete this item?',
                                  showFooter: true,
                                  footerButtons:
                                      Ux4gModalFooterButtons.twoButtons,
                                  footerAlign: Ux4gModalFooterAlign.center,
                                  isDestructive: true,
                                  primaryButtonText: 'Delete',
                                  secondaryButtonText: 'Cancel',
                                  onPrimaryClick: () =>
                                      Navigator.of(context).pop(),
                                  onSecondaryClick: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                              text: 'Open Destructive Modal (Centered)',
                              backgroundColor: Ux4gPalette.red500,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => _showModal(
                                context,
                                Ux4gModal(
                                  onDismiss: () => Navigator.of(context).pop(),
                                  headerImageStyle: Ux4gModalHeaderImage.none,
                                  showHeader: false,
                                  showDividers: false,
                                  showSubtitle: true,
                                  subtitleText: 'Confirm Action',
                                  showBody: true,
                                  bodyText:
                                      'This will permanently remove the selected items. Continue?',
                                  showFooter: true,
                                  footerButtons:
                                      Ux4gModalFooterButtons.twoButtons,
                                  footerAlign: Ux4gModalFooterAlign.split,
                                  isDestructive: true,
                                  primaryButtonText: 'Confirm',
                                  secondaryButtonText: 'Cancel',
                                  showCloseButton: false,
                                  onPrimaryClick: () =>
                                      Navigator.of(context).pop(),
                                  onSecondaryClick: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                              text: 'Open Minimal Confirm Modal',
                              backgroundColor: Ux4gPalette.gray800,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => _showModal(
                                context,
                                Ux4gModal(
                                  onDismiss: () => Navigator.of(context).pop(),
                                  headerImageContent: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF9C6FE0),
                                          Color(0xFFE07BAD),
                                        ],
                                      ),
                                    ),
                                  ),
                                  headerImageStyle: Ux4gModalHeaderImage.padded,
                                  leadingItem: Ux4gModalLeadingItem.avatar,
                                  avatarInitials: 'JD',
                                  alignment: Ux4gModalAlignment.centered,
                                  showHeader: true,
                                  headerTitle: 'Header',
                                  showDescription: true,
                                  descriptionText: 'Write description here',
                                  showSubtitle: true,
                                  showBody: true,
                                  showFooter: true,
                                  footerButtons:
                                      Ux4gModalFooterButtons.oneButton,
                                  footerAlign: Ux4gModalFooterAlign.center,
                                  isDestructive: true,
                                  onPrimaryClick: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                              text: 'Avatar Modal (Centered + Padded)',
                              backgroundColor: Ux4gPalette.primary700,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => _showModal(
                                context,
                                Ux4gModal(
                                  onDismiss: () => Navigator.of(context).pop(),
                                  headerImageStyle: Ux4gModalHeaderImage.none,
                                  leadingItem: Ux4gModalLeadingItem.icon,
                                  leadingIcon: Icons.info_outline,
                                  leadingIconTint: Ux4gPalette.red500,
                                  alignment: Ux4gModalAlignment.leftAligned,
                                  showHeader: true,
                                  headerTitle: 'Header',
                                  showDescription: true,
                                  descriptionText: 'Write description here',
                                  showSubtitle: true,
                                  showBody: true,
                                  showFooter: true,
                                  footerButtons:
                                      Ux4gModalFooterButtons.twoButtons,
                                  footerAlign: Ux4gModalFooterAlign.split,
                                  isDestructive: true,
                                  primaryButtonText: 'Delete',
                                  secondaryButtonText: 'Cancel',
                                  onPrimaryClick: () =>
                                      Navigator.of(context).pop(),
                                  onSecondaryClick: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                              text: 'Icon Modal (No image + Split)',
                              backgroundColor: Ux4gPalette.red700,
                              contentColor: Ux4gPalette.white,
                            ),
                          ],
                        ),
                      ),

                      // ─── 22. Card Component ───────────────────────────
                      _sectionTitle('Card Component', typography, colors),
                      const SizedBox(height: 12),

                      // Full card
                      Ux4gCard(
                        mediaImageUrl:
                            'https://picsum.photos/seed/card1/600/300',
                        mediaLabelText: 'Label',
                        avatar: Ux4gAvatar(
                          size: Ux4gAvatarSize.s,
                          initials: 'JD',
                          containerColor: Ux4gPalette.primary50,
                          contentColor: Ux4gPalette.primary700,
                        ),
                        title: 'Title',
                        subtitle: 'Subtitle',
                        statusChips: const ['Status A', 'Pending', 'Approved'],
                        body:
                            'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
                        bottomChips: const ['Label', 'Label', 'Label', 'Label'],
                        footerType: Ux4gCardFooterType.primaryAndSecondary,
                        footerAlignment: Ux4gCardFooterAlignment.centered,
                        primaryButtonText: 'Confirm',
                        secondaryButtonText: 'Cancel',
                      ),
                      const SizedBox(height: 16),

                      // Outlined card
                      Ux4gCard(
                        mediaImageUrl:
                            'https://picsum.photos/seed/card2/600/300',
                        mediaLabelText: 'New',
                        borderColor: Ux4gPalette.primary,
                        borderWidth: 1,
                        title: 'Outlined Card',
                        subtitle: 'No avatar shown here',
                        statusChips: const ['Category', 'Design'],
                        body:
                            'This card has a primary coloured border and only a secondary footer button.',
                        bottomChips: const ['Kotlin', 'Compose', 'Ux4G'],
                        footerType: Ux4gCardFooterType.secondaryOnly,
                        footerAlignment: Ux4gCardFooterAlignment.left,
                        secondaryButtonText: 'Learn More',
                      ),
                      const SizedBox(height: 16),

                      // Elevated card
                      Ux4gCard(
                        elevation: 4,
                        backgroundColor: Ux4gPalette.primary50,
                        cornerRadius: Ux4gRadius.radius16,
                        title: 'Elevated Card',
                        body:
                            'This card has a tinted background and elevated shadow, no image required.',
                        bottomChips: const ['Jetpack', 'Material3', 'API 26+'],
                        footerType: Ux4gCardFooterType.primaryOnly,
                        footerAlignment: Ux4gCardFooterAlignment.right,
                        primaryButtonText: 'Get Started',
                      ),

                      const SizedBox(height: 32),

                      // ─── 23. Sliders ──────────────────────────────────
                      _showcaseCard(
                        title: 'Sliders',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gSlider(
                              value: _slider1,
                              onValueChange: (v) =>
                                  setState(() => _slider1 = v),
                              label: 'Basic Single Slider (Small)',
                              showMarksAndValues: true,
                              steps: 9,
                            ),
                            const SizedBox(height: 24),
                            Ux4gRangeSlider(
                              values: _slider2,
                              onValueChange: (v) =>
                                  setState(() => _slider2 = v),
                              label: 'Basic Range Slider (Medium)',
                              size: Ux4gSliderSize.medium,
                              showValueLabels: true,
                              showMarksAndValues: true,
                              steps: 9,
                            ),
                            const SizedBox(height: 24),
                            Ux4gSlider(
                              value: _slider3,
                              onValueChange: (v) =>
                                  setState(() => _slider3 = v),
                              label: 'With Value Indicator',
                              showIndicator: true,
                              showMarksAndValues: true,
                              steps: 4,
                            ),
                            const SizedBox(height: 24),
                            Ux4gRangeSlider(
                              values: _slider4,
                              onValueChange: (v) =>
                                  setState(() => _slider4 = v),
                              label: 'With Editable Input Fields',
                              showInputFields: true,
                              showMarksAndValues: true,
                              steps: 5,
                            ),
                            const SizedBox(height: 24),
                            Ux4gSlider(
                              value: 60,
                              onValueChange: null,
                              label: 'Disabled State',
                              enabled: false,
                              showMarksAndValues: true,
                              steps: 9,
                              caption: 'Component is disabled',
                            ),
                            const SizedBox(height: 24),
                            Ux4gSlider(
                              value: 15,
                              onValueChange: null,
                              label: 'Error state',
                              caption: 'Value is out of budget!',
                              captionVariant: Ux4gSliderCaptionVariant.error,
                              showMarksAndValues: true,
                              steps: 2,
                            ),
                            const SizedBox(height: 16),
                            Ux4gSlider(
                              value: 85,
                              onValueChange: null,
                              label: 'Warning state',
                              caption: 'High priority task',
                              captionVariant: Ux4gSliderCaptionVariant.warning,
                              showMarksAndValues: true,
                              steps: 2,
                            ),
                            const SizedBox(height: 16),
                            Ux4gSlider(
                              value: 100,
                              onValueChange: null,
                              label: 'Success state',
                              caption: 'Target achieved!',
                              captionVariant: Ux4gSliderCaptionVariant.success,
                              showMarksAndValues: true,
                              steps: 2,
                            ),
                          ],
                        ),
                      ),

                      // ─── 24. Interactive Toast ────────────────────────
                      _showcaseCard(
                        title: 'Interactive Toasts',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Position: ${_toastAtTop ? "Top" : "Bottom"}',
                              style: typography.bS_default,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () =>
                                  setState(() => _toastAtTop = !_toastAtTop),
                              text: 'Toggle Toast Position',
                              backgroundColor: Ux4gPalette.gray800,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => _toastHostState.showToast(
                                      category: Ux4gToastCategory.success,
                                      title: 'Success!',
                                      subtitle:
                                          'Operation completed successfully.',
                                      autoClose: true,
                                      duration: const Duration(seconds: 2),
                                    ),
                                    text: 'Success',
                                    backgroundColor: Ux4gPalette.green500,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => _toastHostState.showToast(
                                      category: Ux4gToastCategory.error,
                                      title: 'Error',
                                      subtitle: 'Something went wrong.',
                                      autoClose: true,
                                      duration: const Duration(seconds: 2),
                                    ),
                                    text: 'Error',
                                    backgroundColor: Ux4gPalette.red500,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => _toastHostState.showToast(
                                      category: Ux4gToastCategory.warning,
                                      title: 'Warning',
                                      subtitle: 'Please check your input.',
                                      autoClose: true,
                                      duration: const Duration(seconds: 2),
                                    ),
                                    text: 'Warning',
                                    backgroundColor: Ux4gPalette.gold600,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => _toastHostState.showToast(
                                      category: Ux4gToastCategory.info,
                                      title: 'Info',
                                      subtitle: 'New update available.',
                                      autoClose: true,
                                      duration: const Duration(seconds: 2),
                                    ),
                                    text: 'Info',
                                    backgroundColor: Ux4gPalette.cyan600,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── 25. Static Toast Varieties ───────────────────
                      _showcaseCard(
                        title: 'Toast Varieties',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Full Layout (Tablet/Desktop)',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.info,
                              title: 'Info',
                              subtitle: 'Write your information text here',
                              actionText: 'Action',
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.success,
                              title: 'Success',
                              subtitle: 'Write your success text here',
                              actionText: 'Action',
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.warning,
                              title: 'Warning',
                              subtitle: 'Write your warning text here',
                              actionText: 'Action',
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.error,
                              title: 'Error',
                              subtitle: 'Write your error text here',
                              actionText: 'Action',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Stacked Layout (Mobile)',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.info,
                              title: 'Info',
                              subtitle: 'Write your information text here',
                              actionText: 'Action',
                              layout: Ux4gToastLayout.stacked,
                            ),
                            const SizedBox(height: 8),
                            Ux4gToast(
                              category: Ux4gToastCategory.warning,
                              title: 'Warning',
                              subtitle: 'Write your warning text here',
                              actionText: 'Action',
                              layout: Ux4gToastLayout.stacked,
                            ),
                          ],
                        ),
                      ),

                      // ─── 26. Stepper ──────────────────────────────────
                      _showcaseCard(
                        title: 'Stepper Component',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Horizontal Stepper',
                              style: typography.lM_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gStepper(
                              totalSteps: 4,
                              currentStep: _currentStep,
                              orientation: StepperOrientation.horizontal,
                              steps: [
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Vertical Stepper',
                              style: typography.lM_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gStepper(
                              totalSteps: 4,
                              currentStep: _currentStep,
                              orientation: StepperOrientation.vertical,
                              steps: [
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                                Ux4gStepItem(
                                  title: 'Label',
                                  description: 'Write description here',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: _currentStep > 1
                                        ? () => setState(() => _currentStep--)
                                        : null,
                                    text: 'Previous',
                                    enabled: _currentStep > 1,
                                    backgroundColor: Ux4gPalette.gray800,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: _currentStep < 4
                                        ? () => setState(() => _currentStep++)
                                        : null,
                                    text: 'Next',
                                    enabled: _currentStep < 4,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Ux4gDivider(),
                            const SizedBox(height: 16),
                            Text(
                              'Stepper with Error State',
                              style: typography.lM_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gStepper(
                              totalSteps: 4,
                              currentStep: 3,
                              orientation: StepperOrientation.horizontal,
                              steps: [
                                Ux4gStepItem(
                                  title: 'Account',
                                  description: 'Completed',
                                ),
                                Ux4gStepItem(
                                  title: 'Profile',
                                  description: 'Completed',
                                ),
                                Ux4gStepItem(
                                  title: 'Payment',
                                  description: 'Transaction failed',
                                  isError: true,
                                ),
                                Ux4gStepItem(
                                  title: 'Done',
                                  description: 'Pending',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── 27. Pagination ───────────────────────────────
                      _showcaseCard(
                        title: 'Pagination Indicators',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Default', style: typography.lM_strong),
                            const SizedBox(height: 8),
                            Center(
                              child: Ux4gPaginationIndicator(
                                totalPageCount: 7,
                                currentPageIndex: _pageIndex,
                                onPageChange: (v) =>
                                    setState(() => _pageIndex = v),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text('Capsule', style: typography.lM_strong),
                            const SizedBox(height: 8),
                            Center(
                              child: Ux4gPaginationIndicator(
                                totalPageCount: 7,
                                currentPageIndex: _pageIndex,
                                onPageChange: (v) =>
                                    setState(() => _pageIndex = v),
                                variant: Ux4gPaginationVariant.capsule,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Dots Only (no arrows)',
                              style: typography.lM_strong,
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Ux4gPaginationIndicator(
                                totalPageCount: 7,
                                currentPageIndex: _pageIndex,
                                onPageChange: (v) =>
                                    setState(() => _pageIndex = v),
                                showArrows: false,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── 28. Bottom Sheets ────────────────────────────
                      _showcaseCard(
                        title: 'Bottom Sheets',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            Ux4gButton(
                              onPressed: () => Ux4gBottomSheet.show(
                                context,
                                title: 'Simple Sheet',
                                content: const Text(
                                  'This is a simple bottom sheet with just a title and body content. It automatically adjusts its height to fit the content.',
                                ),
                              ),
                              text: 'Open Basic Bottom Sheet',
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => Ux4gBottomSheet.show(
                                context,
                                title: 'Header',
                                subtitle: 'Subtle text',
                                icon: Icons.info_outline,
                                description: 'Write description here',
                                footerType:
                                    Ux4gCardFooterType.primaryAndSecondary,
                                footerAlignment:
                                    Ux4gBottomSheetFooterAlignment.justified,
                                primaryButtonText: 'Action',
                                secondaryButtonText: 'Cancel',
                                content: const Text(
                                  'A Drawer is a panel that slides out from the edge of the screen to show extra information or options. It follows the same footer structure as the Card component.',
                                ),
                              ),
                              text: 'Open Full Bottom Sheet (Justified)',
                              backgroundColor: Ux4gPalette.primary700,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => Ux4gBottomSheet.show(
                                context,
                                title: 'Non-Draggable Sheet',
                                isDraggable: false,
                                description:
                                    'The drag handle is hidden and swipe gestures are handled by the system (usually minimal interaction).',
                                content: const Text(
                                  "This sheet has the 'isDraggable' property set to false.",
                                ),
                              ),
                              text: 'Open Non-Draggable Sheet',
                              backgroundColor: Ux4gPalette.gray800,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => Ux4gBottomSheet.show(
                                context,
                                title: 'Complex Settings',
                                description:
                                    'You can add any custom UI inside this central area.',
                                footerType: Ux4gCardFooterType.primaryOnly,
                                primaryButtonText: 'Apply Settings',
                                content: Column(
                                  children: [
                                    Text(
                                      'Pick your notification types:',
                                      style: typography.tS_strong,
                                    ),
                                    Ux4gCheckbox(
                                      value: true,
                                      onChanged: (_) {},
                                      label: 'Email',
                                    ),
                                    Ux4gCheckbox(
                                      value: false,
                                      onChanged: (_) {},
                                      label: 'Push',
                                    ),
                                    const SizedBox(height: 8),
                                    const Ux4gDivider(),
                                    const SizedBox(height: 8),
                                    Ux4gSlider(
                                      value: 75,
                                      onValueChange: (_) {},
                                      showMarksAndValues: true,
                                      steps: 4,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Notice how the sheet automatically expands to fit these custom components.',
                                      style: typography.bS_default.copyWith(
                                        color: colors.onSurface.withValues(
                                          alpha: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              text: 'Open Custom Content Sheet',
                              backgroundColor: Ux4gPalette.green700,
                              contentColor: Ux4gPalette.white,
                            ),
                            const SizedBox(height: 8),
                            Ux4gButton(
                              onPressed: () => Ux4gBottomSheet.show(
                                context,
                                title: 'Scrollable Content',
                                description:
                                    'Header and footer stay fixed. Only middle scrolls.',
                                footerType:
                                    Ux4gCardFooterType.primaryAndSecondary,
                                footerAlignment:
                                    Ux4gBottomSheetFooterAlignment.justified,
                                primaryButtonText: 'Got it',
                                secondaryButtonText: 'Cancel',
                                content: Column(
                                  children: List.generate(
                                    20,
                                    (i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        'Item #$i: This long text demonstrates that even when the content grows beyond the screen height, only the inner body remains scrollable while the top header and bottom buttons stay pinned.',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              text: 'Open Long Content Sheet',
                              backgroundColor: Ux4gPalette.cyan600,
                              contentColor: Ux4gPalette.white,
                            ),
                          ],
                        ),
                      ),

                      // ─── 29. Capsule Stepper ──────────────────────────
                      _showcaseCard(
                        title: 'Capsule (Compact) Stepper',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Layout: Linear (Default)',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCapsuleStepper(
                              totalSteps: 12,
                              currentStep: _capsuleStep,
                              stepLabel: 'Account Setup',
                              description:
                                  'Enter your personal details to continue.',
                              layout: Ux4gCapsuleStepperLayout.linear,
                              onNext: _capsuleStep < 12
                                  ? () => setState(() => _capsuleStep++)
                                  : () {},
                              onPrevious: _capsuleStep > 1
                                  ? () => setState(() => _capsuleStep--)
                                  : () {},
                            ),
                            const SizedBox(height: 16),
                            const Ux4gDivider(),
                            const SizedBox(height: 16),
                            Text(
                              'Layout: Right Aligned',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCapsuleStepper(
                              totalSteps: 12,
                              currentStep: _capsuleStep,
                              stepLabel: 'Finalize Profile',
                              description:
                                  'Uploading your bio and other settings.',
                              layout: Ux4gCapsuleStepperLayout.rightAligned,
                              onNext: _capsuleStep < 12
                                  ? () => setState(() => _capsuleStep++)
                                  : () {},
                              onPrevious: _capsuleStep > 1
                                  ? () => setState(() => _capsuleStep--)
                                  : () {},
                            ),
                            const SizedBox(height: 16),
                            const Ux4gDivider(),
                            const SizedBox(height: 16),
                            Text(
                              'Layout: Centered',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 8),
                            Ux4gCapsuleStepper(
                              totalSteps: 12,
                              currentStep: _capsuleStep,
                              stepLabel: 'Payment Methods',
                              description:
                                  'Review your cards and billing address.',
                              layout: Ux4gCapsuleStepperLayout.centered,
                              onNext: _capsuleStep < 12
                                  ? () => setState(() => _capsuleStep++)
                                  : () {},
                              onPrevious: _capsuleStep > 1
                                  ? () => setState(() => _capsuleStep--)
                                  : () {},
                            ),
                            const SizedBox(height: 16),
                            const Ux4gDivider(),
                            const SizedBox(height: 16),
                            Text('Layout: Split', style: typography.lS_strong),
                            const SizedBox(height: 8),
                            Ux4gCapsuleStepper(
                              totalSteps: 12,
                              currentStep: _capsuleStep,
                              stepLabel: 'Confirmation',
                              description:
                                  'Almost done. Just one more click to finish your setup and start using the platform.',
                              layout: Ux4gCapsuleStepperLayout.split,
                              onNext: _capsuleStep < 12
                                  ? () => setState(() => _capsuleStep++)
                                  : () {},
                              onPrevious: _capsuleStep > 1
                                  ? () => setState(() => _capsuleStep--)
                                  : () {},
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),

                // ── Toast overlay ───────────────────────────────────────
                Positioned(
                  top: _toastAtTop ? 0 : null,
                  bottom: _toastAtTop ? null : 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Ux4gToastHost(
                      hostState: _toastHostState,
                      isBottom: !_toastAtTop,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showModal(BuildContext context, Ux4gModal modal) {
    Ux4gModal.show(context, modal: modal);
  }

  Widget _sectionTitle(
    String text,
    Ux4gTypography typography,
    Ux4gColors colors,
  ) {
    return Text(
      text,
      style: typography.tS_strong.copyWith(color: colors.onBackground),
    );
  }

  Widget _showcaseCard({
    required String title,
    required Ux4gTypography typography,
    required Ux4gColors colors,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Ux4gCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: typography.tS_strong.copyWith(
                  color: colors.onBackground,
                ),
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
