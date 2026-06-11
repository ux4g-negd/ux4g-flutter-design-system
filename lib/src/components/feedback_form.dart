import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import 'buttons.dart';
import 'chips.dart';
import 'text_area.dart';

class Ux4gFeedbackForm extends StatefulWidget {
  final List<String> improvementOptions;
  final int minWords;
  final int maxLength;
  final void Function(int rating, List<String> selectedChips, String comment)
  onSubmit;
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
  final Color? lowRatingColor;
  final Color? highRatingColor;
  final Color? inactiveRatingColor;
  final Color? successIconColor;
  final Color? successBackgroundColor;

  /// Number of stars at or below which [lowRatingColor] is used.
  /// Default is 2 (1-2 stars = lowRatingColor, 3-5 stars = highRatingColor).
  final int lowRatingThreshold;

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
    this.successMessage =
        'Thank you for your feedback. This helps improve government services.',
    this.titleStyle,
    this.improvementTitleStyle,
    this.successTitleStyle,
    this.successMessageStyle,
    this.ratingIcon = Icons.star,
    this.successIcon = Icons.thumb_up,
    this.activeRatingColor,
    this.lowRatingColor = Ux4gPalette.red600,
    this.highRatingColor = Ux4gPalette.yellow600,
    this.lowRatingThreshold = 2,
    this.inactiveRatingColor,
    this.successIconColor,
    this.successBackgroundColor,
  });

  @override
  State<Ux4gFeedbackForm> createState() => _Ux4gFeedbackFormState();
}

class _Ux4gFeedbackFormState extends State<Ux4gFeedbackForm> {
  int _rating = 0;
  final Set<String> _selectedChips = {};
  String _comment = '';
  bool _isSubmitted = false;

  int _getWordCount(String text) {
    if (text.trim().isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  bool get _isFormValid {
    if (_rating == 0) return false;
    if (_selectedChips.isEmpty) return false;
    if (_comment.trim().isEmpty) return false;
    if (widget.minWords > 0 && _getWordCount(_comment) < widget.minWords)
      return false;
    return true;
  }

  void _handleSubmit() {
    if (_isFormValid) {
      widget.onSubmit(_rating, _selectedChips.toList(), _comment);
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
    final info = ux4gColors?.info ?? materialTheme.colorScheme.primary;
    final onSurface =
        ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final onBackground =
        ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;

    final hlStrong =
        ux4gTypography?.hL_strong ??
        materialTheme.textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 28);
    final bmStrong =
        ux4gTypography?.bM_strong ??
        materialTheme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ) ??
        const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style:
              widget.titleStyle ??
              hlStrong.copyWith(
                color: onBackground,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 16),

        // Star Rating
        Row(
          children: List.generate(5, (index) {
            final starIndex = index + 1;
            final isSelected = starIndex <= _rating;

            // Determine active color based on rating level
            Color activeColor;
            final isDark = materialTheme.brightness == Brightness.dark;
            if (widget.activeRatingColor != null) {
              activeColor = widget.activeRatingColor!;
            } else if (_rating <= widget.lowRatingThreshold) {
              activeColor = (widget.lowRatingColor == Ux4gPalette.red600 && isDark)
                  ? (ux4gColors?.error ?? Ux4gPalette.red300)
                  : (widget.lowRatingColor ?? info);
            } else {
              activeColor = (widget.highRatingColor == Ux4gPalette.yellow600 && isDark)
                  ? Ux4gPalette.yellow500
                  : (widget.highRatingColor ?? info);
            }

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
                      ? activeColor
                      : (widget.inactiveRatingColor ??
                            onSurface.withValues(alpha: 0.15)),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),

        // Improvement Section
        Text(
          widget.improvementTitle,
          style:
              widget.improvementTitleStyle ??
              bmStrong.copyWith(color: onBackground),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.improvementOptions.map((option) {
            return Ux4gChoiceChip(
              text: option,
              selected: _selectedChips.contains(option),
              borderRadius: widget.chipBorderRadius,
              onClick: () {
                setState(() {
                  if (_selectedChips.contains(option)) {
                    _selectedChips.remove(option);
                  } else {
                    _selectedChips.add(option);
                  }
                });
              },
              selectedBackgroundColor: primary.withValues(alpha: 0.1),
              selectedBorderColor: primary.withValues(alpha: 0.3),
              selectedTextColor: primary,
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
              style: TextButton.styleFrom(foregroundColor: onBackground),
              child: Text(
                widget.skipButtonText,
                style: bmStrong.copyWith(color: onBackground),
              ),
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
                _rating = 0;
                _selectedChips.clear();
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
