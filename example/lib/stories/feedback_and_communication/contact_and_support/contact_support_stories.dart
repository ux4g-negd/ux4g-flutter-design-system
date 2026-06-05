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

final contactSupportComponent = WidgetbookComponent(
  name: 'Contact Support',
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
          name: 'Contact Support ($variant)',
          description: isCard
              ? 'Contact support page with multiple support channels inside a '
                'card container with light purple background.'
              : 'Contact support page with multiple support channels on white background.',
          code: isCard ? _contactSupportCardCode : _contactSupportDefaultCode,
          center: true,
          child: _ContactSupportMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _contactSupportDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

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
              leadingWidgets: [
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
                    Text('Still need help?',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Contact our support team — we are here to help.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Phone Support
                    _SupportCard(
                      icon: Icons.phone,
                      title: 'Phone Support',
                      subtitle: '1800-XXX-XXXX · Toll free · Mon-Sat 9AM-6PM',
                      buttonText: 'Call Now',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    // Live Chat
                    _SupportCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'Live Chat',
                      subtitle: 'Available now · Estimated wait 1-2 minutes',
                      buttonText: 'Start Chat',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    // Email Support
                    _SupportCard(
                      icon: Icons.email_outlined,
                      title: 'Email Support',
                      subtitle: 'Response within 2 working days',
                      buttonText: 'Send Email',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    // Walk-in Centre
                    _SupportCard(
                      icon: Icons.person_pin_circle_outlined,
                      title: 'Walk-in Centre',
                      subtitle: 'Visit your nearest Common Service Centre',
                      buttonText: 'Find CSC',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 24),
                    // File complaint link
                    Center(
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'File a complaint about this portal',
                        variant: Ux4gButtonVariant.ghost,
                        contentColor: const Color(0xFF432CBB),
                      ),
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

const _contactSupportCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — contact support inside a white card on purple background.
class ContactSupportCardScreen extends StatelessWidget {
  const ContactSupportCardScreen({super.key});

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
              leadingWidgets: [
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
                        Text('Still need help?',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Contact our support team — we are here to help.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Support cards
                        _SupportCard(
                          icon: Icons.phone,
                          title: 'Phone Support',
                          subtitle: '1800-XXX-XXXX · Toll free · Mon-Sat 9AM-6PM',
                          buttonText: 'Call Now',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        _SupportCard(
                          icon: Icons.chat_bubble_outline,
                          title: 'Live Chat',
                          subtitle: 'Available now · Estimated wait 1-2 minutes',
                          buttonText: 'Start Chat',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        _SupportCard(
                          icon: Icons.email_outlined,
                          title: 'Email Support',
                          subtitle: 'Response within 2 working days',
                          buttonText: 'Send Email',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 12),
                        _SupportCard(
                          icon: Icons.person_pin_circle_outlined,
                          title: 'Walk-in Centre',
                          subtitle: 'Visit your nearest Common Service Centre',
                          buttonText: 'Find CSC',
                          onPressed: () {},
                        ),
                        const SizedBox(height: 24),
                        // File complaint link
                        Center(
                          child: Ux4gButton(
                            onPressed: () {},
                            text: 'File a complaint about this portal',
                            variant: Ux4gButtonVariant.ghost,
                            contentColor: const Color(0xFF432CBB),
                          ),
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

class _ContactSupportMockup extends StatelessWidget {
  final bool isCard;

  const _ContactSupportMockup({this.isCard = false});

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
                leadingWidgets: [
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
          'Still need help?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),
        const Text(
          'Contact our support team — we are here to help.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Phone Support
        _SupportCard(
          icon: Icons.phone,
          title: 'Phone Support',
          subtitle: '1800-XXX-XXXX · Toll free · Mon-Sat 9AM-6PM',
          buttonText: 'Call Now',
          onPressed: () {},
        ),
        const SizedBox(height: 12),

        // Live Chat
        _SupportCard(
          icon: Icons.chat_bubble_outline,
          title: 'Live Chat',
          subtitle: 'Available now · Estimated wait 1-2 minutes',
          buttonText: 'Start Chat',
          onPressed: () {},
        ),
        const SizedBox(height: 12),

        // Email Support
        _SupportCard(
          icon: Icons.email_outlined,
          title: 'Emai Support',
          subtitle: 'Response within 2 working days',
          buttonText: 'Send Email',
          onPressed: () {},
        ),
        const SizedBox(height: 12),

        // Walk-in Centre
        _SupportCard(
          icon: Icons.person_pin_circle_outlined,
          title: 'Walk-in Centre',
          subtitle: 'Visit your nearest Common Service Centre',
          buttonText: 'Find CSC',
          onPressed: () {},
        ),
        const SizedBox(height: 24),

        // File complaint link
        Center(
          child: Ux4gButton(
            onPressed: () {},
            text: 'File a complaint about this portal',
            variant: Ux4gButtonVariant.ghost,
            contentColor: _primaryColor,
          ),
        ),
      ],
    );
  }
}

// ── Support Card Widget ──────────────────────────────────────────────────

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const _SupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Ux4gCard(
      backgroundColor: const Color(0xFFF5F5F5),
      cornerRadius: 12,
      borderColor: const Color(0xFFE5E5E5),
      borderWidth: 1,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFDCD4FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF4A2BC2)),
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: _subtleText),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Button
            Ux4gButton(
              onPressed: onPressed,
              text: buttonText,
              variant: Ux4gButtonVariant.outline,
              size: Ux4gButtonSize.small,
              borderColor: _primaryColor,
              contentColor: _primaryColor,
              borderRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
