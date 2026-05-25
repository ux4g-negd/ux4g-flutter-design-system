# UX4G Flutter Design System

Flutter package for the UX4G design system, with reusable foundations and UI components ported from the Android Compose implementation.

## Included

- foundations: colors, typography, spacing, radii, icons
- inputs: buttons, checkbox, toggle, dropdown, selection, input field, search field, text area, slider
- feedback: toast, tooltip, loader, modal, bottom sheet
- navigation and progress: pagination, steppers
- data display: card, badge, tag, chips, avatar, divider

## Use this package as a library

### Depend on it

Run this command:

With Flutter:

```shell
 $ flutter pub add ux4g_flutter_design_system
```

This will add a line like this to your package's pubspec.yaml (and run an implicit `flutter pub get`):

```yaml
dependencies:
  ux4g_flutter_design_system: ^0.1.0
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

### Import it

Now in your Dart code, you can use:

```dart
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
```

## Basic usage

```dart
import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void main() {
  runApp(
    const Ux4gTheme(
      child: MaterialApp(
        home: DemoScreen(),
      ),
    ),
  );
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ux4gButton(
              onPressed: () {},
              text: 'Primary action',
            ),
            const SizedBox(height: 16),
            Ux4gCard(
              title: 'Title',
              subtitle: 'Subtitle',
              body: 'Body content',
              footerType: Ux4gCardFooterType.primaryOnly,
              primaryButtonText: 'Continue',
              onPrimaryClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
```

## Showcase

A full component showcase app is included in [example/lib/main.dart](./example/lib/main.dart).

Run it with:

```bash
cd example
flutter run
```

## Notes

- Components are being aligned with the UX4G Android Compose design system.
- Some APIs expose both simple and rich variants where Android has separate usage patterns.
- The example app is the best reference for current component coverage and configuration.

## Repository

- Source: https://github.com/ux4g-negd/ux4g-flutter-design-system
