import 'package:kingfisher/models/insurer_policy.dart';

class Insurer {
  String name;
  String image;
  String contactPerson;
  String contactEmail;
  String physicalAddress;
  List<InsurancePolicy> policies;

  Insurer(
      {this.name,
      this.image,
      this.contactPerson,
      this.contactEmail,
      this.physicalAddress,
      this.policies});

  // From JSON
  factory Insurer.fromJson(Map<String, dynamic> json) {
    return Insurer(
      name: json['name'],
      image: json['image'],
      contactPerson: json['contact_person'],
      contactEmail: json['contact_email'],
      physicalAddress: json['physical_address'],
      policies: (json['policies'] as List)
          .map((i) => InsurancePolicy.fromJson(i))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'contact_person': contactPerson,
      'contact_email': contactEmail,
      'physical_address': physicalAddress,
      'policies': policies.map((i) => i.toJson()).toList(),
    };
  }
}
