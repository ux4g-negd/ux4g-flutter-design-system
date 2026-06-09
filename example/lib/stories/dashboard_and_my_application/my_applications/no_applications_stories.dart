import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final noApplicationsComponent = WidgetbookComponent(
  name: 'No Applications',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'No Applications',
          description:
              'An empty state pattern shown when the user has no active applications. '
              'Includes a greeting, empty state illustration, CTA button, and popular services list.',
          code: _noApplicationsCode,
          center: true,
          child: const _NoApplicationsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _noApplicationsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoApplicationsScreen extends StatelessWidget {
  const NoApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
                const SizedBox(width: 8),
                const Text('Government of India', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
              ],
              actions: [
                Ux4gAppHeaderAction(icon: Icons.notifications_outlined, onPressed: () {}),
              ],
              showAvatar: true,
              avatarInitials: 'R',
            ),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    Text('Good morning, Ramesh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    const SizedBox(height: 4),
                    Text("You haven't started any applications yet", style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 40),

                    // Empty state
                    Center(
                      child: Column(
                        children: [
                          // Illustration icon
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Color(0xFFF3F0FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.laptop_mac_outlined, size: 32, color: Color(0xFF432CBB)),
                          ),
                          const SizedBox(height: 20),
                          Text('No active applications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 8),
                          Text(
                            'Start your application easily by clicking on the\nbutton below',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                          ),
                          const SizedBox(height: 24),
                          Ux4gButton(
                            text: 'Start application',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            contentColor: Color(0xFF432CBB),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Popular services
                    Text('Popular services to get started', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                    const SizedBox(height: 16),

                    _ServiceCard(title: 'Caste Certificate', subtitle: 'SC / ST / OBC category proof'),
                    const SizedBox(height: 12),
                    _ServiceCard(title: 'Domicile Certificate', subtitle: 'Proof of residence in the state'),
                    const SizedBox(height: 12),
                    _ServiceCard(title: 'Income Certificate', subtitle: 'Proof of annual family income'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _ServiceCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Start now', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF432CBB))),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 14, color: Color(0xFF432CBB)),
            ],
          ),
        ],
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _NoApplicationsMockup extends StatelessWidget {
  const _NoApplicationsMockup();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                      SvgPicture.asset(
                        _nationalEmblemLogoPath,
                        height: 36,
                        errorBuilder: (c, e, s) => const Icon(
                          Icons.account_balance,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        _unionLogoPath,
                        height: 28,
                        errorBuilder: (c, e, s) => const Icon(
                          Icons.blur_on,
                          size: 28,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Government of India',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _titleColor,
                        ),
                      ),
                    ],
                    actions: [
                      Ux4gAppHeaderAction(
                        icon: Icons.notifications_outlined,
                        onPressed: () {},
                      ),
                    ],
                    showAvatar: true,
                    avatarInitials: 'R',
                  ),
                  const Divider(height: 1, color: _borderColor),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    const Text(
                      'Good morning, Ramesh',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "You haven't started any applications yet",
                      style: TextStyle(fontSize: 13, color: _subtleText),
                    ),
                    const SizedBox(height: 40),

                    // Empty state
                    Center(
                      child: Column(
                        children: [
                          // Illustration icon
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F0FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.laptop_mac_outlined,
                              size: 32,
                              color: _primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No active applications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _titleColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Start your application easily by clicking on the\nbutton below',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: _subtleText),
                          ),
                          const SizedBox(height: 24),
                          Ux4gButton(
                            text: 'Start application',
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            contentColor: _primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Popular services
                    const Text(
                      'Popular services to get started',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildServiceCard(
                      'Caste Certificate',
                      'SC / ST / OBC category proof',
                    ),
                    const SizedBox(height: 12),
                    _buildServiceCard(
                      'Domicile Certificate',
                      'Proof of residence in the state',
                    ),
                    const SizedBox(height: 12),
                    _buildServiceCard(
                      'Income Certificate',
                      'Proof of annual family income',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _titleColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text(
                'Start now',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _primaryColor,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 14, color: _primaryColor),
            ],
          ),
        ],
      ),
    );
  }
}
