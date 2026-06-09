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

final liveChatSupportComponent = WidgetbookComponent(
  name: 'Live Chat Support',
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
          name: 'Live Chat Support ($variant)',
          description: isCard
              ? 'Live chat support page with agent availability status inside a '
                'card container with light purple background.'
              : 'Live chat support page with agent availability status on white background.',
          code: isCard ? _liveChatCardCode : _liveChatDefaultCode,
          center: true,
          child: _LiveChatSupportMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _liveChatDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class LiveChatSupportScreen extends StatelessWidget {
  const LiveChatSupportScreen({super.key});

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
                const SizedBox(width: 3),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 3),
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
                    Text('Live Chat Support',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Chat with a support agent for real-time help with your application.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Status card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD1FAE5)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF00522C), size: 22),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Queue agent available',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF00522C))),
                              const SizedBox(height: 2),
                              Text('Estimated wait time: 1-2 mins',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF00522C))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Connect now to discuss your application with our support team. Average response time under 2 minutes.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 32),
                    // Start Chat button
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Start Chat Session',
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Email support button
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Email support instead',
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        borderColor: const Color(0xFF432CBB),
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

const _liveChatCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — live chat support inside a white card on purple background.
class LiveChatSupportCardScreen extends StatelessWidget {
  const LiveChatSupportCardScreen({super.key});

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
                        Text('Live Chat Support',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Chat with a support agent for real-time help with your application.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Status card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFD1FAE5)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Color(0xFF00522C), size: 22),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Queue agent available',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF00522C))),
                                  const SizedBox(height: 2),
                                  Text('Estimated wait time: 1-2 mins',
                                      style: TextStyle(fontSize: 12, color: Color(0xFF00522C))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text('Connect now to discuss your application with our support team. Average response time under 2 minutes.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 32),
                        // Start Chat button
                        SizedBox(
                          width: double.infinity,
                          child: Ux4gButton(
                            onPressed: () {},
                            text: 'Start Chat Session',
                            variant: Ux4gButtonVariant.primary,
                            size: Ux4gButtonSize.large,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Email support button
                        SizedBox(
                          width: double.infinity,
                          child: Ux4gButton(
                            onPressed: () {},
                            text: 'Email support instead',
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.large,
                            borderColor: const Color(0xFF432CBB),
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

class _LiveChatSupportMockup extends StatelessWidget {
  final bool isCard;

  const _LiveChatSupportMockup({this.isCard = false});

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
                  const SizedBox(width: 3),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 3),
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

              // Buttons at bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Start Chat Session',
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Email support instead',
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
          'Live Chat Support',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),
        const Text(
          'Chat with a support agent for real-time help with your application.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Status card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF2FCEF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF80DA88)),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF00522C), size: 22),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Queue agent available',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF065F46)),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Estimated wait time: 1-2 mins',
                    style: TextStyle(fontSize: 12, color: Color(0xFF00522C)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          'Connect now to discuss your application with our support team. Average response time under 2 minutes.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
