import 'package:flutter/material.dart';
import 'package:flutter_task_1/core/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontFamily: 'Lato',
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w800),
    bodyMedium:
        TextStyle(fontFamily: 'Lato', fontSize: 25, color: Colors.white),
    bodySmall: TextStyle(fontFamily: 'Lato', fontSize: 20, color: Colors.white),
    labelLarge:
        TextStyle(fontFamily: 'Lato', fontSize: 18, color: Colours.greyColor),
    labelMedium:
        TextStyle(fontFamily: 'Lato', fontSize: 16, color: Colours.greyColor , fontWeight: FontWeight.w400),
    labelSmall:
        TextStyle(fontFamily: 'Lato', fontSize: 14, color: Colours.greyColor),
  ));
}
