import 'package:flutter/material.dart';

import 'package:ecommerce_c19/core/theme/app_colors.dart';

abstract class AppTheme {
  static final light = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    textTheme: ThemeData.light().textTheme.apply(
      fontFamily: 'Poppins',
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primary),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
