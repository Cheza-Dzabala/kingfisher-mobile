import 'package:cloud_firestore/cloud_firestore.dart';

class KingfisherUser {
  String id;
  String avatar;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String cityOfResidence;
  String dateOfBirth;
  Timestamp createdAt;

  KingfisherUser({
    this.id,
    this.avatar = '',
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.cityOfResidence,
    this.dateOfBirth,
    this.createdAt,
  });

  // Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'avatar': avatar,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city_of_residence': cityOfResidence,
        'date_of_birth': dateOfBirth,
        'created_at': createdAt
      };

  // Deserialize from JSON using factory
  factory KingfisherUser.fromJson(Map<String, dynamic> json) => KingfisherUser(
        id: json['id'],
        avatar: json['avatar'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        cityOfResidence: json['city_of_residence'],
        dateOfBirth: json['date_of_birth'],
        createdAt: json['createdAt'],
      );

  // Combine firstName and lastName and return fullName
  String get fullName => '$firstName $lastName';
}
