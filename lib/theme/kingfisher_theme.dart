import 'package:flutter/material.dart';
import 'package:kingfisher/theme/button_theme.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/theme/text_field_theme.dart';

ThemeData kingfisherTheme() {
  return ThemeData(
    fontFamily: 'Poppins',
    primaryColor: PRIMARY_COLOR,
    accentColor: ACCENT_COLOR,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 48,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w100,
      ),
      bodyText2: TextStyle(
        color: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.w100,
      ),
    ),
    inputDecorationTheme: kingfisherInputDecorationTheme(),
    elevatedButtonTheme: elevatedButtonThemeData(),
  );
}
