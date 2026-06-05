import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _mutedText = Color(0xFF6B7280);
const _primaryColor = Color(0xFF432CBB);

// ── Component ────────────────────────────────────────────────────────────

final languageSwitcherComponent = WidgetbookComponent(
  name: 'Language Switcher',
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
          name: 'Language Switcher ($variant)',
          description: isCard
              ? 'Interface language selection with dropdown inside a '
                'card container with light purple background.'
              : 'Interface language selection with dropdown on white background.',
          code: isCard ? _languageSwitcherCardCode : _languageSwitcherDefaultCode,
          center: true,
          child: _LanguageSwitcherMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _languageSwitcherDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class LanguageSwitcherScreen extends StatelessWidget {
  const LanguageSwitcherScreen({super.key});

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
              leadingSpacing: 2,
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                SizedBox(width: 3),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                SizedBox(width: 3),
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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Choose your interface language',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Switch the portal to a language you read most comfortably. You can change this anytime from the header.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Interface Language label
                    Text('Interface Language',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    // Dropdown
                    Ux4gSelectionDropdown(
                      options: const [
                        Ux4gDropdownOption(id: 'en', label: 'English (United States)'),
                        Ux4gDropdownOption(id: 'hi', label: 'Hindi (हिन्दी)'),
                        Ux4gDropdownOption(id: 'ta', label: 'Tamil (தமிழ்)'),
                      ],
                      selectedOptionIds: const ['en'],
                      onSelectionChange: (_) {},
                      size: Ux4gDropdownSize.m,
                      leadingIcon: Icons.language,
                    ),
                    const SizedBox(height: 12),
                    Text('Auto-detected from your browser preferences. Changing this updates the portal immediately — no page reload needed.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
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

const _languageSwitcherCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — language switcher inside a white card on purple background.
class LanguageSwitcherCardScreen extends StatelessWidget {
  const LanguageSwitcherCardScreen({super.key});

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
              leadingSpacing: 2,
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
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
            // White card content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Ux4gCard(
                  backgroundColor: Colors.white,
                  cornerRadius: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Choose your interface language',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Switch the portal to a language you read most comfortably. You can change this anytime from the header.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Interface Language label
                        Text('Interface Language',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        // Dropdown
                        Ux4gSelectionDropdown(
                          options: const [
                            Ux4gDropdownOption(id: 'en', label: 'English (United States)', leadingIcon: Icons.language),
                            Ux4gDropdownOption(id: 'hi', label: 'Hindi (हिन्दी)', leadingIcon: Icons.language),
                            Ux4gDropdownOption(id: 'ta', label: 'Tamil (தமிழ்)', leadingIcon: Icons.language),
                          ],
                          selectedOptionIds: const ['en'],
                          onSelectionChange: (_) {},
                          size: Ux4gDropdownSize.m,
                        ),
                        const SizedBox(height: 12),
                        Text('Auto-detected from your browser preferences. Changing this updates the portal immediately — no page reload needed.',
                            style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                      ],
                    ),
                  ),
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
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _LanguageSwitcherMockup extends StatelessWidget {
  final bool isCard;

  const _LanguageSwitcherMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingSpacing: 2,
                leadingWidgets: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                SizedBox(width: 3),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                SizedBox(width: 3),
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
                        errorBuilder: (_, __, ___) => const Text('\u{1f1ee}\u{1f1f3}', style: TextStyle(fontSize: 14))),
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

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isCard
                      ? Ux4gCard(
                          backgroundColor: Colors.white,
                          cornerRadius: 16,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildContent(),
                          ),
                        )
                      : _buildContent(),
                ),
              ),

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

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose your interface language',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),
        const Text(
          'Switch the portal to a language you read most comfortably. You can change this anytime from the header.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Interface Language label
        const Text('Interface Language',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
        const SizedBox(height: 8),

        // Dropdown field
        Ux4gSelectionDropdown(
          options: const [
            Ux4gDropdownOption(id: 'en', label: 'English (United States)'),
            Ux4gDropdownOption(id: 'hi', label: 'Hindi (हिन्दी)'),
            Ux4gDropdownOption(id: 'ta', label: 'Tamil (தமிழ்)'),
            Ux4gDropdownOption(id: 'te', label: 'Telugu (తెలుగు)'),
          ],
          selectedOptionIds: const ['en'],
          onSelectionChange: (_) {},
          size: Ux4gDropdownSize.m,
          leadingIcon: Icons.language,
          valueTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 12),

        const Text(
          'Auto-detected from your browser preferences. Changing this updates the portal immediately — no page reload needed.',
          style: TextStyle(fontSize: 13, color: _mutedText),
        ),
      ],
    );
  }
}
