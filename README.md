# 🌟 UX4G Flutter Design System

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Version](https://img.shields.io/badge/Version-0.4.2-blue.svg?style=for-the-badge)

Flutter package for the **UX4G design system**, providing beautifully crafted, reusable foundations and UI components ported directly from the Android Compose implementation.

---

## 🎨 Included Features

- **Foundations**: Colors, typography, spacing, radii, icons
- **Inputs**: Buttons, checkboxes, toggles, dropdowns, selections, input fields, search fields, text areas, sliders
- **Feedback**: Toasts, tooltips, loaders, modals, bottom sheets
- **Navigation & Progress**: Pagination, steppers
- **Data Display**: Cards, badges, tags, chips, avatars, dividers

---

## 🚀 Quick Start

### 1️⃣ Depend on it

Run this command in your Flutter project:

```shell
flutter pub add ux4g_flutter_design_system
```

This will automatically add the following line to your `pubspec.yaml`:

```yaml
dependencies:
  ux4g_flutter_design_system: ^0.4.2
```

### 2️⃣ Import it

Now in your Dart code, you can use:

```dart
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
```

---

## 📖 Basic Usage

Wrap your application with `Ux4gTheme` to ensure all components inherit the proper design foundations.

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
