import 'dart:convert';

CreateFamilyModel createFamilyModelFromJson(String str) =>
    CreateFamilyModel.fromJson(json.decode(str));

String createFamilyModelToJson(CreateFamilyModel data) =>
    json.encode(data.toJson());

class CreateFamilyModel {
  String personId;
  String familyMemberTypeId;
  String titleNameId;
  String firstName;
  String midName;
  String lastName;
  String dateOfBirth;
  String vitalStatusId;

  CreateFamilyModel({
    required this.personId,
    required this.familyMemberTypeId,
    required this.titleNameId,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.dateOfBirth,
    required this.vitalStatusId,
  });

  factory CreateFamilyModel.fromJson(Map<String, dynamic> json) =>
      CreateFamilyModel(
        personId: json["personId"],
        familyMemberTypeId: json["familyMemberTypeId"],
        titleNameId: json["titleNameId"],
        firstName: json["firstName"],
        midName: json["midName"],
        lastName: json["lastName"],
        dateOfBirth: json["dateOfBirth"],
        vitalStatusId: json["vitalStatusId"],
      );

  Map<String, dynamic> toJson() => {
        "personId": personId,
        "familyMemberTypeId": familyMemberTypeId,
        "titleNameId": titleNameId,
        "firstName": firstName,
        "midName": midName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "vitalStatusId": vitalStatusId,
      };
}
