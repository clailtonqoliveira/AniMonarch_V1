import 'package:flutter/material.dart';

class AppColors {
  // --- Paleta Principal ---
  static const Color background = Color(0xFF05070B);
  static const Color backgroundDark = Color(0xFF08111F);
  static const Color cardBackground = Color(0xFF0D1624);

  // --- Cores de Destaque (Neon) ---
  static const Color primaryNeon = Color(0xFF00BFFF); // DeepSkyBlue
  static const Color secondaryNeon = Color(0xFF39D8FF); // Bright Cyan
  static const Color accent = secondaryNeon; // Alias para a cor neon secundária
  static const Color electricBlue = Color(0xFF1E90FF); // DodgerBlue

  // --- Cores de Texto e Suporte ---
  static const Color textPrimary = Color(0xFFEAF7FF); // Branco Gelo
  static const Color textSecondary = Color(0xB3EAF7FF); // Branco Gelo com 70% opacidade
  static const Color textTertiary = Color(0x80EAF7FF); // Branco Gelo com 50% opacidade
  static const Color textFaint = Color(0x4DEAF7FF); // Branco Gelo com 30% opacidade


  // --- Cores de UI ---
  static const Color dividerColor = Color(0x4D39D8FF); // Ciano com 30% opacidade
  static const Color shadowColor = Color(0x3300BFFF); // Azul Neon com 20% opacidade
  
  // --- Cores de Status ---
  static const Color success = Colors.greenAccent;
  static const Color warning = Colors.amberAccent;
  static const Color error = Colors.redAccent;
}
