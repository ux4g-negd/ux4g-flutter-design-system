import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _errorColor = Color(0xFFDC2626);
const Color _orangeColor = Color(0xFFF59E0B);
const Color _greenColor = Color(0xFF16A34A);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final pendingTasksComponent = WidgetbookComponent(
  name: 'Pending Tasks',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Pending Tasks',
          description:
              'A task-oriented pattern showing pending actions the user needs to complete. '
              'Includes tab filters, expandable task cards with deadlines, and completed tasks section.',
          code: _pendingTasksCode,
          center: true,
          child: const _PendingTasksMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _pendingTasksCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PendingTasksScreen extends StatefulWidget {
  const PendingTasksScreen({super.key});

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  int _selectedTab = 2;

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pending Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('3 tasks need your attention', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 16),
                    // Tab filters
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Ux4gChoiceChip(text: 'All', selected: _selectedTab == 0, onClick: () => setState(() => _selectedTab = 0), borderRadius: 4),
                        Ux4gChoiceChip(text: 'Pending', selected: _selectedTab == 1, onClick: () => setState(() => _selectedTab = 1), borderRadius: 4),
                        Ux4gChoiceChip(text: 'Under Review', selected: _selectedTab == 2, onClick: () => setState(() => _selectedTab = 2), borderRadius: 4),
                        Ux4gChoiceChip(text: 'Approved', selected: _selectedTab == 3, onClick: () => setState(() => _selectedTab = 3), borderRadius: 4),
                        Ux4gChoiceChip(text: 'Rejected', selected: _selectedTab == 4, onClick: () => setState(() => _selectedTab = 4), borderRadius: 4),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Task cards...
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

class _PendingTasksMockup extends StatefulWidget {
  const _PendingTasksMockup();

  @override
  State<_PendingTasksMockup> createState() => _PendingTasksMockupState();
}

class _PendingTasksMockupState extends State<_PendingTasksMockup> {
  int _selectedTab = 2;

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
                        errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 28, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      SvgPicture.asset(
                        _unionLogoPath,
                        height: 28,
                        errorBuilder: (c, e, s) => const Icon(Icons.blur_on, size: 28, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Text('Government of India', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
                    ],
                    actions: [
                      Ux4gAppHeaderAction(icon: Icons.notifications_outlined, onPressed: () {}),
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
                    // Title
                    const Text('Pending Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _titleColor)),
                    const SizedBox(height: 4),
                    const Text('3 tasks need your attention', style: TextStyle(fontSize: 13, color: _subtleText)),
                    const SizedBox(height: 16),

                    // Tab filters
                    _buildTabFilters(),
                    const SizedBox(height: 20),

                    // Task Card 1 - Expanded
                    _buildExpandedTaskCard(
                      icon: Icons.upload_file_outlined,
                      title: 'Upload income proof',
                      subtitle: 'Income Certificate · INC-2026-MH-04127',
                      urgencyText: 'Overdue by 2 days',
                      urgencyColor: _errorColor,
                      deadline: '10 Apr 2026',
                      reference: 'INC-2026-MH-04127',
                      department: 'Revenue Department',
                      supportText: 'Contact support',
                      actionText: 'Upload now',
                    ),
                    const SizedBox(height: 16),

                    // Task Card 2 - Collapsed
                    _buildCollapsedTaskCard(
                      icon: Icons.payment_outlined,
                      title: 'Pay application fee',
                      subtitle: 'Birth Certificate · ₹50 application fee',
                      urgencyText: 'Due in 5 days',
                      urgencyColor: const Color(0xFFAD4E00),
                      urgencyBgColor: Ux4gPalette.secondary100,
                      actionText: 'Pay now',
                      actionFilled: true,
                    ),
                    const SizedBox(height: 16),

                    // Task Card 3 - Collapsed
                    _buildCollapsedTaskCard(
                      icon: Icons.calendar_today_outlined,
                      title: 'Schedule field inspection',
                      subtitle: 'Land Records Update · LRU-2026-MH-00231',
                      urgencyText: 'Due in 9 days',
                      urgencyColor: const Color(0xFF006D75),
                      urgencyBgColor: const Color(0xFFC9F7F2),
                      actionText: 'Schedule slot',
                      actionFilled: false,
                    ),
                    const SizedBox(height: 24),

                    // Completed section
                    const Divider(color: _borderColor),
                    const SizedBox(height: 16),
                    const Text('Completed today', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                    const SizedBox(height: 16),

                    // Completed card
                    _buildCompletedTaskCard(
                      icon: Icons.verified_user_outlined,
                      title: 'Aadhaar e-KYC verification',
                      subtitle: 'Ration Card Renewal · RCR-2026-MH-00917',
                      actionText: 'View receipt',
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

  Widget _buildTabFilters() {
    final tabs = [
      {'label': 'All', 'count': '62'},
      {'label': 'Pending', 'count': '3'},
      {'label': 'Under Review', 'count': '12'},
      {'label': 'Approved', 'count': '41'},
      {'label': 'Rejected', 'count': '6'},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(tabs.length, (index) {
        final isSelected = index == _selectedTab;
        return Ux4gChoiceChip(
          text: tabs[index]['label']!,
          selected: isSelected,
          onClick: () => setState(() => _selectedTab = index),
          borderRadius: 4,
          trailingContent: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withValues(alpha: 0.25) : _primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tabs[index]['count']!,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildExpandedTaskCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String urgencyText,
    required Color urgencyColor,
    required String deadline,
    required String reference,
    required String department,
    required String supportText,
    required String actionText,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 20, color: _subtleText),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: _subtleText)),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_up, size: 20, color: _subtleText),
              ],
            ),
            const SizedBox(height: 10),

            // Urgency tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: urgencyColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(urgencyText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: urgencyColor)),
            ),
            const SizedBox(height: 12),
            const Divider(color: _borderColor, height: 1),
            const SizedBox(height: 16),

            // Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Deadline', style: TextStyle(fontSize: 11, color: _subtleText)),
                      const SizedBox(height: 2),
                      Text(deadline, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reference', style: TextStyle(fontSize: 11, color: _subtleText)),
                      const SizedBox(height: 2),
                      Text(reference, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Department', style: TextStyle(fontSize: 11, color: _subtleText)),
                      const SizedBox(height: 2),
                      Text(department, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Have issues?', style: TextStyle(fontSize: 11, color: _subtleText)),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(supportText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _primaryColor)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 14, color: _primaryColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action button
            SizedBox(
              width: double.infinity,
              child: Ux4gButton(
                text: actionText,
                onPressed: () {},
                variant: Ux4gButtonVariant.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedTaskCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String urgencyText,
    required Color urgencyColor,
    Color? urgencyBgColor,
    required String actionText,
    required bool actionFilled,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 20, color: _subtleText),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: _subtleText)),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: urgencyBgColor ?? urgencyColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(urgencyText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: urgencyColor)),
            ),
            const SizedBox(height: 12),

            // Action button
            SizedBox(
              width: double.infinity,
              child: Ux4gButton(
                text: actionText,
                onPressed: () {},
                variant: actionFilled ? Ux4gButtonVariant.primary : Ux4gButtonVariant.outline,
                contentColor: actionFilled ? null : _primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedTaskCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 20, color: _subtleText),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 12, color: _subtleText)),
                    ],
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
              ],
            ),
            const SizedBox(height: 8),

            // Completed tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _greenColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Completed', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: _greenColor)),
            ),
            const SizedBox(height: 12),

            // View receipt link
            Center(
              child: Text(actionText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}
