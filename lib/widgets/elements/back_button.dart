import 'package:flutter/material.dart';
import 'package:kingfisher/theme/colors.dart';

Container backButtonWidget({BuildContext context}) => Container(
      margin: EdgeInsets.only(left: 10),
      height: 50,
      width: 50,
      // add a decoration with PRIMARY_COLOR as a background color and a circular shape with a back arrow
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
        ),
        color: Colors.white,
      ),
    );
