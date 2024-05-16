import 'dart:convert';

GetDataContact getDataContactFromJson(String str) =>
    GetDataContact.fromJson(json.decode(str));

String getDataContactToJson(GetDataContact data) => json.encode(data.toJson());

class GetDataContact {
  List<ContactPersonInfoDatum> contactPersonInfoData;
  String message;
  bool status;

  GetDataContact({
    required this.contactPersonInfoData,
    required this.message,
    required this.status,
  });

  factory GetDataContact.fromJson(Map<String, dynamic> json) => GetDataContact(
        contactPersonInfoData: List<ContactPersonInfoDatum>.from(
            json["contactPersonInfoData"]
                .map((x) => ContactPersonInfoDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "contactPersonInfoData":
            List<dynamic>.from(contactPersonInfoData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ContactPersonInfoDatum {
  String contactPersonInfoId;
  String personId;
  String relation;
  TitleName titleName;
  String firstName;
  String midName;
  String lastName;
  String? occupation;
  String companyName;
  String positionName;
  String homePhone;
  String mobilePhone;

  ContactPersonInfoDatum({
    required this.contactPersonInfoId,
    required this.personId,
    required this.relation,
    required this.titleName,
    required this.firstName,
    required this.midName,
    required this.lastName,
    this.occupation,
    required this.companyName,
    required this.positionName,
    required this.homePhone,
    required this.mobilePhone,
  });

  factory ContactPersonInfoDatum.fromJson(Map<String, dynamic> json) =>
      ContactPersonInfoDatum(
        contactPersonInfoId: json["contactPersonInfoId"],
        personId: json["personId"],
        relation: json["relation"],
        titleName: TitleName.fromJson(json["titleName"]),
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
        "contactPersonInfoId": contactPersonInfoId,
        "personId": personId,
        "relation": relation,
        "titleName": titleName.toJson(),
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

class TitleName {
  String titleNameId;
  String titleNameTh;
  String titleNameEn;

  TitleName({
    required this.titleNameId,
    required this.titleNameTh,
    required this.titleNameEn,
  });

  factory TitleName.fromJson(Map<String, dynamic> json) => TitleName(
        titleNameId: json["titleNameId"],
        titleNameTh: json["titleNameTh"],
        titleNameEn: json["titleNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "titleNameId": titleNameId,
        "titleNameTh": titleNameTh,
        "titleNameEn": titleNameEn,
      };
}
