import 'package:flutter/material.dart';

class Ux4gPalette {
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray800 = Color(0xFF333333);
  static const Color gray900 = Color(0xFF121212);

  // Primary
  static const Color primary = Color(0xFF6A4EFF);
  static const Color primary50 = Color(0xFFF2EFFF);
  static const Color primary100 = Color(0xFFDCD4FF);
  static const Color primary200 = Color(0xFFC0B3FF);
  static const Color primary300 = Color(0xFFA391FF);
  static const Color primary400 = Color(0xFF8670FF);
  static const Color primary500 = Color(0xFF6A4EFF);
  static const Color primary600 = Color(0xFF4A2BC2);
  static const Color primary700 = Color(0xFF3D239F);
  static const Color primary800 = Color(0xFF301C7D);
  static const Color primary900 = Color(0xFF24145C);
  static const Color primary950 = Color(0xFF1A0E3D);

  // Secondary
  static const Color secondary = Color(0xFFFFA827);
  static const Color secondary50 = Color(0xFFFFF7E6);
  static const Color secondary100 = Color(0xFFFFE7BF);
  static const Color secondary200 = Color(0xFFFFD899);
  static const Color secondary300 = Color(0xFFFFC973);
  static const Color secondary400 = Color(0xFFFFBA4D);
  static const Color secondary500 = Color(0xFFFFA827);
  static const Color secondary600 = Color(0xFFFF8F1F);
  static const Color secondary700 = Color(0xFFD46F13);
  static const Color secondary800 = Color(0xFFAD530A);
  static const Color secondary900 = Color(0xFF873C05);
  static const Color secondary950 = Color(0xFF612800);

  // Red
  static const Color red = Color(0xFFF55E57);
  static const Color red50 = Color(0xFFFFF8F8);
  static const Color red100 = Color(0xFFFFECEE);
  static const Color red200 = Color(0xFFFFDADC);
  static const Color red300 = Color(0xFFFFB3AE);
  static const Color red400 = Color(0xFFFF8983);
  static const Color red500 = Color(0xFFF55E57);
  static const Color red600 = Color(0xFFDB372D);
  static const Color red700 = Color(0xFFB3251E);
  static const Color red800 = Color(0xFF8A1A16);
  static const Color red900 = Color(0xFF60150F);
  static const Color red950 = Color(0xFF3A0907);

  // Green
  static const Color green = Color(0xFF1AA64A);
  static const Color green50 = Color(0xFFF2FCEF);
  static const Color green100 = Color(0xFFDDF8D8);
  static const Color green200 = Color(0xFFBEEFBB);
  static const Color green300 = Color(0xFF80DA88);
  static const Color green400 = Color(0xFF44C265);
  static const Color green500 = Color(0xFF1AA64A);
  static const Color green600 = Color(0xFF128937);
  static const Color green700 = Color(0xFF006C35);
  static const Color green800 = Color(0xFF00522C);
  static const Color green900 = Color(0xFF00381F);
  static const Color green950 = Color(0xFF002110);

  // Blue (Info)
  static const Color blue50 = Color(0xFFE3F2FD);
  static const Color blue500 = Color(0xFF2196F3);
  static const Color blue700 = Color(0xFF1976D2);

  // Orange (Warning/Secondary)
  static const Color orange50 = Color(0xFFFFF3E0);
  static const Color orange500 = Color(0xFFFF9800);
  static const Color orange700 = Color(0xFFF57C00);

  // Gold
  static const Color gold50 = Color(0xFFFFFDE7);
  static const Color gold500 = Color(0xFFFFEB3B);
  static const Color gold600 = Color(0xFFFDD835);
  static const Color gold700 = Color(0xFFFBC02D);

  // Cyan
  static const Color cyan50 = Color(0xFFE0F7FA);
  static const Color cyan500 = Color(0xFF00BCD4);
  static const Color cyan600 = Color(0xFF00ACC1);

  // Purple
  static const Color purple50 = Color(0xFFF3E5F5);
  static const Color purple500 = Color(0xFF9C27B0);
  static const Color purple600 = Color(0xFF8E24AA);

  static const Color neutral1000black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
  
  static const Color neutral500 = Color(0xFF737373);
  static const Color neutral700 = Color(0xFF404040);
}

class Ux4gColors extends ThemeExtension<Ux4gColors> {
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;

  const Ux4gColors({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
  });

  @override
  ThemeExtension<Ux4gColors> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? error,
    Color? onError,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
  }) {
    return Ux4gColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  ThemeExtension<Ux4gColors> lerp(ThemeExtension<Ux4gColors>? other, double t) {
    if (other is! Ux4gColors) return this;
    return Ux4gColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      background: Color.lerp(background, other.background, t) ?? background,
      onBackground: Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      info: Color.lerp(info, other.info, t) ?? info,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
    );
  }
}

final lightUx4gColors = Ux4gColors(
  primary: Ux4gPalette.primary,
  onPrimary: Ux4gPalette.white,
  secondary: Ux4gPalette.secondary,
  onSecondary: Ux4gPalette.gray900,
  background: Ux4gPalette.gray100,
  onBackground: Ux4gPalette.gray900,
  surface: Ux4gPalette.white,
  onSurface: Ux4gPalette.gray900,
  error: Ux4gPalette.red,
  onError: Ux4gPalette.white,
  success: Ux4gPalette.green,
  onSuccess: Ux4gPalette.white,
  warning: Ux4gPalette.secondary,
  onWarning: Ux4gPalette.gray900,
  info: Ux4gPalette.blue500,
  onInfo: Ux4gPalette.white,
);

final darkUx4gColors = Ux4gColors(
  primary: Ux4gPalette.primary,
  onPrimary: Ux4gPalette.gray900,
  secondary: const Color(0xFF1157CE),
  onSecondary: Ux4gPalette.white,
  background: Ux4gPalette.gray900,
  onBackground: Ux4gPalette.white,
  surface: Ux4gPalette.gray800,
  onSurface: Ux4gPalette.white,
  error: Ux4gPalette.red400,
  onError: Ux4gPalette.gray900,
  success: Ux4gPalette.green400,
  onSuccess: Ux4gPalette.gray900,
  warning: Ux4gPalette.secondary400,
  onWarning: Ux4gPalette.gray900,
  info: Ux4gPalette.blue500,
  onInfo: Ux4gPalette.gray900,
);
