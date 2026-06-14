import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

void main() {
  runApp(
    const Ux4gTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UX4G Demo',
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
      appBar: AppBar(title: const Text('UX4G Design System Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Buttons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Ux4gButton(
              onPressed: () {},
              text: 'Primary Action',
            ),
            const SizedBox(height: 16),
            const Text('Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Ux4gCard(
              title: 'Welcome to UX4G',
              subtitle: 'A modern design system',
              body: 'This is a simple demo of the UX4G Flutter Design System components.',
              footerType: Ux4gCardFooterType.primaryOnly,
              primaryButtonText: 'Continue',
              onPrimaryClick: () {},
            ),
            const SizedBox(height: 16),
            const Text('Input Field', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Ux4gInputField(
              value: '',
              onValueChange: (value) {},
              label: 'Email Address',
              placeholder: 'Enter your email',
            ),
          ],
        ),
      ),
    );
  }
}
