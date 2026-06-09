import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final searchResultsListComponent = WidgetbookComponent(
  name: 'Search Results List',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Search Results List',
          description:
              'Search results pattern with filter chips, result count, '
              'and paginated service cards with Apply actions.',
          code: _searchResultsListCode,
          center: true,
          child: const _SearchResultsListMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _searchResultsListCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class SearchResultsListScreen extends StatefulWidget {
  const SearchResultsListScreen({super.key});

  @override
  State<SearchResultsListScreen> createState() => _SearchResultsListScreenState();
}

class _SearchResultsListScreenState extends State<SearchResultsListScreen> {
  String _searchValue = 'income';
  int _selectedChip = 1; // 0=All, 1=Certificates, 2=Schemes, 3=Services

  final List<String> _options = [
    'Income Certificate',
    'Income Tax Return Filing',
    'Low Income Group Certificate',
    'Income & Asset Certificate',
    'EWS Certificate',
  ];

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
            const SizedBox(height: 20),
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Builder(
                builder: (context) {
                  final filtered = _options
                      .where((e) => e.toLowerCase().contains(_searchValue.toLowerCase()))
                      .toList();
                  return Ux4gSearchField(
                    value: _searchValue,
                    onValueChange: (v) => setState(() => _searchValue = v),
                    variant: Ux4gSearchFieldVariant.autocomplete,
                    placeholder: 'Search services...',
                    showVoiceIcon: true,
                    showClearIcon: true,
                    options: filtered,
                    onOptionSelected: (s) => setState(() => _searchValue = s),
                    buttonStyle: Ux4gSearchFieldButtonStyle.filled,
                  );
                },
              ),
            ),
            // Results count + filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text('48 results', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Ux4gChoiceChip(text: 'All · 48', selected: _selectedChip == 0, onClick: () => setState(() => _selectedChip = 0)),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(text: 'Certificates · 22', selected: _selectedChip == 1, onClick: () => setState(() => _selectedChip = 1)),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(text: 'Schemes · 14', selected: _selectedChip == 2, onClick: () => setState(() => _selectedChip = 2)),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(text: 'Services · 12', selected: _selectedChip == 3, onClick: () => setState(() => _selectedChip = 3)),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(text: 'Documents · 8', selected: false, onClick: () {}),
                  const SizedBox(width: 8),
                  Ux4gChoiceChip(text: 'Applications · 5', selected: false, onClick: () {}),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Results list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _ResultCard(title: 'Income Certificate', fee: 'Free', time: '20 mins'),
                  _ResultCard(title: 'Income Tax Return (ITR) Filing', fee: 'Free', time: '30 mins'),
                  _ResultCard(title: 'Low Income Group (LIG) Certificate', fee: 'Free', time: '7 days'),
                  _ResultCard(title: 'Income & Asset Certificate', fee: '₹50+', time: '15 days', isPaid: true),
                  _ResultCard(title: 'EWS Certificate', fee: 'Free', time: '10 days'),
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
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String fee;
  final String time;
  final bool isPaid;
  const _ResultCard({required this.title, required this.fee, required this.time, this.isPaid = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
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
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                          color: Color(0xFF171717))),
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

class _SearchResultsListMockup extends StatefulWidget {
  const _SearchResultsListMockup();

  @override
  State<_SearchResultsListMockup> createState() => _SearchResultsListMockupState();
}

class _SearchResultsListMockupState extends State<_SearchResultsListMockup> {
  int _selectedChip = 1;
  String _searchValue = 'income';

  final List<String> _options = [
    'Income Certificate',
    'Income Tax Return Filing',
    'Low Income Group Certificate',
    'Income & Asset Certificate',
    'EWS Certificate',
  ];

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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: _primaryColor,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'National Services Portal',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search bar area
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: Colors.white,
                child: Builder(
                  builder: (context) {
                    final filtered = _options
                        .where((e) => e.toLowerCase().contains(_searchValue.toLowerCase()))
                        .toList();
                    return Ux4gSearchField(
                      value: _searchValue,
                      onValueChange: (v) => setState(() => _searchValue = v),
                      variant: Ux4gSearchFieldVariant.autocomplete,
                      placeholder: 'Search services...',
                      showVoiceIcon: true,
                      showClearIcon: true,
                      options: filtered,
                      onOptionSelected: (s) => setState(() => _searchValue = s),
                      buttonStyle: Ux4gSearchFieldButtonStyle.filled,
                    );
                  },
                ),
              ),

              // Results count + Filters
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Text('48 results', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Ux4gChoiceChip(text: 'All · 48', selected: _selectedChip == 0, onClick: () => setState(() => _selectedChip = 0)),
                    const SizedBox(width: 8),
                    Ux4gChoiceChip(text: 'Certificates · 22', selected: _selectedChip == 1, onClick: () => setState(() => _selectedChip = 1)),
                    const SizedBox(width: 8),
                    Ux4gChoiceChip(text: 'Schemes · 14', selected: _selectedChip == 2, onClick: () => setState(() => _selectedChip = 2)),
                    const SizedBox(width: 8),
                    Ux4gChoiceChip(text: 'Services · 12', selected: _selectedChip == 3, onClick: () => setState(() => _selectedChip = 3)),
                    const SizedBox(width: 8),
                    Ux4gChoiceChip(text: 'Documents · 8', selected: false, onClick: () {}),
                    const SizedBox(width: 8),
                    Ux4gChoiceChip(text: 'Applications · 5', selected: false, onClick: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Results list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildResultCard('Income Certificate', 'Free', '20 mins', false),
                    _buildResultCard('Income Tax Return (ITR) Filing', 'Free', '30 mins', false),
                    _buildResultCard('Low Income Group (LIG)\nCertificate', 'Free', '7 days', false),
                    _buildResultCard('Income & Asset Certificate', '₹ 50+', '15 days', true),
                    _buildResultCard('EWS Certificate', 'Free', '10 days', false),
                  ],
                ),
              ),

              // Pagination dots
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.chevron_left, size: 20, color: _subtleText),
                    const SizedBox(width: 8),
                    ...List.generate(8, (i) => Container(
                      width: i == 0 ? 10 : 8,
                      height: i == 0 ? 10 : 8,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == 0 ? _primaryColor : _borderColor,
                      ),
                    )),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, size: 20, color: _subtleText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildResultCard(String title, String fee, String time, bool isPaid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isPaid ? 'Paid' : 'Free',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF171717),
                        ),
                      ),
                    ),
                    if (isPaid) ...[
                      const SizedBox(width: 4),
                      Text(fee, style: const TextStyle(fontSize: 11, color: _subtleText)),
                    ],
                    const SizedBox(width: 6),
                    const Icon(Icons.access_time, size: 12, color: _subtleText),
                    const SizedBox(width: 3),
                    Text(time, style: const TextStyle(fontSize: 11, color: _subtleText)),
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
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 20, color: _subtleText),
        ],
      ),
    );
  }
}
