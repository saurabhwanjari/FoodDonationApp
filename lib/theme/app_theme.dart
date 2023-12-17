import 'package:flutter/material.dart';
import '../constants/app_colors.dart';


class AppTheme {
  //
  static const String fontFamily = 'Roboto';

  //
  static const ColorScheme lightColorScheme = AppColors.light;
  //static const ColorScheme darkColorScheme = AppColors.dark;  
  

  static final ThemeData light = ThemeData(
    fontFamily: fontFamily,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,
  );

  // static final ThemeData dark = ThemeData(
  //   fontFamily: fontFamily,
  //   colorScheme: darkColorScheme,
  //   scaffoldBackgroundColor: darkColorScheme.background,
  // );
}