import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final noResultsComponent = WidgetbookComponent(
  name: 'No Results',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'No Results',
          description:
              'Empty state pattern when search returns no results. Shows suggestions, '
              'a browse all link, and popular services to help users continue.',
          code: _noResultsCode,
          center: true,
          child: const _NoResultsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _noResultsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class NoResultsScreen extends StatefulWidget {
  const NoResultsScreen({super.key});

  @override
  State<NoResultsScreen> createState() => _NoResultsScreenState();
}

class _NoResultsScreenState extends State<NoResultsScreen> {
  String _searchValue = 'xyz123';

  final List<String> _suggestions = [
    'Income Certificate',
    'Income & Asset Certificate',
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
              child: Ux4gSearchField(
                value: _searchValue,
                onValueChange: (v) => setState(() => _searchValue = v),
                variant: Ux4gSearchFieldVariant.searchWithSubmit,
                placeholder: 'Search services...',
                showVoiceIcon: true,
                showClearIcon: true,
                buttonStyle: Ux4gSearchFieldButtonStyle.filled,
              ),
            ),
            // No results content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Search icon
                    Icon(Icons.search, size: 48, color: Color(0xFF432CBB)),
                    const SizedBox(height: 16),
                    Text(
                      'No services found for "$_searchValue"',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text('Did you mean:', style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 4),
                    Wrap(
                      children: _suggestions.map((s) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(s, style: TextStyle(fontSize: 13, color: Color(0xFF432CBB))),
                      )).toList(),
                    ),
                    const SizedBox(height: 20),
                    Ux4gButton(
                      text: 'Browse all services',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.medium,
                    ),
                    const SizedBox(height: 32),
                    // Popular services
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Popular services', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 12),
                    _PopularCard(title: 'Income Certificate', dept: 'Revenue Department', fee: 'Free', time: '20 mins'),
                    const SizedBox(height: 12),
                    _PopularCard(title: 'Ration Card', dept: 'Food & Civil Supplies', fee: 'Free', time: '10 days'),
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

class _PopularCard extends StatelessWidget {
  final String title;
  final String dept;
  final String fee;
  final String time;
  const _PopularCard({required this.title, required this.dept, required this.fee, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(dept, style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(fee, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
              Text('  ·  $time', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
            ],
          ),
          const SizedBox(height: 10),
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

class _NoResultsMockup extends StatefulWidget {
  const _NoResultsMockup();

  @override
  State<_NoResultsMockup> createState() => _NoResultsMockupState();
}

class _NoResultsMockupState extends State<_NoResultsMockup> {
  String _searchValue = 'xyz123';

  final List<String> _suggestions = [
    'Income Certificate',
    'Income & Asset Certificate',
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
                child: Ux4gSearchField(
                  value: _searchValue,
                  onValueChange: (v) => setState(() => _searchValue = v),
                  variant: Ux4gSearchFieldVariant.searchWithSubmit,
                  placeholder: 'Search services...',
                  showVoiceIcon: true,
                  showClearIcon: true,
                  buttonStyle: Ux4gSearchFieldButtonStyle.filled,
                ),
              ),

              // No results content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      // Search icon
                      const Icon(Icons.search, size: 48, color: _primaryColor),
                      const SizedBox(height: 16),
                      Text(
                        'No services found for "$_searchValue"',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text('Did you mean:', style: TextStyle(fontSize: 13, color: _subtleText)),
                      const SizedBox(height: 4),
                      Wrap(
                        children: _suggestions.asMap().entries.map((entry) {
                          final isLast = entry.key == _suggestions.length - 1;
                          return Text(
                            isLast ? entry.value : '${entry.value},  ',
                            style: const TextStyle(fontSize: 13, color: _primaryColor),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Ux4gButton(
                        text: 'Browse all services',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.medium,
                        backgroundColor: const Color(0xFFDCD4FF),
                        borderWidth: 0,
                      ),
                      const SizedBox(height: 32),
                      // Popular services
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Popular services',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPopularCard('Income Certificate', 'Revenue Department', 'Free', '20 mins'),
                      const SizedBox(height: 12),
                      _buildPopularCard('Ration Card', 'Food & Civil Supplies', 'Free', '10 days'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCard(String title, String dept, String fee, String time) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _titleColor)),
          const SizedBox(height: 2),
          Text(dept, style: const TextStyle(fontSize: 12, color: _subtleText)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(fee, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _greenColor)),
              Text('  ·  $time', style: const TextStyle(fontSize: 12, color: _subtleText)),
            ],
          ),
          const SizedBox(height: 10),
          Ux4gButton(
            text: 'Apply',
            onPressed: () {},
            variant: Ux4gButtonVariant.outline,
            size: Ux4gButtonSize.small,
          ),
        ],
      ),
    );
  }
}
