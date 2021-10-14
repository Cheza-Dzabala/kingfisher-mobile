import 'package:flutter/material.dart';
import 'package:kingfisher/data/home_links.dart';
import 'package:kingfisher/pages/home_widgets/home_icon.dart';
import 'package:kingfisher/widgets/section_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: homeLinks().map<Widget>((link) {
            return HomeIcon(link: link);
          }).toList(),
        ),
        SizedBox(
          height: 15.0,
        ),
        SectionTitle(
          title: 'Insurers',
          subTitle: 'Insurers we work with',
        ),
      ],
    );
  }
}
