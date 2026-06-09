import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _primaryColor = Color(0xFF432CBB);
const _successGreen = Color(0xFF16A34A);
const _successBg = Color(0xFFF2FCEF);
const _successBorder = Color(0xFF80DA88);
const _successTextColor = Color(0xFF00522C);
const _fileBg = Color(0xFFF3F4F6);

// ── Component ────────────────────────────────────────────────────────────

final serviceCompletionComponent = WidgetbookComponent(
  name: 'Service Completed',
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
          name: 'Service Completed ($variant)',
          description: isCard
              ? 'Service completion confirmation with downloaded certificate info '
                'inside a card container with light purple background.'
              : 'Service completion confirmation with downloaded certificate info '
                'on a white background.',
          code: isCard ? _serviceCompletionCardCode : _serviceCompletionDefaultCode,
          center: true,
          child: _ServiceCompletionMockup(
            isCard: isCard,
          ),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _serviceCompletionDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class ServiceCompletionScreen extends StatelessWidget {
  const ServiceCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Ux4gButton(
                      onPressed: () {},
                      text: 'Back',
                      variant: Ux4gButtonVariant.ghost,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.arrow_back,
                      contentColor: const Color(0xFF111827),
                    ),
                    const SizedBox(height: 20),
                    Text('Service Completed',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text('Your income certificate has been downloaded.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Success banner
                    Ux4gCard(
                      backgroundColor: const Color(0xFFF2FCEF),
                      borderColor: const Color(0xFF80DA88),
                      borderWidth: 1,
                      cornerRadius: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, size: 20, color: Color(0xFF16A34A)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('Income Certificate Downloaded.',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF00522C))),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Text('Your certificate has been saved to your\ndevice.',
                                  style: TextStyle(fontSize: 13, color: Color(0xFF00522C))),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Ux4gButton(
                                onPressed: () {},
                                text: 'View',
                                variant: Ux4gButtonVariant.ghost,
                                size: Ux4gButtonSize.small,
                                contentColor: const Color(0xFF00522C),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // File info
                    Ux4gCard(
                      backgroundColor: const Color(0xFFF3F4F6),
                      cornerRadius: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            Text('income_certificate_2026.pdf',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 8),
                            Text('28 KB · PDF',
                                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            // Save to DigiLocker button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Ux4gButton(
                onPressed: () {},
                text: 'Save to DigiLocker',
                variant: Ux4gButtonVariant.outline,
                size: Ux4gButtonSize.large,
                width: double.infinity,
                borderColor: const Color(0xFF432CBB),
                contentColor: const Color(0xFF432CBB),
                borderRadius: 8,
              ),
            ),
            // Download Again button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Ux4gButton(
                onPressed: () {},
                text: 'Download Again',
                variant: Ux4gButtonVariant.primary,
                size: Ux4gButtonSize.large,
                width: double.infinity,
                backgroundColor: const Color(0xFF4A2BC2),
                borderRadius: 8,
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

const _serviceCompletionCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — content inside a white card on purple background.
class ServiceCompletionCardScreen extends StatelessWidget {
  const ServiceCompletionCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Ux4gCard(
                backgroundColor: Colors.white,
                cornerRadius: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Ux4gButton(
                        onPressed: () {},
                        text: 'Back',
                        variant: Ux4gButtonVariant.ghost,
                        size: Ux4gButtonSize.small,
                        leadingIcon: Icons.arrow_back,
                        contentColor: const Color(0xFF111827),
                      ),
                      const SizedBox(height: 20),
                      Text('Service Completed',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text('Your income certificate has been downloaded.',
                          style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      // Success banner
                      Ux4gCard(
                        backgroundColor: const Color(0xFFF2FCEF),
                        borderColor: const Color(0xFF80DA88),
                        borderWidth: 1,
                        cornerRadius: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.check_circle, size: 20, color: Color(0xFF16A34A)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text('Income Certificate Downloaded.',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF00522C))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.only(left: 28),
                                child: Text('Your certificate has been saved to your\ndevice.',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF00522C))),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(left: 28),
                                child: Ux4gButton(
                                  onPressed: () {},
                                  text: 'View',
                                  variant: Ux4gButtonVariant.ghost,
                                  size: Ux4gButtonSize.small,
                                  contentColor: const Color(0xFF00522C),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // File info
                      Ux4gCard(
                        backgroundColor: const Color(0xFFF3F4F6),
                        cornerRadius: 8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Text('income_certificate_2026.pdf',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                              const SizedBox(width: 8),
                              Text('28 KB · PDF',
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
            const Spacer(),
            // Save to DigiLocker button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Ux4gButton(
                onPressed: () {},
                text: 'Save to DigiLocker',
                variant: Ux4gButtonVariant.outline,
                size: Ux4gButtonSize.large,
                width: double.infinity,
                borderColor: const Color(0xFF432CBB),
                contentColor: const Color(0xFF432CBB),
                borderRadius: 8,
              ),
            ),
            // Download Again button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Ux4gButton(
                onPressed: () {},
                text: 'Download Again',
                variant: Ux4gButtonVariant.primary,
                size: Ux4gButtonSize.large,
                width: double.infinity,
                backgroundColor: const Color(0xFF4A2BC2),
                borderRadius: 8,
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

class _ServiceCompletionMockup extends StatelessWidget {
  final bool isCard;

  const _ServiceCompletionMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header with logos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 32,
                      child: Ux4gDivider(
                        orientation: Ux4gDividerOrientation.vertical,
                        color: const Color(0xFFD1D5DB),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset('assets/Union.svg', height: 32),
                  ],
                ),
              ),

              // Gov bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Image.asset('assets/india_flag.png', height: 14, width: 22,
                        errorBuilder: (_, __, ___) => const Text('🇮🇳', style: TextStyle(fontSize: 14))),
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
              if (!isCard)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildMainContent(),
                  ),
                ),
              if (isCard)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildCardContent(),
                ),

              if (isCard) const Spacer(),

              // Buttons + Powered by at bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: _buildSaveButton(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _buildDownloadButton(),
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

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button using Ux4gButton
        Ux4gButton(
          onPressed: () {},
          text: 'Back',
          variant: Ux4gButtonVariant.ghost,
          size: Ux4gButtonSize.small,
          leadingIcon: Icons.arrow_back,
          contentColor: _titleColor,
        ),
        const SizedBox(height: 20),

        // Title
        const Text(
          'Service Completed',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 6),
        const Text(
          'Your income certificate has been downloaded.',
          style: TextStyle(fontSize: 13, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Success banner using Ux4gCard
        Ux4gCard(
          backgroundColor: _successBg,
          borderColor: _successBorder,
          borderWidth: 1,
          cornerRadius: 10,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.check_circle, size: 20, color: _successGreen),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Income Certificate Downloaded.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _successTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.only(left: 28),
                child: Text(
                  'Your certificate has been saved to your\ndevice.',
                  style: TextStyle(fontSize: 13, color: _successTextColor),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Ux4gButton(
                  onPressed: () {},
                  text: 'View',
                  variant: Ux4gButtonVariant.ghost,
                  size: Ux4gButtonSize.small,
                  contentColor: _successTextColor,
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          ),
        ),
        const SizedBox(height: 16),

        // File info row using Ux4gCard
        Ux4gCard(
          backgroundColor: _fileBg,
          cornerRadius: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
            children: const [
              Text(
                'income_certificate_2026.pdf',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor),
              ),
              SizedBox(width: 8),
              Text(
                '28 KB · PDF',
                style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Ux4gButton(
      onPressed: () {},
      text: 'Save to DigiLocker',
      variant: Ux4gButtonVariant.outline,
      size: Ux4gButtonSize.large,
      width: double.infinity,
      borderColor: _primaryColor,
      contentColor: _primaryColor,
      borderRadius: 8,
    );
  }

  Widget _buildDownloadButton() {
    return Ux4gButton(
      onPressed: () {},
      text: 'Download Again',
      variant: Ux4gButtonVariant.primary,
      size: Ux4gButtonSize.large,
      width: double.infinity,
      backgroundColor: const Color(0xFF4A2BC2),
      borderRadius: 8,
    );
  }

  Widget _buildCardContent() {
    return Ux4gCard(
      backgroundColor: Colors.white,
      cornerRadius: 16,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildMainContent(),
      ),
    );
  }
}
