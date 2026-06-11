import 'package:flutter/material.dart';
import '../../foundation/colors.dart';

/// Colors used across the biometric verification flow.
class BiometricColors {
  final Color primary;
  final Color success;
  final Color error;
  final Color warning;
  final Color surface;
  final Color onSurface;
  final Color overlay;
  final Color ovalGuide;
  final Color ovalActive;
  final Color ovalBlink;
  final Color ovalError;
  final Color cardBackground;
  final Color instructionCardBg;
  final Color shimmer;
  final Color statusBadgeBg;
  final Color attemptWarningBg;
  final Color attemptWarningBorder;
  final Color attemptLastBg;
  final Color attemptLastBorder;

  const BiometricColors({
    this.primary = Ux4gPalette.primary500,
    this.success = Ux4gPalette.green500,
    this.error = Ux4gPalette.red500,
    this.warning = Ux4gPalette.secondary500,
    this.surface = Ux4gPalette.white,
    this.onSurface = Ux4gPalette.gray900,
    this.overlay = const Color(0xCC000000),
    this.ovalGuide = Ux4gPalette.white,
    this.ovalActive = Ux4gPalette.green500,
    this.ovalBlink = Ux4gPalette.primary500,
    this.ovalError = Ux4gPalette.red500,
    this.cardBackground = const Color(0xFFF8F8F8),
    this.instructionCardBg = Ux4gPalette.white,
    this.shimmer = const Color(0xFFE0E0E0),
    this.statusBadgeBg = Ux4gPalette.green500,
    this.attemptWarningBg = const Color(0xFFFFF8E1),
    this.attemptWarningBorder = const Color(0xFFFFE082),
    this.attemptLastBg = const Color(0xFFFFEBEE),
    this.attemptLastBorder = const Color(0xFFEF9A9A),
  });
}

/// Typography presets for biometric screens.
class BiometricTypography {
  final TextStyle headline;
  final TextStyle title;
  final TextStyle body;
  final TextStyle label;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle instruction;

  const BiometricTypography({
    this.headline = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    this.title = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    this.body = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    this.label = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    this.caption = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    this.button = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1,
    ),
    this.instruction = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.4,
    ),
  });
}

/// Theme configuration for the biometric verification flow.
class BiometricThemeData {
  final BiometricColors colors;
  final BiometricTypography typography;
  final Duration animationDuration;
  final Curve animationCurve;
  final double cardRadius;
  final double buttonRadius;
  final EdgeInsets screenPadding;

  const BiometricThemeData({
    this.colors = const BiometricColors(),
    this.typography = const BiometricTypography(),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.cardRadius = 16.0,
    this.buttonRadius = 12.0,
    this.screenPadding = const EdgeInsets.symmetric(horizontal: 24),
  });
}

/// InheritedWidget to provide [BiometricThemeData] down the tree.
class BiometricTheme extends InheritedWidget {
  final BiometricThemeData data;

  const BiometricTheme({super.key, required this.data, required super.child});

  static BiometricThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<BiometricTheme>();
    return widget?.data ?? const BiometricThemeData();
  }

  @override
  bool updateShouldNotify(BiometricTheme oldWidget) => data != oldWidget.data;
}
