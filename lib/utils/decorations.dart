import 'package:flutter/rendering.dart';

BoxDecoration kStandardDecoration() => BoxDecoration(
      // add a background image
      image: DecorationImage(
        image: AssetImage('assets/images/background.png'),
        fit: BoxFit.cover,
      ),
    );
