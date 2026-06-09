import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../widgets/component_docs.dart';

// ── Design tokens ────────────────────────────────────────────────────────
const _titleColor = Color(0xFF111827);
const _subtleText = Color(0xFF4B5563);
const _primaryColor = Color(0xFF432CBB);
const _borderColor = Color(0xFFE5E5E5);

// ── Component ────────────────────────────────────────────────────────────

final fileComplaintComponent = WidgetbookComponent(
  name: 'File a Complaint',
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
          name: 'File a Complaint ($variant)',
          description: isCard
              ? 'Complaint form with subject, category dropdown, and description '
                'inside a card container with light purple background.'
              : 'Complaint form with subject, category dropdown, and description on white background.',
          code: isCard ? _fileComplaintCardCode : _fileComplaintDefaultCode,
          center: true,
          child: _FileComplaintMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _fileComplaintDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class FileComplaintScreen extends StatelessWidget {
  const FileComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
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
                    Text('File a complaint',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Report a portal issue — we will respond within 2 working days.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                    const SizedBox(height: 24),
                    // Subject field
                    Text('Subject', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      placeholder: 'Briefly describe the issue',
                    ),
                    const SizedBox(height: 20),
                    // Category dropdown
                    Text('Category', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      placeholder: 'Select Category',
                      trailingIcon: Icons.keyboard_arrow_down,
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                    // Description field
                    Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Ux4gInputField(
                      value: '',
                      onValueChange: (_) {},
                      placeholder: 'Tell us what happened, when, and what you expect',
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Submit complaint',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Cancel',
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      borderColor: const Color(0xFF432CBB),
                      contentColor: const Color(0xFF432CBB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _fileComplaintCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — file complaint form inside a white card on purple background.
class FileComplaintCardScreen extends StatelessWidget {
  const FileComplaintCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(
                  height: 32,
                  child: Ux4gDivider(
                    orientation: Ux4gDividerOrientation.vertical,
                    color: const Color(0xFFD1D5DB),
                  ),
                ),
                const SizedBox(width: 8),
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
                        Text('File a complaint',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Report a portal issue — we will respond within 2 working days.',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
                        const SizedBox(height: 24),
                        // Subject field
                        Text('Subject', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Ux4gInputField(
                          hintText: 'Briefly describe the issue',
                        ),
                        const SizedBox(height: 20),
                        // Category dropdown
                        Text('Category', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Ux4gInputField(
                          hintText: 'Select Category',
                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280)),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        // Description field
                        Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Ux4gInputField(
                          hintText: 'Tell us what happened, when, and what you expect',
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Submit complaint',
                      variant: Ux4gButtonVariant.primary,
                      size: Ux4gButtonSize.large,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Ux4gButton(
                      onPressed: () {},
                      text: 'Cancel',
                      variant: Ux4gButtonVariant.outline,
                      size: Ux4gButtonSize.large,
                      borderColor: const Color(0xFF432CBB),
                      contentColor: const Color(0xFF432CBB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
    );
  }
}
""";

// ───────────────────────────────────────────────────────────────────────
// Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _FileComplaintMockup extends StatelessWidget {
  final bool isCard;

  const _FileComplaintMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
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
                  const SizedBox(width: 3),
                  SizedBox(
                    height: 32,
                    child: Ux4gDivider(
                      orientation: Ux4gDividerOrientation.vertical,
                      color: const Color(0xFFD1D5DB),
                    ),
                  ),
                  const SizedBox(width: 3),
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
                    Image.asset('assets/india_flag.png', height: 14, width: 22,
                        errorBuilder: (_, __, ___) => const Text('\u{1f1ee}\u{1f1f3}', style: TextStyle(fontSize: 14))),
                    const SizedBox(width: 8),
                    const Text('Government of India',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 11, color: Colors.white),
                    const Spacer(),
                    const Icon(Icons.accessibility_new, size: 16, color: Colors.white),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isCard
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

              // Buttons at bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Submit complaint',
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        onPressed: () {},
                        text: 'Cancel',
                        variant: Ux4gButtonVariant.outline,
                        size: Ux4gButtonSize.large,
                        borderColor: _primaryColor,
                        contentColor: _primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Powered by
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Powered by -',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                    const SizedBox(width: 4),
                    Image.asset('assets/digital_india_logo.png', height: 20,
                        errorBuilder: (_, __, ___) => const Text('Digital India',
                            style: TextStyle(fontSize: 10, color: Color(0xFF432CBB)))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'File a complaint',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: _titleColor),
        ),
        const SizedBox(height: 8),
        const Text(
          'Report a portal issue — we will respond within 2 working days.',
          style: TextStyle(fontSize: 14, color: _subtleText),
        ),
        const SizedBox(height: 24),

        // Subject
        const Text('Subject',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
        const SizedBox(height: 6),
        Ux4gInputField(
          value: '',
          onValueChange: (_) {},
          placeholder: 'Briefly describe the issue',
          placeholderStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(height: 20),

        // Category
        const Text('Category',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
        const SizedBox(height: 6),
        Ux4gInputField(
          value: '',
          onValueChange: (_) {},
          placeholder: 'Select Category',
          placeholderStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF9CA3AF)),
          trailingIcon: Icons.keyboard_arrow_down,
          readOnly: true,
        ),
        const SizedBox(height: 20),

        // Description
        const Text('Description',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _titleColor)),
        const SizedBox(height: 6),
        Ux4gInputField(
          value: '',
          onValueChange: (_) {},
          placeholder: 'Tell us what happened, when, and what you expect',
          placeholderStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF9CA3AF)),
          maxLines: 4,
        ),
      ],
    );
  }
}
