import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _orangeColor = Color(0xFFF59E0B);
const Color _borderColor = Color(0xFFE5E7EB);
const String _nationalEmblemLogoPath = 'assets/national_amblam_logo.svg';
const String _unionLogoPath = 'assets/Union.svg';

final searchApplicationsComponent = WidgetbookComponent(
  name: 'Search Applications',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Search Applications',
          description:
              'A search pattern for finding applications by reference number or service name. '
              'Shows search input, result count, and application cards with expanded details.',
          code: _searchApplicationsCode,
          center: true,
          child: const _SearchApplicationsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _searchApplicationsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchApplicationsScreen extends StatefulWidget {
  const SearchApplicationsScreen({super.key});

  @override
  State<SearchApplicationsScreen> createState() => _SearchApplicationsScreenState();
}

class _SearchApplicationsScreenState extends State<SearchApplicationsScreen> {
  final _searchController = TextEditingController(text: 'income');

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
                    Text('Good morning, Ramesh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('Find an application by reference or service name', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 16),
                    // Search bar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () => _searchController.clear()),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(color: Color(0xFF432CBB), borderRadius: BorderRadius.circular(8)),
                          child: IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('2 results for "income"', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 16),
                    // Result cards using Ux4gResultRow
                    Ux4gResultRow(
                      title: 'Income Certificate',
                      actionButtonText: 'Track',
                      initialExpanded: true,
                      detailsColumns: 2,
                      statusTag: 'Under review',
                      tagColorScheme: Ux4gTagColor.warning,
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
                          text: '8 days left',
                          textColor: Color(0xFF1F2937),
                          leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                        ),
                        Ux4gPillSegment(text: 'Under review', textColor: Color(0xFF1F2937)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Ux4gResultRow(
                      title: 'Income Certificate',
                      actionButtonText: 'Track',
                      initialExpanded: false,
                      statusTag: 'Under review',
                      tagColorScheme: Ux4gTagColor.warning,
                      metadataSegments: [
                        Ux4gPillSegment(
                          text: '8 days left',
                          textColor: Color(0xFF1F2937),
                          leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Color(0xFFF59E0B), shape: BoxShape.circle)),
                        ),
                        Ux4gPillSegment(text: 'Under review', textColor: Color(0xFF1F2937)),
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
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _SearchApplicationsMockup extends StatefulWidget {
  const _SearchApplicationsMockup();

  @override
  State<_SearchApplicationsMockup> createState() => _SearchApplicationsMockupState();
}

class _SearchApplicationsMockupState extends State<_SearchApplicationsMockup> {
  final _searchController = TextEditingController(text: 'income');

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
                    const Text('Find an application by reference or service name', style: TextStyle(fontSize: 13, color: _subtleText)),
                    const SizedBox(height: 16),

                    // Search bar
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () => _searchController.clear(),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: _borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: _borderColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: _primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Result count
                    const Text('2 results for "income"', style: TextStyle(fontSize: 13, color: _subtleText)),
                    const SizedBox(height: 16),

                    // Result Card 1 - Expanded
                    _buildExpandedResultCard(),
                    const SizedBox(height: 16),

                    // Result Card 2 - Collapsed
                    _buildCollapsedResultCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedResultCard() {
    return Ux4gCard(
      cornerRadius: 12,
      borderColor: _borderColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Income Certificate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor)),
                Row(
                  children: [
                    Ux4gButton(
                      text: 'Track',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.small,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_up, size: 20, color: _subtleText),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Status pill
            Ux4gUnifiedPillTag(
              segments: [
                Ux4gPillSegment(
                  text: '8 days left',
                  textColor: const Color(0xFF1F2937),
                  leading: Container(width: 8, height: 8, decoration: const BoxDecoration(color: _orangeColor, shape: BoxShape.circle)),
                ),
                Ux4gPillSegment(
                  text: 'Under review',
                  textColor: const Color(0xFF1F2937),
                ),
              ],
              borderColor: const Color(0xFFD1D5DB),
            ),
            const SizedBox(height: 16),

            // Details grid
            _detailRow('Reference Number', 'INC-2026-MH-04127', 'Last Updated Date', '10 Apr 2026'),
            const SizedBox(height: 12),
            _detailRow('Submitted Date', '1 Apr 2026', 'Assigned Officer', 'Rahul Sharma'),
            const SizedBox(height: 12),
            _detailRow('Department', 'Revenue Department', 'Documents', 'ID Proof, Address\nProof'),

            const SizedBox(height: 16),
            Text('Action needed', style: TextStyle(fontSize: 11, color: _orangeColor)),
            const SizedBox(height: 4),
            Ux4gButton(
              text: 'Upload document',
              onPressed: () {},
              variant: Ux4gButtonVariant.ghost,
              size: Ux4gButtonSize.small,
              contentColor: _primaryColor,
              trailingIcon: Icons.file_upload_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedResultCard() {
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
                const Text('Income Certificate', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor)),
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
                  text: '8 days left',
                  textColor: const Color(0xFF1F2937),
                  leading: Container(width: 8, height: 8, decoration: const BoxDecoration(color: _orangeColor, shape: BoxShape.circle)),
                ),
                Ux4gPillSegment(
                  text: 'Under review',
                  textColor: const Color(0xFF1F2937),
                ),
              ],
              borderColor: const Color(0xFFD1D5DB),
            ),
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
}
