import 'package:kingfisher/pages/home.dart';
import 'package:kingfisher/pages/vehicles/vehicles.dart';

List<DrawerItem> drawerItems() => [
      DrawerItem(
        title: 'My Vehicles',
        icon: 'assets/icons/vehicle-icon.svg',
        link: Vehicles.id,
      ),
      DrawerItem(
        title: 'Notifications',
        icon: 'assets/icons/notification-icon.svg',
        link: Home.id,
      ),
      DrawerItem(
        title: 'Settings',
        icon: 'assets/icons/settings-icon.svg',
        link: Home.id,
      ),
      DrawerItem(
        title: 'Logout',
        icon: 'assets/icons/logout-icon.svg',
        link: Home.id,
        hasBackground: true,
      ),
    ];

class DrawerItem {
  String title;
  String icon;
  String link;
  bool hasBackground;
  DrawerItem({this.title, this.icon, this.link, this.hasBackground = false});
}
