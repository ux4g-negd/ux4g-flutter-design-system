"""Patch utils_stories.dart — complete color palette overhaul."""
import os

p = r'C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories\utils_stories.dart'
with open(p, encoding='utf-8') as f:
    content = f.read()

# ─── anchor: entire Semantic + Neutral + closing ];  );  ──────────────────────
# (ends right before // ── Utils — Dimensions)

ANCHOR = (
    "    WidgetbookUseCase(\n"
    "      name: 'Semantic',\n"
    "      builder: (context) => SingleChildScrollView(\n"
    "        padding: const EdgeInsets.all(24),\n"
    "        child: Column(\n"
    "          crossAxisAlignment: CrossAxisAlignment.start,\n"
    "          children: [\n"
    "            _PaletteView(\n"
    "              label: 'Red (Error)',\n"
    "              swatches: const [\n"
    "                _Swatch('red-50', Ux4gPalette.red50, '50'),\n"
    "                _Swatch('red-500', Ux4gPalette.red500, '500 \u2605', main: true),\n"
    "                _Swatch('red-600', Ux4gPalette.red600, '600'),\n"
    "                _Swatch('red-700', Ux4gPalette.red700, '700'),\n"
    "              ],\n"
    "              compact: true,\n"
    "            ),\n"
    "            const SizedBox(height: 24),\n"
    "            _PaletteView(\n"
    "              label: 'Green (Success)',\n"
    "              swatches: const [\n"
    "                _Swatch('green-50', Ux4gPalette.green50, '50'),\n"
    "                _Swatch('green-500', Ux4gPalette.green500, '500 \u2605', main: true),\n"
    "                _Swatch('green-700', Ux4gPalette.green700, '700'),\n"
    "              ],\n"
    "              compact: true,\n"
    "            ),\n"
    "            const SizedBox(height: 24),\n"
    "            _PaletteView(\n"
    "              label: 'Blue (Info)',\n"
    "              swatches: const [\n"
    "                _Swatch('blue-50', Ux4gPalette.blue50, '50'),\n"
    "                _Swatch('blue-500', Ux4gPalette.blue500, '500 \u2605', main: true),\n"
    "                _Swatch('blue-700', Ux4gPalette.blue700, '700'),\n"
    "              ],\n"
    "              compact: true,\n"
    "            ),\n"
    "            const SizedBox(height: 24),\n"
    "            _PaletteView(\n"
    "              label: 'Orange (Warning)',\n"
    "              swatches: const [\n"
    "                _Swatch('orange-50', Ux4gPalette.orange50, '50'),\n"
    "                _Swatch('orange-500', Ux4gPalette.orange500, '500 \u2605', main: true),\n"
    "                _Swatch('orange-700', Ux4gPalette.orange700, '700'),\n"
    "              ],\n"
    "              compact: true,\n"
    "            ),\n"
    "          ],\n"
    "        ),\n"
    "      ),\n"
    "    ),\n"
    "    WidgetbookUseCase(\n"
    "      name: 'Neutral',\n"
    "      builder: (context) => _PaletteView(\n"
    "        label: 'Neutral / Gray',\n"
    "        swatches: const [\n"
    "          _Swatch('gray-100', Ux4gPalette.gray100, '100'),\n"
    "          _Swatch('gray-200', Ux4gPalette.gray200, '200'),\n"
    "          _Swatch('gray-800', Ux4gPalette.gray800, '800'),\n"
    "          _Swatch('gray-900', Ux4gPalette.gray900, '900'),\n"
    "        ],\n"
    "      ),\n"
    "    ),\n"
    "  ],\n"
    ");"
)

if ANCHOR not in content:
    print('ANCHOR NOT FOUND')
    # Debug: show first 50 chars of anchor vs file
    for i, line in enumerate(ANCHOR.split('\n')[:6]):
        idx = content.find(line)
        print(f'  line {i}: found={idx >= 0}  {repr(line[:60])}')
    exit(1)

REPLACEMENT = '''\
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
                _Swatch('red-500', Ux4gPalette.red500, '500 \u2605', main: true),
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
                _Swatch('green-500', Ux4gPalette.green500, '500 \u2605', main: true),
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
                _Swatch('blue-500', Ux4gPalette.blue500, '500 \u2605', main: true),
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
                _Swatch('orange-500', Ux4gPalette.orange500, '500 \u2605', main: true),
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
                _Swatch('gold-500', Ux4gPalette.gold500, '500 \u2605', main: true),
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
                _Swatch('cyan-500', Ux4gPalette.cyan500, '500 \u2605', main: true),
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
                _Swatch('purple-500', Ux4gPalette.purple500, '500 \u2605', main: true),
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
                    '// Use: colors.primary  colors.onPrimary  colors.surface …',
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
    // ── How to use ─────────────────────────────────────────────────────────────
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
            code:
                "import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';\n"
                '\n'
                '// Fixed palette shades\n'
                'Container(color: Ux4gPalette.primary500)   // #6A4EFF  — brand purple\n'
                'Container(color: Ux4gPalette.primary50)    // #F2EFFF  — lightest tint\n'
                'Container(color: Ux4gPalette.primary950)   // #1A0E3D  — darkest shade\n'
                '\n'
                'Container(color: Ux4gPalette.red500)       // #F55E57  — error\n'
                'Container(color: Ux4gPalette.green500)     // #1AA64A  — success\n'
                'Container(color: Ux4gPalette.secondary500) // #FFA827  — amber\n'
                'Container(color: Ux4gPalette.gray900)      // #121212  — near-black\n'
                'Container(color: Ux4gPalette.white)        // #FFFFFF\n'
                'Container(color: Ux4gPalette.neutral1000black) // #000000',
          ),
        ],
        trailingSections: const [
          _DocSection(
            heading: '2. Semantic Tokens  (theme-aware, recommended)',
            body:
                'Ux4gColors holds semantic tokens that automatically switch value '
                'when the user changes between Light and Dark themes. '
                'Always prefer these inside your own widgets to keep the UI '
                'consistent with the rest of the design system.\n\n'
                'Available tokens:\n'
                '  \u2022 primary / onPrimary\n'
                '  \u2022 secondary / onSecondary\n'
                '  \u2022 background / onBackground\n'
                '  \u2022 surface / onSurface\n'
                '  \u2022 error / onError',
          ),
        ],
        trailingCodeBlocks: const [
          _CodeBlock(
            label: 'Dart — Ux4gTheme.colors(context)',
            code:
                '// Inside any build() method, after Ux4gTheme is in the widget tree:\n'
                'final colors = Ux4gTheme.colors(context);\n'
                '\n'
                '// Pair usage — background + foreground\n'
                'Container(\n'
                '  color: colors.surface,\n'
                '  child: Text(\n'
                "    'Hello',\n"
                '    style: TextStyle(color: colors.onSurface),\n'
                '  ),\n'
                ');\n'
                '\n'
                '// Other semantic tokens\n'
                'colors.primary        // Brand primary color\n'
                'colors.onPrimary      // Text / icon color ON primary background\n'
                'colors.secondary      // Secondary brand color\n'
                'colors.onSecondary    // Text / icon color ON secondary background\n'
                'colors.background     // Page-level background\n'
                'colors.onBackground   // Text color on background\n'
                'colors.error          // Error state color\n'
                'colors.onError        // Text / icon color ON error background',
          ),
          _CodeBlock(
            label: 'Light vs Dark values',
            code:
                '// Light theme values\n'
                'primary    = #6A4EFF   onPrimary    = #FFFFFF\n'
                'secondary  = #FFA827   onSecondary  = #121212\n'
                'background = #F5F5F5   onBackground = #121212\n'
                'surface    = #FFFFFF   onSurface    = #121212\n'
                'error      = #F55E57   onError      = #FFFFFF\n'
                '\n'
                '// Dark theme values\n'
                'primary    = #6A4EFF   onPrimary    = #121212\n'
                'secondary  = #1157CE   onSecondary  = #FFFFFF\n'
                'background = #121212   onBackground = #FFFFFF\n'
                'surface    = #333333   onSurface    = #FFFFFF\n'
                'error      = #FF8983   onError      = #121212',
          ),
        ],
      ),
    ),
  ],
);'''

new_content = content.replace(ANCHOR, REPLACEMENT)
if new_content == content:
    print('REPLACEMENT HAD NO EFFECT')
    exit(1)

with open(p, 'w', encoding='utf-8') as f:
    f.write(new_content)
print('OK: themeColorComponent patched')
