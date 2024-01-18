import 'dart:convert';

GetDropdownPositionTypeModel getDropdownPositionTypeModelFromJson(String str) =>
    GetDropdownPositionTypeModel.fromJson(json.decode(str));

String getDropdownPositionTypeModelToJson(GetDropdownPositionTypeModel data) =>
    json.encode(data.toJson());

class GetDropdownPositionTypeModel {
  List<PositionTypeDatum> positionTypeData;
  String message;
  bool status;

  GetDropdownPositionTypeModel({
    required this.positionTypeData,
    required this.message,
    required this.status,
  });

  factory GetDropdownPositionTypeModel.fromJson(Map<String, dynamic> json) =>
      GetDropdownPositionTypeModel(
        positionTypeData: List<PositionTypeDatum>.from(
            json["positionTypeData"].map((x) => PositionTypeDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionTypeData":
            List<dynamic>.from(positionTypeData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PositionTypeDatum {
  String positionTypeId;
  String positionTypeNameTh;

  PositionTypeDatum({
    required this.positionTypeId,
    required this.positionTypeNameTh,
  });

  factory PositionTypeDatum.fromJson(Map<String, dynamic> json) =>
      PositionTypeDatum(
        positionTypeId: json["positionTypeId"],
        positionTypeNameTh: json["positionTypeNameTH"],
      );

  Map<String, dynamic> toJson() => {
        "positionTypeId": positionTypeId,
        "positionTypeNameTH": positionTypeNameTh,
      };
}
