import 'dart:math' as math;
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

  // Accordion
  int? _expandedAccordionIndex = 2;

  // Chips
  int _selectedChoiceChip = 0;
  final Set<int> _selectedFilterChips = {0, 2};

  // TextArea
  String _textAreaVal = '';

  // Linear Progress
  double _progressValue = 0.0;
  double _circularProgressValue = 0.5;

  // Social Links
  SocialMediaIcon _selectedSocialIcon = SocialMediaIcon.github;
  Color _selectedTintColor = Ux4gPalette.primary500;

  // File Upload
  List<UploadedFile> _uploadedFiles = [];


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
                        title: 'Accordion',
                        typography: typography,
                        colors: colors,
                        child: Ux4gAccordionGroup(
                          items: const [
                            Ux4gAccordionItem(title: 'Accordion Item'),
                            Ux4gAccordionItem(title: 'Accordion Item'),
                            Ux4gAccordionItem(title: 'Accordion Item'),
                            Ux4gAccordionItem(title: 'Accordion Item'),
                            Ux4gAccordionItem(
                              title: 'Accordion Item',
                              enabled: false,
                            ),
                          ],
                          expandedIndex: _expandedAccordionIndex,
                          onExpandedIndexChange: (value) {
                            setState(() => _expandedAccordionIndex = value);
                          },
                          contentBuilder: (index, item) {
                            if (index != 2) {
                              return const SizedBox.shrink();
                            }

                            return Text(
                              'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development. Its purpose is to permit a page layout to be designed, independently of the copy that will subsequently populate it.',
                              style: typography.bXS_default.copyWith(
                                color: Ux4gPalette.neutral500,
                              ),
                            );
                          },
                        ),
                      ),

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

                      // ─── Carousel Showcase ─────────────────────────
                      _showcaseCard(
                        title: 'Carousel (Image Slider)',
                        typography: typography,
                        colors: colors,
                        child: Ux4gCarousel(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          height: 250,
                          items: List.generate(4, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Slide ${index + 1}',
                                    style: typography.hM_strong,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '(Replace with desired banner content)',
                                    style: typography.lS_default.copyWith(
                                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),

                      // ─── Date Picker Showcase ────────────────────────
                      _showcaseCard(
                        title: 'Date Picker',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Single Date Selection',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 8),
                            Ux4gDatePicker(
                              mode: Ux4gDatePickerMode.single,
                              placeholder: 'Select DOB',
                              maxDate: DateTime.now(), // Prevent future DOB
                              onDateSelected: (date) {
                                print('Selected Date: $date');
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Date Range Selection',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 8),
                            Ux4gDatePicker(
                              mode: Ux4gDatePickerMode.range,
                              placeholder: 'Select range',
                              onDateRangeSelected: (range) {
                                print('Selected Range: ${range.start} to ${range.end}');
                              },
                            ),
                          ],
                        ),
                      ),

                      // ─── Time Picker Showcase ────────────────────────
                      _showcaseCard(
                        title: 'Time Picker',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Standard Time Picker',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 8),
                            Ux4gTimePicker(
                              placeholder: 'Select time',
                              onTimeSelected: (time) {
                                print('Selected Time: $time');
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '5-Minute Interval',
                              style: typography.lM_default,
                            ),
                            const SizedBox(height: 8),
                            Ux4gTimePicker(
                              placeholder: 'Select time (5m intervals)',
                              minuteInterval: 5,
                              onTimeSelected: (time) {
                                print('Selected Time (Interval): $time');
                              },
                            ),
                          ],
                        ),
                      ),
                      // ─── Status Banners Showcase ─────────────────────
                      _showcaseCard(
                        title: 'Status Banners (Top Snackbars)',
                        typography: typography,
                        colors: colors,
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            Ux4gButton(
                              text: 'Show Complex Warning',
                              variant: Ux4gButtonVariant.primary,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.warningLight,
                                  leadingIcon: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5B4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.inventory_2_outlined, color: Color(0xFFF58220), size: 16),
                                  ),
                                  title: 'Income Certificate Application',
                                  subtitle: 'Last saved: 10 Apr 2026',
                                  badge: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5B4),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Step 3 of 5 Document Upload',
                                      style: typography.lM_default.copyWith(color: const Color(0xFFF58220), fontSize: 12),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Ux4gBannerManager.hide(),
                                      child: Text('Discard', style: typography.bM_strong.copyWith(color: const Color(0xFFC41D7F))),
                                    ),
                                    Ux4gButton(
                                      text: 'Resume',
                                      variant: Ux4gButtonVariant.primary,
                                      onPressed: () => Ux4gBannerManager.hide(),
                                    ),
                                  ],
                                  autoDismiss: false,
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Simple Warning',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.warningLight,
                                  leadingIcon: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5B4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.inventory_2_outlined, color: Color(0xFFF58220), size: 16),
                                  ),
                                  title: 'Your draft expires in 5 days',
                                  badge: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFE5B4),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '16 Apr',
                                      style: typography.lM_default.copyWith(color: const Color(0xFFF58220), fontSize: 12),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Solid Warning',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.warningSolid,
                                  leadingIcon: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.inventory_2_outlined, color: Color(0xFFF58220), size: 16),
                                  ),
                                  title: 'Your draft expires tomorrow. Submit today',
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Error',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.errorLight,
                                  leadingIcon: const Icon(Icons.error_outline, color: Color(0xFFFF4D4F), size: 24),
                                  title: 'Draft expired on 9 April 2026',
                                  actions: [
                                    TextButton(
                                      onPressed: () => Ux4gBannerManager.hide(),
                                      child: Text('Action', style: typography.bM_strong.copyWith(color: const Color(0xFFA8071A))),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Saving',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.savingLight,
                                  title: '',
                                  trailingIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF722ED1)),
                                      ),
                                      const SizedBox(width: 8),
                                      Text('Saving', style: typography.bM_default.copyWith(color: Ux4gPalette.neutral500)),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Success (Right Icon)',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.successLight,
                                  title: '',
                                  trailingIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle_outline, color: Color(0xFF52C41A), size: 20),
                                      const SizedBox(width: 8),
                                      Text('Saved 3:14 PM', style: typography.bM_default.copyWith(color: Ux4gPalette.gray900)),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Ux4gButton(
                              text: 'Show Success (Left Icon)',
                              variant: Ux4gButtonVariant.outline,
                              onPressed: () {
                                Ux4gBannerManager.show(
                                  context,
                                  variant: Ux4gBannerVariant.successLight,
                                  leadingIcon: const Icon(Icons.check_circle_outline, color: Color(0xFF52C41A), size: 24),
                                  title: 'Draft saved successfully at 3:14 PM',
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // ─── Feedback Form Showcase ───────────────────────
                      _showcaseCard(
                        title: 'Feedback Form',
                        typography: typography,
                        colors: colors,
                        child: Center(
                          child: Ux4gFeedbackForm(
                            improvementOptions: const ['Content accuracy', 'Visual design', 'Performance', 'Navigation'],
                            minWords: 0,
                            maxLength: 200,
                            onSubmit: (rating, chip, comment) {
                              print('Feedback Submitted: Rating: $rating, Chip: $chip, Comment: $comment');
                            },
                            onSkip: () {
                              print('Feedback Skipped');
                            },
                          ),
                        ),
                      ),

                      // ─── NPS Feedback Form Showcase ───────────────────
                      _showcaseCard(
                        title: 'NPS Feedback Form',
                        typography: typography,
                        colors: colors,
                        child: Center(
                          child: Ux4gFeedbackFormNps(
                            onSubmit: (score, comment) {
                              print('NPS Submitted: Score: $score, Comment: $comment');
                            },
                            onSkip: () {
                              print('NPS Skipped');
                            },
                          ),
                        ),
                      ),

                      // ─── CSAT Feedback Form Showcase ──────────────────
                      _showcaseCard(
                        title: 'CSAT Feedback Form',
                        typography: typography,
                        colors: colors,
                        child: Center(
                          child: Ux4gFeedbackFormCsat(
                            onSubmit: (score, comment) {
                              print('CSAT Submitted: Score: $score, Comment: $comment');
                            },
                            onSkip: () {
                              print('CSAT Skipped');
                            },
                          ),
                        ),
                      ),

                      // ─── Result Rows Showcase ──────────────────────
                      _showcaseCard(
                        title: 'Result Rows (Search / Status)',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          children: [
                            // 1. Under Review Variant
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              statusTag: 'Under review',
                              tagColorScheme: Ux4gTagColor.warning,
                              actionButtonText: 'Track',
                              details: const [
                                Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04127'),
                                Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                                Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                                Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                              ],
                            ),

                            // 2. Download Variant
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              actionButtonText: 'Download',
                              actionButtonIcon: Icons.file_download_outlined,
                              details: const [
                                Ux4gResultDetail(label: 'Issued', value: '05 Apr 2026'),
                                Ux4gResultDetail(label: 'Valid till', value: '05 Apr 2027'),
                                Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04127'),
                                Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                                Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                                Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                              ],
                            ),

                            // 3. Metadata Variant (Paid)
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              metadataSegments: const [
                                Ux4gPillSegment(text: 'Paid', bold: true),
                                Ux4gPillSegment(text: '₹ 120/-'),
                                Ux4gPillSegment(text: '20 mins', leading: Icon(Icons.access_time, size: 12)),
                              ],
                              actionButtonText: 'Apply',
                              details: const [
                                Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04127'),
                                Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                                Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                                Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                              ],
                            ),

                            // 4. Escalated / Overdue Variant
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              statusTag: 'Escalated',
                              tagColorScheme: Ux4gTagColor.error,
                              actionButtonText: 'Track',
                              details: const [
                                Ux4gResultDetail(label: 'Reference Number', value: 'GRV-2026-04127'),
                                Ux4gResultDetail(
                                  label: 'SLA Status',
                                  value: 'SLA 3 days overdue',
                                  icon: Icons.priority_high,
                                  valueColor: Ux4gPalette.orange700,
                                  isBold: true,
                                ),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                                Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                                Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                              ],
                            ),

                            // 5. Receipt Variant
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              statusTag: 'Paid',
                              tagColorScheme: Ux4gTagColor.success,
                              actionButtonText: 'Receipt',
                              actionButtonIcon: Icons.receipt_long_outlined,
                              detailsColumns: 2,
                              showBottomDivider: false,
                              details: const [
                                Ux4gResultDetail(label: 'Amount paid', value: '₹400/-', isBold: true),
                                Ux4gResultDetail(label: 'Paid on', value: '12 Apr 2026'),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                                Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                                Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                              ],
                            ),

                            // 6. Explicit 2-Column & Custom Color Variant
                            Ux4gResultRow(
                              title: 'Income Certificate',
                              statusTag: 'Paid',
                              tagColorScheme: Ux4gTagColor.success,
                              actionButtonText: 'Download',
                              actionButtonIcon: Icons.download,
                              actionButtonColor: Ux4gPalette.blue700, // Custom Blue Button
                              detailsColumns: 2, // Explicitly 2 columns
                              showBottomDivider: false,
                              details: const [
                                Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04127'),
                                Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                                Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                                Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── Divider Showcase ─────────────────────────
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
                              runSpacing: 8,
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
                              runSpacing: 8,
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
                              runSpacing: 8,
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

                      // --- 24. Linear Progress ---
                      _showcaseCard(
                        title: 'Linear Progress Indicator',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Interactive Demo',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            Ux4gAnimatedLinearProgress(
                              value: _progressValue,
                              icon: Icons.rocket_launch_outlined,
                              iconColor: const Color(0xFF6A4EFF),
                              iconBackgroundColor: const Color(
                                0xFF6A4EFF,
                              ).withValues(alpha: 0.12),
                              label: 'Upload Progress',
                              height: 12,
                              shape: Ux4gProgressShape.rounded,
                              gradientColors: const [
                                Color(0xFF6A4EFF),
                                Color(0xFF9B59B6),
                              ],
                              showPercentage: true,
                              labelPosition: Ux4gProgressLabelPosition.outside,
                              duration: const Duration(milliseconds: 800),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () =>
                                        setState(() => _progressValue = 0.0),
                                    text: 'Reset',
                                    variant: Ux4gButtonVariant.outline,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: _progressValue >= 1.0
                                        ? null
                                        : () => setState(
                                            () => _progressValue =
                                                (_progressValue + 0.1).clamp(
                                                  0.0,
                                                  1.0,
                                                ),
                                          ),
                                    text: '+10%',
                                    enabled: _progressValue < 1.0,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () =>
                                        setState(() => _progressValue = 1.0),
                                    text: 'Complete',
                                    backgroundColor: Ux4gPalette.green600,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'With Icon, Label & Gradient',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            Ux4gLinearProgress(
                              value: 0.55,
                              icon: Icons.cloud_upload_outlined,
                              iconColor: const Color(0xFF6A4EFF),
                              iconBackgroundColor: const Color(
                                0xFF6A4EFF,
                              ).withValues(alpha: 0.12),
                              label: 'Label',
                              hint: 'Hint',
                              height: 10,
                              shape: Ux4gProgressShape.rounded,
                              gradientColors: const [
                                Color(0xFF6A4EFF),
                                Color(0xFF9B59B6),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Ux4gLinearProgress(
                              value: 0.45,
                              icon: Icons.bolt_outlined,
                              iconColor: const Color(0xFFF39C12),
                              iconBackgroundColor: const Color(
                                0xFFF39C12,
                              ).withValues(alpha: 0.12),
                              label: 'Label',
                              hint: 'Hint',
                              height: 10,
                              shape: Ux4gProgressShape.rounded,
                              gradientColors: const [
                                Color(0xFFFFAE00),
                                Color(0xFFFF5F00),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Ux4gLinearProgress(
                              value: 0.35,
                              icon: Icons.warning_amber_rounded,
                              iconColor: const Color(0xFFE74C3C),
                              iconBackgroundColor: const Color(
                                0xFFE74C3C,
                              ).withValues(alpha: 0.12),
                              label: 'Label',
                              hint: 'Hint',
                              height: 10,
                              shape: Ux4gProgressShape.rounded,
                              gradientColors: const [
                                Color(0xFFFFB3AE),
                                Color(0xFFE74C3C),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Ux4gLinearProgress(
                              value: 0.6,
                              icon: Icons.check_circle_outline,
                              iconColor: const Color(0xFF27AE60),
                              iconBackgroundColor: const Color(
                                0xFF27AE60,
                              ).withValues(alpha: 0.12),
                              label: 'Label',
                              hint: 'Hint',
                              height: 10,
                              shape: Ux4gProgressShape.rounded,
                              gradientColors: const [
                                Color(0xFF90EE90),
                                Color(0xFF27AE60),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Sharp vs Rounded',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sharp',
                                        style: typography.lS_default.copyWith(
                                          color: Ux4gPalette.neutral500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Ux4gLinearProgress(
                                        value: 0.65,
                                        height: 12,
                                        shape: Ux4gProgressShape.sharp,
                                        color: Ux4gPalette.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rounded',
                                        style: typography.lS_default.copyWith(
                                          color: Ux4gPalette.neutral500,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Ux4gLinearProgress(
                                        value: 0.65,
                                        height: 12,
                                        shape: Ux4gProgressShape.rounded,
                                        color: Ux4gPalette.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Label Outside vs Inside',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: List.generate(5, (i) {
                                final val = (i + 1) * 0.2;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Ux4gLinearProgress(
                                          value: val,
                                          height: 16,
                                          shape: Ux4gProgressShape.sharp,
                                          color: Ux4gPalette.primary,
                                          showPercentage: true,
                                          labelPosition:
                                              Ux4gProgressLabelPosition.outside,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Ux4gLinearProgress(
                                          value: val,
                                          height: 16,
                                          shape: Ux4gProgressShape.rounded,
                                          color: Ux4gPalette.primary,
                                          showPercentage: true,
                                          labelPosition:
                                              Ux4gProgressLabelPosition.outside,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Ux4gLinearProgress(
                                          value: val,
                                          height: 16,
                                          shape: Ux4gProgressShape.sharp,
                                          color: Ux4gPalette.primary,
                                          showPercentage: true,
                                          labelPosition:
                                              Ux4gProgressLabelPosition.inside,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Ux4gLinearProgress(
                                          value: val,
                                          height: 16,
                                          shape: Ux4gProgressShape.rounded,
                                          color: Ux4gPalette.primary,
                                          showPercentage: true,
                                          labelPosition:
                                              Ux4gProgressLabelPosition.inside,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      // ─── 24. Interactive Toast ────────────────────────
                      _showcaseCard(
                        title: 'Circular Progress Indicator',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Interactive Demo',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            Center(
                              child: Ux4gAnimatedCircularProgress(
                                value: _circularProgressValue,
                                size: Ux4gCircularProgressSize.xxxl,
                                backgroundColor: Ux4gPalette.gray100,
                                progressGradient: SweepGradient(
                                  transform: GradientRotation(-math.pi / 2),
                                  colors: [
                                    Color(0xFFDCD4FF),
                                    Color(0xFF6A4EFF),
                                  ],
                                ),
                                centerValueText:
                                    '${(_circularProgressValue * 100).round()}%',
                                centerDescription: 'Description',
                                label:
                                    '${(_circularProgressValue * 100).round()}%',
                                description: 'Description',
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => setState(
                                      () => _circularProgressValue = 0.0,
                                    ),
                                    text: 'Reset',
                                    variant: Ux4gButtonVariant.outline,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: _circularProgressValue >= 1.0
                                        ? null
                                        : () => setState(
                                            () => _circularProgressValue =
                                                (_circularProgressValue + 0.1)
                                                    .clamp(0.0, 1.0),
                                          ),
                                    text: '+10%',
                                    enabled: _circularProgressValue < 1.0,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Ux4gButton(
                                    onPressed: () => setState(
                                      () => _circularProgressValue = 1.0,
                                    ),
                                    text: 'Complete',
                                    backgroundColor: Ux4gPalette.green600,
                                    contentColor: Ux4gPalette.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Responsive Size Matrix',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final compact = constraints.maxWidth < 780;
                                final items = [
                                  ('XS', Ux4gCircularProgressSize.xs, false),
                                  ('S', Ux4gCircularProgressSize.s, false),
                                  ('M', Ux4gCircularProgressSize.m, false),
                                  ('L', Ux4gCircularProgressSize.l, false),
                                  ('XL', Ux4gCircularProgressSize.xl, true),
                                  ('2XL', Ux4gCircularProgressSize.xxl, true),
                                  ('3XL', Ux4gCircularProgressSize.xxxl, true),
                                ];

                                return Wrap(
                                  spacing: compact ? 24 : 36,
                                  runSpacing: compact ? 28 : 40,
                                  children: items
                                      .map(
                                        (item) => SizedBox(
                                          width: compact ? 112 : 128,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                item.$1,
                                                style: typography.lM_strong,
                                              ),
                                              const SizedBox(height: 10),
                                              _circularProgressDemoItem(
                                                size: item.$2,
                                                inlineMeta: item.$3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Color Variants (Rounded)',
                              style: typography.lS_strong,
                            ),
                            const SizedBox(height: 12),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _circularColorVariant(
                                    colors: colors,
                                    typography: typography,
                                    progressColor: const Color(0xFF6A4EFF),
                                    gradient: const SweepGradient(
                                      transform: GradientRotation(-math.pi / 2),
                                      colors: [
                                        Color(0xFFDCD4FF),
                                        Color(0xFF6A4EFF),
                                      ],
                                    ),
                                    footerColor: const Color(0xFFEFEAFF),
                                    footerTextColor: const Color(0xFF6A4EFF),
                                  ),
                                  const SizedBox(width: 20),
                                  _circularColorVariant(
                                    colors: colors,
                                    typography: typography,
                                    progressColor: const Color(0xFFFFA827),
                                    gradient: const SweepGradient(
                                      transform: GradientRotation(-math.pi / 2),
                                      colors: [
                                        Color(0xFFFFF2D9),
                                        Color(0xFFFFA827),
                                      ],
                                    ),
                                    footerColor: const Color(0xFFFFF7E6),
                                    footerTextColor: const Color(0xFFFFA827),
                                  ),
                                  const SizedBox(width: 20),
                                  _circularColorVariant(
                                    colors: colors,
                                    typography: typography,
                                    progressColor: const Color(0xFFF55E57),
                                    descriptionColor: const Color(0xFFB3251E),
                                    gradient: const SweepGradient(
                                      transform: GradientRotation(-math.pi / 2),
                                      colors: [
                                        Color(0xFFFFECEE),
                                        Color(0xFFF55E57),
                                      ],
                                    ),
                                    footerColor: const Color(0xFFFFF0F0),
                                    footerTextColor: const Color(0xFFF55E57),
                                  ),
                                  const SizedBox(width: 20),
                                  _circularColorVariant(
                                    colors: colors,
                                    typography: typography,
                                    progressColor: const Color(0xFF1AA64A),
                                    gradient: const SweepGradient(
                                      transform: GradientRotation(-math.pi / 2),
                                      colors: [
                                        Color(0xFFDFF9E8),
                                        Color(0xFF1AA64A),
                                      ],
                                    ),
                                    footerColor: const Color(0xFFF2FCEF),
                                    footerTextColor: const Color(0xFF1AA64A),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── Status Pipeline ──────────────────────────
                      _showcaseCard(
                        title: 'Status Pipeline',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Vertical — Circles Only ──
                            Text(
                              'Vertical — Circles Only',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              showLabels: false,
                              showDescriptions: false,
                              steps: [
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            // ── Vertical — With Labels ──
                            Text(
                              'Vertical — With Labels',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              showDescriptions: false,
                              steps: [
                                Ux4gPipelineStep(label: 'Submitted'),
                                Ux4gPipelineStep(label: 'Verification'),
                                Ux4gPipelineStep(label: 'Inspection'),
                                Ux4gPipelineStep(label: 'Decision'),
                                Ux4gPipelineStep(label: 'Issued'),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            // ── Vertical — Labels + Descriptions ──
                            Text(
                              'Vertical — Labels + Descriptions',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'In progress',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Inspection',
                                  description: 'Est. 10 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Decision',
                                  description: 'Est. 18 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Issued',
                                  description: 'Est. 20 Apr',
                                ),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            // ── Vertical — With Error & Warning ──
                            Text(
                              'Vertical — Error & Warning States',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.m,
                              currentStep: -1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                  state: Ux4gPipelineStepState.completed,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'Failed',
                                  state: Ux4gPipelineStepState.error,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Inspection',
                                  description: 'Blocked',
                                  state: Ux4gPipelineStepState.warning,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Decision',
                                  state: Ux4gPipelineStepState.upcoming,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Issued',
                                  state: Ux4gPipelineStepState.upcoming,
                                ),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            // ── Vertical — Small Size ──
                            Text(
                              'Vertical — Small Size',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.s,
                              currentStep: 1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'In progress',
                                ),
                                Ux4gPipelineStep(label: 'Inspection'),
                                Ux4gPipelineStep(label: 'Decision'),
                                Ux4gPipelineStep(label: 'Issued'),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            // ── Vertical — Large Size ──
                            Text(
                              'Vertical — Large Size',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.vertical,
                              size: Ux4gPipelineSize.l,
                              currentStep: 2,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: '8 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Inspection',
                                  description: 'In progress',
                                ),
                                Ux4gPipelineStep(label: 'Decision'),
                                Ux4gPipelineStep(label: 'Issued'),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space32),

                            // ══════════════════════════════════════════════
                            // HORIZONTAL
                            // ══════════════════════════════════════════════
                            Text(
                              'Horizontal — Circles Only',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.horizontal,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              showLabels: false,
                              showDescriptions: false,
                              steps: [
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                                Ux4gPipelineStep(),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            Text(
                              'Horizontal — With Labels',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.horizontal,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              showDescriptions: false,
                              steps: [
                                Ux4gPipelineStep(label: 'Submitted'),
                                Ux4gPipelineStep(label: 'Verification'),
                                Ux4gPipelineStep(label: 'Inspection'),
                                Ux4gPipelineStep(label: 'Decision'),
                                Ux4gPipelineStep(label: 'Issued'),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            Text(
                              'Horizontal — Labels + Descriptions',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.horizontal,
                              size: Ux4gPipelineSize.m,
                              currentStep: 1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'In progress',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Inspection',
                                  description: 'Est. 10 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Decision',
                                  description: 'Est. 18 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Issued',
                                  description: 'Est. 20 Apr',
                                ),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            Text(
                              'Horizontal — Small Size',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.horizontal,
                              size: Ux4gPipelineSize.s,
                              currentStep: 1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'In progress',
                                ),
                                Ux4gPipelineStep(label: 'Inspection'),
                                Ux4gPipelineStep(label: 'Decision'),
                                Ux4gPipelineStep(label: 'Issued'),
                              ],
                            ),

                            const SizedBox(height: Ux4gSpace.space24),

                            Text(
                              'Horizontal — Error & Warning',
                              style: typography.bS_strong,
                            ),
                            const SizedBox(height: Ux4gSpace.space12),
                            const Ux4gStatusPipeline(
                              orientation: Ux4gPipelineOrientation.horizontal,
                              size: Ux4gPipelineSize.m,
                              currentStep: -1,
                              steps: [
                                Ux4gPipelineStep(
                                  label: 'Submitted',
                                  description: '5 Apr',
                                  state: Ux4gPipelineStepState.completed,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Verification',
                                  description: 'Failed',
                                  state: Ux4gPipelineStepState.error,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Inspection',
                                  state: Ux4gPipelineStepState.warning,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Decision',
                                  state: Ux4gPipelineStepState.upcoming,
                                ),
                                Ux4gPipelineStep(
                                  label: 'Issued',
                                  state: Ux4gPipelineStepState.upcoming,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── Journey Timeline ───────────────────────────
                      _showcaseCard(
                        title: 'Journey Timeline',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Vertical Timeline with header ──
                            Text(
                              'Vertical Timeline',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Ux4gJourneyTimeline(
                              header: const Ux4gJourneyHeader(
                                title: 'Title',
                                description: 'Description',
                                icon: Icons.settings_outlined,
                              ),
                              currentStep: 1,
                              steps: [
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // ── Card Variants ──
                            Text(
                              'Card Variants',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Ux4gJourneyTimeline(
                              currentStep: 4,
                              steps: [
                                // Simple
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                // With helping text
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                  helpingText: 'Helping Text',
                                ),
                                // With icon
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                  icon: Icons.link,
                                ),
                                // With status
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                  status: Ux4gJourneyStepStatus(
                                    text: '2 days remaining',
                                    dotColor: Ux4gPalette.secondary,
                                    badgeText: 'Pending',
                                    badgeColor: Ux4gPalette.secondary
                                        .withValues(alpha: 0.12),
                                    badgeTextColor: Ux4gPalette.secondary,
                                  ),
                                ),
                                // Upcoming (gray)
                                const Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),

                            // ── Horizontal Timeline ──
                            Text(
                              'Horizontal Timeline',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Ux4gJourneyTimeline(
                              orientation: Ux4gJourneyOrientation.horizontal,
                              header: const Ux4gJourneyHeader(
                                title: 'Title',
                                description: 'Description',
                                icon: Icons.settings_outlined,
                              ),
                              currentStep: 1,
                              steps: const [
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                                Ux4gJourneyStep(
                                  title: 'Title',
                                  date: 'Date',
                                  tag: 'Tag',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ─── App Header ─────────────────────────────────
                      _showcaseCard(
                        title: 'App Header',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Default: Emblem + Logo + Title + Settings + Avatar ──
                            Text(
                              'With Leading Icons + Avatar',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    leadingWidgets: [
                                      Icon(
                                        Icons.account_balance,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.onSurface,
                                      ),
                                      Icon(
                                        Icons.waves,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.primary,
                                      ),
                                    ],
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                    showAvatar: true,
                                    avatarSize: Ux4gAvatarSize.s,
                                    avatarImageUrl:
                                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Emblem + Logo + Title + Settings + Hamburger ──
                            Text(
                              'With Leading Icons + Hamburger Menu',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    leadingWidgets: [
                                      Icon(
                                        Icons.account_balance,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.onSurface,
                                      ),
                                      Icon(
                                        Icons.waves,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.primary,
                                      ),
                                    ],
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                      Ux4gAppHeaderAction(
                                        icon: Icons.menu,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Back + Title (simple) ──
                            Text(
                              'Back + Title Only',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    showBackButton: true,
                                    onBackPressed: () {},
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Back + Title + 1 Action ──
                            Text(
                              'Back + Title + Action',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    showBackButton: true,
                                    onBackPressed: () {},
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Back + Title + 2 Actions ──
                            Text(
                              'Back + Title + 2 Actions',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    showBackButton: true,
                                    onBackPressed: () {},
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Back + Title + 3 Actions ──
                            Text(
                              'Back + Title + 3 Actions',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    showBackButton: true,
                                    onBackPressed: () {},
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── With Status Avatar ──
                            Text(
                              'With Status Avatar',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    leadingWidgets: [
                                      Icon(
                                        Icons.account_balance,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.onSurface,
                                      ),
                                      Icon(
                                        Icons.waves,
                                        size: 24,
                                        color: v == Ux4gAppHeaderVariant.filled
                                            ? colors.onPrimary
                                            : colors.primary,
                                      ),
                                    ],
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                    avatar: Ux4gStatusAvatar(
                                      size: Ux4gAvatarSize.s,
                                      imageUrl:
                                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
                                      variant: Ux4gStatusVariant.online,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ── Back + Title + Status Avatar ──
                            Text(
                              'Back + Title + Status Avatar',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...[
                              Ux4gAppHeaderVariant.light,
                              Ux4gAppHeaderVariant.filled,
                              Ux4gAppHeaderVariant.outlined,
                            ].map(
                              (v) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ux4gAppHeader(
                                    title: 'Title',
                                    variant: v,
                                    showBackButton: true,
                                    onBackPressed: () {},
                                    actions: [
                                      Ux4gAppHeaderAction(
                                        icon: Icons.settings_outlined,
                                        onPressed: () {},
                                      ),
                                    ],
                                    avatar: Ux4gStatusAvatar(
                                      size: Ux4gAvatarSize.s,
                                      initials: 'JD',
                                      variant: Ux4gStatusVariant.busy,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ─── Half Circle Progress Indicator ─────────────
                      _showcaseCard(
                        title: 'Half Circle Progress Indicator',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Without Scale ──
                            Text(
                              'Without Scale',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.s,
                                  description: 'Description',
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.m,
                                  description: 'Description',
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.l,
                                  description: 'Description',
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.xl,
                                  description: 'Description',
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // ── With Scale ──
                            Text(
                              'With Scale',
                              style: typography.bS_strong.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.s,
                                  description: 'Description',
                                  showScale: true,
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.m,
                                  description: 'Description',
                                  showScale: true,
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.l,
                                  description: 'Description',
                                  showScale: true,
                                ),
                                Ux4gHalfCircleProgress(
                                  value: 0.5,
                                  size: Ux4gHalfCircleProgressSize.xl,
                                  description: 'Description',
                                  showScale: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

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

                      // ─── Biometric Verification ─────────────────────
                      _showcaseCard(
                        title: 'Biometric Verification',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Face capture + liveness detection + UIDAI verification flow',
                              style: typography.bS_default.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: Ux4gButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const BiometricShowcasePage(mockSuccess: true),
                                    ),
                                  );
                                },
                                text: 'Simulate Success Flow',
                                leadingIcon: Icons.check_circle_outline,
                                backgroundColor: Ux4gPalette.green,
                                contentColor: Ux4gPalette.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: Ux4gButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const BiometricShowcasePage(mockSuccess: false),
                                    ),
                                  );
                                },
                                text: 'Simulate Failure Flow',
                                leadingIcon: Icons.error_outline,
                                backgroundColor: Ux4gPalette.red,
                                contentColor: Ux4gPalette.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ─── Empty State ──────────────────────────────────
                      _sectionTitle('Empty State', typography, colors),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // No results found
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.12),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Ux4gEmptyState(
                              variant: Ux4gEmptyStateVariant.noResults,
                              title: 'No results found',
                              subtitle: 'Did you mean:',
                              description: 'Driving License, Ration Card',
                              buttonText: 'Clear all filters',
                              onButtonPressed: () {},
                            ),
                          ),

                          const SizedBox(height: 16),

                          // No active applications
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.12),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Ux4gEmptyState(
                              variant: Ux4gEmptyStateVariant.noData,
                              title: 'No active applications',
                              subtitle: 'Start your application easily',
                              description: 'by clicking on the button below.',
                              buttonText: 'Start application',
                              onButtonPressed: () {},
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Coming soon
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.12),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Ux4gEmptyState(
                              variant: Ux4gEmptyStateVariant.comingSoon,
                              title: 'Coming soon',
                              subtitle: 'This feature is under development.',
                              buttonText: 'Go Back',
                              onButtonPressed: () {},
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Could not load data
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.12),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Ux4gEmptyState(
                              variant: Ux4gEmptyStateVariant.error,
                              title: 'Could not load data',
                              subtitle: 'Last updated: 4 minutes ago',
                              buttonText: 'Refresh',
                              onButtonPressed: () {},
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Custom variant
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.onSurface.withValues(alpha: 0.12),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Ux4gEmptyState(
                              variant: Ux4gEmptyStateVariant.custom,
                              icon: Icons.lock_outline_rounded,
                              iconColor: Ux4gPalette.secondary,
                              title: 'Access restricted',
                              subtitle: 'You do not have permission to view this content.',
                              description: 'Please contact your administrator.',
                              buttonText: 'Request access',
                              onButtonPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // ─── Social Links ─────────────────────────────────
                      _sectionTitle('Social Links', typography, colors),
                      const SizedBox(height: 12),

                      _showcaseCard(
                        title: 'Icon Variants - Original White',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Face capture + liveness detection + UIDAI verification flow',
                              style: typography.bS_default.copyWith(
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: Ux4gButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const BiometricShowcasePage(mockSuccess: true),
                                    ),
                                  );
                                },
                                text: 'Simulate Success Flow',
                                leadingIcon: Icons.check_circle_outline,
                                backgroundColor: Ux4gPalette.green,
                                contentColor: Ux4gPalette.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: Ux4gButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const BiometricShowcasePage(mockSuccess: false),
                                    ),
                                  );
                                },
                                text: 'Simulate Failure Flow',
                                leadingIcon: Icons.error_outline,
                                backgroundColor: Ux4gPalette.red,
                                contentColor: Ux4gPalette.white,

                            Text('Original White Icon (As Imported):', style: typography.lS_strong),
                            const SizedBox(height: 12),
                            Center(
                              child: Column(
                                children: [
                                  Ux4gSocialLink(
                                    icon: _selectedSocialIcon,
                                    size: SocialLinkSize.xxl,
                                    color: Ux4gPalette.white,
                                    enableBackground: true,
                                    containerSize: 100,
                                    containerColor: const Color(0xFFF5F5F5),
                                    tooltip: _selectedSocialIcon.name,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _selectedSocialIcon.name.toUpperCase(),
                                    style: typography.lM_strong.copyWith(color: colors.onBackground),
                                  ),
                                ],

                              ),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 16),

                      _showcaseCard(
                        title: 'Icon Variants - Colored',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Colored Icon (Original colored version):', style: typography.lS_strong),
                            const SizedBox(height: 12),
                            Center(
                              child: Column(
                                children: [
                                  Ux4gSocialLink(
                                    icon: _selectedSocialIcon,
                                    size: SocialLinkSize.xxl,
                                    useColoredIcon: true,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _selectedSocialIcon.name.toUpperCase(),
                                    style: typography.lM_strong.copyWith(color: colors.onBackground),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      _showcaseCard(
                        title: 'Icon Variants - Custom Tint',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select Tint Color:', style: typography.lS_strong),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                (Ux4gPalette.red500, 'Red'),
                                (Ux4gPalette.green500, 'Green'),
                                (Ux4gPalette.primary500, 'Blue'),
                                (Ux4gPalette.gold600, 'Gold'),
                                (Ux4gPalette.purple500, 'Purple'),
                                (Ux4gPalette.cyan500, 'Cyan'),
                              ]
                                  .map((colorTuple) {
                                final color = colorTuple.$1;
                                final label = colorTuple.$2;
                                final isSelected = _selectedTintColor == color;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedTintColor = color),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? color.withValues(alpha: 0.15) : colors.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected ? color : colors.onSurface.withValues(alpha: 0.12),
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Text(
                                      label,
                                      style: typography.tS_strong.copyWith(
                                        color: isSelected ? color : colors.onSurface,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Column(
                                children: [
                                  Ux4gSocialLink(
                                    icon: _selectedSocialIcon,
                                    size: SocialLinkSize.xxl,
                                    color: _selectedTintColor,
                                    enableBackground: true,
                                    containerSize: 100,
                                    containerColor: _selectedTintColor.withValues(alpha: 0.1),
                                    onPressed: () {},
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${_selectedSocialIcon.name.toUpperCase()} with custom tint',
                                    style: typography.lM_strong.copyWith(color: _selectedTintColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      _showcaseCard(
                        title: 'Pick an Icon',
                        typography: typography,
                        colors: colors,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select Icon to Preview:', style: typography.lS_strong),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: SocialMediaIcon.values.map((icon) {
                                final isSelected = _selectedSocialIcon == icon;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedSocialIcon = icon),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? colors.primary.withValues(alpha: 0.15)
                                          : colors.surface,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? colors.primary
                                            : colors.onSurface.withValues(alpha: 0.12),
                                        width: isSelected ? 1.5 : 1,
                                      ),
                                    ),
                                    child: Ux4gSocialLink(
                                      icon: icon,
                                      size: SocialLinkSize.m,
                                      color: isSelected ? colors.primary : colors.onSurface,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ─── File Upload ──────────────────────────────────
                      _sectionTitle('File Upload', typography, colors),
                      const SizedBox(height: 12),

                      _showcaseCard(
                        title: 'File Upload Component',
                        typography: typography,
                        colors: colors,
                        child: Ux4gFileUpload(
                          maxFiles: 5,
                          maxFileSize: 5 * 1024 * 1024, // 5MB
                          onFilesChanged: (files) {
                            setState(() => _uploadedFiles = files);
                          },
                          onUpload: (file) async {
                            // Simulate upload delay
                            await Future.delayed(const Duration(seconds: 2));
                            // Return true for success, false for failure
                            return true;
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ─── Slot Grid ────────────────────────────────────
                      _sectionTitle('Slot Grid', typography, colors),
                      const SizedBox(height: 12),

                      _showcaseCard(
                        title: 'Slot Grid – Calendar Booking',
                        typography: typography,
                        colors: colors,
                        child: SlotGridShowcase(),
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

  Widget _circularProgressDemoItem({
    required Ux4gCircularProgressSize size,
    required bool inlineMeta,
  }) {
    final valueText = '${(_circularProgressValue * 100).round()}%';

    return Ux4gCircularProgress(
      value: _circularProgressValue,
      size: size,
      backgroundColor:
          (size == Ux4gCircularProgressSize.xl ||
              size == Ux4gCircularProgressSize.xxl ||
              size == Ux4gCircularProgressSize.xxxl)
          ? Ux4gPalette.gray100
          : null,
      progressGradient: SweepGradient(
        transform: GradientRotation(-math.pi / 2),
        colors: [Color(0xFFDCD4FF), Color(0xFF6A4EFF)],
      ),
      centerValueText: valueText,
      centerDescription: inlineMeta ? 'Description' : null,
      label: inlineMeta ? null : valueText,
      description: inlineMeta ? null : 'Description',
      gap: 6,
    );
  }
}

Widget _circularColorVariant({
  required Ux4gColors colors,
  required Ux4gTypography typography,
  required Color progressColor,
  required SweepGradient gradient,
  required Color footerColor,
  required Color footerTextColor,
  Color? descriptionColor,
}) {
  return Ux4gCircularProgress(
    value: 0.65,
    size: Ux4gCircularProgressSize.xl,
    strokeWidth: 6,
    strokeCap: StrokeCap.round,
    progressGradient: gradient,
    centerValueText: '8',
    centerDescription: 'days left',
    label: 'Label',
    description: 'Description',
    descriptionStyle: descriptionColor != null
        ? typography.bS_default.copyWith(color: descriptionColor)
        : null,
    footer: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: footerColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Label',
        style: typography.bXS_strong.copyWith(color: footerTextColor),
      ),
    ),
  );
}

// ─── Biometric Showcase Page ──────────────────────────────────────────────

class BiometricShowcasePage extends StatelessWidget {
  final bool mockSuccess;

  const BiometricShowcasePage({super.key, this.mockSuccess = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BiometricVerificationFlow(
        onSuccess: (result) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verified: ${result.maskedName ?? "Success"}'),
              backgroundColor: const Color(0xFF1AA64A),
            ),
          );
        },
        onFailure: (reason, message) {
          // Handled by the flow internally (retry / OTP)
        },
        onDismiss: () => Navigator.of(context).pop(),
        onAlternateVerify: () {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP verification flow...')),
          );
        },
        enableBlinkCheck: true,
        enableLightingCheck: true,
        enableLiveness: true,
        maxAttempts: 3,
        mockSuccess: mockSuccess,
      ),
    );
  }
}

// ─── Slot Grid Showcase ──────────────────────────────────────────────────────

class SlotGridShowcase extends StatefulWidget {
  const SlotGridShowcase({super.key});

  @override
  State<SlotGridShowcase> createState() => _SlotGridShowcaseState();
}

class _SlotGridShowcaseState extends State<SlotGridShowcase> {
  DateTime? _selectedDate;
  late SlotGridData _data;
  SlotPickerViewMode _selectedViewMode = SlotPickerViewMode.expanded;

  // Mutable copy of time slots per date key (including "default").
  // Initialized from _getJsonInput() so bookings persist across taps.
  Map<String, List<Map<String, dynamic>>> _mutableTimeSlots = {};

  Map<String, dynamic> _getJsonInput() {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final dayAfter = now.add(const Duration(days: 2));
    final day4 = now.add(const Duration(days: 3));

    return {
      "year": now.year,
      "month": now.month,
      "today": '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      "weeklyOffWeekdays": [6, 7],
      "allowTapOnPublicHoliday": false,
      "allowTapOnWeeklyOff": false,
      "viewMode": _selectedViewMode == SlotPickerViewMode.compact ? "compact" : "expanded",
      "dates": [
        {
          "date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 2)}',
          "status": "publicHoliday"
        },
        {
          "date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 4)}',
          "status": "noSlots"
        },
        {
          "date": '${now.year}-${now.month.toString().padLeft(2, '0')}-${_pad(now.day + 6)}',
          "status": "noSlots"
        },
      ],
      "timeSlots": {
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}': [
          {"time": "9:00 AM", "slotCount": 2, "status": "available"},
          {"time": "10:00 AM", "slotCount": 1, "status": "limited"},
          {"time": "11:00 AM", "slotCount": 0, "status": "noSlots"},
          {"time": "2:00 PM", "slotCount": 3, "status": "available"},
        ],
        '${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}': [
          {"time": "9:30 AM", "slotCount": 5, "status": "available"},
          {"time": "10:30 AM", "slotCount": 2, "status": "available"},
          {"time": "1:00 PM", "slotCount": 4, "status": "available"},
          {"time": "3:00 PM", "slotCount": 1, "status": "limited"},
          {"time": "4:00 PM", "slotCount": 0, "status": "noSlots"},
        ],
        '${day4.year}-${day4.month.toString().padLeft(2, '0')}-${day4.day.toString().padLeft(2, '0')}': [
          {"time": "11:00 AM", "slotCount": 8, "status": "available"},
          {"time": "12:00 PM", "slotCount": 6, "status": "available"},
          {"time": "1:00 PM", "slotCount": 3, "status": "available"},
          {"time": "2:30 PM", "slotCount": 1, "status": "limited"},
        ],
        "default": [
          {"time": "9:00 AM", "slotCount": 4, "status": "available"},
          {"time": "9:30 AM", "slotCount": 6, "status": "available"},
          {"time": "10:00 AM", "slotCount": 3, "status": "available"},
          {"time": "10:30 AM", "slotCount": 0, "status": "noSlots"},
          {"time": "11:00 AM", "slotCount": 8, "status": "available"},
          {"time": "11:30 AM", "slotCount": 5, "status": "available"},
          {"time": "12:00 PM", "slotCount": 10, "status": "available"},
          {"time": "2:00 PM", "slotCount": 5, "status": "available"},
          {"time": "2:30 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:00 PM", "slotCount": 2, "status": "limited"},
          {"time": "3:30 PM", "slotCount": 1, "status": "limited"},
          {"time": "4:00 PM", "slotCount": 7, "status": "available"},
          {"time": "4:30 PM", "slotCount": 2, "status": "limited"},
          {"time": "5:00 PM", "slotCount": 2, "status": "limited"},
          {"time": "5:30 PM", "slotCount": 0, "status": "noSlots"},
        ]
      }
    };
  }

  static String _pad(int day) => day.toString().padLeft(2, '0');

  /// Builds the mutable slot map from the JSON definition.
  Map<String, List<Map<String, dynamic>>> _buildMutableSlots() {
    final json = _getJsonInput();
    final raw = json['timeSlots'] as Map<String, dynamic>;
    return raw.map((key, value) => MapEntry(
          key,
          (value as List).map((e) => Map<String, dynamic>.from(e as Map)).toList(),
        ));
  }

  @override
  void initState() {
    super.initState();
    _mutableTimeSlots = _buildMutableSlots();
    _data = SlotGridData.fromJson(_getJsonInput());
  }

  /// Returns current slots for [date], falling back to "default".
  List<SlotTimeEntry> _timeSlotsFor(DateTime date) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (_mutableTimeSlots.isEmpty) {
      _mutableTimeSlots = _buildMutableSlots();
    }
    // If no date-specific entry, create one by copying 'default' so mutations are isolated.
    if (!_mutableTimeSlots.containsKey(dateStr)) {
      final defaultSlots = _mutableTimeSlots['default'] ?? [];
      _mutableTimeSlots[dateStr] = defaultSlots
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
    return _mutableTimeSlots[dateStr]!
        .map((e) => SlotTimeEntry.fromJson(e))
        .toList();
  }

  /// Increments slotCount for [bookedTime] on [date] and updates status.
  void _onSlotBooked(DateTime date, SlotTimeEntry bookedTime) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (_mutableTimeSlots.isEmpty) {
      _mutableTimeSlots = _buildMutableSlots();
    }
    // Always use date-specific key (ensured by _timeSlotsFor creating it on tap)
    final slots = _mutableTimeSlots[dateStr];
    if (slots == null) return;

    setState(() {
      for (final slot in slots) {
        if (slot['time'] == bookedTime.time) {
          final newCount = (slot['slotCount'] as int) + 1;
          slot['slotCount'] = newCount;
          if (newCount == 0) {
            slot['status'] = 'noSlots';
          } else if (newCount <= 2) {
            slot['status'] = 'limited';
          } else {
            slot['status'] = 'available';
          }
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // View mode toggle buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Ux4gButton(
              onPressed: () {
                setState(() {
                  _selectedViewMode = SlotPickerViewMode.expanded;
                  _data = SlotGridData.fromJson(_getJsonInput());
                });
              },
              text: 'Expanded View',
              variant: _selectedViewMode == SlotPickerViewMode.expanded
                  ? Ux4gButtonVariant.primary
                  : Ux4gButtonVariant.outline,
            ),
            Ux4gButton(
              onPressed: () {
                setState(() {
                  _selectedViewMode = SlotPickerViewMode.compact;
                  _data = SlotGridData.fromJson(_getJsonInput());
                });
              },
              text: 'Compact View',
              variant: _selectedViewMode == SlotPickerViewMode.compact
                  ? Ux4gButtonVariant.primary
                  : Ux4gButtonVariant.outline,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SlotGrid(
          data: _data,
          timeSlotProvider: _timeSlotsFor,
          onSlotConfirmed: (date, slot) => _onSlotBooked(date, slot),
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              final json = _getJsonInput();
              _data = SlotGridData.fromJson({
                ...json,
                'selectedDate':
                    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
                'year': _data.year,
                'month': _data.month,
              });
            });
          },
          onMonthChanged: (year, month) {
            setState(() {
              final json = _getJsonInput();
              _data = SlotGridData.fromJson({
                ...json,
                'year': year,
                'month': month,
              });
            });
          },
        ),
        if (_selectedDate != null) ...[
          const SizedBox(height: 16),
          Text(
            'Selected: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            style: typography.bS_default.copyWith(color: colors.onBackground),
          ),
        ],
      ],
    );
  }
}
