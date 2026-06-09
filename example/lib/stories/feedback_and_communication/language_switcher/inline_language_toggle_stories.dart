import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _primaryColor = Color(0xFF432CBB);

// ── Component ────────────────────────────────────────────────────────────

final inlineLanguageToggleComponent = WidgetbookComponent(
  name: 'Inline Language Toggle',
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
          name: 'Inline Language Toggle ($variant)',
          description: isCard
              ? 'Inline language toggle with choice chips inside a '
                    'card container with light purple background.'
              : 'Inline language toggle with choice chips on white background.',
          code: isCard
              ? _inlineLanguageToggleCardCode
              : _inlineLanguageToggleDefaultCode,
          center: true,
          child: _InlineLanguageToggleMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _inlineLanguageToggleDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class InlineLanguageToggleScreen extends StatefulWidget {
  const InlineLanguageToggleScreen({super.key});

  @override
  State<InlineLanguageToggleScreen> createState() => _InlineLanguageToggleScreenState();
}

class _InlineLanguageToggleScreenState extends State<InlineLanguageToggleScreen> {
  int _selectedIndex = 0;

  final _languages = ['English', 'हिन्दी', 'தமிழ்', 'తెలుగు'];

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
                    Text('Apply for Income Certificate',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Switch the inline toggle to change form labels — your entered data is preserved.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Language chips
                    Wrap(
                      spacing: 8,
                      children: List.generate(_languages.length, (i) {
                        return Ux4gChoiceChip(
                          text: _languages[i],
                          selected: _selectedIndex == i,
                          onClick: () => setState(() => _selectedIndex = i),
                        );
                      }),
                    ),
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

const _inlineLanguageToggleCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — inline language toggle inside a white card on purple background.
class InlineLanguageToggleCardScreen extends StatefulWidget {
  const InlineLanguageToggleCardScreen({super.key});

  @override
  State<InlineLanguageToggleCardScreen> createState() => _InlineLanguageToggleCardScreenState();
}

class _InlineLanguageToggleCardScreenState extends State<InlineLanguageToggleCardScreen> {
  int _selectedIndex = 0;

  final _languages = ['English', 'हिन्दी', 'தமிழ்', 'తెలుగు'];

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
                        Text('Apply for Income Certificate',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Switch the inline toggle to change form labels — your entered data is preserved.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 20),
                        // Language chips
                        Wrap(
                          spacing: 8,
                          children: List.generate(_languages.length, (i) {
                            return Ux4gChoiceChip(
                              text: _languages[i],
                              selected: _selectedIndex == i,
                              onClick: () => setState(() => _selectedIndex = i),
                            );
                          }),
                        ),
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

class _InlineLanguageToggleMockup extends StatefulWidget {
  final bool isCard;

  const _InlineLanguageToggleMockup({this.isCard = false});

  @override
  State<_InlineLanguageToggleMockup> createState() =>
      _InlineLanguageToggleMockupState();
}

class _InlineLanguageToggleMockupState
    extends State<_InlineLanguageToggleMockup> {
  int _selectedIndex = 0;

  final _languages = const ['English', 'हिन्दी', 'தமிழ்', 'తెలుగు'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: widget.isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingSpacing: 2,
                leadingWidgets: [
                  SvgPicture.asset(
                    'assets/national_amblam_logo.svg',
                    height: 40,
                  ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/india_flag.png',
                      height: 14,
                      width: 22,
                      errorBuilder: (_, __, ___) => const Text(
                        '\u{1f1ee}\u{1f1f3}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Government of India',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.open_in_new,
                      size: 11,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.accessibility_new,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: widget.isCard
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
                    const Text(
                      'Powered by -',
                      style: TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/digital_india_logo.png',
                      height: 20,
                      errorBuilder: (_, __, ___) => const Text(
                        'Digital India',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF432CBB),
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

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Apply for Income Certificate',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Switch the inline toggle to change form labels — your entered data is preserved.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Language chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_languages.length, (i) {
            return Ux4gChoiceChip(
              text: _languages[i],
              selected: _selectedIndex == i,
              onClick: () => setState(() => _selectedIndex = i),
            );
          }),
        ),
      ],
    );
  }
}
