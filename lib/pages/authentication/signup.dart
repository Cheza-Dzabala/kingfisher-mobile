import 'package:flutter/material.dart';
import 'package:kingfisher/pages/authentication/login.dart';
import 'package:kingfisher/pages/onboarding/onboarding_welcome.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';

class Signup extends StatefulWidget {
  static String id = '/signup';
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // Create text editing controllers for email, password, and password confirmation
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(backButton: true, context: context),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          decoration: kStandardDecoration(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Sign up to get started.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      // Created a space of 20 between
                      SizedBox(
                        height: SPACE_IN_FORM,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: SPACE_IN_FORM,
                      ),
                      TextFormField(
                        controller: _passwordConfirmationController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: SPACE_IN_FORM,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(OnboardingWelcome.id),
                          child: Text('REGISTER'),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                  child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, Login.id),
                child: Text('Login Instead.'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
