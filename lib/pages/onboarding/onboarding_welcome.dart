import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kingfisher/pages/onboarding/onboarding_location.dart';
import 'package:kingfisher/providers/user_provider.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/services/profile_service.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/utils/constants.dart';
import 'package:kingfisher/utils/decorations.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingWelcome extends ConsumerStatefulWidget {
  static String id = '/onboarding_welcome';
  const OnboardingWelcome({Key key}) : super(key: key);

  @override
  _OnboardingWelcomeState createState() => _OnboardingWelcomeState();
}

class _OnboardingWelcomeState extends ConsumerState<OnboardingWelcome> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool isLoadingImage = false;
  final _profileService = getIt<ProfileService>();

  final _formKey = GlobalKey<FormState>();

  _selectProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    // Get permissions for gallery
    var status = await Permission.photos.request();

    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    } else {
      XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        try {
          setState(() {
            isLoadingImage = true;
          });
          String avatarUrl =
              await _profileService.uploadAvatar(file: File(image.path));
          ref.read(userProvider).state.avatar = avatarUrl;
          setState(() {
            isLoadingImage = false;
          });
        } catch (e) {
          print('Upload error $e');
          setState(() {
            isLoadingImage = false;
          });
          Get.snackbar(
            'Error',
            'Avatar Upload Error',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        }
      }
    }
  }

  _handleSubmit({@required BuildContext context}) {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      ref.read(userProvider).state.firstName = _firstNameController.text;
      ref.read(userProvider).state.lastName = _lastNameController.text;
      ref.read(userProvider).state.phoneNumber = _phoneNumberController.text;
      Navigator.of(context).pushNamed(OnboardingLocation.id);
    }
  }

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
    var _user = ref.watch(userProvider);
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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: PRIMARY_COLOR,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    iconSize: 60,
                    onPressed: () => _selectProfilePicture(),
                    icon: isLoadingImage
                        ? CircularProgressIndicator(
                            color: PRIMARY_COLOR,
                          )
                        : _user.state.avatar.isEmpty
                            ? SvgPicture.asset(
                                'assets/svgs/camera.svg',
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(_user.state.avatar),
                                radius: 60,
                              ),
                  ),
                ),
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
                        keyboardType: TextInputType.number,
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
                          onPressed: () => _handleSubmit(context: context),
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
