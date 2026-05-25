import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../foundation/typography.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum Ux4gOtpBoxStatus {
  defaultStatus,
  focused,
  error,
  warning,
  success,
  disabled,
}

enum Ux4gOtpInputStatus {
  defaultStatus,
  error,
  warning,
  success,
  locked,
}

enum Ux4gOtpCaptionVariant {
  /// e.g. "Didn't receive OTP?  Resend in 00:17"
  resendTimer,

  /// e.g. "Didn't receive OTP?  [Resend OTP]"
  resendAction,

  /// e.g. "🔴 Attempt 2 of 3   Resend OTP in 00:17"
  attemptWithTimer,

  /// e.g. "🔒 Locked for 28:43   Resend OTP"
  locked,

  /// e.g. "✅ Verification successful"
  success,

  /// e.g. "⚠️ Warning message"
  warning,

  /// Custom plain caption
  plain,
}

// ─── Ux4gOtpBox (single digit box) ──────────────────────────────────────────

/// A single OTP digit box — used standalone or internally by [Ux4gOtpInput].
class Ux4gOtpBox extends StatelessWidget {
  final String value;
  final Ux4gOtpBoxStatus status;

  /// Width of the box. Defaults to 48 (medium).
  final double size;

  /// Whether to obscure the character (password mode).
  final bool obscure;

  const Ux4gOtpBox({
    super.key,
    this.value = '',
    this.status = Ux4gOtpBoxStatus.defaultStatus,
    this.size = 48,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    final hsStrong = ux4gTypography?.hS_strong ?? materialTheme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 20);
    final bmDefault = ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle(fontSize: 16);

    final borderColor = _borderColor(materialTheme, ux4gColors);
    final bgColor = _bgColor(materialTheme, ux4gColors);
    final borderWidth = status == Ux4gOtpBoxStatus.focused
        ? Ux4gBorderWidth.thick
        : Ux4gBorderWidth.thin;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Ux4gRadius.radius8),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      alignment: Alignment.center,
      child: value.isNotEmpty
          ? Text(
              obscure ? '•' : value,
              style: hsStrong.copyWith(
                color: status == Ux4gOtpBoxStatus.disabled
                    ? onSurface.withValues(alpha: 0.35)
                    : onSurface,
              ),
            )
          : status == Ux4gOtpBoxStatus.focused
              ? _Cursor(color: primary)
              : Text(
                  '—',
                  style: bmDefault.copyWith(
                    color: onSurface.withValues(alpha: 0.3),
                  ),
                ),
    );
  }

  Color _borderColor(ThemeData materialTheme, Ux4gColors? ux4gColors) {
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final warning = ux4gColors?.warning ?? Colors.orange;
    final success = ux4gColors?.success ?? Colors.green;

    return switch (status) {
      Ux4gOtpBoxStatus.focused => primary,
      Ux4gOtpBoxStatus.error => error,
      Ux4gOtpBoxStatus.warning => warning,
      Ux4gOtpBoxStatus.success => success,
      Ux4gOtpBoxStatus.disabled => onSurface.withValues(alpha: 0.2),
      Ux4gOtpBoxStatus.defaultStatus => onSurface.withValues(alpha: 0.25),
    };
  }

  Color _bgColor(ThemeData materialTheme, Ux4gColors? ux4gColors) {
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;

    if (status == Ux4gOtpBoxStatus.disabled) {
      return onSurface.withValues(alpha: 0.05);
    }
    return surface;
  }
}

// Blinking cursor widget
class _Cursor extends StatefulWidget {
  final Color color;
  const _Cursor({required this.color});

  @override
  State<_Cursor> createState() => _CursorState();
}

class _CursorState extends State<_Cursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(width: 1.5, height: 20, color: widget.color),
    );
  }
}

// ─── Ux4gOtpCaption ──────────────────────────────────────────────────────────

/// Caption section that renders below the OTP field.
/// Wraps all message variants (timer, resend, attempt, locked, success, warning).
class Ux4gOtpCaption extends StatelessWidget {
  final Ux4gOtpCaptionVariant variant;

  /// Plain text caption (for [Ux4gOtpCaptionVariant.plain]).
  final String? caption;

  /// Leading label, e.g. "Didn't receive OTP?" or "Attempt 2 of 3".
  final String? leadingText;

  /// Trailing label, e.g. "Resend in 00:17" or "Resend OTP".
  final String? trailingText;

  /// When [trailingText] is tappable (e.g. "Resend OTP" link).
  final VoidCallback? onTrailingTap;

  /// Whether trailing text is a highlighted action (bold + primary color).
  final bool trailingIsAction;

  const Ux4gOtpCaption({
    super.key,
    required this.variant,
    this.caption,
    this.leadingText,
    this.trailingText,
    this.onTrailingTap,
    this.trailingIsAction = false,
  });

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final success = ux4gColors?.success ?? Colors.green;
    final warning = ux4gColors?.warning ?? Colors.orange;

    final bxsDefault = ux4gTypography?.bXS_default ?? materialTheme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    final bxsStrong = ux4gTypography?.bXS_strong ?? materialTheme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 12);

    switch (variant) {
      // "Didn't receive OTP?  Resend in 00:17"
      case Ux4gOtpCaptionVariant.resendTimer:
        return _inline(
          leading: _text(
            leadingText ?? "Didn't receive OTP?",
            bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6)),
          ),
          trailing: _text(
            trailingText ?? '',
            bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6)),
          ),
        );

      // "Didn't receive OTP?  [Resend OTP]" (action link)
      case Ux4gOtpCaptionVariant.resendAction:
        return _inline(
          leading: _text(
            leadingText ?? "Didn't receive OTP?",
            bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6)),
          ),
          trailing: GestureDetector(
            onTap: onTrailingTap,
            child: _text(
              trailingText ?? 'Resend OTP',
              bxsStrong.copyWith(color: primary),
            ),
          ),
        );

      // "🔴 Attempt 2 of 3   Resend OTP in 00:17"
      case Ux4gOtpCaptionVariant.attemptWithTimer:
        return _spaceBetween(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, size: 14, color: error),
              const SizedBox(width: 4),
              _text(
                leadingText ?? '',
                bxsStrong.copyWith(color: error),
              ),
            ],
          ),
          trailing: _text(
            trailingText ?? '',
            bxsDefault.copyWith(
                color: onSurface.withValues(alpha: 0.6)),
          ),
        );

      // "🔒 Locked for 28:43   Resend OTP"
      case Ux4gOtpCaptionVariant.locked:
        return _spaceBetween(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_outline, size: 14,
                  color: onSurface.withValues(alpha: 0.6)),
              const SizedBox(width: 4),
              _text(
                leadingText ?? '',
                bxsDefault.copyWith(
                    color: onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
          trailing: GestureDetector(
            onTap: onTrailingTap,
            child: _text(
              trailingText ?? 'Resend OTP',
              bxsDefault.copyWith(
                  color: onSurface.withValues(alpha: 0.6)),
            ),
          ),
        );

      // "✅ Verification successful"
      case Ux4gOtpCaptionVariant.success:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 14, color: success),
            const SizedBox(width: 6),
            _text(
              caption ?? 'Verification successful',
              bxsStrong.copyWith(color: success),
            ),
          ],
        );

      // "⚠️ Warning message"
      case Ux4gOtpCaptionVariant.warning:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 14, color: warning),
            const SizedBox(width: 6),
            _text(
              caption ?? 'Warning message',
              bxsDefault.copyWith(color: warning),
            ),
          ],
        );

      // plain text
      case Ux4gOtpCaptionVariant.plain:
        return _text(
          caption ?? '',
          bxsDefault.copyWith(
              color: onSurface.withValues(alpha: 0.6)),
        );
    }
  }

  // Inline: leading text immediately followed by trailing (both left-aligned)
  Widget _inline({required Widget leading, required Widget trailing}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        leading,
        trailing,
      ],
    );
  }

  // Space-between: leading on left, trailing on right edge
  Widget _spaceBetween({required Widget leading, required Widget trailing}) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 4,
        children: [
          leading,
          trailing,
        ],
      ),
    );
  }

  Widget _text(String t, TextStyle s) => Text(t, style: s);
}

// ─── Ux4gOtpInput (complete component) ──────────────────────────────────────

class Ux4gOtpInput extends StatefulWidget {
  /// Number of OTP digits.
  final int length;

  /// Current OTP value (controlled). Pass empty string to clear.
  final String value;

  /// Called on every character change with the full current OTP string.
  final ValueChanged<String> onChanged;

  /// Called when all digits are filled.
  final ValueChanged<String>? onCompleted;

  /// Label shown above the boxes.
  final String? label;

  /// Whether label has required asterisk.
  final bool required;

  /// Trailing icon next to the label (e.g. info icon).
  final IconData? labelTrailingIcon;

  /// Overall status — drives box border colours and caption icon.
  final Ux4gOtpInputStatus status;

  /// Obscure digits (password-style).
  final bool obscure;

  /// Size of each box in logical pixels.
  final double boxSize;

  /// Gap between boxes.
  final double gap;

  /// Show a '–' dash separator between boxes (matches the design spec).
  final bool showSeparator;

  /// Keyboard type — defaults to [TextInputType.number].
  final TextInputType keyboardType;

  // ── Caption props (forwarded to [Ux4gOtpCaption]) ───────────────────────

  final Ux4gOtpCaptionVariant? captionVariant;
  final String? captionLeadingText;
  final String? captionTrailingText;
  final VoidCallback? onCaptionTrailingTap;
  final String? captionText;

  // ── Auto-countdown (for timer captions) ─────────────────────────────────

  /// When set, the component auto-counts down this many seconds and updates
  /// [captionTrailingText] with the formatted "mm:ss" timer.
  /// When the timer expires the caption variant switches to resendAction.
  final int? autoCountdownSeconds;

  /// Called when the countdown reaches zero.
  final VoidCallback? onCountdownComplete;

  final bool enabled;

  const Ux4gOtpInput({
    super.key,
    this.length = 6,
    required this.value,
    required this.onChanged,
    this.onCompleted,
    this.label,
    this.required = false,
    this.labelTrailingIcon,
    this.status = Ux4gOtpInputStatus.defaultStatus,
    this.obscure = false,
    this.boxSize = 48,
    this.gap = 8,
    this.showSeparator = true,
    this.keyboardType = TextInputType.number,
    this.captionVariant,
    this.captionLeadingText,
    this.captionTrailingText,
    this.onCaptionTrailingTap,
    this.captionText,
    this.autoCountdownSeconds,
    this.onCountdownComplete,
    this.enabled = true,
  });

  @override
  State<Ux4gOtpInput> createState() => _Ux4gOtpInputState();
}

class _Ux4gOtpInputState extends State<Ux4gOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int _focusedIndex = -1;

  // Countdown
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _countdownExpired = false;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initCountdown();
  }

  void _initControllers() {
    final chars = _splitValue(widget.value);
    _controllers = List.generate(
      widget.length,
      (i) => TextEditingController(text: chars.length > i ? chars[i] : ''),
    );
    _focusNodes = List.generate(widget.length, (i) {
      final fn = FocusNode();
      fn.addListener(() {
        if (mounted) setState(() => _focusedIndex = fn.hasFocus ? i : -1);
      });
      return fn;
    });
  }

  void _initCountdown() {
    if (widget.autoCountdownSeconds != null &&
        widget.autoCountdownSeconds! > 0) {
      _remainingSeconds = widget.autoCountdownSeconds!;
      _countdownExpired = false;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _countdownExpired = true;
          t.cancel();
          widget.onCountdownComplete?.call();
        }
      });
    });
  }

  @override
  void didUpdateWidget(Ux4gOtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync external value
    final chars = _splitValue(widget.value);
    for (int i = 0; i < widget.length; i++) {
      final c = chars.length > i ? chars[i] : '';
      if (_controllers[i].text != c) {
        _controllers[i].text = c;
      }
    }
    // Re-init countdown if changed
    if (widget.autoCountdownSeconds != oldWidget.autoCountdownSeconds) {
      _timer?.cancel();
      _initCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  List<String> _splitValue(String v) => v.characters.toList();

  String get _currentValue =>
      _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String val) {
    // Allow only single character
    final sanitized =
        val.isEmpty ? '' : val.characters.last;

    _controllers[index].text = sanitized;
    _controllers[index].selection =
        TextSelection.fromPosition(
            TextPosition(offset: sanitized.length));

    final full = _currentValue;
    widget.onChanged(full);

    if (sanitized.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (sanitized.isNotEmpty && index == widget.length - 1) {
      _focusNodes[index].unfocus();
      if (full.length == widget.length) {
        widget.onCompleted?.call(full);
      }
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      _controllers[index - 1].clear();
      final full = _currentValue;
      widget.onChanged(full);
    }
  }

  // Paste support: fill boxes from clipboard
  void _handlePaste(String pasted) {
    final digits = pasted.replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < widget.length; i++) {
      _controllers[i].text = i < digits.length ? digits[i] : '';
    }
    final full = _currentValue;
    widget.onChanged(full);
    if (full.length == widget.length) {
      _focusNodes[widget.length - 1].unfocus();
      widget.onCompleted?.call(full);
    } else {
      final nextEmpty = _controllers.indexWhere((c) => c.text.isEmpty);
      if (nextEmpty != -1) {
        FocusScope.of(context).requestFocus(_focusNodes[nextEmpty]);
      }
    }
  }

  Ux4gOtpBoxStatus _boxStatus(int index) {
    if (!widget.enabled) return Ux4gOtpBoxStatus.disabled;
    if (_focusedIndex == index) return Ux4gOtpBoxStatus.focused;
    return switch (widget.status) {
      Ux4gOtpInputStatus.error => Ux4gOtpBoxStatus.error,
      Ux4gOtpInputStatus.warning => Ux4gOtpBoxStatus.warning,
      Ux4gOtpInputStatus.success => Ux4gOtpBoxStatus.success,
      Ux4gOtpInputStatus.locked => Ux4gOtpBoxStatus.disabled,
      Ux4gOtpInputStatus.defaultStatus => Ux4gOtpBoxStatus.defaultStatus,
    };
  }

  String _formattedRemaining() {
    final m = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;

    final bsStrong = ux4gTypography?.bS_strong ?? materialTheme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 14);
    final bmDefault = ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle(fontSize: 16);

    // Resolve effective caption variant
    Ux4gOtpCaptionVariant? effectiveVariant = widget.captionVariant;
    String? effectiveTrailing = widget.captionTrailingText;

    if (widget.autoCountdownSeconds != null) {
      if (_countdownExpired) {
        effectiveVariant = Ux4gOtpCaptionVariant.resendAction;
        effectiveTrailing = widget.captionTrailingText ?? 'Resend OTP';
      } else {
        // keep variant (timer or attemptWithTimer) and inject formatted time
        effectiveTrailing =
            '${widget.captionTrailingText ?? 'Resend in'} ${_formattedRemaining()}';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Label ────────────────────────────────────────────────────────
        if (widget.label != null) ...[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            runSpacing: 2,
            children: [
              Text(
                widget.label!,
                style: bsStrong.copyWith(
                  color: widget.enabled
                      ? onSurface
                      : onSurface.withValues(alpha: 0.4),
                ),
              ),
              if (widget.required)
                Text('*',
                    style: bsStrong
                        .copyWith(color: error)),
              if (widget.labelTrailingIcon != null)
                Icon(widget.labelTrailingIcon,
                    size: 16,
                    color: onSurface.withValues(alpha: 0.5)),
            ],
          ),
          const SizedBox(height: 10),
        ],

        // ── OTP Boxes ─────────────────────────────────────────────────────
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.length, (i) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (i > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.gap / 2),
                      child: widget.showSeparator
                          ? Text(
                              '–',
                              style: bmDefault.copyWith(
                                color: onSurface.withValues(alpha: 0.35),
                              ),
                            )
                          : SizedBox(width: widget.gap / 2),
                    ),
                  KeyboardListener(
                    focusNode: FocusNode(skipTraversal: true),
                    onKeyEvent: (e) => _onKeyEvent(i, e),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.enabled &&
                            widget.status != Ux4gOtpInputStatus.locked) {
                          FocusScope.of(context).requestFocus(_focusNodes[i]);
                        }
                      },
                      child: SizedBox(
                        width: widget.boxSize,
                        height: widget.boxSize,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Ux4gOtpBox(
                                value: _controllers[i].text,
                                status: _boxStatus(i),
                                size: widget.boxSize,
                                obscure: widget.obscure,
                              ),
                            ),
                            if (widget.enabled &&
                                widget.status != Ux4gOtpInputStatus.locked)
                              Positioned.fill(
                                child: Opacity(
                                  opacity: 0,
                                  child: TextField(
                                    controller: _controllers[i],
                                    focusNode: _focusNodes[i],
                                    keyboardType: widget.keyboardType,
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [
                                      widget.keyboardType == TextInputType.number
                                          ? FilteringTextInputFormatter.digitsOnly
                                          : FilteringTextInputFormatter.allow(RegExp(r'.')),
                                    ],
                                    onChanged: (v) {
                                      if (v.length > 1) {
                                        _handlePaste(v);
                                      } else {
                                        _onDigitChanged(i, v);
                                      }
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),

        // ── Caption ───────────────────────────────────────────────────────
        if (effectiveVariant != null) ...[
          const SizedBox(height: 8),
          Ux4gOtpCaption(
            variant: effectiveVariant,
            caption: widget.captionText,
            leadingText: widget.captionLeadingText,
            trailingText: effectiveTrailing,
            onTrailingTap: widget.onCaptionTrailingTap,
          ),
        ],
      ],
    );
  }
}
