class KingfisherUser {
  String id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String cityOfResidence;
  String dateOfBirth;

  KingfisherUser({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.cityOfResidence,
    this.dateOfBirth,
  });

  // Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'city_of_residence': cityOfResidence,
        'date_of_birth': dateOfBirth,
      };

  // Deserialize from JSON using factory
  factory KingfisherUser.fromJson(Map<String, dynamic> json) => KingfisherUser(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        cityOfResidence: json['city_of_residence'],
        dateOfBirth: json['date_of_birth'],
      );

  // Combine firstName and lastName and return fullName
  String get fullName => '$firstName $lastName';
}
