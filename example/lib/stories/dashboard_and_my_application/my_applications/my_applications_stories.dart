import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _errorColor = Color(0xFFDC2626);
const Color _greenColor = Color(0xFF16A34A);
const Color _orangeColor = Color(0xFFF59E0B);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final myApplicationsComponent = WidgetbookComponent(
  name: 'My Applications',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'My Applications',
          description:
              'A dashboard pattern showing an overview of user applications with '
              'summary stats, tab filters, and detailed application cards with tracking.',
          code: _myApplicationsCode,
          center: true,
          child: const _MyApplicationsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _myApplicationsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  int _selectedTab = 2;

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
                    Text(
                      'Good morning, Ramesh',
                      style: Ux4gTypography.headingMd.copyWith(color: Ux4gPalette.neutral900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'An overview of your applications',
                      style: Ux4gTypography.bodySmall.copyWith(color: Ux4gPalette.neutral600),
                    ),
                    const SizedBox(height: 20),

                    // Stats grid
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(value: '2', label: 'Active'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(value: '1', label: 'Needs attention', showDot: true, dotColor: Ux4gPalette.error500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(value: '5', label: 'Completed'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(value: '8', label: 'Total'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Your applications title
                    Text(
                      'Your applications',
                      style: Ux4gTypography.headingSm.copyWith(color: Ux4gPalette.neutral900),
                    ),
                    const SizedBox(height: 16),

                    // Tab filters using Ux4gChoiceChip with trailingContent
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Ux4gChoiceChip(text: 'All', selected: _selectedTab == 0, onClick: () => setState(() => _selectedTab = 0), borderRadius: 4, trailingContent: _countBadge('62', _selectedTab == 0)),
                        Ux4gChoiceChip(text: 'Pending', selected: _selectedTab == 1, onClick: () => setState(() => _selectedTab = 1), borderRadius: 4, trailingContent: _countBadge('3', _selectedTab == 1)),
                        Ux4gChoiceChip(text: 'Under Review', selected: _selectedTab == 2, onClick: () => setState(() => _selectedTab = 2), borderRadius: 4, trailingContent: _countBadge('12', _selectedTab == 2)),
                        Ux4gChoiceChip(text: 'Approved', selected: _selectedTab == 3, onClick: () => setState(() => _selectedTab = 3), borderRadius: 4, trailingContent: _countBadge('41', _selectedTab == 3)),
                        Ux4gChoiceChip(text: 'Rejected', selected: _selectedTab == 4, onClick: () => setState(() => _selectedTab = 4), borderRadius: 4, trailingContent: _countBadge('6', _selectedTab == 4)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Application Card 1 - Escalation available
                    Ux4gResultRow(
                      title: 'Income Certificate',
                      actionButtonText: 'Track',
                      initialExpanded: true,
                      detailsColumns: 2,
                      details: const [
                        Ux4gResultDetail(label: 'Reference Number', value: 'PMS-2026-MH-02231'),
                        Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                        Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                        Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                        Ux4gResultDetail(label: 'Department', value: 'Social Welfare Department'),
                        Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                      ],
                      metadataSegments: [
                        Ux4gPillSegment(
                          text: '2 days overdue',
                          textColor: Color(0xFF1F2937),
                          leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Color(0xFFDC2626), shape: BoxShape.circle)),
                        ),
                        Ux4gPillSegment(
                          text: 'Escalation available',
                          textColor: Color(0xFFDC2626),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Application Card 2 - Action needed
                    Ux4gResultRow(
                      title: 'Income Certificate',
                      actionButtonText: 'Track',
                      initialExpanded: true,
                      detailsColumns: 2,
                      details: const [
                        Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04127'),
                        Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                        Ux4gResultDetail(label: 'Submitted Date', value: '1 Apr 2026'),
                        Ux4gResultDetail(label: 'Assigned Officer', value: 'Rahul Sharma'),
                        Ux4gResultDetail(label: 'Department', value: 'Revenue Department'),
                        Ux4gResultDetail(label: 'Documents', value: 'ID Proof, Address Proof'),
                      ],
                      metadataSegments: [
                        Ux4gPillSegment(
                          text: '4 days left',
                          textColor: Color(0xFFF59E0B),
                          leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                        ),
                        Ux4gPillSegment(
                          text: 'Action needed',
                          textColor: Color(0xFFF59E0B),
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Application Card 3 - Under review (compact)
                    Ux4gResultRow(
                      title: 'Income Certificate',
                      actionButtonText: 'Track',
                      initialExpanded: false,
                      details: const [
                        Ux4gResultDetail(label: 'Reference Number', value: 'INC-2026-MH-04128'),
                        Ux4gResultDetail(label: 'Last Updated Date', value: '10 Apr 2026'),
                      ],
                      metadataSegments: [
                        Ux4gPillSegment(
                          text: '8 days left',
                          textColor: Color(0xFF1F2937),
                          leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                        ),
                        Ux4gPillSegment(
                          text: 'Under review',
                          textColor: Color(0xFF1F2937),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Application Card 4 - Birth Certificate (completed)
                    Ux4gResultRow(
                      title: 'Birth Certificate',
                      statusTag: 'Completed',
                      tagColorScheme: Ux4gTagColor.success,
                      actionButtonText: 'Download',
                      actionButtonIcon: Icons.file_download_outlined,
                      initialExpanded: false,
                      details: const [
                        Ux4gResultDetail(label: 'Issued', value: '05 Apr 2026'),
                        Ux4gResultDetail(label: 'Valid till', value: '05 Apr 2027'),
                      ],
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
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final bool showDot;
  final Color? dotColor;
  const _StatCard({required this.value, required this.label, this.showDot = false, this.dotColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Ux4gPalette.neutral200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(value, style: Ux4gTypography.headingMd.copyWith(color: Ux4gPalette.neutral900)),
              if (showDot) ...[
                const SizedBox(width: 6),
                Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor)),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: Ux4gTypography.bodyXs.copyWith(color: Ux4gPalette.neutral500)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String count;
  final bool isSelected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.count, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Ux4gPalette.primary600 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Ux4gPalette.primary600 : Ux4gPalette.neutral200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : Ux4gPalette.neutral900)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : Ux4gPalette.neutral100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(count, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Ux4gPalette.neutral600)),
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

class _MyApplicationsMockup extends StatefulWidget {
  const _MyApplicationsMockup();

  @override
  State<_MyApplicationsMockup> createState() => _MyApplicationsMockupState();
}

class _MyApplicationsMockupState extends State<_MyApplicationsMockup> {
  int _selectedTab = 2; // Under Review selected by default

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
                    // Greeting
                    const Text('Good morning, Ramesh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _titleColor)),
                    const SizedBox(height: 4),
                    const Text('An overview of your applications', style: TextStyle(fontSize: 13, color: _subtleText)),
                    const SizedBox(height: 20),

                    // Stats grid
                    _buildStatsGrid(),
                    const SizedBox(height: 24),

                    // Your applications
                    const Text('Your applications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor)),
                    const SizedBox(height: 16),

                    // Tab filters
                    _buildTabFilters(),
                    const SizedBox(height: 20),

                    // Application cards
                    _buildApplicationCard(
                      title: 'Income Certificate',
                      statusText: '2 days overdue',
                      statusColor: _errorColor,
                      badgeText: 'Escalation available',
                      badgeColor: _orangeColor,
                      referenceNumber: 'PMS-2026-MH-02231',
                      lastUpdated: '10 Apr 2026',
                      submittedDate: '1 Apr 2026',
                      assignedOfficer: 'Rahul Sharma',
                      department: 'Social Welfare\nDepartment',
                      documents: 'ID Proof, Address\nProof',
                      escalation: 'Register grievance',
                    ),
                    const SizedBox(height: 16),

                    _buildApplicationCard(
                      title: 'Income Certificate',
                      statusText: '4 days left',
                      statusColor: _orangeColor,
                      badgeText: 'Action needed',
                      badgeColor: _orangeColor,
                      referenceNumber: 'INC-2026-MH-04127',
                      lastUpdated: '10 Apr 2026',
                      submittedDate: '1 Apr 2026',
                      assignedOfficer: 'Rahul Sharma',
                      department: 'Revenue Department',
                      documents: 'ID Proof, Address\nProof',
                      actionText: 'Upload document',
                      actionIcon: Icons.file_upload_outlined,
                    ),
                    const SizedBox(height: 16),

                    _buildApplicationCardCompact(
                      title: 'Income Certificate',
                      statusText: '8 days left',
                      statusColor: Color(0xFFF59E0B),
                      badgeText: 'Under review',
                      badgeColor: Color(0xFF1F2937),
                    ),
                    const SizedBox(height: 16),

                    _buildApplicationCardMinimal(
                      title: 'Birth Certificate',
                      hasDownload: true,
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

  Widget _countBadge(String count, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.25) : _primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _StatCard(value: '2', label: 'Active')),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(value: '1', label: 'Needs attention', dot: true, dotColor: _errorColor)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StatCard(value: '5', label: 'Completed')),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(value: '8', label: 'Total')),
          ],
        ),
      ],
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
              color: isSelected ? Colors.white.withOpacity(0.25) : _primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tabs[index]['count']!,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildApplicationCard({
    required String title,
    required String statusText,
    required Color statusColor,
    required String badgeText,
    required Color badgeColor,
    required String referenceNumber,
    required String lastUpdated,
    required String submittedDate,
    required String assignedOfficer,
    required String department,
    required String documents,
    String? escalation,
    String? actionText,
    IconData? actionIcon,
  }) {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row with Track button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor)),
                Row(
                  children: [
                    Ux4gButton(
                      text: 'Track',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.small,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Status row
            Ux4gUnifiedPillTag(
              segments: [
                Ux4gPillSegment(
                  text: statusText,
                  textColor: const Color(0xFF1F2937),
                  leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                ),
                Ux4gPillSegment(
                  text: badgeText,
                  textColor: const Color(0xFFDC2626),
                ),
              ],
              borderColor: const Color(0xFFD1D5DB),
            ),
            const SizedBox(height: 16),

            // Details grid
            _detailRow('Reference Number', referenceNumber, 'Last Updated Date', lastUpdated),
            const SizedBox(height: 12),
            _detailRow('Submitted Date', submittedDate, 'Assigned Officer', assignedOfficer),
            const SizedBox(height: 12),
            _detailRow('Department', department, 'Documents', documents),

            // Escalation or Action
            if (escalation != null) ...[
              const SizedBox(height: 16),
              Text('Escalation', style: TextStyle(fontSize: 11, color: _orangeColor)),
              const SizedBox(height: 4),
              Ux4gButton(
                text: 'Register grievance',
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.small,
                contentColor: _primaryColor,
                trailingIcon: Icons.arrow_forward,
              ),
            ],

            if (actionText != null) ...[
              const SizedBox(height: 16),
              Text('Action needed', style: TextStyle(fontSize: 11, color: _orangeColor)),
              const SizedBox(height: 4),
              Ux4gButton(
                text: actionText,
                onPressed: () {},
                variant: Ux4gButtonVariant.ghost,
                size: Ux4gButtonSize.small,
                contentColor: _primaryColor,
                trailingIcon: actionIcon ?? Icons.arrow_forward,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label1, String value1, String label2, String value2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label1, style: const TextStyle(fontSize: 11, color: _subtleText)),
              const SizedBox(height: 2),
              Text(value1, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label2, style: const TextStyle(fontSize: 11, color: _subtleText)),
              const SizedBox(height: 2),
              Text(value2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _titleColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationCardCompact({
    required String title,
    required String statusText,
    required Color statusColor,
    required String badgeText,
    required Color badgeColor,
  }) {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor)),
                Row(
                  children: [
                    Ux4gButton(
                      text: 'Track',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.small,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Ux4gUnifiedPillTag(
              segments: [
                Ux4gPillSegment(
                  text: statusText,
                  textColor: const Color(0xFF1F2937),
                  leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                ),
                Ux4gPillSegment(
                  text: badgeText,
                  textColor: Color(0xFF1F2937),
                ),
              ],
              borderColor: const Color(0xFFD1D5DB),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationCardMinimal({
    required String title,
    bool hasDownload = false,
  }) {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor)),
                const SizedBox(width: 8),
                const Icon(Icons.check_circle, size: 18, color: _greenColor),
              ],
            ),
            Row(
              children: [
                Ux4gButton(
                  text: 'Download',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.ghost,
                  size: Ux4gButtonSize.small,
                  contentColor: _primaryColor,
                  leadingIcon: Icons.file_download_outlined,
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────────────────────────────────
// Stat Card
// ───────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final bool dot;
  final Color? dotColor;

  const _StatCard({
    required this.value,
    required this.label,
    this.dot = false,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor)),
              if (dot) ...[
                const SizedBox(width: 6),
                Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor ?? _errorColor)),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: _subtleText)),
        ],
      ),
    );
  }
}
