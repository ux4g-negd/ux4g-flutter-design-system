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

final translationUnavailableComponent = WidgetbookComponent(
  name: 'Translation Unavailable',
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
          name: 'Translation Unavailable ($variant)',
          description: isCard
              ? 'Translation unavailable notice with progress status inside a '
                    'card container with light purple background.'
              : 'Translation unavailable notice with progress status on white background.',
          code: isCard
              ? _translationUnavailableCardCode
              : _translationUnavailableDefaultCode,
          center: true,
          child: _TranslationUnavailableMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _translationUnavailableDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class TranslationUnavailableScreen extends StatelessWidget {
  const TranslationUnavailableScreen({super.key});

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
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This page is not yet available in Tamil',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('We are translating Income Certificate pages — the Tamil version is coming in May 2026.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Warning card
                    Ux4gCard(
                      backgroundColor: const Color(0xFFFFF7E6),
                      cornerRadius: 12,
                      borderColor: const Color(0xFFFFC973),
                      borderWidth: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info, color: Color(0xFFFA8C16), size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Translation in progress',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00))),
                                  const SizedBox(height: 4),
                                  Text('You can read this page in English meanwhile, or use your browser to auto-translate.',
                                      style: TextStyle(fontSize: 13, color: Color(0xFFAD4E00))),
                                ],
                              ),
                            ),
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
                      text: 'Switch to English',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Translate with Browser',
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

const _translationUnavailableCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — translation unavailable inside a white card on purple background.
class TranslationUnavailableCardScreen extends StatelessWidget {
  const TranslationUnavailableCardScreen({super.key});

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
                SizedBox(width:3),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                SizedBox(width:3),
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
                        Text('This page is not yet available in Tamil',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('We are translating Income Certificate pages — the Tamil version is coming in May 2026.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Warning card
                        Ux4gCard(
                          backgroundColor: const Color(0xFFFFF7E6),
                          cornerRadius: 12,
                          borderColor: const Color(0xFFFFC973),
                          borderWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info, color: Color(0xFFFA8C16), size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Translation in progress',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00))),
                                      const SizedBox(height: 4),
                                      Text('You can read this page in English meanwhile, or use your browser to auto-translate.',
                                          style: TextStyle(fontSize: 13, color: Color(0xFFAD4E00))),
                                    ],
                                  ),
                                ),
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
                      text: 'Switch to English',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Translate with Browser',
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

class _TranslationUnavailableMockup extends StatelessWidget {
  final bool isCard;

  const _TranslationUnavailableMockup({this.isCard = false});

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
                        text: 'Switch to English',
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Translate with Browser',
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
          'This page is not yet available in Tamil',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'We are translating Income Certificate pages — the Tamil version is coming in May 2026.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Warning card
        Ux4gCard(
          backgroundColor: const Color(0xFFFFF7E6),
          cornerRadius: 12,
          borderColor: const Color(0xFFFFC973),
          borderWidth: 1,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info, color: Color(0xFFFA8C16), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Translation in progress',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFAD4E00),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'You can read this page in English meanwhile, or use your browser to auto-translate.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFAD4E00),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
