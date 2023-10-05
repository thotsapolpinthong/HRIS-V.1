import 'dart:convert';

FamilyMemberDataModel familyMemberDataModelFromJson(String str) =>
    FamilyMemberDataModel.fromJson(json.decode(str));

String familyMemberDataModelToJson(FamilyMemberDataModel data) =>
    json.encode(data.toJson());

class FamilyMemberDataModel {
  List<FamilyMemberDatum> familyMemberData;
  String message;
  bool status;

  FamilyMemberDataModel({
    required this.familyMemberData,
    required this.message,
    required this.status,
  });

  factory FamilyMemberDataModel.fromJson(Map<String, dynamic> json) =>
      FamilyMemberDataModel(
        familyMemberData: List<FamilyMemberDatum>.from(
            json["familyMemberData"].map((x) => FamilyMemberDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "familyMemberData":
            List<dynamic>.from(familyMemberData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class FamilyMemberDatum {
  String familyMemberId;
  String personId;
  FamilyMemberTypeData familyMemberTypeData;
  TitleNameData titleNameData;
  String firstName;
  String midName;
  String lastName;
  String dateOfBirth;
  String age;
  VitalStatusData vitalStatusData;

  FamilyMemberDatum({
    required this.familyMemberId,
    required this.personId,
    required this.familyMemberTypeData,
    required this.titleNameData,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.dateOfBirth,
    required this.age,
    required this.vitalStatusData,
  });

  factory FamilyMemberDatum.fromJson(Map<String, dynamic> json) =>
      FamilyMemberDatum(
        familyMemberId: json["familyMemberId"],
        personId: json["personId"],
        familyMemberTypeData:
            FamilyMemberTypeData.fromJson(json["familyMemberTypeData"]),
        titleNameData: TitleNameData.fromJson(json["titleNameData"]),
        firstName: json["firstName"],
        midName: json["midName"],
        lastName: json["lastName"],
        dateOfBirth: json["dateOfBirth"],
        age: json["age"],
        vitalStatusData: VitalStatusData.fromJson(json["vitalStatusData"]),
      );

  Map<String, dynamic> toJson() => {
        "familyMemberId": familyMemberId,
        "personId": personId,
        "familyMemberTypeData": familyMemberTypeData.toJson(),
        "titleNameData": titleNameData.toJson(),
        "firstName": firstName,
        "midName": midName,
        "lastName": lastName,
        "dateOfBirth": dateOfBirth,
        "age": age,
        "vitalStatusData": vitalStatusData.toJson(),
      };
}

class FamilyMemberTypeData {
  String familyMemberTypeId;
  String familyMemberTypeName;

  FamilyMemberTypeData({
    required this.familyMemberTypeId,
    required this.familyMemberTypeName,
  });

  factory FamilyMemberTypeData.fromJson(Map<String, dynamic> json) =>
      FamilyMemberTypeData(
        familyMemberTypeId: json["familyMemberTypeId"],
        familyMemberTypeName: json["familyMemberTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "familyMemberTypeId": familyMemberTypeId,
        "familyMemberTypeName": familyMemberTypeName,
      };
}

class TitleNameData {
  String titleNameId;
  String titleNameTh;
  String titleNameEn;

  TitleNameData({
    required this.titleNameId,
    required this.titleNameTh,
    required this.titleNameEn,
  });

  factory TitleNameData.fromJson(Map<String, dynamic> json) => TitleNameData(
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

class VitalStatusData {
  String vitalStatusId;
  String vitalStatusName;

  VitalStatusData({
    required this.vitalStatusId,
    required this.vitalStatusName,
  });

  factory VitalStatusData.fromJson(Map<String, dynamic> json) =>
      VitalStatusData(
        vitalStatusId: json["vitalStatusId"],
        vitalStatusName: json["vitalStatusName"],
      );

  Map<String, dynamic> toJson() => {
        "vitalStatusId": vitalStatusId,
        "vitalStatusName": vitalStatusName,
      };
}
