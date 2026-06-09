import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final searchWithResultsComponent = WidgetbookComponent(
  name: 'Search with Results',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Search with Results',
          description:
              'Search pattern with autocomplete suggestions showing matching '
              'services as the user types. Uses Ux4gSearchField with autocomplete variant.',
          code: _searchWithResultsCode,
          center: true,
          child: const _SearchWithResultsMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _searchWithResultsCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class SearchWithResultsScreen extends StatefulWidget {
  const SearchWithResultsScreen({super.key});

  @override
  State<SearchWithResultsScreen> createState() => _SearchWithResultsScreenState();
}

class _SearchWithResultsScreenState extends State<SearchWithResultsScreen> {
  String _searchValue = 'income';

  final List<String> _allServices = [
    'Income Certificate',
    'Income Tax Return Filing',
    'Low Income Group Certificate',
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
            // Search area
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF2EFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Find any government service',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  const Text('Search 3,000+ services & schemes',
                    style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                  const SizedBox(height: 16),
                  Ux4gSearchField(
                    value: _searchValue,
                    onValueChange: (v) => setState(() => _searchValue = v),
                    variant: Ux4gSearchFieldVariant.autocomplete,
                    placeholder: 'Search services...',
                    showVoiceIcon: true,
                    showClearIcon: true,
                    options: _allServices,
                    onOptionSelected: (option) {
                      setState(() => _searchValue = option);
                    },
                  ),
                ],
              ),
            ),
            // Rest of content (browse by category, popular services)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Browse by category grid...
                    // Popular services list...
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

class _SearchWithResultsMockup extends StatefulWidget {
  const _SearchWithResultsMockup();

  @override
  State<_SearchWithResultsMockup> createState() =>
      _SearchWithResultsMockupState();
}

class _SearchWithResultsMockupState extends State<_SearchWithResultsMockup> {
  String _searchValue = 'income';

  final List<String> _options = [
    'Income Certificate',
    'Income Tax Return Filing',
    'Low Income Group Certificate',
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

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search area with purple bg
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        color: const Color(0xFFF2EFFF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Find any government service',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: _titleColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Search 3,000+ services & schemes',
                              style: TextStyle(
                                fontSize: 13,
                                color: _subtleText,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Search field with autocomplete
                            Builder(
                              builder: (context) {
                                final filtered = _options
                                    .where(
                                      (e) => e.toLowerCase().contains(
                                        _searchValue.toLowerCase(),
                                      ),
                                    )
                                    .toList();
                                return Ux4gSearchField(
                                  value: _searchValue,
                                  onValueChange: (v) =>
                                      setState(() => _searchValue = v),
                                  variant: Ux4gSearchFieldVariant.autocomplete,
                                  placeholder: 'Search services...',
                                  showVoiceIcon: true,
                                  showClearIcon: true,
                                  options: filtered,
                                  onOptionSelected: (s) =>
                                      setState(() => _searchValue = s),
                                  buttonStyle:
                                      Ux4gSearchFieldButtonStyle.filled,
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Rest of content
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Browse by category
                            const Text(
                              'Browse by category',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _titleColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildCategoryGrid(),
                            const SizedBox(height: 24),

                            // Popular services
                            const Text(
                              'Popular services',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _titleColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildServiceCard(
                              'Income Certificate',
                              'Revenue Department',
                              'Free',
                              '20 mins',
                            ),
                            const SizedBox(height: 12),
                            _buildServiceCard(
                              'Caste Certificate',
                              'Social Welfare Dept',
                              'Free',
                              '15 mins',
                            ),
                            const SizedBox(height: 12),
                            _buildServiceCard(
                              'Driving Licence',
                              'Transport Department',
                              '₹200',
                              '30 days',
                            ),
                          ],
                        ),
                      ),
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

  static Widget _buildCategoryGrid() {
    final categories = [
      (Icons.health_and_safety_outlined, 'Health', '24 services'),
      (Icons.agriculture_outlined, 'Agriculture', '18 services'),
      (Icons.school_outlined, 'Education', '31 services'),
      (Icons.landscape_outlined, 'Land Records', '12 services'),
      (Icons.directions_bus_outlined, 'Transport', '15 services'),
      (Icons.people_outline, 'Social Welfare', '27 services'),
      (Icons.bolt_outlined, 'Utilities', '9 services'),
      (Icons.account_balance_outlined, 'Finance', '21 services'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final (icon, label, count) = categories[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _primaryColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: _primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _titleColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                count,
                style: const TextStyle(fontSize: 11, color: _subtleText),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildServiceCard(
    String title,
    String dept,
    String fee,
    String time,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
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
          const SizedBox(height: 2),
          Text(dept, style: const TextStyle(fontSize: 12, color: _subtleText)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                fee,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _greenColor,
                ),
              ),
              Text(
                '  ·  $time',
                style: const TextStyle(fontSize: 12, color: _subtleText),
              ),
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
