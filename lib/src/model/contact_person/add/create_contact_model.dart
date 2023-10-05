import 'dart:convert';

CreateContactModel createContactModelFromJson(String str) =>
    CreateContactModel.fromJson(json.decode(str));

String createContactModelToJson(CreateContactModel data) =>
    json.encode(data.toJson());

class CreateContactModel {
  String personId;
  String relation;
  String titleId;
  String firstName;
  String midName;
  String lastName;
  String occupation;
  String companyName;
  String positionName;
  String homePhone;
  String mobilePhone;

  CreateContactModel({
    required this.personId,
    required this.relation,
    required this.titleId,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.occupation,
    required this.companyName,
    required this.positionName,
    required this.homePhone,
    required this.mobilePhone,
  });

  factory CreateContactModel.fromJson(Map<String, dynamic> json) =>
      CreateContactModel(
        personId: json["personId"],
        relation: json["relation"],
        titleId: json["titleId"],
        firstName: json["firstName"],
        midName: json["midName"],
        lastName: json["lastName"],
        occupation: json["occupation"],
        companyName: json["companyName"],
        positionName: json["positionName"],
        homePhone: json["homePhone"],
        mobilePhone: json["mobilePhone"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "relation": relation,
        "titleId": titleId,
        "firstName": firstName,
        "midName": midName,
        "lastName": lastName,
        "occupation": occupation,
        "companyName": companyName,
        "positionName": positionName,
        "homePhone": homePhone,
        "mobilePhone": mobilePhone,
      };
}
