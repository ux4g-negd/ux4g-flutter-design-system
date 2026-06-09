import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final categoryServiceListComponent = WidgetbookComponent(
  name: 'Category Service List',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Category Service List',
          description:
              'Category-specific service listing with breadcrumb, filter chips, '
              'and paginated service rows with Apply actions.',
          code: _categoryServiceListCode,
          center: true,
          child: const _CategoryServiceListMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _categoryServiceListCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class CategoryServiceListScreen extends StatefulWidget {
  const CategoryServiceListScreen({super.key});

  @override
  State<CategoryServiceListScreen> createState() => _CategoryServiceListScreenState();
}

class _CategoryServiceListScreenState extends State<CategoryServiceListScreen> {
  int _selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            // Breadcrumb
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFFF2EFFF),
              child: Row(
                children: [
                  Text('Home', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  Text('  ›  ', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  Text('Services', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  Text('  ›  ', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  Text('Health', style: TextStyle(fontSize: 12, color: Color(0xFF432CBB), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            // Title + filter chips + list
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Health services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('Hospitals, certificates, insurance and disability',
                          style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      ],
                    ),
                  ),
                  // Results count + Filters button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Text('48 services', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Ux4gButton(text: 'Filters', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small, leadingIcon: Icons.tune),
                      ],
                    ),
                  ),
                  // Filter chips
                  Ux4gChipGroup(
                    labels: const ['All · 48', 'Hospitals · 12', 'Certificates · 18', 'Insurance'],
                    selectedIndex: _selectedChip,
                    onChanged: (i) => setState(() => _selectedChip = i),
                    layout: Ux4gChipGroupLayout.scroll,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  // Service list
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _ServiceRow(title: 'Ayushman Bharat Health Card', fee: 'Free', time: '7 days'),
                        _ServiceRow(title: 'Hospital Empanelment', fee: 'Free', time: '30 days'),
                        _ServiceRow(title: 'Birth Certificate', fee: 'Free', time: '20 mins'),
                        _ServiceRow(title: 'Disability Certificate (UDID)', fee: 'Free', time: '15 days'),
                        _ServiceRow(title: 'Health Insurance Claim', fee: 'Free', time: '10 days'),
                        _ServiceRow(title: 'Vaccination Certificate', fee: 'Free', time: 'Instant'),
                        _ServiceRow(title: 'Medical Reimbursement', fee: '₹ 500', time: '21 days', isPaid: true),
                        _ServiceRow(title: 'Janani Suraksha Yojana', fee: 'Free', time: 'On delivery'),
                      ],
                    ),
                  ),
                  // Pagination
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Ux4gPagination(totalPages: 8, currentPage: 1, onPageChanged: (_) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final String title;
  final String fee;
  final String time;
  final bool isPaid;
  const _ServiceRow({required this.title, required this.fee, required this.time, this.isPaid = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(isPaid ? 'Paid' : 'Free',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF171717))),
                    ),
                    if (isPaid) ...[
                      const SizedBox(width: 4),
                      Text(fee, style: TextStyle(fontSize: 11, color: Color(0xFF4B5563))),
                    ],
                    const SizedBox(width: 6),
                    Icon(Icons.access_time, size: 12, color: Color(0xFF4B5563)),
                    const SizedBox(width: 3),
                    Text(time, style: TextStyle(fontSize: 11, color: Color(0xFF4B5563))),
                  ],
                ),
              ],
            ),
          ),
          Ux4gButton(text: 'Apply', onPressed: () {}, variant: Ux4gButtonVariant.outline, size: Ux4gButtonSize.small),
        ],
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _CategoryServiceListMockup extends StatefulWidget {
  const _CategoryServiceListMockup();

  @override
  State<_CategoryServiceListMockup> createState() =>
      _CategoryServiceListMockupState();
}

class _CategoryServiceListMockupState
    extends State<_CategoryServiceListMockup> {
  int _selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // App Header - filled purple
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                color: _primaryColor,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'National Services Portal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Breadcrumb
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                color: Colors.white,
                child: const Row(
                  children: [
                    Icon(Icons.home_outlined, size: 14, color: _subtleText),
                    SizedBox(width: 4),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 12, color: _subtleText),
                    ),
                    Text(
                      '  ›  ',
                      style: TextStyle(fontSize: 12, color: _subtleText),
                    ),
                    Text(
                      'Services',
                      style: TextStyle(fontSize: 12, color: _subtleText),
                    ),
                    Text(
                      '  ›  ',
                      style: TextStyle(fontSize: 12, color: _subtleText),
                    ),
                    Text(
                      'Health',
                      style: TextStyle(
                        fontSize: 12,
                        color: _primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Title section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Health services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _titleColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hospitals, certificates, insurance and disability',
                      style: TextStyle(fontSize: 13, color: _subtleText),
                    ),
                  ],
                ),
              ),

              // Results count + Filters button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    const Text(
                      '48 services',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _titleColor,
                      ),
                    ),
                    const Spacer(),
                    Ux4gButton(
                      text: 'Filters',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.small,
                      leadingIcon: Icons.tune,
                    ),
                  ],
                ),
              ),

              // Filter chips
              Ux4gChipGroup(
                arrangement: Ux4gChipGroupArrangement.horizontal,
                chips: [
                  Ux4gChoiceChip(
                    text: 'All · 48',
                    selected: _selectedChip == 0,
                    onClick: () => setState(() => _selectedChip = 0),
                  ),
                  Ux4gChoiceChip(
                    text: 'Hospitals · 12',
                    selected: _selectedChip == 1,
                    onClick: () => setState(() => _selectedChip = 1),
                  ),
                  Ux4gChoiceChip(
                    text: 'Certificates · 18',
                    selected: _selectedChip == 2,
                    onClick: () => setState(() => _selectedChip = 2),
                  ),
                  Ux4gChoiceChip(
                    text: 'Insurance',
                    selected: _selectedChip == 3,
                    onClick: () => setState(() => _selectedChip = 3),
                  ),
                ],
              ),

              // Service list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildServiceRow(
                      'Ayushman Bharat Health Card',
                      'Free',
                      '7 days',
                      false,
                    ),
                    _buildServiceRow(
                      'Hospital Empanelment',
                      'Free',
                      '30 days',
                      false,
                    ),
                    _buildServiceRow(
                      'Birth Certificate',
                      'Free',
                      '20 mins',
                      false,
                    ),
                    _buildServiceRow(
                      'Disability Certificate (UDID)',
                      'Free',
                      '15 days',
                      false,
                    ),
                    _buildServiceRow(
                      'Health Insurance Claim',
                      'Free',
                      '10 days',
                      false,
                    ),
                    _buildServiceRow(
                      'Vaccination Certificate',
                      'Free',
                      'Instant',
                      false,
                    ),
                    _buildServiceRow(
                      'Medical Reimbursement',
                      '₹ 500',
                      '21 days',
                      true,
                    ),
                    _buildServiceRow(
                      'Janani Suraksha Yojana',
                      'Free',
                      'On delivery',
                      false,
                    ),
                  ],
                ),
              ),

              // Pagination dots
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: _subtleText,
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(
                      8,
                      (i) => Container(
                        width: i == 0 ? 10 : 8,
                        height: i == 0 ? 10 : 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == 0 ? _primaryColor : _borderColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: _subtleText,
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

  Widget _buildServiceRow(String title, String fee, String time, bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    // "Free" / "Paid" small bordered badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _borderColor),
                      ),
                      child: Text(
                        isPaid ? 'Paid' : 'Free',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _titleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Clock icon + time as plain text
                    const Icon(Icons.access_time, size: 13, color: _subtleText),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: _subtleText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Ux4gButton(
            text: 'Apply',
            onPressed: () {},
            variant: Ux4gButtonVariant.outline,
            size: Ux4gButtonSize.small,
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
        ],
      ),
    );
  }
}
