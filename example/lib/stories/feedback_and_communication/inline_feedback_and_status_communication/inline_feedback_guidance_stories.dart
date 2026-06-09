import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _warningOrange = Color(0xFFAD4E00);
const Color _warningBg = Color(0xFFFFF7E6);

final inlineFeedbackGuidanceComponent = WidgetbookComponent(
  name: 'Inline Feedback Guidance',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final variant = context.knobs.object.dropdown<String>(
          label: 'Variant',
          options: ['Default', 'Card Style'],
          initialOption: 'Default',
        );
        final isCard = variant == 'Card Style';

        return ComponentDocs(
          mobileMockup: true,
          name: 'Inline Feedback Guidance ($variant)',
          description: isCard
              ? 'Conditional guidance with file upload area inside a card container. '
                    'Shows context-sensitive info based on selected field value.'
              : 'Conditional guidance with file upload area. '
                    'Shows context-sensitive info based on selected field value.',
          code: isCard
              ? _inlineFeedbackGuidanceCardCode
              : _inlineFeedbackGuidanceCode,
          center: true,
          child: _InlineFeedbackGuidanceMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Guidance Default
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackGuidanceCode = r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class InlineFeedbackGuidanceScreen extends StatelessWidget {
  const InlineFeedbackGuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Header with logos
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(height: 32, child: Ux4gDivider(orientation: Ux4gDividerOrientation.vertical, color: const Color(0xFFD1D5DB))),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Ux4gButton(
                      text: 'Back',
                      onPressed: () {},
                      variant: Ux4gButtonVariant.ghost,
                      leadingIcon: Icons.arrow_back,
                      contentColor: const Color(0xFF432CBB),
                      size: Ux4gButtonSize.small,
                    ),
                    const SizedBox(height: 20),
                    Text('Conditional Guidance',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Text('Context-sensitive info appears based on the selected field value.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4)),
                    const SizedBox(height: 24),
                    // Reservation Category input
                    Ux4gInputField(
                      value: 'SC/ST',
                      onValueChange: (_) {},
                      label: 'Reservation Category',
                      caption: 'Select your reservation category',
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    // File upload area
                    Ux4gFileUpload(
                      maxFiles: 1,
                      maxFileSize: 5 * 1024 * 1024,
                      allowedExtensions: const ['pdf', 'jpg', 'png'],
                      borderStyle: Ux4gFileUploadBorderStyle.dashed,
                      variant: Ux4gFileUploadVariant.dropzone,
                      onFilesChanged: (_) {},
                    ),
                    const SizedBox(height: 20),
                    // Warning banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF7E6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFFFC973)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.error, size: 18, color: Color(0xFFAD4E00)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Additional Document Required',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00))),
                                const SizedBox(height: 4),
                                Text('Since you selected SC category, please upload your caste certificate in the Documents step.',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Continue button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Continue',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.primary,
                  size: Ux4gButtonSize.large,
                  backgroundColor: const Color(0xFF4A2BC2),
                ),
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
// Source Code String — Guidance Card Style
// ───────────────────────────────────────────────────────────────────────

const _inlineFeedbackGuidanceCardCode =
    r"""import 'package:flutter/material.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant — the form content sits inside a light purple card.
class InlineFeedbackGuidanceCardScreen extends StatelessWidget {
  const InlineFeedbackGuidanceCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Header with logos
            Ux4gAppHeader(
              variant: Ux4gAppHeaderVariant.light,
              title: '',
              leadingWidgets: [
                SvgPicture.asset('assets/national_amblam_logo.svg', height: 40),
                const SizedBox(width: 8),
                SizedBox(height: 32, child: Ux4gDivider(orientation: Ux4gDividerOrientation.vertical, color: const Color(0xFFD1D5DB))),
                const SizedBox(width: 8),
                SvgPicture.asset('assets/Union.svg', height: 32),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Ux4gButton(
                        text: 'Back',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.ghost,
                        leadingIcon: Icons.arrow_back,
                        contentColor: const Color(0xFF432CBB),
                        size: Ux4gButtonSize.small,
                      ),
                      const SizedBox(height: 20),
                      Text('Conditional Guidance',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Context-sensitive info appears based on the selected field value.',
                        style: TextStyle(fontSize: 13, color: Color(0xFF4B5563))),
                      const SizedBox(height: 20),
                      // Reservation Category input
                      Ux4gInputField(
                        value: 'SC/ST',
                        onValueChange: (_) {},
                        label: 'Reservation Category',
                        caption: 'Select your reservation category',
                      ),
                      const SizedBox(height: 20),
                      // File upload area
                      // ... (custom file upload widget)
                      const SizedBox(height: 20),
                      // Warning banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF7E6),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFFFC973)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error, size: 18, color: Color(0xFFAD4E00)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Additional Document Required',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00))),
                                  const SizedBox(height: 4),
                                  Text('Since you selected SC category, please upload your caste certificate in the Documents step.',
                                    style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Continue button at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Continue',
                  onPressed: () {},
                  variant: Ux4gButtonVariant.primary,
                  size: Ux4gButtonSize.large,
                  backgroundColor: const Color(0xFF4A2BC2),
                ),
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
// Guidance Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _InlineFeedbackGuidanceMockup extends StatelessWidget {
  final bool isCard;

  const _InlineFeedbackGuidanceMockup({this.isCard = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Ux4gTheme.themeData(isDark: false),
      child: Scaffold(
        backgroundColor: isCard ? const Color(0xFFF2EFFF) : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // App Header with logos
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/national_amblam_logo.svg',
                      height: 40,
                    ),
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
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: isCard ? _buildCardContent() : _buildDefaultContent(),
                ),
              ),

              // Continue button at bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Ux4gButton(
                    text: 'Continue',
                    onPressed: () {},
                    variant: Ux4gButtonVariant.primary,
                    size: Ux4gButtonSize.large,
                    backgroundColor: const Color(0xFF4A2BC2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button
        Align(
          alignment: Alignment.centerLeft,
          child: Ux4gButton(
            text: 'Back',
            onPressed: () {},
            variant: Ux4gButtonVariant.ghost,
            leadingIcon: Icons.arrow_back,
            contentColor: _primaryColor,
            size: Ux4gButtonSize.small,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        const Text(
          'Conditional Guidance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 10),

        // Description
        const Text(
          'Context-sensitive info appears based on the selected field value.',
          style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
        ),
        const SizedBox(height: 24),

        // Reservation Category input
        Ux4gInputField(
          value: 'SC/ST',
          onValueChange: (_) {},
          label: 'Reservation Category',
          caption: 'Select your reservation category',
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        ),
        const SizedBox(height: 20),

        // File upload area
        _buildFileUploadArea(),
        const SizedBox(height: 20),

        // Warning banner
        _buildWarningBanner(),
      ],
    );
  }

  Widget _buildFileUploadArea() {
    return Ux4gFileUpload(
      maxFiles: 1,
      maxFileSize: 5 * 1024 * 1024,
      allowedExtensions: const ['pdf', 'jpg', 'png'],
      borderStyle: Ux4gFileUploadBorderStyle.dashed,
      variant: Ux4gFileUploadVariant.dropzone,
      onFilesChanged: (_) {},
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _warningBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFC973)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error, size: 18, color: _warningOrange),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Additional Document Required',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _warningOrange,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Since you selected SC category, please upload your caste certificate in the Documents step.',
                  style: TextStyle(fontSize: 12, color: _subtleText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultContent() {
    return _buildFormFields();
  }

  Widget _buildCardContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildFormFields(),
    );
  }
}
