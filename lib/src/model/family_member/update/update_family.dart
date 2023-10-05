import 'dart:convert';

UpdateFamilyModel updateFamilyModelFromJson(String str) =>
    UpdateFamilyModel.fromJson(json.decode(str));

String updateFamilyModelToJson(UpdateFamilyModel data) =>
    json.encode(data.toJson());

class UpdateFamilyModel {
  String familyMemberId;
  String personId;
  String familyMemberTypeId;
  String titleNameId;
  String firstName;
  String midName;
  String lastName;
  String dateOfBirth;
  String vitalStatusId;
  String modifiedBy;
  String comment;

  UpdateFamilyModel({
    required this.familyMemberId,
    required this.personId,
    required this.familyMemberTypeId,
    required this.titleNameId,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.dateOfBirth,
    required this.vitalStatusId,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateFamilyModel.fromJson(Map<String, dynamic> json) =>
      UpdateFamilyModel(
        familyMemberId: json["familyMemberId"],
        personId: json["personId"],
        familyMemberTypeId: json["familyMemberTypeId"],
        titleNameId: json["titleNameId"],
        firstName: json["firstName"],
        midName: json["midName"],
        lastName: json["lastName"],
        dateOfBirth: json["dateOfBirth"],
        vitalStatusId: json["vitalStatusId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "familyMemberId": familyMemberId,
        "personId": personId,
        "familyMemberTypeId": familyMemberTypeId,
        "titleNameId": titleNameId,
        "firstName": firstName,
        "midName": midName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "vitalStatusId": vitalStatusId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
