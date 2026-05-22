import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';
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
    this.successMessage = 'Thank you for your feedback. This helps improve government services.',
    this.titleStyle,
    this.successTitleStyle,
    this.successMessageStyle,
    this.successIcon = Icons.thumb_up,
    this.successIconColor,
    this.successBackgroundColor,
    this.selectedScoreBackgroundColor,
    this.selectedScoreTextColor,
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
    if (widget.minWords > 0 && _getWordCount(_comment) < widget.minWords) return false;
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
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _isSubmitted ? _buildSuccessView(colors, typography) : _buildFormView(colors, typography),
    );
  }

  Widget _buildFormView(Ux4gColors colors, Ux4gTypography typography) {
    final highlightBg = widget.selectedScoreBackgroundColor ?? colors.success.withValues(alpha: 0.12);
    final highlightText = widget.selectedScoreTextColor ?? colors.success;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: widget.titleStyle ?? typography.hM_strong.copyWith(color: colors.onBackground, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 24),
        
        // NPS Scale 0-10
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: List.generate(11, (index) {
            final isHighlighted = _selectedScore != null && index <= _selectedScore!;
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
                  color: isHighlighted ? highlightBg : colors.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: isHighlighted 
                      ? null 
                      : Border.all(color: colors.onSurface.withValues(alpha: 0.15)),
                ),
                child: Text(
                  '$index',
                  style: typography.bM_strong.copyWith(
                    color: isHighlighted ? highlightText : colors.onBackground,
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
              style: typography.bXS_default.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
            ),
            Text(
              widget.likelyLabel,
              style: typography.bXS_default.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
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
            style: TextButton.styleFrom(
              foregroundColor: colors.onBackground,
            ),
            child: Text(
              widget.skipButtonText,
              style: typography.bM_strong.copyWith(color: colors.onBackground),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSuccessView(Ux4gColors colors, Ux4gTypography typography) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: widget.successBackgroundColor ?? colors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.successIcon,
                color: widget.successIconColor ?? colors.success,
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                widget.successTitle,
                textAlign: TextAlign.center,
                style: widget.successTitleStyle ?? typography.hL_strong.copyWith(color: colors.onBackground, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                widget.successMessage,
                textAlign: TextAlign.center,
                style: widget.successMessageStyle ?? typography.bM_default.copyWith(color: colors.onSurface.withValues(alpha: 0.7)),
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
