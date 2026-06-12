import 'dart:io';

void main() {
  final file = File('example/lib/stories/pattern_stories.dart');
  var content = file.readAsStringSync();
  
  // Fix _signInWithMobileCardCode Title
  content = content.replaceAll(
    "Text('Sign in to your account',\n                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),",
    "Text('Sign in to your account',\n                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Theme.of(context).brightness == Brightness.dark ? Ux4gPalette.neutral50 : Ux4gPalette.gray900)),"
  );
  
  // Fix _signInWithMobileCardCode Subtitle
  content = content.replaceAll(
    "Text('Access your government services securely',\n                          style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),",
    "Text('Access your government services securely',\n                          style: TextStyle(fontSize: 13, color: Theme.of(context).brightness == Brightness.dark ? Ux4gPalette.neutral400 : Color(0xFF6B7280))),"
  );
  
  // Fix _signInWithMobileCardCode Banner
  final oldBanner = '''                        Ux4gStatusBanner(
                          variant: Ux4gBannerVariant.errorLight,
                          title: 'Your status message goes here',
                          subtitle: 'Take action',
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                          leadingIcon: Icon(Icons.error_outline,
                            color: Ux4gPalette.red600, size: 20),
                          trailingIcon: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Ux4gPalette.red200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Attempt 1 of 5',
                              style: TextStyle(fontSize: 12,
                                color: Ux4gPalette.red800,
                                fontWeight: FontWeight.w500)),
                          ),
                        ),''';
  final newBanner = '''                        Ux4gStatusBanner(
                          variant: Ux4gBannerVariant.errorLight,
                          title: 'Your status message goes here',
                          subtitleWidget: Row(
                            children: [
                              Text(
                                'Take action',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Ux4gPalette.red300
                                      : Ux4gPalette.red800,
                                  height: 1.3,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Ux4gPalette.red800
                                      : Ux4gPalette.red100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Attempt 1 of 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Ux4gPalette.red300
                                        : Ux4gPalette.red800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.zero,
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Ux4gPalette.red900
                              : Ux4gPalette.red50,
                          borderColor: Theme.of(context).brightness == Brightness.dark
                              ? Ux4gPalette.red600
                              : Ux4gPalette.red300,
                          padding: EdgeInsets.fromLTRB(12, 12, 10, 12),
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Ux4gPalette.red300
                                : Ux4gPalette.red800,
                            height: 1.3,
                          ),
                          leadingIcon: Icon(
                            Icons.error,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Ux4gPalette.red500
                                : Ux4gPalette.red600,
                            size: 20,
                          ),
                        ),''';
  content = content.replaceAll(oldBanner, newBanner);
  
  file.writeAsStringSync(content);
}
