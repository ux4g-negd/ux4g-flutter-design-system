import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';
import 'buttons.dart';
import 'chips.dart';
import 'text_area.dart';

class Ux4gFeedbackForm extends StatefulWidget {
  final List<String> improvementOptions;
  final int minWords;
  final int maxLength;
  final void Function(int rating, String selectedChip, String comment) onSubmit;
  final VoidCallback? onSkip;
  final VoidCallback? onCloseSuccess;
  final double chipBorderRadius;
  
  // Customization
  final String title;
  final String improvementTitle;
  final String commentPlaceholder;
  final String submitButtonText;
  final String skipButtonText;
  final String successTitle;
  final String successMessage;

  // Typography Config
  final TextStyle? titleStyle;
  final TextStyle? improvementTitleStyle;
  final TextStyle? successTitleStyle;
  final TextStyle? successMessageStyle;

  // Icon & Color Config
  final IconData ratingIcon;
  final IconData successIcon;
  final Color? activeRatingColor;
  final Color? inactiveRatingColor;
  final Color? successIconColor;
  final Color? successBackgroundColor;

  const Ux4gFeedbackForm({
    super.key,
    required this.improvementOptions,
    required this.onSubmit,
    this.minWords = 0,
    this.maxLength = 200,
    this.onSkip,
    this.onCloseSuccess,
    this.chipBorderRadius = 4.0,
    this.title = 'Rate your experience',
    this.improvementTitle = 'What can we improve?',
    this.commentPlaceholder = 'Tell us more about your experience',
    this.submitButtonText = 'Submit',
    this.skipButtonText = 'Skip',
    this.successTitle = 'Feedback submitted',
    this.successMessage = 'Thank you for your feedback. This helps improve government services.',
    this.titleStyle,
    this.improvementTitleStyle,
    this.successTitleStyle,
    this.successMessageStyle,
    this.ratingIcon = Icons.star,
    this.successIcon = Icons.thumb_up,
    this.activeRatingColor,
    this.inactiveRatingColor,
    this.successIconColor,
    this.successBackgroundColor,
  });

  @override
  State<Ux4gFeedbackForm> createState() => _Ux4gFeedbackFormState();
}

class _Ux4gFeedbackFormState extends State<Ux4gFeedbackForm> {
  int _rating = 0;
  String? _selectedChip;
  String _comment = '';
  bool _isSubmitted = false;

  int _getWordCount(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  bool get _isFormValid {
    if (_rating == 0) return false;
    if (_selectedChip == null) return false;
    if (_comment.trim().isEmpty) return false;
    if (widget.minWords > 0 && _getWordCount(_comment) < widget.minWords) return false;
    return true;
  }

  void _handleSubmit() {
    if (_isFormValid) {
      widget.onSubmit(_rating, _selectedChip!, _comment);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ?? typography.hL_strong.copyWith(color: colors.onBackground, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        
        // Star Rating
        Row(
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            final isSelected = starIndex <= _rating;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _rating = starIndex;
                });
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  widget.ratingIcon,
                  size: 32,
                  color: isSelected 
                      ? (widget.activeRatingColor ?? colors.info) 
                      : (widget.inactiveRatingColor ?? colors.onSurface.withValues(alpha: 0.15)),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        
        // Improvement Section
        Text(
          widget.improvementTitle,
          style: widget.improvementTitleStyle ?? typography.bM_strong.copyWith(color: colors.onBackground),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.improvementOptions.map((option) {
            return Ux4gChoiceChip(
              text: option,
              selected: _selectedChip == option,
              borderRadius: widget.chipBorderRadius,
              onClick: () {
                setState(() {
                  _selectedChip = option;
                });
              },
              selectedBackgroundColor: colors.primary.withValues(alpha: 0.1),
              selectedBorderColor: colors.primary.withValues(alpha: 0.3),
              selectedTextColor: colors.primary,
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        
        // Comment Section
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
        const SizedBox(height: 24),
        
        // Buttons
        SizedBox(
          width: double.infinity,
          child: Ux4gButton(
            text: widget.submitButtonText,
            variant: Ux4gButtonVariant.primary,
            enabled: _isFormValid,
            onPressed: _handleSubmit,
          ),
        ),
        if (widget.onSkip != null) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: widget.onSkip,
              style: TextButton.styleFrom(
                foregroundColor: colors.onBackground,
              ),
              child: Text(
                widget.skipButtonText,
                style: typography.bM_strong.copyWith(color: colors.onBackground),
              ),
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
            color: widget.successBackgroundColor ?? colors.success.withValues(alpha: 0.12), // Light green success background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.successIcon,
                color: widget.successIconColor ?? colors.success, // Solid green success icon
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
              // Optionally reset form if no explicit close handler is provided
              setState(() {
                _rating = 0;
                _selectedChip = null;
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
