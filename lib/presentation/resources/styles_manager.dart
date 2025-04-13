import 'dart:ui';
import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
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
    getTextStyle(fontSize, FontWeightManager.regular, color);

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    getTextStyle(fontSize, FontWeightManager.medium, color);

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    getTextStyle(fontSize, FontWeightManager.light, color);

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    getTextStyle(fontSize, FontWeightManager.bold, color);

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) =>
    getTextStyle(fontSize, FontWeightManager.semiBold, color);
