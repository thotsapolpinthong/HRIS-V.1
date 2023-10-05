import 'dart:convert';

UpdateContactModel updateContactModelFromJson(String str) =>
    UpdateContactModel.fromJson(json.decode(str));

String updateContactModelToJson(UpdateContactModel data) =>
    json.encode(data.toJson());

class UpdateContactModel {
  String contactPersonInfoId;
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
  String modifiedBy;
  String comment;

  UpdateContactModel({
    required this.contactPersonInfoId,
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
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateContactModel.fromJson(Map<String, dynamic> json) =>
      UpdateContactModel(
        contactPersonInfoId: json["contactPersonInfoId"],
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
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "contactPersonInfoId": contactPersonInfoId,
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
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
