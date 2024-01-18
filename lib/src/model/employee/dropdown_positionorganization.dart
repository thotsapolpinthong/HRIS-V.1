import 'dart:convert';

GetPositionorganizationDropdown getPositionorganizationDropdownFromJson(
        String str) =>
    GetPositionorganizationDropdown.fromJson(json.decode(str));

String getPositionorganizationDropdownToJson(
        GetPositionorganizationDropdown data) =>
    json.encode(data.toJson());

class GetPositionorganizationDropdown {
  List<PositionOrganizationDatumm> positionOrganizationData;
  String message;
  bool status;

  GetPositionorganizationDropdown({
    required this.positionOrganizationData,
    required this.message,
    required this.status,
  });

  factory GetPositionorganizationDropdown.fromJson(Map<String, dynamic> json) =>
      GetPositionorganizationDropdown(
        positionOrganizationData: List<PositionOrganizationDatumm>.from(
            json["positionOrganizationData"]
                .map((x) => PositionOrganizationDatumm.fromJson(x))),
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

class PositionOrganizationDatumm {
  String positionOrganizationId;
  PositionData positionData;

  PositionOrganizationDatumm({
    required this.positionOrganizationId,
    required this.positionData,
  });

  factory PositionOrganizationDatumm.fromJson(Map<String, dynamic> json) =>
      PositionOrganizationDatumm(
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
