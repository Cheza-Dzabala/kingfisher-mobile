import 'package:flutter/material.dart';
import 'package:kingfisher/pages/authentication/signup.dart';
import 'package:kingfisher/utils/decorations.dart';

import 'authentication/login.dart';

class Landing extends StatefulWidget {
  static String id = '/';
  const Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        decoration: kStandardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/man.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Text(
              'Manage your policies, vehicles & claims all in one place with Kingfisher.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Signup.id),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SIGN UP'),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
            Container(
              // add vertical margin of 10
              margin: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(Login.id),
                child: Center(
                  child: Text('Already have an account? Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
