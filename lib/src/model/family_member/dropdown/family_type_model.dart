import 'dart:convert';

FamilyMembersTypeModel familyMembersTypeModelFromJson(String str) =>
    FamilyMembersTypeModel.fromJson(json.decode(str));

String familyMembersTypeModelToJson(FamilyMembersTypeModel data) =>
    json.encode(data.toJson());

class FamilyMembersTypeModel {
  List<FamilyMembersTypeDatum> familyMembersTypeData;
  String message;
  bool status;

  FamilyMembersTypeModel({
    required this.familyMembersTypeData,
    required this.message,
    required this.status,
  });

  factory FamilyMembersTypeModel.fromJson(Map<String, dynamic> json) =>
      FamilyMembersTypeModel(
        familyMembersTypeData: List<FamilyMembersTypeDatum>.from(
            json["familyMembersTypeData"]
                .map((x) => FamilyMembersTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "familyMembersTypeData":
            List<dynamic>.from(familyMembersTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class FamilyMembersTypeDatum {
  String familyMemberTypeId;
  String familyMemberTypeName;

  FamilyMembersTypeDatum({
    required this.familyMemberTypeId,
    required this.familyMemberTypeName,
  });

  factory FamilyMembersTypeDatum.fromJson(Map<String, dynamic> json) =>
      FamilyMembersTypeDatum(
        familyMemberTypeId: json["familyMemberTypeId"],
        familyMemberTypeName: json["familyMemberTypeName"],
      );

  Map<String, dynamic> toJson() => {
        "familyMemberTypeId": familyMemberTypeId,
        "familyMemberTypeName": familyMemberTypeName,
      };
}
