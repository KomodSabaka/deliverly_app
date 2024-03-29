import 'package:flutter/material.dart';
import '../constants/app_palette.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor:AppPalette.backdropColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppPalette.primaryTextColor,
          fontSize: 34,
          letterSpacing: 0.41,
        ),
        bodyLarge: TextStyle(
          color: AppPalette.secondaryTextColor,
          fontSize: 17,
          letterSpacing: -0.41,
        ),
        bodyMedium: TextStyle(
          color: AppPalette.primaryTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: AppPalette.primaryTextColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryButtonColor,
          textStyle: const TextStyle(
            fontSize: 15,
            letterSpacing: -0.01,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
