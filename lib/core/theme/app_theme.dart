import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFF7FAFC);
  static const surface = Colors.white;
  static const primary = Color(0xFF6EE7B7);
  static const primaryDark = Color(0xFF0F9F75);
  static const ink = Color(0xFF0B1220);
  static const muted = Color(0xFF64748B);
  static const outline = Color(0xFFDDE7EC);
  static const softBlue = Color(0xFFE9F8F2);
  static const splashBackground = Color(0xFF0B1220);
  static const splashSurface = Color(0xFF111C2D);
  static const splashMuted = Color(0xFF94A3B8);
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      brightness: Brightness.light,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: AppColors.ink,
          fontSize: 28,
          height: 1.08,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
        ),
        bodyLarge: TextStyle(
          color: AppColors.muted,
          fontSize: 15,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
