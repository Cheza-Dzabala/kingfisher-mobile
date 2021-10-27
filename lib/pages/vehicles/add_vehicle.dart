import 'dart:io';

import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kingfisher/models/vehicle.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/services/vehicle_service.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:kingfisher/widgets/page_action_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';

class AddVehicle extends StatefulWidget {
  static String id = '/add_vehicle';
  const AddVehicle({Key key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  bool inAsyncCall = false;
  BuildContext _context;
  VehicleService _service = getIt<VehicleService>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _yearOfMakeController = TextEditingController();
  TextEditingController _vehicleMakeController = TextEditingController();
  TextEditingController _vehicleModelController = TextEditingController();
  TextEditingController _registrationNumberController = TextEditingController();
  TextEditingController _valuationController = TextEditingController();

  List<String> images = [];

  bool isAddingImage = false;

  _uploadImage() async {
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
            isAddingImage = true;
          });
          String imageUrl = await _service.uploadVehicleImage(
            image: File(image.path),
          );
          setState(() {
            images.add(imageUrl);
            isAddingImage = false;
          });
        } catch (e) {
          print('Upload error $e');
          Get.snackbar(
            'Image upload error',
            'Image upload error',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    }
  }

  _deleteImage(String imageUrl) async {
    try {
      await _service.deleteVehicleImage(imageUrl: imageUrl);
      // remove image from images List
      setState(() {
        images.remove(imageUrl);
        print(images);
      });
      Get.snackbar(
        'Success',
        'Successfully removed image',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Delete error $e');
      Get.snackbar(
        'Image delete error',
        'Image delete error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  _handleSubmit() async {
    // Validate form
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (images.length == 0) {
      Get.snackbar(
        'Error',
        'Please upload at least 3 pictures of your car.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } else if (images.length < 3) {
      Get.snackbar(
        'Error',
        'Please upload at least 3 pictures of your car.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    setState(() {
      inAsyncCall = true;
    });
    Vehicle vehicle = new Vehicle();
    vehicle.userId = FirebaseAuth.instance.currentUser.uid;
    vehicle.yearOfMake = _yearOfMakeController.text;
    vehicle.make = _vehicleMakeController.text;
    vehicle.model = _vehicleModelController.text;
    vehicle.registrationNumber = _registrationNumberController.text;
    vehicle.valuation = int.parse(_valuationController.text);
    vehicle.images = images;
    vehicle.hasInsuranceAttached = false;

    try {
      await _service.save(vehicle: vehicle);
      Get.snackbar(
        'Success',
        'Successfully added vehicle',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      setState(() {
        inAsyncCall = false;
      });
      Navigator.pop(_context);
    } catch (e) {
      setState(() {
        inAsyncCall = false;
      });
      print('Add vehicle error $e');
      Get.snackbar(
        'Error',
        'Error adding vehicle',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: appBar(backButton: true, context: context, title: 'Add Vehicle'),
      body: ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: Offset(0, 15), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Wrap(
                        children: [
                          Wrap(
                            runSpacing: 10,
                            children: images.isEmpty
                                ? [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          'Upload pictures of your vehicle.'),
                                    ),
                                  ]
                                : images.map<Widget>((imageUrl) {
                                    return Badge(
                                      badgeColor: Color(0XFFDE5B5B),
                                      shape: BadgeShape.square,
                                      position:
                                          BadgePosition.topEnd(top: -5, end: 0),
                                      borderRadius: BorderRadius.circular(10),
                                      badgeContent: GestureDetector(
                                        onTap: () => _deleteImage(imageUrl),
                                        child: SvgPicture.asset(
                                          'assets/icons/icon-remove.svg',
                                        ),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                          ),
                          isAddingImage
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PageActionButton(
                                    onTap: () {},
                                    isLoading: true,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PageActionButton(
                                    onTap: () => _uploadImage(),
                                    isLoading: false,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _yearOfMakeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Year of Make',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter year of make';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _vehicleMakeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Vehicle Make',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter vehicle make';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _vehicleModelController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Vehicle Model',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter vehicle model';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _registrationNumberController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Registration Number',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter vehicle registration number.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _valuationController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Vehicle Value',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter vehicle value';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _handleSubmit,
                              child: Text('DONE'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
