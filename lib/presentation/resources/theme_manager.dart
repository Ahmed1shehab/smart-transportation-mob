import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'color_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

// Custom text styles
TextStyle getRegularStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.regular, color);

TextStyle getMediumStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.medium, color);

TextStyle getLightStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.light, color);

TextStyle getBoldStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.bold, color);

TextStyle getSemiBoldStyle(
        {double fontSize = FontSize.s12, required Color color}) =>
    _getTextStyle(fontSize, FontWeightManager.semiBold, color);

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: ColorManager.primary,
      secondary: ColorManager.primary.withOpacity(0.8),
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: 4,
      titleTextStyle: getBoldStyle(fontSize: 20, color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        textStyle: getBoldStyle(fontSize: 16, color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    // Text theme with custom styles
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(fontSize: 32, color: ColorManager.onBoardingTitle),
      displayMedium:
          getBoldStyle(fontSize: 24, color: ColorManager.onBoardingTitle),
      bodyLarge: getRegularStyle(fontSize: 16, color: ColorManager.black),
      bodyMedium: getRegularStyle(fontSize: 14, color: ColorManager.black),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      hintStyle: getRegularStyle(fontSize: 14, color: Colors.grey),
      labelStyle: getRegularStyle(fontSize: 14, color: ColorManager.black),
      errorStyle: getRegularStyle(fontSize: 12, color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ColorManager.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    ),
  );
}
