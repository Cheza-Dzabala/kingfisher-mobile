import 'package:flutter/material.dart';
import 'package:kingfisher/pages/authentication/signup.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';

class Login extends StatefulWidget {
  static String id = '/login';
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  // Create a text editing conntroller called _emailController to get the text from the text field
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    'Login.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Sign in to get started.',
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => print('Login'),
                          child: Text('LOGIN'),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                  child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, Signup.id),
                child: Text('Sign Up.'),
              )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(child: Text('Forgot Password?')),
            ],
          ),
        ),
      ),
    );
  }
}
