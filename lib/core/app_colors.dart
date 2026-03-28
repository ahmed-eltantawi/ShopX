import 'package:flutter/material.dart';
import 'theme_provider.dart';

class AppColors {
  final Color background;
  final Color cardBackground;
  final Color inputBackground;
  final Color overlayBackground;

  final Color primaryText;
  final Color secondaryText;
  final Color hintText;
  final Color labelText;

  final Color buttonDark;
  final Color buttonText;
  final Color accentGold;

  final Color divider;
  final Color inputBorder;

  final Color success;
  final Color error;

  final Color navBackground;
  final Color navIconActive;
  final Color navIconInactive;
  final Color navFab;

  const AppColors({
    required this.background,
    required this.cardBackground,
    required this.inputBackground,
    required this.overlayBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.hintText,
    required this.labelText,
    required this.buttonDark,
    required this.buttonText,
    required this.accentGold,
    required this.divider,
    required this.inputBorder,
    required this.success,
    required this.error,
    required this.navBackground,
    required this.navIconActive,
    required this.navIconInactive,
    required this.navFab,
  });

  static AppColors of(BuildContext context) {
    final mode = ThemeProvider.getTheme(context);
    return mode == ThemeMode.dark ? dark : light;
  }

  // Pure Monochromatic Stark Contrast Light Theme
  static const appLight = AppColors(
    background: Color(0xFFFFFFFF),
    cardBackground: Color(0xFFF8F8F8),
    inputBackground: Color(0xFFF3F3F3),
    overlayBackground: Color(0xFFE0E0E0),
    primaryText: Color(0xFF000000),
    secondaryText: Color(0xFF666666),
    hintText: Color(0xFF999999),
    labelText: Color(0xFF333333),
    buttonDark: Color(0xFF000000),
    buttonText: Color(0xFFFFFFFF),
    accentGold: Color(0xFF000000), // Stark black as the accent
    divider: Color(0xFFEEEEEE),
    inputBorder: Color(0xFFDDDDDD),
    success: Color(0xFF000000), // Keeping strictly monochromatic
    error: Color(0xFFCF6679), // Keep error red for visibility
    navBackground: Color(0xFFFFFFFF),
    navIconActive: Color(0xFF000000),
    navIconInactive: Color(0xFF999999),
    navFab: Color(0xFF000000),
  );

  // Light alias
  static const light = appLight;

  // Dark Luxury (Gold + Black)
  static const appDark = AppColors(
    background: Color(0xFF0A0A0B),
    cardBackground: Color(0xFF141415),
    inputBackground: Color(0xFF1E1E1F),
    overlayBackground: Color(0xFF2C2C2E),
    primaryText: Color(0xFFFFFFFF),
    secondaryText: Color(0xFFCCCCCC),
    hintText: Color(0xFF6D6D72),
    labelText: Color(0xFF8E8E93),
    buttonDark: Color(0xFFD4AF37), // Gold Button
    buttonText: Color(0xFF0A0A0B), // Black Text on Gold Button
    accentGold: Color(0xFFD4AF37), // Gold Theme Accent
    divider: Color(0xFF2C2C2E),
    inputBorder: Color(0xFF3A3A3C),
    success: Color(0xFFD4AF37),
    error: Color(0xFFCF6679),
    navBackground: Color(0xFF141415),
    navIconActive: Color(0xFFD4AF37), // Gold active
    navIconInactive: Color(0xFF6D6D72),
    navFab: Color(0xFFD4AF37),
  );

  // Dark alias
  static const dark = appDark;
}
