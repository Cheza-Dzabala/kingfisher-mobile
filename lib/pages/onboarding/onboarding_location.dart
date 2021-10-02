import 'package:flutter/material.dart';
import 'package:kingfisher/pages/onboarding/onboarding_finish.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/utils/lists.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:select_form_field/select_form_field.dart';

class OnboardingLocation extends StatefulWidget {
  static String id = '/onboarding_location';
  const OnboardingLocation({Key key}) : super(key: key);

  @override
  _OnboardingLocationState createState() => _OnboardingLocationState();
}

class _OnboardingLocationState extends State<OnboardingLocation> {
  // Create a text controller for city of residence
  final _cityOfResidenceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                    'Location.',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Step 2 of 3.',
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
                      SelectFormField(
                          controller: _cityOfResidenceController,
                          type: SelectFormFieldType.dialog, // or can be dialog
                          hintText: 'Please select your city of residence.',
                          items: malawiCities,
                          onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select city of residence';
                            }
                            return null;
                          }),
                      // Created a space of 20 between

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
                                  .pushNamed(OnboardingFinish.id);
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
