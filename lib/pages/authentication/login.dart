import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfisher/pages/authentication/signup.dart';
import 'package:kingfisher/pages/home.dart';
import 'package:kingfisher/services/authentication_service.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:kingfisher/widgets/elements/back_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  static String id = '/login';
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _authService = getIt<AuthenticationService>();
  bool _isLoading = false;
  // Create a text editing conntroller called _emailController to get the text from the text field
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _handeSubmit({BuildContext context}) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      await _authService.login(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pushNamed(context, Home.id);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
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
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: kStandardDecoration(),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: bar.preferredSize.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: bar.preferredSize.height,
                  child: Container(
                    child: backButtonWidget(context: context),
                  ),
                ),
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
                            onPressed: () => _handeSubmit(context: context),
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
      ),
    );
  }
}
