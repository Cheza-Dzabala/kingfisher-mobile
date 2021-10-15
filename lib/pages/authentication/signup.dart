import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kingfisher/pages/authentication/login.dart';
import 'package:kingfisher/pages/onboarding/onboarding_welcome.dart';
import 'package:kingfisher/providers/user_provider.dart';
import 'package:kingfisher/services/authentication_service.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:kingfisher/widgets/elements/back_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends ConsumerStatefulWidget {
  static String id = '/signup';
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final _authService = getIt<AuthenticationService>();
  // Create text editing controllers for email, password, and password confirmation
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  _handleSubmit({@required BuildContext context}) async {
    if (!_formKey.currentState.validate()) {
      print('invalid form');
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await _authService.signup(
            email: _emailController.text, password: _passwordController.text);
        ref.read(userProvider).state.email = _emailController.text;
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamed(OnboardingWelcome.id);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Register Error $e');
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value != _passwordConfirmationController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: SPACE_IN_FORM,
                        ),
                        TextFormField(
                          controller: _passwordConfirmationController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: SPACE_IN_FORM,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _handleSubmit(context: context),
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
      ),
    );
  }
}
