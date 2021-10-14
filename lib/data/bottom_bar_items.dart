List<BottomBarItem> bottomBarItems() => [
      BottomBarItem(icon: 'assets/icons/icon-home.svg', label: 'Home'),
      // BottomBarItem(icon: 'assets/icons/icon-policies.svg', label: 'Policies'),
      BottomBarItem(icon: 'assets/icons/icon-account.svg', label: 'Account'),
    ];

class BottomBarItem {
  String icon;
  String label;
  bool isSelected;
  BottomBarItem({this.icon, this.label, this.isSelected = false});
}
