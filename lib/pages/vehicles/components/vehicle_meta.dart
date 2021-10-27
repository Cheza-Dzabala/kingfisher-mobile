import 'package:flutter/material.dart';
import 'package:kingfisher/models/vehicle.dart';
import 'package:kingfisher/theme/colors.dart';

class VehicleMeta extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleMeta({Key key, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Year Of Make',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                vehicle.yearOfMake,
                style: TextStyle(fontSize: 18, color: ACCENT_COLOR),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                vehicle.registrationNumber,
                style: TextStyle(fontSize: 18, color: ACCENT_COLOR),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Insurer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                vehicle.insurance != null ? vehicle.registrationNumber : 'None',
                style: TextStyle(fontSize: 18, color: ACCENT_COLOR),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
