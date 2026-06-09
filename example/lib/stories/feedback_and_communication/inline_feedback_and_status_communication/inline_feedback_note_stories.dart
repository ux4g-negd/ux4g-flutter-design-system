import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';
import '../../../../widgets/component_docs.dart';

const Color _titleColor = Color(0xFF111827);
const Color _subtleText = Color(0xFF4B5563);
const Color _primaryColor = Color(0xFF432CBB);
const Color _noteBg = Color(0xFFFFF7E6);
const Color _noteBorder = Color(0xFFFFC973);
const Color _noteTitle = Color(0xFFAD4E00);

final inlineFeedbackNoteComponent = WidgetbookComponent(
  name: 'Inline Feedback Note',
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
          name: 'Inline Feedback Note ($variant)',
          description: isCard
              ? 'A note from a reviewing officer inside a card container. '
                    'Shows an important message with action required.'
              : 'A note from a reviewing officer displayed inline. '
                    'Shows an important message with action required.',
          code: isCard ? _noteCardCode : _noteDefaultCode,
          center: true,
          child: _NoteMockup(isCard: isCard),
        );
      },
    ),
  ],
);

// ───────────────────────────────────────────────────────────────────────
// Source Code String — Default
// ───────────────────────────────────────────────────────────────────────

const _noteDefaultCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

class NoteToCitizenScreen extends StatelessWidget {
  const NoteToCitizenScreen({super.key});

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
              child: Padding(
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
                    Text('Note to Citizen',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Text('A note written by a reviewing officer.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4)),
                    const SizedBox(height: 24),
                    // Note card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF7E6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFFFFC973)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.error, size: 18, color: Color(0xFFAD4E00)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Note from Revenue Inspector - 12 April 2026, 11:34 AM',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Please resubmit the income proof with a clearer scan. The current file shows glare on the income figure row. Resubmit within 5 working days to avoid delay.',
                                  style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Resubmit Documents button
                    SizedBox(
                      width: double.infinity,
                      child: Ux4gButton(
                        text: 'Resubmit Documents',
                        onPressed: () {},
                        variant: Ux4gButtonVariant.primary,
                        size: Ux4gButtonSize.large,
                        backgroundColor: const Color(0xFF4A2BC2),
                      ),
                    ),
                  ],
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
// Source Code String — Card Style
// ───────────────────────────────────────────────────────────────────────

const _noteCardCode = r"""import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ux4g_flutter_design_system/ux4g_flutter_design_system.dart';

/// Card Style variant
class NoteToCitizenCardScreen extends StatelessWidget {
  const NoteToCitizenCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EFFF),
      body: SafeArea(
        child: Column(
          children: [
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                      Text('Note to Citizen',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 10),
                      Text('A note written by a reviewing officer.',
                        style: TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.4)),
                      const SizedBox(height: 24),
                      // Note card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF7E6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFFFFC973)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.error, size: 18, color: Color(0xFFAD4E00)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Note from Revenue Inspector - 12 April 2026, 11:34 AM',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFAD4E00)),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Please resubmit the income proof with a clearer scan. The current file shows glare on the income figure row. Resubmit within 5 working days to avoid delay.',
                                    style: TextStyle(fontSize: 13, color: Color(0xFF4B5563), height: 1.4),
                                  ),
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
            // Resubmit Documents button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Ux4gButton(
                  text: 'Resubmit Documents',
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
// Note Mockup Widget
// ───────────────────────────────────────────────────────────────────────

class _NoteMockup extends StatelessWidget {
  final bool isCard;

  const _NoteMockup({this.isCard = false});

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
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
              if (!isCard)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildDefaultContent(),
                  ),
                ),
              if (isCard)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildCardContent(),
                  ),
                ),

              // Resubmit Documents button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Ux4gButton(
                    text: 'Resubmit Documents',
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
          'Note to Citizen',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: _titleColor,
          ),
        ),
        const SizedBox(height: 10),

        // Description
        const Text(
          'A note written by a reviewing officer.',
          style: TextStyle(fontSize: 14, color: _subtleText, height: 1.4),
        ),
        const SizedBox(height: 24),

        // Note card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _noteBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _noteBorder),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error, size: 18, color: _noteTitle),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Note from Revenue Inspector - 12 April 2026, 11:34 AM',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _noteTitle,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Please resubmit the income proof with a clearer scan. The current file shows glare on the income figure row. Resubmit within 5 working days to avoid delay.',
                      style: TextStyle(
                        fontSize: 13,
                        color: _subtleText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildFormFields()],
    );
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
