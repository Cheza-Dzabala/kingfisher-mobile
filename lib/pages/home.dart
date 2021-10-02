import 'package:flutter/material.dart';
import 'package:kingfisher/pages/landing.dart';
import 'package:kingfisher/services/authentication_service.dart';
import 'package:kingfisher/services/locator.dart';

class Home extends StatefulWidget {
  // define a static id
  static const String id = '/home';
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authenticationService = getIt<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text('Logout'),
        onPressed: () async {
          try {
            await _authenticationService.logout();
            Navigator.pushReplacementNamed(context, Landing.id);
          } catch (e) {
            print(e);
          }
        },
      )),
    );
  }
}
