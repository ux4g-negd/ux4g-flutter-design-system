import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _primaryColor = Color(0xFF432CBB);

// ── Component ────────────────────────────────────────────────────────────

final allScheduledLanguagesComponent = WidgetbookComponent(
  name: 'All Scheduled Languages',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.list(
          label: 'Variant',
          options: const ['Default', 'Card Style'],
          initialOption: 'Default',
          description:
              'Switch between the standard layout and the card-style layout '
              'with a light purple background.',
        );

        final isCard = variant == 'Card Style';

        return ComponentDocs(
          mobileMockup: true,
          name: 'All Scheduled Languages ($variant)',
          description: isCard
              ? 'Full language list with search and selected state inside a '
                    'card container with light purple background.'
              : 'Full language list with search and selected state on white background.',
          code: isCard
              ? _allScheduledLanguagesCardCode
              : _allScheduledLanguagesDefaultCode,
          center: true,
          child: _AllScheduledLanguagesMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _allScheduledLanguagesDefaultCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class AllScheduledLanguagesScreen extends StatefulWidget {
  const AllScheduledLanguagesScreen({super.key});

  @override
  State<AllScheduledLanguagesScreen> createState() => _AllScheduledLanguagesScreenState();
}

class _AllScheduledLanguagesScreenState extends State<AllScheduledLanguagesScreen> {
  int _selectedIndex = -1;
  String _searchValue = '';
  bool _isDropdownOpen = false;

  final _languages = [
    {'name': 'English', 'sub': 'United States'},
    {'name': 'हिंदी', 'sub': 'Hindi'},
    {'name': 'मराठी', 'sub': 'Marathi'},
    {'name': 'தமிழ்', 'sub': 'Tamil'},
    {'name': 'తెలుగు', 'sub': 'Telegu'},
    {'name': 'বাংলা', 'sub': 'Bengali'},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter languages
    final query = _searchValue.toLowerCase();
    final isExactSelection = _languages.any((l) => l['name']!.toLowerCase() == query);
    final filteredLanguages = (isExactSelection || query.isEmpty)
        ? _languages
        : _languages.where((l) =>
            l['name']!.toLowerCase().contains(query) ||
            l['sub']!.toLowerCase().contains(query)).toList();

    return GestureDetector(
      onTap: () {
        if (_isDropdownOpen) {
          setState(() {
            _isDropdownOpen = false;
            if (_selectedIndex >= 0) _searchValue = _languages[_selectedIndex]['name']!;
          });
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingSpacing: 2,
                leadingWidgets: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                  SizedBox(width:3),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  SizedBox(width:3),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),
              // Gov bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Text('🇮🇳', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                    const SizedBox(width: 4),
                    Icon(Icons.open_in_new, size: 12, color: Colors.white),
                    const Spacer(),
                    Icon(Icons.accessibility_new, size: 18, color: Colors.white),
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
                      Text('All scheduled languages',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('India\'s 22 scheduled languages plus English. Tap any tile to switch — "Coming soon" tiles mean translation is in progress.',
                          style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      // Search field
                      Ux4gSearchField(
                        value: _searchValue,
                        onValueChange: (v) {
                          setState(() { _searchValue = v; _isDropdownOpen = true; });
                        },
                        variant: Ux4gSearchFieldVariant.searchWithSubmit,
                        size: Ux4gSearchFieldSize.medium,
                        placeholder: 'Search for Language',
                        showVoiceIcon: true,
                        showClearIcon: true,
                        onClearClick: () {
                          setState(() { _searchValue = ''; _selectedIndex = -1; _isDropdownOpen = false; });
                        },
                        onSubmitClick: (_) {},
                      ),
                      // Dropdown list
                      if (_isDropdownOpen)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(filteredLanguages.length, (i) {
                              final lang = filteredLanguages[i];
                              final originalIndex = _languages.indexOf(lang);
                              final isSelected = _selectedIndex == originalIndex;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = originalIndex;
                                    _searchValue = lang['name']!;
                                    _isDropdownOpen = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFFF2EFFF) : null,
                                    border: i < filteredLanguages.length - 1
                                        ? const Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1))
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(lang['name']!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isSelected ? Color(0xFF4A2BC2) : Color(0xFF111827))),
                                            const SizedBox(height: 2),
                                            Text(lang['sub']!, style: TextStyle(fontSize: 12, color: isSelected ? Color(0xFF4A2BC2) : Color(0xFF6B7280))),
                                          ],
                                        ),
                                      ),
                                      if (isSelected) Icon(Icons.check, color: Color(0xFF4A2BC2), size: 20),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Powered by Digital India
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    const SizedBox(width: 4),
                    Image.asset('assets/digital_india_logo.png', height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _allScheduledLanguagesCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — all scheduled languages inside a white card on purple background.
class AllScheduledLanguagesCardScreen extends StatefulWidget {
  const AllScheduledLanguagesCardScreen({super.key});

  @override
  State<AllScheduledLanguagesCardScreen> createState() => _AllScheduledLanguagesCardScreenState();
}

class _AllScheduledLanguagesCardScreenState extends State<AllScheduledLanguagesCardScreen> {
  int _selectedIndex = -1;
  String _searchValue = '';
  bool _isDropdownOpen = false;

  final _languages = [
    {'name': 'English', 'sub': 'United States'},
    {'name': 'हिंदी', 'sub': 'Hindi'},
    {'name': 'मराठी', 'sub': 'Marathi'},
    {'name': 'தமிழ்', 'sub': 'Tamil'},
    {'name': 'తెలుగు', 'sub': 'Telegu'},
    {'name': 'বাংলা', 'sub': 'Bengali'},
  ];

  @override
  Widget build(BuildContext context) {
    final query = _searchValue.toLowerCase();
    final isExactSelection = _languages.any((l) => l['name']!.toLowerCase() == query);
    final filteredLanguages = (isExactSelection || query.isEmpty)
        ? _languages
        : _languages.where((l) =>
            l['name']!.toLowerCase().contains(query) ||
            l['sub']!.toLowerCase().contains(query)).toList();

    return GestureDetector(
      onTap: () {
        if (_isDropdownOpen) {
          setState(() {
            _isDropdownOpen = false;
            if (_selectedIndex >= 0) _searchValue = _languages[_selectedIndex]['name']!;
          });
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2EFFF),
        body: SafeArea(
          child: Column(
            children: [
              // App Header
              Ux4gAppHeader(
                variant: Ux4gAppHeaderVariant.light,
                title: '',
                leadingSpacing: 2,
                leadingWidgets: [
                  SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  SvgPicture.asset('assets/Union.svg', height: 32),
                ],
              ),
              // Gov bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: const Color(0xFF1E3A8A),
                child: Row(
                  children: [
                    Text('🇮🇳', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text('Government of India', style: TextStyle(color: Colors.white, fontSize: 13)),
                    const SizedBox(width: 4),
                    Icon(Icons.open_in_new, size: 12, color: Colors.white),
                    const Spacer(),
                    Icon(Icons.accessibility_new, size: 18, color: Colors.white),
                  ],
                ),
              ),
              // White card content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Ux4gCard(
                    backgroundColor: Colors.white,
                    cornerRadius: 16,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('All scheduled languages',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          Text('India\'s 22 scheduled languages plus English. Tap any tile to switch — "Coming soon" tiles mean translation is in progress.',
                              style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                          const SizedBox(height: 20),
                          // Search field
                          Ux4gSearchField(
                            value: _searchValue,
                            onValueChange: (v) {
                              setState(() { _searchValue = v; _isDropdownOpen = true; });
                            },
                            variant: Ux4gSearchFieldVariant.searchWithSubmit,
                            size: Ux4gSearchFieldSize.medium,
                            placeholder: 'Search for Language',
                            showVoiceIcon: true,
                            showClearIcon: true,
                            onClearClick: () {
                              setState(() { _searchValue = ''; _selectedIndex = -1; _isDropdownOpen = false; });
                            },
                            onSubmitClick: (_) {},
                          ),
                          // Dropdown list
                          if (_isDropdownOpen)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(filteredLanguages.length, (i) {
                                  final lang = filteredLanguages[i];
                                  final originalIndex = _languages.indexOf(lang);
                                  final isSelected = _selectedIndex == originalIndex;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = originalIndex;
                                        _searchValue = lang['name']!;
                                        _isDropdownOpen = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected ? const Color(0xFFF2EFFF) : null,
                                        border: i < filteredLanguages.length - 1
                                            ? const Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1))
                                            : null,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(lang['name']!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: isSelected ? Color(0xFF4A2BC2) : Color(0xFF111827))),
                                                const SizedBox(height: 2),
                                                Text(lang['sub']!, style: TextStyle(fontSize: 12, color: isSelected ? Color(0xFF4A2BC2) : Color(0xFF6B7280))),
                                              ],
                                            ),
                                          ),
                                          if (isSelected) Icon(Icons.check, color: Color(0xFF4A2BC2), size: 20),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Powered by Digital India
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Powered by -', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    const SizedBox(width: 4),
                    Image.asset('assets/digital_india_logo.png', height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _AllScheduledLanguagesMockup extends StatefulWidget {
  final bool isCard;

  const _AllScheduledLanguagesMockup({this.isCard = false});

  @override
  State<_AllScheduledLanguagesMockup> createState() =>
      _AllScheduledLanguagesMockupState();
}

class _AllScheduledLanguagesMockupState
    extends State<_AllScheduledLanguagesMockup> {
  int _selectedIndex = -1;
  String _searchValue = '';
  bool _isDropdownOpen = false;

  final _languages = const [
    {'name': 'English', 'sub': 'United States'},
    {'name': 'हिंदी', 'sub': 'Hindi'},
    {'name': 'मराठी', 'sub': 'Marathi'},
    {'name': 'தமிழ்', 'sub': 'Tamil'},
    {'name': 'తెలుగు', 'sub': 'Telegu'},
    {'name': 'বাংলা', 'sub': 'Bengali'},
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: GestureDetector(
        onTap: () {
          // Close dropdown on outside tap and restore selected value
          if (_isDropdownOpen) {
            setState(() {
              _isDropdownOpen = false;
              // Restore selected item name in field if user didn't use clear
              if (_selectedIndex >= 0) {
                _searchValue = _languages[_selectedIndex]['name']!;
              }
            });
          }
        },
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          backgroundColor: widget.isCard
              ? const Color(0xFFF2EFFF)
              : Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // App Header
                Ux4gAppHeader(
                  variant: Ux4gAppHeaderVariant.light,
                  title: '',
                  leadingSpacing: 2,
                  leadingWidgets: [
                    SvgPicture.asset(
                      'assets/national_amblam_logo.svg',
                      height: 40,
                    ),
                    SizedBox(width: 3),
                    SizedBox(
                      height: 32,
                      child: Ux4gDivider(
                        orientation: Ux4gDividerOrientation.vertical,
                        color: const Color(0xFFD1D5DB),
                      ),
                    ),
                    SizedBox(width: 3),
                    SvgPicture.asset('assets/Union.svg', height: 32),
                  ],
                ),

                // Gov bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: const Color(0xFF1E3A8A),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/india_flag.png',
                        height: 14,
                        width: 22,
                        errorBuilder: (_, __, ___) => const Text(
                          '\u{1f1ee}\u{1f1f3}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Government of India',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.open_in_new,
                        size: 11,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.accessibility_new,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: widget.isCard
                        ? Ux4gCard(
                            backgroundColor: Colors.white,
                            cornerRadius: 16,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: _buildContent(),
                            ),
                          )
                        : _buildContent(),
                  ),
                ),

                // Powered by
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Powered by -',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/digital_india_logo.png',
                        height: 20,
                        errorBuilder: (_, __, ___) => const Text(
                          'Digital India',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF432CBB),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Filter languages based on search
    final query = _searchValue.toLowerCase();
    final isExactSelection = _languages.any(
      (lang) => lang['name']!.toLowerCase() == query,
    );
    final filteredLanguages = (isExactSelection || query.isEmpty)
        ? _languages
        : _languages.where((lang) {
            return lang['name']!.toLowerCase().contains(query) ||
                lang['sub']!.toLowerCase().contains(query);
          }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All scheduled languages',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'India\'s 22 scheduled languages plus English. Tap any tile to switch — "Coming soon" tiles mean translation is in progress.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 20),

        // Search field — tap opens dropdown, shows selected value
        Ux4gSearchField(
          value: _searchValue,
          onValueChange: (v) {
            setState(() {
              _searchValue = v;
              _isDropdownOpen = true;
            });
          },
          variant: Ux4gSearchFieldVariant.searchWithSubmit,
          size: Ux4gSearchFieldSize.medium,
          placeholder: 'Search for Language',
          showVoiceIcon: true,
          showClearIcon: true,
          onClearClick: () {
            setState(() {
              _searchValue = '';
              _selectedIndex = -1;
              _isDropdownOpen = false;
            });
          },
          onSubmitClick: (_) {},
        ),

        // Dropdown list — only visible when open
        if (_isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(filteredLanguages.length, (i) {
                final lang = filteredLanguages[i];
                final originalIndex = _languages.indexOf(lang);
                final isSelected = _selectedIndex == originalIndex;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = originalIndex;
                      _searchValue = lang['name']!;
                      _isDropdownOpen = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFF2EFFF) : null,
                      border: i < filteredLanguages.length - 1
                          ? const Border(
                              bottom: BorderSide(
                                color: Color(0xFFE5E7EB),
                                width: 1,
                              ),
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang['name']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? const Color(0xFF4A2BC2)
                                      : _titleColor,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lang['sub']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? const Color(0xFF4A2BC2)
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: Color(0xFF4A2BC2),
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
