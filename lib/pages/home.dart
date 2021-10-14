import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kingfisher/models/kingfisher_user.dart';
import 'package:kingfisher/pages/home_widgets/account.dart';
import 'package:kingfisher/pages/home_widgets/bottom_app_bar.dart';
import 'package:kingfisher/pages/home_widgets/drawer.dart';
import 'package:kingfisher/pages/home_widgets/homepage.dart';
import 'package:kingfisher/providers/bottom_bar_provider.dart';
import 'package:kingfisher/providers/user_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:line_icons/line_icons.dart';

class Home extends ConsumerStatefulWidget {
  // define a static id
  static const String id = '/home';
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool inAsyncCall = false;

  int currentIndex = 0;

  List<Widget> widgetList() => [
        Homepage(),
        Account(),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KingfisherUser user = ref.watch(userProvider).state;
    int currentIndex = ref.watch(indexProvider).state;
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer: KingfisherDrawer(user: user),
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Top Content
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  padding: EdgeInsets.only(
                    top: bar.preferredSize.height,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    // Add image to background
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => scaffoldKey.currentState.openDrawer(),
                          child: Container(
                            width: 40,
                            height: 150.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/clip.png'),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                LineIcons.horizontalEllipsis,
                                color: PRIMARY_COLOR,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.avatar),
                              radius: 25.0,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                user.cityOfResidence.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // End Top Content

              // Main Page content
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  height: MediaQuery.of(context).size.height * 0.70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                    // DropShadow
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20.0,
                        spreadRadius: 0.0,
                        offset: Offset(
                          0.0,
                          -10.0,
                        ),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: widgetList()[currentIndex],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: KingfisherBottomAppBar(),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            onPressed: () => print('Add Policy'),
            child: Icon(
              LineIcons.plus,
              color: Colors.white,
              size: 30.0,
            ),
            backgroundColor: PRIMARY_COLOR,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
