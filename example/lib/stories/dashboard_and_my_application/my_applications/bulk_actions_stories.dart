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

final bulkActionsComponent = WidgetbookComponent(
  name: 'Bulk Actions',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Bulk Actions',
          description:
              'A multi-select pattern allowing users to select multiple applications '
              'for bulk actions like downloading or tracking together.',
          code: _bulkActionsCode,
          center: true,
          child: const _BulkActionsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _bulkActionsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BulkActionsScreen extends StatefulWidget {
  const BulkActionsScreen({super.key});

  @override
  State<BulkActionsScreen> createState() => _BulkActionsScreenState();
}

class _BulkActionsScreenState extends State<BulkActionsScreen> {
  final Set<int> _selected = {0, 1, 2};

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
                    Text('Select applications to download or track together', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    // Bulk action bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${_selected.length} selected', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                              TextButton(onPressed: () => setState(() => _selected.clear()), child: Text('Clear filters')),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Ux4gButton(text: 'Download all', onPressed: () {}, variant: Ux4gButtonVariant.outline, contentColor: Color(0xFF432CBB)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Ux4gButton(text: 'Track together', onPressed: () {}, variant: Ux4gButtonVariant.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Application cards with checkboxes
                    // ... cards here
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

class _BulkActionsMockup extends StatefulWidget {
  const _BulkActionsMockup();

  @override
  State<_BulkActionsMockup> createState() => _BulkActionsMockupState();
}

class _BulkActionsMockupState extends State<_BulkActionsMockup> {
  final Set<int> _selected = {0, 1, 2};

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
                    const Text('Select applications to download or track together', style: TextStyle(fontSize: 13, color: _subtleText)),
                    const SizedBox(height: 20),

                    // Bulk action bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Ux4gPalette.primary50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_selected.length} selected',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor),
                              ),
                              GestureDetector(
                                onTap: () => setState(() => _selected.clear()),
                                child: const Text('Clear filters', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _primaryColor)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Ux4gButton(
                                  text: 'Download all',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.outline,
                                  contentColor: _primaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Ux4gButton(
                                  text: 'Track together',
                                  onPressed: () {},
                                  variant: Ux4gButtonVariant.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Application cards
                    _buildSelectableCard(
                      index: 0,
                      title: 'Income Certificate',
                      statusText: '2 days overdue',
                      statusColor: _errorColor,
                      badgeText: 'Escalation available',
                      badgeColor: _orangeColor,
                      actionText: 'Track',
                    ),
                    const SizedBox(height: 12),
                    _buildSelectableCard(
                      index: 1,
                      title: 'Income Certificate',
                      statusText: '4 days left',
                      statusColor: _errorColor,
                      badgeText: 'Action needed',
                      badgeColor: _orangeColor,
                      actionText: 'Track',
                    ),
                    const SizedBox(height: 12),
                    _buildSelectableCard(
                      index: 2,
                      title: 'Income Certificate',
                      statusText: '8 days left',
                      statusColor: _orangeColor,
                      badgeText: 'Under review',
                      badgeColor: const Color(0xFF1F2937),
                      actionText: 'Track',
                    ),
                    const SizedBox(height: 12),
                    _buildCompletedCard(
                      index: 3,
                      title: 'Birth\nCertificate',
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

  Widget _buildSelectableCard({
    required int index,
    required String title,
    required String statusText,
    required Color statusColor,
    required String badgeText,
    required Color badgeColor,
    required String actionText,
  }) {
    final isSelected = _selected.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selected.remove(index);
          } else {
            _selected.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isSelected ? _primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isSelected ? _primaryColor : const Color(0xFFD1D5DB), width: 1.5),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                      Row(
                        children: [
                          Ux4gButton(
                            text: actionText,
                            onPressed: () {},
                            variant: Ux4gButtonVariant.outline,
                            size: Ux4gButtonSize.small,
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.keyboard_arrow_down, size: 18, color: _subtleText),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(width: 7, height: 7, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(statusText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1F2937))),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: badgeColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedCard({
    required int index,
    required String title,
  }) {
    final isSelected = _selected.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selected.remove(index);
          } else {
            _selected.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? _primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isSelected ? _primaryColor : const Color(0xFFD1D5DB), width: 1.5),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),

            // Title with green check
            Expanded(
              child: Row(
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
                  const SizedBox(width: 6),
                  const Icon(Icons.check_circle, size: 18, color: _greenColor),
                ],
              ),
            ),

            // Download button
            Row(
              children: [
                Ux4gButton(
                  text: 'Download',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.ghost,
                  size: Ux4gButtonSize.small,
                  contentColor: _titleColor,
                  leadingIcon: Icons.file_download_outlined,
                ),
                const SizedBox(width: 6),
                const Icon(Icons.keyboard_arrow_down, size: 18, color: _subtleText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
