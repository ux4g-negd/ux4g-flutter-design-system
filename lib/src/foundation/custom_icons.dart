/// Custom Icons Helper
///
/// This file provides utilities for using custom icons from the assets/icons folder.
///
/// ## Usage
///
/// ### SVG Icons
/// ```dart
/// import 'package:flutter_svg/flutter_svg.dart';
///
/// SvgPicture.asset(
///   'assets/icons/your_icon.svg',
///   width: 24,
///   height: 24,
///   colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
/// )
/// ```
///
/// ### PNG Icons
/// ```dart
/// Image.asset(
///   'assets/icons/your_icon.png',
///   width: 24,
///   height: 24,
/// )
/// ```
///
/// ### Adding to Ux4gIcons
/// To make your custom icons available as constants in the design system,
/// add them to `lib/src/foundation/icons.dart`:
///
/// ```dart
/// class Ux4gIcons {
///   // Material Icons
///   static const IconData arrowBack = Icons.arrow_back;
///
///   // Custom SVG icons (use Image.asset or SvgPicture.asset)
///   static const String customIconPath = 'assets/icons/custom.svg';
/// }
/// ```
///
/// Then use in your components:
/// ```dart
/// SvgPicture.asset(Ux4gIcons.customIconPath)
/// ```
library;

class Ux4gCustomIcons {
  /// Path to custom SVG icons
  static const String iconsPath = 'assets/icons/';
}
