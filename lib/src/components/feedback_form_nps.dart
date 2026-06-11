import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'buttons.dart';
import 'text_area.dart';

class Ux4gFeedbackFormNps extends StatefulWidget {
  final void Function(int score, String comment) onSubmit;
  final int minWords;
  final int maxLength;
  final VoidCallback? onSkip;
  final VoidCallback? onCloseSuccess;

  // Customization
  final String title;
  final String unlikelyLabel;
  final String likelyLabel;
  final String commentPlaceholder;
  final String submitButtonText;
  final String skipButtonText;
  final String successTitle;
  final String successMessage;

  // Typography Config
  final TextStyle? titleStyle;
  final TextStyle? successTitleStyle;
  final TextStyle? successMessageStyle;

  // Icon & Color Config
  final IconData successIcon;
  final Color? successIconColor;
  final Color? successBackgroundColor;
  final Color? selectedScoreBackgroundColor;
  final Color? selectedScoreTextColor;

  /// Colors for low scores (0-3)
  final Color lowScoreBackgroundColor;
  final Color lowScoreTextColor;

  /// Colors for medium scores (4-6)
  final Color mediumScoreBackgroundColor;
  final Color mediumScoreTextColor;

  /// Colors for high scores (7-10)
  final Color highScoreBackgroundColor;
  final Color highScoreTextColor;

  const Ux4gFeedbackFormNps({
    super.key,
    required this.onSubmit,
    this.minWords = 0,
    this.maxLength = 200,
    this.onSkip,
    this.onCloseSuccess,
    this.title = 'How likely are you to recommend us?',
    this.unlikelyLabel = '0 - Extremely Unlikely',
    this.likelyLabel = '10 - Extremely Likely',
    this.commentPlaceholder = 'Please tell us why you gave this score',
    this.submitButtonText = 'Submit',
    this.skipButtonText = 'Skip',
    this.successTitle = 'Feedback submitted',
    this.successMessage =
        'Thank you for your feedback. This helps improve government services.',
    this.titleStyle,
    this.successTitleStyle,
    this.successMessageStyle,
    this.successIcon = Icons.thumb_up,
    this.successIconColor,
    this.successBackgroundColor,
    this.selectedScoreBackgroundColor,
    this.selectedScoreTextColor,
    this.lowScoreBackgroundColor = Ux4gPalette.red100,
    this.lowScoreTextColor = Ux4gPalette.red800,
    this.mediumScoreBackgroundColor = Ux4gPalette.orange100,
    this.mediumScoreTextColor = Ux4gPalette.orange800,
    this.highScoreBackgroundColor = Ux4gPalette.green100,
    this.highScoreTextColor = Ux4gPalette.green800,
  });

  @override
  State<Ux4gFeedbackFormNps> createState() => _Ux4gFeedbackFormNpsState();
}

class _Ux4gFeedbackFormNpsState extends State<Ux4gFeedbackFormNps> {
  int? _selectedScore;
  String _comment = '';
  bool _isSubmitted = false;

  int _getWordCount(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  bool get _isFormValid {
    if (_selectedScore == null) return false;
    if (widget.minWords > 0 && _getWordCount(_comment) < widget.minWords)
      return false;
    return true;
  }

  void _handleSubmit() {
    if (_isFormValid) {
      widget.onSubmit(_selectedScore!, _comment);
      setState(() {
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _isSubmitted
          ? _buildSuccessView(materialTheme, ux4gColors, ux4gTypography)
          : _buildFormView(materialTheme, ux4gColors, ux4gTypography),
    );
  }

  Widget _buildFormView(
    ThemeData materialTheme,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
  ) {
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final onBackground =
        ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;

    final hmStrong =
        ux4gTypography?.hM_strong ??
        materialTheme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 24);
    final bmStrong =
        ux4gTypography?.bM_strong ??
        materialTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
    final bxsDefault =
        ux4gTypography?.bXS_default ??
        materialTheme.textTheme.bodySmall ??
        const TextStyle(fontSize: 12);

    final highlightBg = widget.selectedScoreBackgroundColor;
    final highlightText = widget.selectedScoreTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style:
              widget.titleStyle ??
              hmStrong.copyWith(
                color: onBackground,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 24),

        // NPS Scale 0-10
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: List.generate(11, (index) {
            final isHighlighted =
                _selectedScore != null && index <= _selectedScore!;

            // Determine colors based on selected score range
            Color scoreBg;
            Color scoreText;
            if (highlightBg != null && highlightText != null) {
              scoreBg = highlightBg;
              scoreText = highlightText;
            } else if (_selectedScore != null && _selectedScore! <= 3) {
              scoreBg = widget.lowScoreBackgroundColor;
              scoreText = widget.lowScoreTextColor;
            } else if (_selectedScore != null && _selectedScore! <= 6) {
              scoreBg = widget.mediumScoreBackgroundColor;
              scoreText = widget.mediumScoreTextColor;
            } else {
              scoreBg = widget.highScoreBackgroundColor;
              scoreText = widget.highScoreTextColor;
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedScore = index;
                });
              },
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isHighlighted ? scoreBg : surface,
                  borderRadius: BorderRadius.circular(4),
                  border: isHighlighted
                      ? null
                      : Border.all(color: onSurface.withValues(alpha: 0.15)),
                ),
                child: Text(
                  '$index',
                  style: bmStrong.copyWith(
                    color: isHighlighted ? scoreText : onBackground,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),

        // Scale Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.unlikelyLabel,
              style: bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              widget.likelyLabel,
              style: bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),

        // Conditional Text Area
        if (_selectedScore != null) ...[
          const SizedBox(height: 24),
          Ux4gTextArea(
            value: _comment,
            minHeight: Ux4gTextAreaMinHeight.large,
            onValueChange: (value) {
              setState(() {
                _comment = value;
              });
            },
            placeholder: widget.commentPlaceholder,
            maxLength: widget.maxLength,
            characterCountText: '${_comment.length}/${widget.maxLength}',
          ),
        ],

        const SizedBox(height: 24),

        // Buttons
        Ux4gButton(
          text: widget.submitButtonText,
          variant: Ux4gButtonVariant.primary,
          enabled: _isFormValid,
          onPressed: _handleSubmit,
        ),
        if (widget.onSkip != null) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: widget.onSkip,
            style: TextButton.styleFrom(foregroundColor: onBackground),
            child: Text(
              widget.skipButtonText,
              style: bmStrong.copyWith(color: onBackground),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuccessView(
    ThemeData materialTheme,
    Ux4gColors? ux4gColors,
    Ux4gTypography? ux4gTypography,
  ) {
    final success = ux4gColors?.success ?? Colors.green;
    final onBackground =
        ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    final hlStrong =
        ux4gTypography?.hL_strong ??
        materialTheme.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 28);
    final bmDefault =
        ux4gTypography?.bM_default ??
        materialTheme.textTheme.bodyMedium ??
        const TextStyle(fontSize: 16);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color:
                widget.successBackgroundColor ??
                success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.successIcon,
                color: widget.successIconColor ?? success,
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                widget.successTitle,
                textAlign: TextAlign.center,
                style:
                    widget.successTitleStyle ??
                    hlStrong.copyWith(
                      color: onBackground,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.successMessage,
                textAlign: TextAlign.center,
                style:
                    widget.successMessageStyle ??
                    bmDefault.copyWith(color: onSurface.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Ux4gButton(
          text: 'Close',
          variant: Ux4gButtonVariant.outline,
          onPressed: () {
            if (widget.onCloseSuccess != null) {
              widget.onCloseSuccess!();
            } else {
              setState(() {
                _selectedScore = null;
                _comment = '';
                _isSubmitted = false;
              });
            }
          },
        ),
      ],
    );
  }
}
