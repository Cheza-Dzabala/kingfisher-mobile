import 'package:flutter/material.dart';
import 'package:kingfisher/pages/onboarding/onboarding_location.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';

class OnboardingWelcome extends StatefulWidget {
  static String id = '/onboarding_welcome';
  const OnboardingWelcome({Key key}) : super(key: key);

  @override
  _OnboardingWelcomeState createState() => _OnboardingWelcomeState();
}

class _OnboardingWelcomeState extends State<OnboardingWelcome> {
  // Create Text Editing controllers for firt name, last name and phone number
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                    'Welcome.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Step 1 of 3.',
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
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      // Created a space of 20 between
                      SizedBox(
                        height: SPACE_IN_FORM,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SPACE_IN_FORM,
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
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
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              Navigator.of(context)
                                  .pushNamed(OnboardingLocation.id);
                            }
                          },
                          child: Text('NEXT'),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
