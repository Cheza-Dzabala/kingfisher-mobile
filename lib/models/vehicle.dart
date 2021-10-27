import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kingfisher/models/insurer.dart';

class Vehicle {
  String userId;
  String yearOfMake;
  String make;
  String registrationNumber;
  String model;
  List<String> images;
  num valuation;
  Insurer insurance;
  String details;
  bool hasInsuranceAttached;
  num premiums;
  num totalPremium;
  Timestamp startDate;
  Timestamp expiryDate;

  Vehicle({
    this.userId,
    this.yearOfMake,
    this.make,
    this.registrationNumber,
    this.model,
    this.images,
    this.valuation,
    this.insurance,
    this.details,
    this.hasInsuranceAttached,
    this.premiums,
    this.totalPremium,
    this.startDate,
    this.expiryDate,
  });

  // From JSON
  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        userId: json["user_id"],
        yearOfMake: json['year_of_make'],
        make: json['make'],
        registrationNumber: json['registration_number'],
        model: json['model'],
        images: List<String>.from(json['images']),
        valuation: json['valuation'],
        insurance: json['insurance'] != null
            ? Insurer.fromJson(json['insurance'])
            : null,
        details: json['details'],
        hasInsuranceAttached: json['has_insurance_attached'],
        premiums: json['premiums'],
        totalPremium: json['total_premium'],
        startDate: json['start_date'],
        expiryDate: json['expiry_date'],
      );

  // To JSON
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        'year_of_make': yearOfMake,
        'make': make,
        'registration_number': registrationNumber,
        'model': model,
        'images': List<dynamic>.from(images),
        'valuation': valuation,
        'insurance': insurance != null ? insurance.toJson() : null,
        'details': details,
        'has_insurance_attached': hasInsuranceAttached,
        'premiums': premiums,
        'total_premium': totalPremium,
        'start_date': startDate,
        'expiry_date': expiryDate,
      };

  String get vehicleMakeModel => '$yearOfMake. $make $model';
}
