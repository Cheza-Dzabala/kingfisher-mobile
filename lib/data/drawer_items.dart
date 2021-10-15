List<DrawerItem> drawerItems() => [
      DrawerItem(
        title: 'My Vehicles',
        icon: 'assets/icons/vehicle-icon.svg',
        link: '',
      ),
      DrawerItem(
        title: 'Notifications',
        icon: 'assets/icons/notification-icon.svg',
        link: '',
      ),
      DrawerItem(
        title: 'Settings',
        icon: 'assets/icons/settings-icon.svg',
        link: '',
      ),
      DrawerItem(
        title: 'Logout',
        icon: 'assets/icons/logout-icon.svg',
        link: '',
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
