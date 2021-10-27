import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingfisher/theme/colors.dart';

class PageActionButton extends StatelessWidget {
  final Function onTap;
  final bool isLoading;
  const PageActionButton({
    Key key,
    @required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: BLUE_PASTEL.withOpacity(0.2),
          ),
          child: Center(
            child: !isLoading
                ? SvgPicture.asset('assets/icons/icon-add.svg')
                : CircularProgressIndicator(
                    color: PRIMARY_COLOR,
                  ),
          ),
        ),
      ),
    );
  }
}
