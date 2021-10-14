import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingfisher/data/bottom_bar_items.dart';
import 'package:kingfisher/pages/home_widgets/bottom_bar_icon.dart';

class KingfisherBottomAppBar extends ConsumerStatefulWidget {
  const KingfisherBottomAppBar({Key key}) : super(key: key);

  @override
  _KingfisherBottomAppBarState createState() => _KingfisherBottomAppBarState();
}

class _KingfisherBottomAppBarState
    extends ConsumerState<KingfisherBottomAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 50.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 5.0,
      color: Colors.white,
      child: Container(
        height: 70.0,
        padding: EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
          right: MediaQuery.of(context).size.width * 0.20,
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bottomBarItems().length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              BottomBarItem item = bottomBarItems()[index];
              return BottomBarIcon(
                bottomBarItem: item,
                index: index,
              );
            }),
      ),
    );
  }
}
