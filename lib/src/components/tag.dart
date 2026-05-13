import 'package:flutter/material.dart';
import '../foundation/colors.dart';
import '../foundation/dimensions.dart';
import '../theme/theme.dart';

enum Ux4gTagSize { m, l }

enum Ux4gTagShape { circular, rectangular }

enum Ux4gTagStyle { tonal, filled, outline, text }

enum Ux4gTagColor { neutral, brand, success, warning, error, info }

class Ux4gTag extends StatelessWidget {
  final String text;
  final Ux4gTagSize size;
  final Ux4gTagShape shape;
  final Ux4gTagStyle style;
  final Ux4gTagColor colorScheme;
  final Widget? leadingContent;
  final VoidCallback? onDismiss;
  final Color? customBackgroundColor;
  final Color? customContentColor;
  final Color? customBorderColor;
  final BorderRadius? customBorderRadius;

  const Ux4gTag({
    super.key,
    required this.text,
    this.size = Ux4gTagSize.m,
    this.shape = Ux4gTagShape.circular,
    this.style = Ux4gTagStyle.tonal,
    this.colorScheme = Ux4gTagColor.neutral,
    this.leadingContent,
    this.onDismiss,
    this.customBackgroundColor,
    this.customContentColor,
    this.customBorderColor,
    this.customBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final defaultColors = _getTagColors(context, colors);
    final bgColor = customBackgroundColor ?? defaultColors.backgroundColor;
    final contentColor = customContentColor ?? defaultColors.contentColor;
    final borderColor = customBorderColor ?? defaultColors.borderColor;

    final height = size == Ux4gTagSize.m ? 20.0 : 24.0;
    final horizontalPadding = size == Ux4gTagSize.m ? 8.0 : 12.0;
    final textStyle = size == Ux4gTagSize.m
        ? typography.lS_default
        : typography.lM_default;

    final borderRadius =
        customBorderRadius ??
        (shape == Ux4gTagShape.circular
            ? BorderRadius.circular(999)
            : BorderRadius.circular(Ux4gRadius.radius4));

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: style == Ux4gTagStyle.outline
            ? Border.all(color: borderColor)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingContent != null) ...[
            leadingContent!,
            const SizedBox(width: 6),
          ],
          Text(text, style: textStyle.copyWith(color: contentColor, height: 1)),
          if (onDismiss != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                size: size == Ux4gTagSize.m ? 12 : 14,
                color: contentColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  _TagColors _getTagColors(BuildContext context, Ux4gColors colors) {
    final (baseLight, baseNormal, baseDark) = switch (colorScheme) {
      Ux4gTagColor.neutral => (
        colors.onSurface.withValues(alpha: 0.1),
        colors.onSurface.withValues(alpha: 0.5),
        colors.onSurface.withValues(alpha: 0.8),
      ),
      Ux4gTagColor.brand => (
        Ux4gPalette.primary50,
        colors.primary,
        Ux4gPalette.primary700,
      ),
      Ux4gTagColor.success => (
        Ux4gPalette.green50,
        Ux4gPalette.green500,
        Ux4gPalette.green700,
      ),
      Ux4gTagColor.warning => (
        Ux4gPalette.orange50,
        Ux4gPalette.orange500,
        Ux4gPalette.orange700,
      ),
      Ux4gTagColor.error => (
        Ux4gPalette.red50,
        colors.error,
        Ux4gPalette.red700,
      ),
      Ux4gTagColor.info => (
        Ux4gPalette.blue50,
        Ux4gPalette.blue500,
        Ux4gPalette.blue700,
      ),
    };

    return switch (style) {
      Ux4gTagStyle.tonal => _TagColors(
        backgroundColor: baseLight,
        contentColor: baseDark,
        borderColor: Colors.transparent,
      ),
      Ux4gTagStyle.filled => _TagColors(
        backgroundColor: baseNormal,
        contentColor:
            (colorScheme == Ux4gTagColor.brand ||
                colorScheme == Ux4gTagColor.error)
            ? Colors.white
            : colors.surface,
        borderColor: Colors.transparent,
      ),
      Ux4gTagStyle.outline => _TagColors(
        backgroundColor: Colors.transparent,
        contentColor: baseNormal,
        borderColor: baseNormal,
      ),
      Ux4gTagStyle.text => _TagColors(
        backgroundColor: Colors.transparent,
        contentColor: baseNormal,
        borderColor: Colors.transparent,
      ),
    };
  }
}

class _TagColors {
  final Color backgroundColor;
  final Color contentColor;
  final Color borderColor;

  const _TagColors({
    required this.backgroundColor,
    required this.contentColor,
    required this.borderColor,
  });
}

// ─── Unified Pill Segment ───────────────────────────────────────────────────

/// A single segment inside a [Ux4gUnifiedPillTag].
class Ux4gPillSegment {
  /// Text displayed in this segment.
  final String text;

  /// Optional widget shown before the text (e.g., a dot indicator).
  final Widget? leading;

  /// Text color override for this segment.
  final Color? textColor;

  /// Text style override: `true` for bold, `false` (default) for regular.
  final bool bold;

  const Ux4gPillSegment({
    required this.text,
    this.leading,
    this.textColor,
    this.bold = false,
  });
}

// ─── Unified Pill Tag ───────────────────────────────────────────────────────

/// A pill-shaped tag that renders multiple [Ux4gPillSegment]s separated by a
/// thin vertical divider — all inside one unified container.
///
/// Example:
/// ```dart
/// Ux4gUnifiedPillTag(
///   segments: [
///     Ux4gPillSegment(
///       text: '2 days remaining',
///       leading: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
///     ),
///     Ux4gPillSegment(text: 'Pending', bold: true, textColor: Colors.orange),
///   ],
/// )
/// ```
class Ux4gUnifiedPillTag extends StatelessWidget {
  /// Segments to render inside the pill.
  final List<Ux4gPillSegment> segments;

  /// Size of the pill.
  final Ux4gTagSize size;

  /// Background color (defaults to white).
  final Color? backgroundColor;

  /// Border color (defaults to subtle onSurface).
  final Color? borderColor;

  /// Divider color between segments.
  final Color? dividerColor;

  /// Custom border radius override.
  final BorderRadius? customBorderRadius;

  const Ux4gUnifiedPillTag({
    super.key,
    required this.segments,
    this.size = Ux4gTagSize.l,
    this.backgroundColor,
    this.borderColor,
    this.dividerColor,
    this.customBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    final height = size == Ux4gTagSize.m ? 20.0 : 24.0;
    final horizontalPadding = size == Ux4gTagSize.m ? 8.0 : 12.0;
    final textStyleDefault = size == Ux4gTagSize.m
        ? typography.lS_default
        : typography.lM_default;
    final textStyleBold = size == Ux4gTagSize.m
        ? typography.lS_strong
        : typography.lM_strong;

    final bgColor = backgroundColor ?? Colors.white;
    final border = borderColor ?? colors.onSurface.withValues(alpha: 0.12);
    final divider = dividerColor ?? colors.onSurface.withValues(alpha: 0.15);
    final defaultTextColor = colors.onSurface.withValues(alpha: 0.7);

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: customBorderRadius ?? BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < segments.length; i++) ...[
            if (i > 0) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 1,
                height: 14,
                color: divider,
              ),
            ],
            if (segments[i].leading != null) ...[
              segments[i].leading!,
              const SizedBox(width: 6),
            ],
            Text(
              segments[i].text,
              style: (segments[i].bold ? textStyleBold : textStyleDefault)
                  .copyWith(
                    color: segments[i].textColor ?? defaultTextColor,
                    height: 1,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
