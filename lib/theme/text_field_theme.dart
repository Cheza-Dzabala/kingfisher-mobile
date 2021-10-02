import 'package:flutter/material.dart';
import 'package:kingfisher/theme/colors.dart';

InputDecorationTheme kingfisherInputDecorationTheme() {
  return InputDecorationTheme(
    focusColor: PRIMARY_COLOR,
    fillColor: FILL_COLOR,
    filled: true,
    prefixStyle: TextStyle(color: PRIMARY_COLOR),
    labelStyle: TextStyle(
      color: Colors.black45,
      letterSpacing: 1.0,
      fontSize: 15.0,
    ),
    hintStyle: TextStyle(
      color: Colors.black,
      fontSize: 13.0,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
