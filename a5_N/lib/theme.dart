import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.deepBlue,
    scaffoldBackgroundColor: AppColors.deepBlue,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.deepBlue,
      secondary: AppColors.red,
      tertiary: AppColors.accentGold,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );

  static BoxDecoration glassDecoration = BoxDecoration(
    color: AppColors.glassWhite,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.2)),
  );

  static BoxDecoration gradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.deepBlue, AppColors.red],
    ),
  );
}
