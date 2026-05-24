import 'package:flutter/material.dart';
import 'package:social_media/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,

      secondary: AppColors.secondary,

      surface: AppColors.surface,

      // onSurface: Colors.white,
    ),

    appBarTheme: const AppBarTheme(backgroundColor: AppColors.background, elevation: 0),
  );
}
