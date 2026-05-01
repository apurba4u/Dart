import 'package:flutter/material.dart';

class AppConstants {
  // Strings
  static const String appName = 'Auth App';
  static const String loginTitle = 'Login';
  static const String registerTitle = 'Register';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String nameHint = 'Name';
  static const String photoUrlHint = 'Photo URL';
  static const String loginButton = 'Login';
  static const String registerButton = 'Register';
  static const String noAccountText = 'Don\'t have an account? Register';
  static const String hasAccountText = 'Already have an account? Login';
  static const String logoutButton = 'Logout';
  static const String footerText = 'Designed by Apurba Ovi (Ultimate Coder)';

  // Colors
  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color primaryGradientStart = Color(0xFF3B82F6); // Blue
  static const Color primaryGradientEnd = Color(0xFF8B5CF6); // Purple
  static const Color glassBackground = Color(0x1AFFFFFF); // Opacity 0.1
  static const Color glassBorder = Color(0x33FFFFFF); // Opacity 0.2
  static const Color textColor = Colors.white;
  static const Color hintColor = Colors.white54;

  // UI Metrics
  static const double cardBorderRadius = 24.0;
  static const double buttonBorderRadius = 30.0;
  static const double inputBorderRadius = 16.0;
  static const double defaultPadding = 24.0;
}
