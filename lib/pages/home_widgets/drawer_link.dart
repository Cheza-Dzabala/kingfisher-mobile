import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kingfisher/data/drawer_items.dart';
import 'package:kingfisher/theme/colors.dart';

class DrawerLink extends StatelessWidget {
  final DrawerItem drawerItem;
  const DrawerLink({
    Key key,
    this.drawerItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: drawerItem.hasBackground
            ? PRIMARY_COLOR.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: ListTile(
        leading: SvgPicture.asset(drawerItem.icon),
        title: Text(
          drawerItem.title,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: PRIMARY_COLOR,
                fontSize: 15,
              ),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(drawerItem.link);
        },
      ),
    );
  }
}
