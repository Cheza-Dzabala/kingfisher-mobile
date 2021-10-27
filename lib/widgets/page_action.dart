import 'package:flutter/material.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/widgets/page_action_button.dart';

class PageAction extends StatelessWidget {
  final String title;
  final String subTitle;
  // final IconData icon;
  final Function onTap;
  const PageAction({
    Key key,
    @required this.title,
    @required this.onTap,
    @required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFA9A9A9).withOpacity(0.5),
            offset: Offset(0, 15),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PageActionButton(onTap: onTap),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ACCENT_COLOR,
                        fontSize: 15,
                      ),
                ),
                Text(subTitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
