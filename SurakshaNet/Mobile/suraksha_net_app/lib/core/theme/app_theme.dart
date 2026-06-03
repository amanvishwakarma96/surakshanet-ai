import 'package:flutter/material.dart';

class AppTheme {
  static const deepBlue = Color(0xFF0B3D91);
  static const criticalRed = Color(0xFFD32F2F);
  static const warningOrange = Color(0xFFF57C00);
  static const safeGreen = Color(0xFF2E7D32);
  static const lightBackground = Color(0xFFF5F7FB);

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: deepBlue, primary: deepBlue, error: criticalRed),
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: const AppBarTheme(backgroundColor: deepBlue, foregroundColor: Colors.white, centerTitle: false),
      cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16)),
      ),
      useMaterial3: true,
    );
  }
}
