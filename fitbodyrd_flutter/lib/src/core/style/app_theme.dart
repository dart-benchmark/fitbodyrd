import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFC1FF00);
  static const Color bg = Color(0xFF0D0D0F);
  static const Color surface = Color(0xFF1A1A1D);
  static const Color surfaceDark = Color(0xFF141416);
  static const Color textColor = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      primaryColor: primary,
      canvasColor: bg,
      splashFactory: NoSplash.splashFactory,
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: textColor,
        ),
        bodySmall: GoogleFonts.poppins(
          color: textColor,
        ),
      ),
      hintColor: KColors.greyScale.g300,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: GoogleFonts.poppins(color: KColors.greyScale.g300),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: surfaceDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: primary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primary,
        surface: surface,
      ),
    );
  }
}
