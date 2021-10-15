import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingfisher/data/bottom_bar_items.dart';
import 'package:kingfisher/providers/bottom_bar_provider.dart';
import 'package:kingfisher/theme/colors.dart';

class BottomBarIcon extends ConsumerStatefulWidget {
  final BottomBarItem bottomBarItem;
  final int index;
  const BottomBarIcon({Key key, this.bottomBarItem, this.index})
      : super(key: key);

  @override
  _BottomBarIconState createState() => _BottomBarIconState();
}

class _BottomBarIconState extends ConsumerState<BottomBarIcon> {
  bool isSelected = false;
  BottomBarItem bottomBarItem;
  int index;

  _updateIndex() => ref.read(indexProvider).state = index;

  @override
  void initState() {
    super.initState();
    bottomBarItem = widget.bottomBarItem;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(indexProvider).state;
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: selectedIndex == widget.index
            ? PRIMARY_COLOR.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 30),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: GestureDetector(
            onTap: _updateIndex,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(bottomBarItem.icon, height: 15),
                Text(
                  bottomBarItem.label,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: PRIMARY_COLOR,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
