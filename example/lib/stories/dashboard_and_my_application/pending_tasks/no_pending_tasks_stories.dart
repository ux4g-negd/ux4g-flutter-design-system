import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _greenColor = Color(0xFF16A34A);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final noPendingTasksComponent = WidgetbookComponent(
  name: 'No Pending Tasks',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'No Pending Tasks',
          description:
              'An empty state pattern shown when the user has no pending tasks. '
              'Displays a success check icon and a message that all applications are progressing smoothly.',
          code: _noPendingTasksCode,
          center: true,
          child: const _NoPendingTasksMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _noPendingTasksCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoPendingTasksScreen extends StatelessWidget {
  const NoPendingTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pending Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF111827))),
                    const SizedBox(height: 4),
                    Text("You're all caught up", style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.arrow_back, size: 14, color: Color(0xFF432CBB)),
                        const SizedBox(width: 4),
                        Text('Back to home', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF432CBB))),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, size: 64, color: Color(0xFF16A34A)),
                          const SizedBox(height: 20),
                          Text('No pending tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const SizedBox(height: 8),
                          Text(
                            'You have no pending tasks right now. All\nyour applications are progressing\nsmoothly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
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
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _NoPendingTasksMockup extends StatelessWidget {
  const _NoPendingTasksMockup();

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
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Pending Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "You're all caught up",
                      style: TextStyle(fontSize: 13, color: _subtleText),
                    ),
                    const SizedBox(height: 12),

                    // Back to home link
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          size: 14,
                          color: _primaryColor,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Back to home',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Empty state centered
                    const SizedBox(height: 60),
                    Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 64,
                            color: _greenColor,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No pending tasks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _titleColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'You have no pending tasks right now. All\nyour applications are progressing\nsmoothly.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13, color: _subtleText),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
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
