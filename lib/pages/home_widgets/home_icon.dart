import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kingfisher/data/home_links.dart';
import 'package:kingfisher/theme/colors.dart';

class HomeIcon extends StatelessWidget {
  final Link link;
  const HomeIcon({Key key, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => print('Navigate'),
      child: Container(
        width: 90.0,
        height: 90.0,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0XFF191F3D).withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SvgPicture.asset(
                link.icon,
                color: PRIMARY_COLOR,
                semanticsLabel: link.label,
                height: 10,
                width: 10,
              ),
            ),
            Text(
              link.label,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 12,
                    color: PRIMARY_COLOR,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(color: ACCENT_COLOR, height: 1, thickness: 2),
            ),
          ],
        ),
      ),
    );
  }
}
