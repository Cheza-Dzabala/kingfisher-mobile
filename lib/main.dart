import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kingfisher/pages/authentication/login.dart';
import 'package:kingfisher/pages/authentication/signup.dart';
import 'package:kingfisher/pages/home.dart';
import 'package:kingfisher/pages/landing.dart';
import 'package:kingfisher/pages/onboarding/onboarding_finish.dart';
import 'package:kingfisher/pages/onboarding/onboarding_location.dart';
import 'package:kingfisher/pages/onboarding/onboarding_welcome.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/theme/kingfisher_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(Init());
}

class Init extends StatelessWidget {
  Init({Key key}) : super(key: key);

  final Future<FirebaseApp> _future = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Error(errorMessage: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Kingfisher();
          }
          return Loading();
        });
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;
  Error({Key key, @required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}

class Kingfisher extends StatelessWidget {
  const Kingfisher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProviderScope(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: kingfisherTheme(),
            title: 'Kingfisher',
            initialRoute: Landing.id,
            routes: {
              Landing.id: (context) => Landing(),
              Login.id: (context) => Login(),
              Signup.id: (context) => Signup(),
              OnboardingWelcome.id: (context) => OnboardingWelcome(),
              OnboardingLocation.id: (context) => OnboardingLocation(),
              OnboardingFinish.id: (context) => OnboardingFinish(),
              Home.id: (context) => Home(),
            }),
      ),
    );
  }
}
