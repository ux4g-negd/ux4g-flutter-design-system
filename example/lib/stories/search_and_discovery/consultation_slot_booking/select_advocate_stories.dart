import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _borderColor = Color(0xFFE5E7EB);
const Color _greenColor = Color(0xFF16A34A);

final selectAdvocateComponent = WidgetbookComponent(
  name: 'Select Advocate',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        return ComponentDocs(
          mobileMockup: true,
          name: 'Select Advocate',
          description:
              'Advocate selection pattern for consultation slot booking. '
              'Shows available advocates with specialization, experience, languages, and slot count.',
          code: _selectAdvocateCode,
          center: true,
          child: const _SelectAdvocateMockup(),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String
// ───────────────────────────────────────────────────────────────────────

const _selectAdvocateCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class SelectAdvocateScreen extends StatelessWidget {
  const SelectAdvocateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.filled,
              title: 'National Services Portal',
              showBackButton: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text('Select an advocate', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text('District Legal Services Authority, Pune · 12 available',
                      style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                    const SizedBox(height: 20),
                    _AdvocateCard(name: 'Adv. M. Sharma', specialization: 'Family Law', experience: '12 yrs', languages: 'Hindi, Marathi, English', slots: 8),
                    const SizedBox(height: 16),
                    _AdvocateCard(name: 'Adv. M. Sharma', specialization: 'Family Law', experience: '12 yrs', languages: 'Hindi, Marathi, English', slots: 5),
                    const SizedBox(height: 16),
                    _AdvocateCard(name: 'Adv. M. Sharma', specialization: 'Family Law', experience: '12 yrs', languages: 'Hindi, Marathi, English', slots: 3),
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

class _AdvocateCard extends StatelessWidget {
  final String name;
  final String specialization;
  final String experience;
  final String languages;
  final int slots;
  const _AdvocateCard({required this.name, required this.specialization, required this.experience, required this.languages, required this.slots});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF432CBB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFF2EFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.balance, size: 20, color: Color(0xFF432CBB)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    Text('$specialization · $experience', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  ],
                ),
              ),
              Text('$slots slots', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF16A34A))),
            ],
          ),
          const SizedBox(height: 8),
          Text('Languages: $languages', style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Ux4gButton(text: 'Select', onPressed: () {}, variant: Ux4gButtonVariant.primary, size: Ux4gButtonSize.medium),
          ),
        ],
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup
// ───────────────────────────────────────────────────────────────────────

class _SelectAdvocateMockup extends StatelessWidget {
  const _SelectAdvocateMockup();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // App Header
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        'Select an advocate',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'District Legal Services Authority, Pune · 12 available',
                        style: TextStyle(fontSize: 13, color: _subtleText),
                      ),
                      const SizedBox(height: 20),
                      _buildAdvocateCard(
                        'Adv. M. Sharma',
                        'Family Law',
                        '12 yrs',
                        'Hindi, Marathi, English',
                        8,
                      ),
                      const SizedBox(height: 16),
                      _buildAdvocateCard(
                        'Adv. M. Sharma',
                        'Family Law',
                        '12 yrs',
                        'Hindi, Marathi, English',
                        5,
                      ),
                      const SizedBox(height: 16),
                      _buildAdvocateCard(
                        'Adv. M. Sharma',
                        'Family Law',
                        '12 yrs',
                        'Hindi, Marathi, English',
                        3,
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

  Widget _buildAdvocateCard(
    String name,
    String specialization,
    String experience,
    String languages,
    int slots,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2EFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.balance,
                  size: 20,
                  color: _primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _titleColor,
                      ),
                    ),
                    Text(
                      '$specialization · $experience',
                      style: const TextStyle(fontSize: 12, color: _subtleText),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF8D8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$slots slots',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _greenColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Languages: $languages',
            style: const TextStyle(fontSize: 12, color: _subtleText),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: Ux4gButton(
              text: 'Select',
              onPressed: () {},
              variant: Ux4gButtonVariant.primary,
              size: Ux4gButtonSize.medium,
              backgroundColor: const Color(0xFF4A2BC2),
            ),
          ),
        ],
      ),
    );
  }
}
