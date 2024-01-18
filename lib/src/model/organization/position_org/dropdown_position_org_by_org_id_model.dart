import 'dart:convert';

GetPositionOrgByIdDropdownModel getPositionOrgByIdDropdownModelFromJson(
        String str) =>
    GetPositionOrgByIdDropdownModel.fromJson(json.decode(str));

String getPositionOrgByIdDropdownModelToJson(
        GetPositionOrgByIdDropdownModel data) =>
    json.encode(data.toJson());

class GetPositionOrgByIdDropdownModel {
  List<PositionOrganizationDatumById> positionOrganizationData;
  String message;
  bool status;

  GetPositionOrgByIdDropdownModel({
    required this.positionOrganizationData,
    required this.message,
    required this.status,
  });

  factory GetPositionOrgByIdDropdownModel.fromJson(Map<String, dynamic> json) =>
      GetPositionOrgByIdDropdownModel(
        positionOrganizationData: List<PositionOrganizationDatumById>.from(
            json["positionOrganizationData"]
                .map((x) => PositionOrganizationDatumById.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationData":
            List<dynamic>.from(positionOrganizationData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PositionOrganizationDatumById {
  String positionOrganizationId;
  PositionData positionData;

  PositionOrganizationDatumById({
    required this.positionOrganizationId,
    required this.positionData,
  });

  factory PositionOrganizationDatumById.fromJson(Map<String, dynamic> json) =>
      PositionOrganizationDatumById(
        positionOrganizationId: json["positionOrganizationId"],
        positionData: PositionData.fromJson(json["positionData"]),
      );

  Map<String, dynamic> toJson() => {
        "positionOrganizationId": positionOrganizationId,
        "positionData": positionData.toJson(),
      };
}

class PositionData {
  String positionId;
  String positionNameTh;

  PositionData({
    required this.positionId,
    required this.positionNameTh,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) => PositionData(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
      };
}
