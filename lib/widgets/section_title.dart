import 'package:flutter/material.dart';
import 'package:kingfisher/theme/colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const SectionTitle({Key key, @required this.title, @required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: GREY,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}
