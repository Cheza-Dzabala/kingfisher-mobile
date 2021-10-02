import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfisher/pages/home.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/services/profile_service.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OnboardingFinish extends StatefulWidget {
  static String id = '/onboarding_finish';
  const OnboardingFinish({Key key}) : super(key: key);

  @override
  _OnboardingFinishState createState() => _OnboardingFinishState();
}

class _OnboardingFinishState extends State<OnboardingFinish> {
  final _profileService = getIt<ProfileService>();
  bool isInAsyncCall = false;

  _handleSubmit() async {
    try {
      setState(() {
        isInAsyncCall = true;
      });
      await _profileService.createProfile();
      setState(() {
        isInAsyncCall = false;
      });
      Navigator.pushReplacementNamed(context, Home.id);
    } catch (e) {
      setState(() {
        isInAsyncCall = false;
      });
      print(e);
      Get.snackbar(
        'Error',
        e.message,
        colorText: Colors.white,
        backgroundColor: ERROR_COLOR,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: bar.preferredSize.height,
            ),
            height: MediaQuery.of(context).size.height,
            decoration: kStandardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Finish.',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      'Step 3 of 3.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    'You\'re all set up.',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/tick.png'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: Text(
                    'Welcome to Kingfisher mobile.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: Text('Get Started'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
