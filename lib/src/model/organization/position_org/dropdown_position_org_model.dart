import 'dart:convert';

PositionOrganizationDropdownModel positionOrganizationDropdownModelFromJson(
        String str) =>
    PositionOrganizationDropdownModel.fromJson(json.decode(str));

String positionOrganizationDropdownModelToJson(
        PositionOrganizationDropdownModel data) =>
    json.encode(data.toJson());

class PositionOrganizationDropdownModel {
  List<PositionOrganizationDatumDropdown> positionOrganizationData;
  String message;
  bool status;

  PositionOrganizationDropdownModel({
    required this.positionOrganizationData,
    required this.message,
    required this.status,
  });

  factory PositionOrganizationDropdownModel.fromJson(
          Map<String, dynamic> json) =>
      PositionOrganizationDropdownModel(
        positionOrganizationData: List<PositionOrganizationDatumDropdown>.from(
            json["positionOrganizationData"]
                .map((x) => PositionOrganizationDatumDropdown.fromJson(x))),
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

class PositionOrganizationDatumDropdown {
  String positionOrganizationId;
  PositionData positionData;

  PositionOrganizationDatumDropdown({
    required this.positionOrganizationId,
    required this.positionData,
  });

  factory PositionOrganizationDatumDropdown.fromJson(
          Map<String, dynamic> json) =>
      PositionOrganizationDatumDropdown(
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
