import 'package:flutter/material.dart';

import 'colors.dart';

ElevatedButtonThemeData elevatedButtonThemeData() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(12),
        // Curve button corners
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        primary: PRIMARY_COLOR,
        textStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 1.0,
        ),
      ),
    );
