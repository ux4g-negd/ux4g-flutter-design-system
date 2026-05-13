import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void main() {
  testWidgets('renders circular progress metadata and center content', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Ux4gTheme(
          child: Scaffold(
            body: Ux4gCircularProgress(
              value: 0.5,
              size: Ux4gCircularProgressSize.xl,
              centerValueText: '50%',
              centerDescription: 'Description',
              label: 'Label',
              description: 'Caption',
              footer: const Ux4gTag(label: 'Tag'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('50%'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Label'), findsOneWidget);
    expect(find.text('Caption'), findsOneWidget);
    expect(find.text('Tag'), findsOneWidget);
  });
}
