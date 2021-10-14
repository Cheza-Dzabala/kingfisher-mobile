import 'package:flutter/material.dart';
import 'package:kingfisher/data/drawer_items.dart';
import 'package:kingfisher/models/kingfisher_user.dart';
import 'package:kingfisher/pages/home_widgets/drawer_link.dart';

class KingfisherDrawer extends StatefulWidget {
  final KingfisherUser user;
  const KingfisherDrawer({Key key, @required this.user}) : super(key: key);

  @override
  _KingfisherDrawerState createState() => _KingfisherDrawerState();
}

class _KingfisherDrawerState extends State<KingfisherDrawer> {
  KingfisherUser user;
  @override
  void initState() {
    super.initState();
    this.user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border(bottom: BorderSide.none),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.avatar,
                    ),
                    radius: 50,
                  ),
                  Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: drawerItems().map<Widget>((item) {
                  return DrawerLink(drawerItem: item);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
