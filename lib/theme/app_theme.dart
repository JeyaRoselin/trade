import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Brand Colors
  static const Color background = Color(0xFF0A0E1A);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceElevated = Color(0xFF1C2333);
  static const Color cardBorder = Color(0xFF1E2D45);
  static const Color accent = Color(0xFF00D4FF);
  static const Color accentDim = Color(0xFF0099BB);
  static const Color bullish = Color(0xFF00C896);
  static const Color bearish = Color(0xFFFF4D6A);
  static const Color neutral = Color(0xFFB0BAD0);
  static const Color textPrimary = Color(0xFFEEF2FF);
  static const Color textSecondary = Color(0xFF8896B0);
  static const Color textMuted = Color(0xFF4A5568);
  static const Color swapHighlightFirst = Color(0xFFFFB347);
  static const Color swapHighlightSecond = Color(0xFF7B61FF);
  static const Color swapModeBanner = Color(0xFF1A1030);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        background: background,
        surface: surface,
        primary: accent,
        secondary: bullish,
        error: bearish,
      ),
      textTheme: GoogleFonts.dmSansTextTheme().apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}
