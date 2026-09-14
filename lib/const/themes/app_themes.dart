import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class AppThemes {
  // ignore: non_constant_identifier_names
  static ThemeData get LightTheme {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(350, 50),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.secondary,
        ),
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        error: AppColors.red,
        onError: AppColors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
    );
  }
}
