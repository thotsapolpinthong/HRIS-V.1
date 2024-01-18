import 'dart:convert';

GetDropdownPositionModel getDropdownPositionModelFromJson(String str) =>
    GetDropdownPositionModel.fromJson(json.decode(str));

String getDropdownPositionModelToJson(GetDropdownPositionModel data) =>
    json.encode(data.toJson());

class GetDropdownPositionModel {
  List<PositionDatum> positionData;
  String message;
  bool status;

  GetDropdownPositionModel({
    required this.positionData,
    required this.message,
    required this.status,
  });

  factory GetDropdownPositionModel.fromJson(Map<String, dynamic> json) =>
      GetDropdownPositionModel(
        positionData: List<PositionDatum>.from(
            json["positionData"].map((x) => PositionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionData": List<dynamic>.from(positionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PositionDatum {
  String positionId;
  String positionNameTh;

  PositionDatum({
    required this.positionId,
    required this.positionNameTh,
  });

  factory PositionDatum.fromJson(Map<String, dynamic> json) => PositionDatum(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
      };
}
