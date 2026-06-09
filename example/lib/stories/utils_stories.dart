import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import 'package:widgetbook/widgetbook.dart';

// ── Quick Guide ───────────────────────────────────────────────────────────────

final quickGuideComponent = WidgetbookComponent(
  name: 'Quick Guide',
  useCases: [
    WidgetbookUseCase(
      name: 'Overview',
      builder: (context) => const _DocPage(
        title: 'UX4G Flutter Design System',
        sections: [
          _DocSection(
            heading: 'What is UX4G?',
            body:
                'UX4G is a government-grade Flutter design system built to deliver '
                'consistent, accessible, and trusted digital experiences across '
                'public service applications. It provides 50+ components, design '
                'tokens, and a theming system that follows WCAG AA accessibility '
                'guidelines.',
          ),
          _DocSection(
            heading: 'How to use this Widgetbook',
            body:
                'Browse components using the left sidebar. Click any component to '
                'see its use cases.\n\n'
                '• Preview tab — Live interactive component\n'
                '• Code tab — Copy-ready Dart snippet\n'
                '• Props tab — Parameter reference\n\n'
                'Use the addons panel (right side) to change viewport, theme '
                '(Light/Dark), text scale, and alignment.',
          ),
          _DocSection(
            heading: 'Categories',
            body:
                'Buttons · Display · Avatar · Form · Progress & Loader · '
                'Navigation & Feedback · Data · Layout · Overlay · Feedback Forms · '
                'Utils',
          ),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Installation',
      builder: (context) => _DocPage(
        title: 'Use this package as a library',
        sections: const [
          _DocSection(
            heading: 'Depend on it',
            body: 'Run this command:\nWith Flutter:',
          ),
        ],
        codeBlocks: const [
          _CodeBlock(
            label: 'Terminal',
            code: r'$ flutter pub add ux4g_flutter_design_system',
          ),
          _CodeBlock(
            label:
                "This will add a line like this to your package's pubspec.yaml\n"
                "(and run an implicit flutter pub get):",
            code: 'dependencies:\n  ux4g_flutter_design_system: ^0.2.0',
          ),
        ],
        trailingSections: const [
          _DocSection(
            heading: 'Import it',
            body: "Now in your Dart code, you can use:",
          ),
        ],
        trailingCodeBlocks: const [
          _CodeBlock(
            label: '',
            code:
                "import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';",
          ),
          _CodeBlock(
            label: 'Wrap your app with Ux4gTheme',
            code:
                "import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';\n\nvoid main() {\n  runApp(\n    Ux4gTheme(\n      child: MaterialApp(\n        home: MyHomePage(),\n      ),\n    ),\n  );\n}",
          ),
          _CodeBlock(
            label: 'Use any component',
            code: "Ux4gButton(\n  label: 'Submit',\n  onPressed: () {},\n)",
          ),
        ],
      ),
    ),
  ],
);

// ── Theme — Color Palette ─────────────────────────────────────────────────────

final themeColorComponent = WidgetbookComponent(
  name: 'Color Palette',
  useCases: [
    WidgetbookUseCase(
      name: 'Primary',
      builder: (context) => _PaletteView(
        label: 'Primary',
        swatches: const [
          _Swatch('primary-50', Ux4gPalette.primary50, '50'),
          _Swatch('primary-100', Ux4gPalette.primary100, '100'),
          _Swatch('primary-200', Ux4gPalette.primary200, '200'),
          _Swatch('primary-300', Ux4gPalette.primary300, '300'),
          _Swatch('primary-400', Ux4gPalette.primary400, '400'),
          _Swatch('primary-500', Ux4gPalette.primary500, '500 ★', main: true),
          _Swatch('primary-600', Ux4gPalette.primary600, '600'),
          _Swatch('primary-700', Ux4gPalette.primary700, '700'),
          _Swatch('primary-800', Ux4gPalette.primary800, '800'),
          _Swatch('primary-900', Ux4gPalette.primary900, '900'),
          _Swatch('primary-950', Ux4gPalette.primary950, '950'),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Secondary',
      builder: (context) => _PaletteView(
        label: 'Secondary',
        swatches: const [
          _Swatch('secondary-50', Ux4gPalette.secondary50, '50'),
          _Swatch('secondary-100', Ux4gPalette.secondary100, '100'),
          _Swatch('secondary-200', Ux4gPalette.secondary200, '200'),
          _Swatch('secondary-300', Ux4gPalette.secondary300, '300'),
          _Swatch('secondary-400', Ux4gPalette.secondary400, '400'),
          _Swatch('secondary-500', Ux4gPalette.secondary500, '500 ★', main: true),
          _Swatch('secondary-600', Ux4gPalette.secondary600, '600'),
          _Swatch('secondary-700', Ux4gPalette.secondary700, '700'),
          _Swatch('secondary-800', Ux4gPalette.secondary800, '800'),
          _Swatch('secondary-900', Ux4gPalette.secondary900, '900'),
          _Swatch('secondary-950', Ux4gPalette.secondary950, '950'),
        ],
      ),
    ),
    WidgetbookUseCase(
      name: 'Semantic',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Red (Error) ──────────────────────────────────────────────────
            _PaletteView(
              label: 'Red  (Error)',
              swatches: const [
                _Swatch('red-50',  Ux4gPalette.red50,  '50'),
                _Swatch('red-100', Ux4gPalette.red100, '100'),
                _Swatch('red-200', Ux4gPalette.red200, '200'),
                _Swatch('red-300', Ux4gPalette.red300, '300'),
                _Swatch('red-400', Ux4gPalette.red400, '400'),
                _Swatch('red-500', Ux4gPalette.red500, '500 ★', main: true),
                _Swatch('red-600', Ux4gPalette.red600, '600'),
                _Swatch('red-700', Ux4gPalette.red700, '700'),
                _Swatch('red-800', Ux4gPalette.red800, '800'),
                _Swatch('red-900', Ux4gPalette.red900, '900'),
                _Swatch('red-950', Ux4gPalette.red950, '950'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Green (Success) ───────────────────────────────────────────────
            _PaletteView(
              label: 'Green  (Success)',
              swatches: const [
                _Swatch('green-50',  Ux4gPalette.green50,  '50'),
                _Swatch('green-100', Ux4gPalette.green100, '100'),
                _Swatch('green-200', Ux4gPalette.green200, '200'),
                _Swatch('green-300', Ux4gPalette.green300, '300'),
                _Swatch('green-400', Ux4gPalette.green400, '400'),
                _Swatch('green-500', Ux4gPalette.green500, '500 ★', main: true),
                _Swatch('green-600', Ux4gPalette.green600, '600'),
                _Swatch('green-700', Ux4gPalette.green700, '700'),
                _Swatch('green-800', Ux4gPalette.green800, '800'),
                _Swatch('green-900', Ux4gPalette.green900, '900'),
                _Swatch('green-950', Ux4gPalette.green950, '950'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Blue (Info) ───────────────────────────────────────────────────
            _PaletteView(
              label: 'Blue  (Info)',
              swatches: const [
                _Swatch('blue-50',  Ux4gPalette.blue50,  '50'),
                _Swatch('blue-500', Ux4gPalette.blue500, '500 ★', main: true),
                _Swatch('blue-700', Ux4gPalette.blue700, '700'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Orange (Warning) ──────────────────────────────────────────────
            _PaletteView(
              label: 'Orange  (Warning)',
              swatches: const [
                _Swatch('orange-50',  Ux4gPalette.orange50,  '50'),
                _Swatch('orange-500', Ux4gPalette.orange500, '500 ★', main: true),
                _Swatch('orange-700', Ux4gPalette.orange700, '700'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Gold ──────────────────────────────────────────────────────────
            _PaletteView(
              label: 'Gold',
              swatches: const [
                _Swatch('gold-50',  Ux4gPalette.gold50,  '50'),
                _Swatch('gold-500', Ux4gPalette.gold500, '500 ★', main: true),
                _Swatch('gold-600', Ux4gPalette.gold600, '600'),
                _Swatch('gold-700', Ux4gPalette.gold700, '700'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Cyan ──────────────────────────────────────────────────────────
            _PaletteView(
              label: 'Cyan',
              swatches: const [
                _Swatch('cyan-50',  Ux4gPalette.cyan50,  '50'),
                _Swatch('cyan-500', Ux4gPalette.cyan500, '500 ★', main: true),
                _Swatch('cyan-600', Ux4gPalette.cyan600, '600'),
              ],
              compact: true,
            ),
            const SizedBox(height: 24),
            // ── Purple ────────────────────────────────────────────────────────
            _PaletteView(
              label: 'Purple',
              swatches: const [
                _Swatch('purple-50',  Ux4gPalette.purple50,  '50'),
                _Swatch('purple-500', Ux4gPalette.purple500, '500 ★', main: true),
                _Swatch('purple-600', Ux4gPalette.purple600, '600'),
              ],
              compact: true,
            ),
          ],
        ),
      ),
    ),
    // ── Neutral ────────────────────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Neutral',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PaletteView(
              label: 'Gray Scale',
              swatches: const [
                _Swatch('gray-100',     Ux4gPalette.gray100,       '100'),
                _Swatch('gray-200',     Ux4gPalette.gray200,       '200'),
                _Swatch('neutral-500',  Ux4gPalette.neutral500,    'neutral-500'),
                _Swatch('neutral-700',  Ux4gPalette.neutral700,    'neutral-700'),
                _Swatch('gray-800',     Ux4gPalette.gray800,       '800'),
                _Swatch('gray-900',     Ux4gPalette.gray900,       '900'),
              ],
            ),
            const SizedBox(height: 24),
            _PaletteView(
              label: 'Base',
              swatches: const [
                _Swatch('white', Ux4gPalette.white,           'white'),
                _Swatch('black', Ux4gPalette.neutral1000black, 'black'),
              ],
            ),
          ],
        ),
      ),
    ),
    // ── Semantic Tokens ────────────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'Semantic Tokens',
      builder: (context) {
        final colors = Ux4gTheme.colors(context);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Semantic Color Tokens',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Theme-aware colors from Ux4gColors — automatically adapt between '
                  'Light and Dark themes. Switch the theme in the addons panel '
                  '(right side) to see the change.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6A4EFF).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: const Color(0xFF6A4EFF).withValues(alpha: 0.25)),
                  ),
                  child: const Text(
                    'final colors = Ux4gTheme.colors(context);\n'
                    '// Use: colors.primary  colors.onPrimary  colors.surface \u2026',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF6A4EFF),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _SemanticTokenRow(
                  pairs: [
                    _SemanticPair('primary',    colors.primary,    'onPrimary',    colors.onPrimary),
                    _SemanticPair('secondary',  colors.secondary,  'onSecondary',  colors.onSecondary),
                    _SemanticPair('background', colors.background, 'onBackground', colors.onBackground),
                    _SemanticPair('surface',    colors.surface,    'onSurface',    colors.onSurface),
                    _SemanticPair('error',      colors.error,      'onError',      colors.onError),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
    // ── How to use ─────────────────────────────────────────────────────
    WidgetbookUseCase(
      name: 'How to use',
      builder: (context) => _DocPage(
        title: 'Using UX4G Colors',
        sections: const [
          _DocSection(
            heading: '1. Palette Colors  (static, always fixed)',
            body:
                'Ux4gPalette provides fixed color constants that never change with '
                'the theme. Use these when you need a very specific shade — for '
                'example, an illustration or a data-visualisation chart that must '
                'always use the same hue.',
          ),
        ],
        codeBlocks: const [
          _CodeBlock(
            label: 'Dart — Ux4gPalette',
            code: '''import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

// Fixed palette shades
Container(color: Ux4gPalette.primary500)       // #6A4EFF  — brand purple
Container(color: Ux4gPalette.primary50)        // #F2EFFF  — lightest tint
Container(color: Ux4gPalette.primary950)       // #1A0E3D  — darkest shade

Container(color: Ux4gPalette.red500)           // #F55E57  — error
Container(color: Ux4gPalette.green500)         // #1AA64A  — success
Container(color: Ux4gPalette.secondary500)     // #FFA827  — amber
Container(color: Ux4gPalette.gray900)          // #121212  — near-black
Container(color: Ux4gPalette.white)            // #FFFFFF
Container(color: Ux4gPalette.neutral1000black) // #000000''',
          ),
        ],
        trailingSections: const [
          _DocSection(
            heading: '2. Semantic Tokens  (theme-aware, recommended)',
            body: '''Ux4gColors holds semantic tokens that automatically switch value when the user changes between Light and Dark themes. Always prefer these inside your own widgets to keep the UI consistent with the rest of the design system.

Available tokens:
  • primary / onPrimary
  • secondary / onSecondary
  • background / onBackground
  • surface / onSurface
  • error / onError''',
          ),
        ],
        trailingCodeBlocks: const [
          _CodeBlock(
            label: 'Dart — Ux4gTheme.colors(context)',
            code: '''// Inside any build() method, after Ux4gTheme is in the widget tree:
final colors = Ux4gTheme.colors(context);

// Pair usage — background + foreground
Container(
  color: colors.surface,
  child: Text(
    'Hello',
    style: TextStyle(color: colors.onSurface),
  ),
);

// Available semantic tokens
colors.primary        // Brand primary color
colors.onPrimary      // Text/icon color ON primary background
colors.secondary      // Secondary brand color
colors.onSecondary    // Text/icon color ON secondary background
colors.background     // Page-level background
colors.onBackground   // Text color on background
colors.error          // Error state color
colors.onError        // Text/icon color ON error background''',
          ),
          _CodeBlock(
            label: 'Component theming example',
            code: '''// Inside your widget build() method:
Widget build(BuildContext context) {
  // Step 1: get semantic colors (theme-aware)
  final colors = Ux4gTheme.colors(context);

  // Step 2: pass them to any UX4G component
  return Ux4gAccordion(
    title: 'My Section',
    expanded: _expanded,
    onExpandedChange: (v) => setState(() => _expanded = v),

    // theme-aware — change with Light/Dark toggle
    backgroundColor:      colors.surface,
    expandedBorderColor:  colors.primary,

    // fixed palette shades — always constant
    titleColor:           Ux4gPalette.primary600,
    collapsedBorderColor: Ux4gPalette.gray200,

    child: Text(\'Content\', style: TextStyle(color: colors.onSurface)),
  );
}''',
          ),
          _CodeBlock(
            label: 'Light vs Dark values',
            code: '''// Light theme
primary    = #6A4EFF   onPrimary    = #FFFFFF
secondary  = #FFA827   onSecondary  = #121212
background = #F5F5F5   onBackground = #121212
surface    = #FFFFFF   onSurface    = #121212
error      = #F55E57   onError      = #FFFFFF

// Dark theme
primary    = #6A4EFF   onPrimary    = #121212
secondary  = #1157CE   onSecondary  = #FFFFFF
background = #121212   onBackground = #FFFFFF
surface    = #333333   onSurface    = #FFFFFF
error      = #FF8983   onError      = #121212''',
          ),
        ],
      ),
    ),
  ],
);
// ── Utils — Dimensions ────────────────────────────────────────────────────────

final dimensionsSpacingComponent = WidgetbookComponent(
  name: 'Spacing',
  useCases: [
    WidgetbookUseCase(
      name: 'Scale',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('Spacing Tokens', 'Ux4gSpace.*'),
            const SizedBox(height: 16),
            ...[
              ('spaceNone', Ux4gSpace.spaceNone),
              ('space2', Ux4gSpace.space2),
              ('space4', Ux4gSpace.space4),
              ('space6', Ux4gSpace.space6),
              ('space8', Ux4gSpace.space8),
              ('space12', Ux4gSpace.space12),
              ('space16', Ux4gSpace.space16),
              ('space20', Ux4gSpace.space20),
              ('space24', Ux4gSpace.space24),
              ('space32', Ux4gSpace.space32),
              ('space40', Ux4gSpace.space40),
              ('space48', Ux4gSpace.space48),
              ('space56', Ux4gSpace.space56),
              ('space64', Ux4gSpace.space64),
              ('space80', Ux4gSpace.space80),
            ].map((e) => _SpacingRow(token: e.$1, value: e.$2)),
          ],
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'How to use',
      builder: (context) => const _DocPage(
        title: 'Using UX4G Dimensions',
        sections: [
          _DocSection(
            heading: '1. Spacing  —  Ux4gSpace.*',
            body:
                'Ux4gSpace provides a fixed scale of spacing constants used for '
                'padding, margins, gaps, and SizedBox dimensions. '
                'Always prefer these over raw numeric literals so your layout '
                'stays aligned with the rest of the design system.\n\n'
                'Available values (dp): 0 · 2 · 4 · 6 · 8 · 12 · 16 · 20 · 24 · 32 · 40 · 48 · 56 · 64 · 80',
          ),
        ],
        codeBlocks: [
          _CodeBlock(
            label: 'Dart — Ux4gSpace',
            code: '''import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

// Padding
Padding(
  padding: const EdgeInsets.all(Ux4gSpace.space16),
  child: Text('Hello'),
);

// Symmetric padding
Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: Ux4gSpace.space24,
    vertical:   Ux4gSpace.space12,
  ),
  child: Text('Hello'),
);

// Gap between widgets
Column(
  children: [
    Text('Item 1'),
    SizedBox(height: Ux4gSpace.space8),
    Text('Item 2'),
    SizedBox(height: Ux4gSpace.space16),
    Text('Item 3'),
  ],
);

// Row gap
Row(
  children: [
    Icon(Icons.check),
    SizedBox(width: Ux4gSpace.space8),
    Text('Done'),
  ],
);''',
          ),
        ],
        trailingSections: [
          _DocSection(
            heading: '2. Border Radius  —  Ux4gRadius.*',
            body:
                'Ux4gRadius defines the corner-rounding scale. '
                'Use radius999 for fully-rounded pill/circle shapes.\n\n'
                'Available values (dp): 0 · 2 · 4 · 8 · 12 · 16 · 24 · 999',
          ),
          _DocSection(
            heading: '3. Border Width  —  Ux4gBorderWidth.*',
            body:
                'Ux4gBorderWidth provides consistent stroke widths.\n\n'
                'none=0  ·  thin=1  ·  thick=2  ·  thicker=3  ·  thickest=4',
          ),
        ],
        trailingCodeBlocks: [
          _CodeBlock(
            label: 'Dart — Ux4gRadius & Ux4gBorderWidth',
            code: '''// Rounded container
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
    border: Border.all(width: Ux4gBorderWidth.thin, color: Colors.grey),
  ),
);

// Pill-shaped button / chip
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(Ux4gRadius.radius999),
  ),
);

// Thicker focus ring
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(Ux4gRadius.radius4),
    border: Border.all(width: Ux4gBorderWidth.thick, color: Colors.blue),
  ),
);''',
          ),
          _CodeBlock(
            label: 'Component example — all three together',
            code: '''// A custom card that uses all three token families
class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);   // theme-aware colors

    return Container(
      padding: const EdgeInsets.all(Ux4gSpace.space16),          // spacing
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Ux4gRadius.radius12),  // radius
        border: Border.all(
          color: colors.onSurface.withValues(alpha: 0.12),
          width: Ux4gBorderWidth.thin,                            // border
        ),
      ),
      child: child,
    );
  }
}''',
          ),
        ],
      ),
    ),
  ],
);

final dimensionsRadiusComponent = WidgetbookComponent(
  name: 'Border Radius',
  useCases: [
    WidgetbookUseCase(
      name: 'Scale',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('Border Radius Tokens', 'Ux4gRadius.*'),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ('radiusNone', Ux4gRadius.radiusNone),
                ('radius2', Ux4gRadius.radius2),
                ('radius4', Ux4gRadius.radius4),
                ('radius8', Ux4gRadius.radius8),
                ('radius12', Ux4gRadius.radius12),
                ('radius16', Ux4gRadius.radius16),
                ('radius24', Ux4gRadius.radius24),
                ('radius999', Ux4gRadius.radius999),
              ].map((e) => _RadiusCard(token: e.$1, value: e.$2)).toList(),
            ),
          ],
        ),
      ),
    ),
  ],
);

final dimensionsBorderComponent = WidgetbookComponent(
  name: 'Border Width',
  useCases: [
    WidgetbookUseCase(
      name: 'Scale',
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader('Border Width Tokens', 'Ux4gBorderWidth.*'),
            const SizedBox(height: 16),
            ...[
              ('none', Ux4gBorderWidth.none),
              ('thin', Ux4gBorderWidth.thin),
              ('thick', Ux4gBorderWidth.thick),
              ('thicker', Ux4gBorderWidth.thicker),
              ('thickest', Ux4gBorderWidth.thickest),
            ].map((e) => _BorderWidthRow(token: e.$1, value: e.$2)),
          ],
        ),
      ),
    ),
  ],
);

// ── Private widgets ───────────────────────────────────────────────────────────

// ── Quick Guide widgets ───────────────────────────────────────────────────────

class _DocSection {
  final String heading;
  final String body;
  const _DocSection({required this.heading, required this.body});
}

class _CodeBlock {
  final String label;
  final String code;
  const _CodeBlock({required this.label, required this.code});
}

class _DocPage extends StatelessWidget {
  final String title;
  final List<_DocSection> sections;
  final List<_CodeBlock> codeBlocks;
  final List<_DocSection> trailingSections;
  final List<_CodeBlock> trailingCodeBlocks;

  const _DocPage({
    required this.title,
    this.sections = const [],
    this.codeBlocks = const [],
    this.trailingSections = const [],
    this.trailingCodeBlocks = const [],
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF6A4EFF);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : const Color(0xFF111827);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 680),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: titleColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 28),
            ...sections.map((s) => _buildSection(context, s)),
            ...codeBlocks.map((c) => _buildCodeBlock(context, c)),
            ...trailingSections.map((s) => _buildSection(context, s)),
            ...trailingCodeBlocks.map((c) => _buildCodeBlock(context, c)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, _DocSection s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headColor = isDark ? Colors.white : const Color(0xFF111827);
    final bodyColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.heading,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: headColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.body,
            style: TextStyle(
              fontSize: 14,
              color: bodyColor,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(BuildContext context, _CodeBlock c) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    
    // Theme-aware code block colors
    final codeBg = isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF3F4F6);
    final codeText = isDark ? const Color(0xFFCDD6F4) : const Color(0xFF374151);
    final border = isDark ? Colors.transparent : const Color(0xFFE5E7EB);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (c.label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                c.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 52), // Room for button
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: codeBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: border),
            ),
            child: Stack(
              clipBehavior: Clip.none, // Allow button to breathe if needed
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 60), // Space for button
                  child: Text(
                    c.code,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: codeText,
                      height: 1.6,
                    ),
                  ),
                ),
                Positioned(
                  top: -2, // Slight offset for better alignment
                  right: 0,
                  child: _CopyButton(text: c.code),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatefulWidget {
  final String text;
  const _CopyButton({required this.text});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme-aware button colors for high visibility
    final bg = isDark 
        ? Colors.white.withValues(alpha: 0.1) 
        : const Color(0xFFE5E7EB);
    final textColor = isDark 
        ? ( _copied ? const Color(0xFFA6E3A1) : const Color(0xFF89DCEB) )
        : ( _copied ? const Color(0xFF059669) : const Color(0xFF2563EB) );

    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: widget.text));
        setState(() => _copied = true);
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) setState(() => _copied = false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_copied)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(Icons.check, size: 12, color: textColor),
              ),
            Text(
              _copied ? 'Copied!' : 'Copy',
              style: TextStyle(
                fontSize: 11,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Color Palette widgets ─────────────────────────────────────────────────────

class _Swatch {
  final String token;
  final Color color;
  final String label;
  final bool main;
  const _Swatch(this.token, this.color, this.label, {this.main = false});
}

// ── Semantic token helpers ────────────────────────────────────────────────────

class _SemanticPair {
  final String baseToken;
  final Color baseColor;
  final String onToken;
  final Color onColor;
  const _SemanticPair(
      this.baseToken, this.baseColor, this.onToken, this.onColor);
}

class _SemanticTokenRow extends StatelessWidget {
  final List<_SemanticPair> pairs;
  const _SemanticTokenRow({required this.pairs});

  String _toHex(Color c) {
    final r = c.r.toInt();
    final g = c.g.toInt();
    final b = c.b.toInt();
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pairs.map((pair) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(child: _tokenTile(pair.baseToken, pair.baseColor)),
              const SizedBox(width: 8),
              Expanded(child: _tokenTile(pair.onToken, pair.onColor)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _tokenTile(String token, Color color) {
    final isDark = (color.r * 0.299 + color.g * 0.587 + color.b * 0.114) < 128;
    final fg = isDark ? Colors.white : Colors.black87;
    final hex = _toHex(color);
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'colors.$token',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
          Text(
            hex,
            style: TextStyle(fontSize: 10, color: fg.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}

class _PaletteView extends StatelessWidget {
  final String label;
  final List<_Swatch> swatches;
  final bool compact;

  const _PaletteView({
    required this.label,
    required this.swatches,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? Colors.white : const Color(0xFF111827);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: labelColor,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: swatches.map((s) => _SwatchTile(s, compact: compact)).toList(),
          ),
        ],
      ),
    );
  }
}

class _SwatchTile extends StatefulWidget {
  final _Swatch swatch;
  final bool compact;
  const _SwatchTile(this.swatch, {this.compact = false});

  @override
  State<_SwatchTile> createState() => _SwatchTileState();
}

class _SwatchTileState extends State<_SwatchTile> {
  bool _copied = false;

  String _toHex(Color c) {
    final r = (c.r * 255).toInt();
    final g = (c.g * 255).toInt();
    final b = (c.b * 255).toInt();
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}'.toUpperCase();
  }

  bool _isDark(Color c) =>
      (c.r * 0.299 + c.g * 0.587 + c.b * 0.114) < 0.5;

  @override
  Widget build(BuildContext context) {
    final hex = _toHex(widget.swatch.color);
    final fg = _isDark(widget.swatch.color) ? Colors.white : Colors.black;
    final w = widget.compact ? 80.0 : 100.0;
    final h = widget.compact ? 64.0 : 80.0;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: hex));
        setState(() => _copied = true);
        await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
        if (mounted) setState(() => _copied = false);
      },
      child: Tooltip(
        message: 'Tap to copy $hex',
        child: Container(
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: widget.swatch.main
                ? Border.all(color: const Color(0xFF6A4EFF), width: 2)
                : Border.all(color: isDarkTheme ? Colors.white12 : const Color(0xFFE5E7EB)),
            boxShadow: isDarkTheme
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: h,
                decoration: BoxDecoration(
                  color: widget.swatch.color,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(7)),
                ),
                alignment: Alignment.center,
                child: _copied
                    ? Icon(Icons.check, color: fg, size: 16)
                    : null,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: isDarkTheme ? const Color(0xFF1E1E2E) : Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.swatch.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDarkTheme ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    Text(
                      hex,
                      style: TextStyle(
                        fontSize: 10,
                        color: isDarkTheme ? Colors.white38 : const Color(0xFF6B7280),
                      ),
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
}

// ── Dimensions widgets ────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String token;
  const _SectionHeader(this.title, this.token);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF6A4EFF).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            token,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF6A4EFF),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpacingRow extends StatelessWidget {
  final String token;
  final double value;
  const _SpacingRow({required this.token, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 160,
            child: Text(
              'Ux4gSpace.$token',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: isDark ? Colors.white70 : const Color(0xFF374151),
              ),
            ),
          ),
          Container(
            width: value == 0 ? 2 : value.clamp(2, 320),
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF6A4EFF).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${value.toStringAsFixed(0)}px',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RadiusCard extends StatelessWidget {
  final String token;
  final double value;
  const _RadiusCard({required this.token, required this.value});

  @override
  Widget build(BuildContext context) {
    final r = value.clamp(0, 40).toDouble();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF6A4EFF).withValues(alpha: 0.12),
            border: Border.all(
                color: const Color(0xFF6A4EFF).withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(r),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          token,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: isDark ? Colors.white70 : const Color(0xFF374151),
          ),
        ),
        Text(
          '${value.toStringAsFixed(0)}px',
          style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white38 : const Color(0xFF6B7280)),
        ),
      ],
    );
  }
}

class _BorderWidthRow extends StatelessWidget {
  final String token;
  final double value;
  const _BorderWidthRow({required this.token, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              'Ux4gBorderWidth.$token',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: isDark ? Colors.white70 : const Color(0xFF374151),
              ),
            ),
          ),
          Container(
            width: 120,
            height: value == 0 ? 1 : value,
            color: const Color(0xFF6A4EFF),
          ),
          const SizedBox(width: 12),
          Text(
            value == 0 ? 'none' : '${value.toStringAsFixed(0)}px',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white38 : const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
