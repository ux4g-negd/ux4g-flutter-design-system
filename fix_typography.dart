import 'dart:io';

void main() {
  final file = File('example/lib/stories/pattern_stories.dart');
  var content = file.readAsStringSync();
  
  content = content.replaceAll(
    'Theme.of(context).extension<Ux4gTypography>()!',
    '(Theme.of(context).extension<Ux4gTypography>() ?? defaultUx4gTypography)'
  );

  content = content.replaceAll(
    'Theme.of(context)\n                        .extension<Ux4gTypography>()!',
    '(Theme.of(context).extension<Ux4gTypography>() ?? defaultUx4gTypography)'
  );
  
  content = content.replaceAll(
    'Theme.of(context)\n                        .extension<Ux4gTypography>()!',
    '(Theme.of(context).extension<Ux4gTypography>() ?? defaultUx4gTypography)'
  );

  final regex = RegExp(r'Theme\.of\(context\)\s*\.extension<Ux4gTypography>\(\)!');
  content = content.replaceAll(regex, '(Theme.of(context).extension<Ux4gTypography>() ?? defaultUx4gTypography)');
  
  file.writeAsStringSync(content);
}
