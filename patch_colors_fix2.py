"""Fix broken string literals in utils_stories.dart How-to-use section."""
import os

p = r'C:\Users\Netoy\ux4g-flutter-design-system\example\lib\stories\utils_stories.dart'
with open(p, encoding='utf-8') as f:
    content = f.read()

start_marker = "    // \u2500\u2500 How to use "
end_marker   = "\n// \u2500\u2500 Utils"
start_idx = content.find(start_marker)
end_idx   = content.find(end_marker, start_idx)

if start_idx < 0 or end_idx < 0:
    print(f'Markers not found: start={start_idx}, end={end_idx}')
    exit(1)

REPLACEMENT = """    // \u2500\u2500 How to use \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500
    WidgetbookUseCase(
      name: 'How to use',
      builder: (context) => _DocPage(
        title: 'Using UX4G Colors',
        sections: const [
          _DocSection(
            heading: '1. Palette Colors  (static, always fixed)',
            body:
                'Ux4gPalette provides fixed color constants that never change with '
                'the theme. Use these when you need a very specific shade \u2014 for '
                'example, an illustration or a data-visualisation chart that must '
                'always use the same hue.',
          ),
        ],
        codeBlocks: const [
          _CodeBlock(
            label: 'Dart \u2014 Ux4gPalette',
            code: '''import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

// Fixed palette shades
Container(color: Ux4gPalette.primary500)       // #6A4EFF  \u2014 brand purple
Container(color: Ux4gPalette.primary50)        // #F2EFFF  \u2014 lightest tint
Container(color: Ux4gPalette.primary950)       // #1A0E3D  \u2014 darkest shade

Container(color: Ux4gPalette.red500)           // #F55E57  \u2014 error
Container(color: Ux4gPalette.green500)         // #1AA64A  \u2014 success
Container(color: Ux4gPalette.secondary500)     // #FFA827  \u2014 amber
Container(color: Ux4gPalette.gray900)          // #121212  \u2014 near-black
Container(color: Ux4gPalette.white)            // #FFFFFF
Container(color: Ux4gPalette.neutral1000black) // #000000''',
          ),
        ],
        trailingSections: const [
          _DocSection(
            heading: '2. Semantic Tokens  (theme-aware, recommended)',
            body: '''Ux4gColors holds semantic tokens that automatically switch value when the user changes between Light and Dark themes. Always prefer these inside your own widgets to keep the UI consistent with the rest of the design system.

Available tokens:
  \u2022 primary / onPrimary
  \u2022 secondary / onSecondary
  \u2022 background / onBackground
  \u2022 surface / onSurface
  \u2022 error / onError''',
          ),
        ],
        trailingCodeBlocks: const [
          _CodeBlock(
            label: 'Dart \u2014 Ux4gTheme.colors(context)',
            code: '''// Inside any build() method, after Ux4gTheme is in the widget tree:
final colors = Ux4gTheme.colors(context);

// Pair usage \u2014 background + foreground
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
);"""

new_content = content[:start_idx] + REPLACEMENT + content[end_idx:]

with open(p, 'w', encoding='utf-8') as f:
    f.write(new_content)
print(f'OK: replaced How-to-use section (chars {start_idx}-{end_idx})')
