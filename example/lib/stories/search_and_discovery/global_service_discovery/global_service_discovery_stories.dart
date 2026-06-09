import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final globalServiceDiscoveryComponent = WidgetbookComponent(
  name: 'Global Service Discovery',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Global Service Discovery',
          description:
              'Full service discovery pattern with search, category grid, featured scheme, '
              'popular services, personalized recommendations, and eligibility quiz CTA.',
          code: _globalServiceDiscoveryCode,
          center: true,
          child: const _GlobalServiceDiscoveryMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _globalServiceDiscoveryCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class GlobalServiceDiscoveryScreen extends StatefulWidget {
  const GlobalServiceDiscoveryScreen({super.key});

  @override
  State<GlobalServiceDiscoveryScreen> createState() => _GlobalServiceDiscoveryScreenState();
}

class _GlobalServiceDiscoveryScreenState extends State<GlobalServiceDiscoveryScreen> {
  String _searchValue = '';

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
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search area
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Find any government service',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text('Search 3,000+ services & schemes',
                            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                          const SizedBox(height: 16),
                          Ux4gSearchField(
                            value: _searchValue,
                            onValueChange: (v) => setState(() => _searchValue = v),
                            variant: Ux4gSearchFieldVariant.searchWithSubmit,
                            placeholder: 'Search services...',
                            showVoiceIcon: true,
                            showClearIcon: true,
                            buttonStyle: Ux4gSearchFieldButtonStyle.filled,
                          ),
                        ],
                      ),
                    ),
                    // Browse by category, Featured scheme, Popular services,
                    // Recommended for user, Eligibility quiz CTA
                    // ... (see mockup for full implementation)
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

class _GlobalServiceDiscoveryMockup extends StatefulWidget {
  const _GlobalServiceDiscoveryMockup();

  @override
  State<_GlobalServiceDiscoveryMockup> createState() => _GlobalServiceDiscoveryMockupState();
}

class _GlobalServiceDiscoveryMockupState extends State<_GlobalServiceDiscoveryMockup> {
  String _searchValue = '';

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

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search area
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        color: const Color(0xFFF2EFFF),                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Ux4gSearchField(
                              value: _searchValue,
                              onValueChange: (v) => setState(() => _searchValue = v),
                              variant: Ux4gSearchFieldVariant.searchWithSubmit,
                              placeholder: 'Search services...',
                              showVoiceIcon: true,
                              showClearIcon: true,
                              buttonStyle: Ux4gSearchFieldButtonStyle.filled,
                            ),
                          ],
                        ),
                      ),

                      // Browse by category
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Browse by category',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                            ),
                            const SizedBox(height: 12),
                            _buildCategoryGrid(),
                          ],
                        ),
                      ),

                      // Featured Scheme
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildFeaturedScheme(),
                      ),

                      // Popular services
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),
                      ),

                      // Recommended for user
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recommended for Ramesh Kumar',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _titleColor),
                            ),
                            const SizedBox(height: 12),
                            _buildRecommendedCard('PM Kisan Samman Nidhi', 'Agriculture Department', 'Free', '₹6,000/yr'),
                            const SizedBox(height: 12),
                            _buildRecommendedCard('Ayushman Bharat (PM-JAY)', 'Health & Family Welfare', 'Free', '₹5L cover'),
                            const SizedBox(height: 12),
                            _buildRecommendedCard('National Pension Scheme', 'Finance Ministry', 'Free', 'Tax benefit'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Eligibility quiz CTA
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildEligibilityQuiz(),
                      ),

                      const SizedBox(height: 24),
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

  Widget _buildCategoryGrid() {
    final categories = [
      (Icons.health_and_safety_outlined, 'Health', '24 services'),
      (Icons.school_outlined, 'Education', '31 services'),
      (Icons.agriculture_outlined, 'Agriculture', '18 services'),
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
            border: Border.all(color: _borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _primaryColor.withValues(alpha: 0.08),
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

  Widget _buildFeaturedScheme() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED SCHEME',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _primaryColor, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          const Text(
            'PM Awas Yojana (Urban)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _titleColor),
          ),
          const SizedBox(height: 4),
          const Text(
            'Subsidised housing loans — Interest subsidy up to ₹2.67 lakh.',
            style: TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Ux4gButton(
              text: 'Check eligibility',
              onPressed: () {},
              variant: Ux4gButtonVariant.primary,
              size: Ux4gButtonSize.medium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(String title, String dept, String fee, String time) {
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

  Widget _buildRecommendedCard(String title, String dept, String fee, String benefit) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
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
              Text('  ·  $benefit', style: const TextStyle(fontSize: 12, color: _subtleText)),
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

  Widget _buildEligibilityQuiz() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2EFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _titleColor.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          const Text(
            "Not sure what you're eligible for?",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _titleColor),
          ),
          const SizedBox(height: 4),
          const Text(
            'Take a 2-minute quiz to find schemes you qualify for.',
            style: TextStyle(fontSize: 12, color: _subtleText),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Ux4gButton(
            text: 'Find my schemes',
            onPressed: () {},
            variant: Ux4gButtonVariant.outline,
            size: Ux4gButtonSize.medium,
            backgroundColor: const Color(0xFFDCD4FF),
            borderWidth: 0,
          ),
        ],
      ),
    );
  }
}
