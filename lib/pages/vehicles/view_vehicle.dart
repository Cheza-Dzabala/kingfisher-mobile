import 'package:flutter/material.dart';
import 'package:kingfisher/models/vehicle.dart';
import 'package:kingfisher/pages/vehicles/components/vehicle_meta.dart';
import 'package:kingfisher/widgets/app_bar.dart';

class ViewVehicle extends StatefulWidget {
  static String id = '/view_vehicle';
  final Vehicle vehicle;
  const ViewVehicle({Key key, this.vehicle}) : super(key: key);

  @override
  _ViewVehicleState createState() => _ViewVehicleState();
}

class _ViewVehicleState extends State<ViewVehicle> {
  Vehicle vehicle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vehicle = widget.vehicle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          backButton: true, context: context, title: vehicle.vehicleMakeModel),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              VehicleMeta(vehicle: vehicle),
            ],
          ),
        ),
      ),
    );
  }
}
