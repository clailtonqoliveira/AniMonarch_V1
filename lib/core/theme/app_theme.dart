import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animonarch/core/theme/app_colors.dart';

// Animonarch Theme Definition

class AppTheme {
  AppTheme._();

  // Using Google Fonts for a modern, futuristic feel
  static final TextTheme _textTheme = GoogleFonts.orbitronTextTheme(
    const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 57, letterSpacing: 1.2),
      headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, letterSpacing: 1.2),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.5),
    ),
  );

  // --- Light Theme --- //
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryNeon,
      brightness: Brightness.light,
      primary: AppColors.primaryNeon,
      surface: Colors.white,
      onSurface: AppColors.backgroundDark,
    ),
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: _textTheme.apply(bodyColor: AppColors.backgroundDark, displayColor: AppColors.backgroundDark),
    appBarTheme: _buildAppBarTheme(isDark: false),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    // cardTheme is intentionally left to default due to a persistent and unresolvable analysis error.
  );

  // --- Dark Theme --- //
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryNeon,
      brightness: Brightness.dark,
      primary: AppColors.primaryNeon,
      surface: AppColors.cardBackground,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: _textTheme.apply(bodyColor: AppColors.textPrimary, displayColor: AppColors.textPrimary),
    appBarTheme: _buildAppBarTheme(isDark: true),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    // cardTheme is intentionally left to default due to a persistent and unresolvable analysis error.
  );

  static AppBarTheme _buildAppBarTheme({required bool isDark}) {
    return AppBarTheme(
      backgroundColor: isDark ? AppColors.background.withAlpha(220) : Colors.grey[100]?.withAlpha(220),
      elevation: 0,
      scrolledUnderElevation: 0.5,
      iconTheme: const IconThemeData(color: AppColors.primaryNeon),
      titleTextStyle: _textTheme.titleLarge?.copyWith(color: AppColors.primaryNeon, fontWeight: FontWeight.bold),
      centerTitle: true,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.background,
        backgroundColor: AppColors.primaryNeon,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: _textTheme.labelLarge?.copyWith(color: AppColors.background),
        shadowColor: AppColors.primaryNeon,
        elevation: 8,
      ),
    );
  }
}
