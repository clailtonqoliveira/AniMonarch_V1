import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle display = GoogleFonts.orbitron(
    color: AppColors.textPrimary,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    letterSpacing: -1.5,
  );

  static final TextStyle h1 = GoogleFonts.orbitron(
    color: AppColors.textPrimary,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static final TextStyle h2 = GoogleFonts.orbitron(
    color: AppColors.primaryNeon,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );

  static final TextStyle h3 = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subtitle1 = GoogleFonts.inter(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static final TextStyle body1 = GoogleFonts.inter(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5, // Line height
  );

  static final TextStyle body2 = GoogleFonts.inter(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4, // Line height
  );

  static final TextStyle button = GoogleFonts.orbitron(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.25,
  );

  static final TextStyle caption = GoogleFonts.inter(
    color: AppColors.textFaint,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );

  static final TextStyle overline = GoogleFonts.inter(
    color: AppColors.textFaint,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );
}
