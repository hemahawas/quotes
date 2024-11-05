import 'package:flutter/material.dart';
import 'package:quotes/src/core/utils/app_colors.dart';
import 'package:quotes/src/core/utils/app_strings.dart';

ThemeData appTheme() => ThemeData(
  primaryColor: AppColors.primary,
  fontFamily: AppStrings.fontFamily,
  textTheme: const TextTheme(
      bodyMedium: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold, 
        height: 1.3,
      ),
  ),
);