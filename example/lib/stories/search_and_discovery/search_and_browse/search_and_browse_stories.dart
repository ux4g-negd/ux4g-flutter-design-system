import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final searchAndBrowseComponent = WidgetbookComponent(
  name: 'Search & Browse Services',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Search & Browse Services',
          description:
              'A discovery pattern for finding government services. Includes '
              'search bar, category grid, featured scheme, popular services list, '
              'and an eligibility quiz CTA.',
          code: _searchAndBrowseCode,
          center: true,
          child: const _SearchAndBrowseMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _searchAndBrowseCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class SearchAndBrowseScreen extends StatelessWidget {
  const SearchAndBrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + subtitle
                    const Text('Find any government service',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    const Text('Search 3,000+ services & schemes',
                      style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 16),

                    // Search bar
                    Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      placeholder: 'Search services...',
                      leadingIcon: Icons.search,
                      trailingIcon: Icons.mic,
                    ),
                    const SizedBox(height: 24),

                    // Browse by category
                    const Text('Browse by category',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    // 2-column grid of category cards
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _CategoryCard(icon: Icons.health_and_safety, label: 'Health', count: '24 services'),
                        _CategoryCard(icon: Icons.agriculture, label: 'Agriculture', count: '18 services'),
                        _CategoryCard(icon: Icons.school, label: 'Education', count: '31 services'),
                        _CategoryCard(icon: Icons.landscape, label: 'Land Records', count: '12 services'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Featured scheme
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FEATURED SCHEME',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF432CBB))),
                          const SizedBox(height: 4),
                          Text('PM Awas Yojana (Urban)',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('Subsidised housing loans — interest subsidy up to ₹2.67 lakh.',
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: Ux4gButton(
                              text: 'Check eligibility',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Popular services
                    const Text('Popular services',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _ServiceCard(
                      title: 'Income Certificate',
                      dept: 'Revenue Department',
                      fee: 'Free',
                      time: '20 mins',
                    ),
                    const SizedBox(height: 12),
                    _ServiceCard(
                      title: 'Caste Certificate',
                      dept: 'Social Welfare Dept',
                      fee: 'Free',
                      time: '15 mins',
                    ),
                    const SizedBox(height: 12),
                    _ServiceCard(
                      title: 'Driving Licence',
                      dept: 'Transport Department',
                      fee: '₹200',
                      time: '30 days',
                    ),
                    const SizedBox(height: 24),

                    // Quiz CTA
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Not sure what you\'re eligible for?',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('Take a 2-minute quiz to find schemes you qualify for.',
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: Ux4gButton(
                              text: 'Find my schemes',
                              onPressed: () {},
                              variant: Ux4gButtonVariant.outline,
                            ),
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
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  const _CategoryCard({required this.icon, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Color(0xFF432CBB)),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Text(count, style: TextStyle(fontSize: 11, color: Color(0xFF4B5563))),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String dept;
  final String fee;
  final String time;
  const _ServiceCard({required this.title, required this.dept, required this.fee, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(dept, style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(fee, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
              Text('  ·  $time', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
            ],
          ),
          const SizedBox(height: 8),
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

class _SearchAndBrowseMockup extends StatelessWidget {
  const _SearchAndBrowseMockup();

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
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    const SizedBox(width: 12),
                    const Text(
                      'National Services Portal',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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
                            // Title
                            const Text(
                              'Find any government service',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _titleColor),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Search 3,000+ services & schemes',
                              style: TextStyle(fontSize: 13, color: _subtleText),
                            ),
                            const SizedBox(height: 16),

                            // Search bar
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 44,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: _borderColor),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, size: 20, color: _subtleText),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Search services...',
                                            style: TextStyle(fontSize: 14, color: _subtleText),
                                          ),
                                        ),
                                        Icon(Icons.mic, size: 20, color: _subtleText),
                                        const SizedBox(width: 8),
                                        Icon(Icons.close, size: 18, color: _subtleText),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.search, color: Colors.white, size: 20),
                                ),
                              ],
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                      ),
                      const SizedBox(height: 12),

                      // Category grid
                      _buildCategoryGrid(),
                      const SizedBox(height: 24),

                      // Featured scheme
                      _buildFeaturedScheme(),
                      const SizedBox(height: 24),

                      // Popular services
                      const Text(
                        'Popular services',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                      ),
                      const SizedBox(height: 12),
                      _buildServiceCard('Income Certificate', 'Revenue Department', 'Free', '20 mins'),
                      const SizedBox(height: 12),
                      _buildServiceCard('Caste Certificate', 'Social Welfare Dept', 'Free', '15 mins'),
                      const SizedBox(height: 12),
                      _buildServiceCard('Driving Licence', 'Transport Department', '₹200', '30 days'),
                      const SizedBox(height: 24),

                      // Quiz CTA
                      _buildQuizCta(),
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
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
              const SizedBox(height: 2),
              Text(count, style: const TextStyle(fontSize: 11, color: _subtleText)),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildFeaturedScheme() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED SCHEME',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _primaryColor, letterSpacing: 0.5),
          ),
          const SizedBox(height: 6),
          const Text(
            'PM Awas Yojana (Urban)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor),
          ),
          const SizedBox(height: 4),
          const Text(
            'Subsidised housing loans — interest subsidy up to\n₹2.67 lakh.',
            style: TextStyle(fontSize: 13, color: _subtleText),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Ux4gButton(
              text: 'Check eligibility',
              onPressed: () {},
              variant: Ux4gButtonVariant.primary,
              height: 44,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildServiceCard(String title, String dept, String fee, String time) {
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

  static Widget _buildQuizCta() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Not sure what you\'re eligible for?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _titleColor),
          ),
          const SizedBox(height: 4),
          const Text(
            'Take a 2-minute quiz to find schemes you qualify for.',
            style: TextStyle(fontSize: 13, color: _subtleText),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Ux4gButton(
              text: 'Find my schemes',
              onPressed: () {},
              variant: Ux4gButtonVariant.outline,
              height: 44,
            ),
          ),
        ],
      ),
    );
  }
}
