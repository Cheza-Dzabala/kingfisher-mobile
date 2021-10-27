import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingfisher/models/vehicle.dart';
import 'package:kingfisher/pages/vehicles/add_vehicle.dart';
import 'package:kingfisher/pages/vehicles/view_vehicle.dart';
import 'package:kingfisher/services/locator.dart';
import 'package:kingfisher/services/vehicle_service.dart';
import 'package:kingfisher/theme/colors.dart';
import 'package:kingfisher/widgets/app_bar.dart';
import 'package:kingfisher/widgets/page_action.dart';

class Vehicles extends StatefulWidget {
  static String id = 'vehicles';
  const Vehicles({Key key}) : super(key: key);

  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  Stream<List<Vehicle>> _stream;

  VehicleService _service = getIt<VehicleService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = _service.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(backButton: true, context: context),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicles.',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              PageAction(
                onTap: () => Navigator.of(context).pushNamed(AddVehicle.id),
                title: 'ADD A VEHICLE',
                subTitle: 'Add a new vehicle to list.',
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: StreamBuilder(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error retrieving vehicles');
                      }
                      if (snapshot.data == null) {
                        return Text('No vehicles added yet.');
                      }
                      List<Vehicle> vehicles = snapshot.data;
                      return ListView.builder(
                          itemCount: vehicles.length,
                          itemBuilder: (item, index) {
                            Vehicle vehicle = vehicles[index];
                            return Container(
                              height: 130,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.only(left: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(vehicle.images[0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            vehicle.vehicleMakeModel,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(fontSize: 15),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            vehicle.registrationNumber,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: !vehicle.hasInsuranceAttached
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: ERROR_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Text(
                                                    'Uninsured',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                )
                                              : Text(''),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(),
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                  ViewVehicle.id,
                                                  arguments: vehicle,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/svgs/bottom-cover.svg',
                                                      height: 80,
                                                      width: 80,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10,
                                                          left: 10,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/forward-button.svg',
                                                          height: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
