class InsurancePolicy {
  String name;
  String details;
  String policyFile;

  InsurancePolicy({this.name, this.details, this.policyFile});

  // From Json
  factory InsurancePolicy.fromJson(Map<String, dynamic> json) =>
      InsurancePolicy(
        name: json["name"],
        details: json["details"],
        policyFile: json["policyFile"],
      );

  // To Json
  Map<String, dynamic> toJson() => {
        "name": name,
        "details": details,
        "policyFile": policyFile,
      };
}
