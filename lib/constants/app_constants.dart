import 'package:flutter/material.dart';

// App-wide constants for colors, text styles, and configuration

class AppConstants {
  // Supabase Configuration
  // TODO: Replace these with your actual Supabase project credentials
  static const String supabaseUrl = 'https://daynvvnerzmidifqyxcy.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_AkmO3_kl5bgb815W3JGxcA_GR8dHSNC';

  // App Colors
  static const Color primaryColor = Color(0xFF2196F3); // Blue
  static const Color secondaryColor = Color(0xFF03DAC6); // Teal
  static const Color backgroundColor = Color(0xFF121212); // Dark background
  static const Color surfaceColor = Color(0xFF1E1E1E); // Card background
  static const Color errorColor = Color(0xFFCF6679); // Error red
  static const Color successColor = Color(0xFF4CAF50); // Success green

  // Text Colors
  static const Color textPrimaryColor = Colors.white;
  static const Color textSecondaryColor = Colors.white70;

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textSecondaryColor,
  );

  static const TextStyle labelStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  // Spacing
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;

  // Border Radius
  static const double borderRadius = 12.0;

  // App Strings
  static const String appName = 'Smart Utility Hub';
  static const String loginTitle = 'Welcome Back';
  static const String registerTitle = 'Create Account';
  static const String profileTitle = 'My Profile';
  static const String converterTitle = 'Temperature Converter';
  static const String galleryTitle = 'Image Gallery';
}
