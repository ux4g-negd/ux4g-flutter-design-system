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

final findServiceCentreComponent = WidgetbookComponent(
  name: 'Find Service Centre',
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
          name: 'Find Service Centre ($variant)',
          description: isCard
              ? 'Find nearest service centre with search and result card inside a '
                    'card container with light purple background.'
              : 'Find nearest service centre with search and result card on white background.',
          code: isCard
              ? _findServiceCentreCardCode
              : _findServiceCentreDefaultCode,
          center: true,
          child: _FindServiceCentreMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _findServiceCentreDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class FindServiceCentreScreen extends StatelessWidget {
  const FindServiceCentreScreen({super.key});

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
                    Text('Find your nearest Service Centre',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Locate a Common Service Centre (CSC) near you for in-person help.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Search bar
                    Ux4gSearchField(
                      value: '',
                      onValueChange: (_) {},
                      variant: Ux4gSearchFieldVariant.searchWithSubmit,
                      placeholder: 'Enter PIN code or city',
                      showVoiceIcon: true,
                      onSubmitClick: (_) {},
                    ),
                    const SizedBox(height: 20),
                    // Result card
                    Ux4gCard(
                      backgroundColor: const Color(0xFFF5F5F5),
                      cornerRadius: 12,
                      borderColor: const Color(0xFFE5E5E5),
                      borderWidth: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CSC Sector 12 — Pune City',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text('45 Patel Nagar, Sector 12, Pune 411001',
                                style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                            const SizedBox(height: 4),
                            Text('1.2 km away · Open Mon-Sat 9 AM – 6 PM',
                                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Get directions',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'View all centres',
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      borderColor: const Color(0xFF432CBB),
                      contentColor: const Color(0xFF432CBB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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

const _findServiceCentreCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — find service centre inside a white card on purple background.
class FindServiceCentreCardScreen extends StatelessWidget {
  const FindServiceCentreCardScreen({super.key});

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
                        Text('Find your nearest Service Centre',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Locate a Common Service Centre (CSC) near you for in-person help.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Search bar
                        Ux4gSearchField(
                          value: '',
                          onValueChange: (_) {},
                          variant: Ux4gSearchFieldVariant.searchWithSubmit,
                          placeholder: 'Enter PIN code or city',
                          showVoiceIcon: true,
                          onSubmitClick: (_) {},
                        ),
                        const SizedBox(height: 20),
                        // Result card
                        Ux4gCard(
                          backgroundColor: const Color(0xFFF5F5F5),
                          cornerRadius: 12,
                          borderColor: const Color(0xFFE5E5E5),
                          borderWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CSC Sector 12 — Pune City',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text('45 Patel Nagar, Sector 12, Pune 411001',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                                const SizedBox(height: 4),
                                Text('1.2 km away · Open Mon-Sat 9 AM – 6 PM',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Get directions',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'View all centres',
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      borderColor: const Color(0xFF432CBB),
                      contentColor: const Color(0xFF432CBB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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

class _FindServiceCentreMockup extends StatelessWidget {
  final bool isCard;

  const _FindServiceCentreMockup({this.isCard = false});

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

              // Buttons at bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Get directions',
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'View all centres',
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        borderColor: _primaryColor,
                        contentColor: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

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
          'Find your nearest Service Centre',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Locate a Common Service Centre (CSC) near you for in-person help.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Search bar
        Ux4gSearchField(
          value: '',
          onValueChange: (_) {},
          variant: Ux4gSearchFieldVariant.searchWithSubmit,
          size: Ux4gSearchFieldSize.large,
          placeholder: 'Enter PIN code or city',
          showVoiceIcon: true,
          onSubmitClick: (_) {},
        ),
        const SizedBox(height: 20),

        // Result card
        Ux4gCard(
          backgroundColor: const Color(0xFFF5F5F5),
          cornerRadius: 12,
          borderColor: const Color(0xFFE5E5E5),
          borderWidth: 1,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CSC Sector 12 — Pune City',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _titleColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '45 Patel Nagar, Sector 12, Pune 411001',
                  style: TextStyle(fontSize: 13, color: _subtleText),
                ),
                SizedBox(height: 4),
                Text(
                  '1.2 km away · Open Mon-Sat 9 AM – 6 PM',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
