import 'dart:convert';

GetShiftDataModel getShiftDataModelFromJson(String str) =>
    GetShiftDataModel.fromJson(json.decode(str));

String getShiftDataModelToJson(GetShiftDataModel data) =>
    json.encode(data.toJson());

class GetShiftDataModel {
  List<ShiftDatum> shiftData;
  String message;
  bool status;

  GetShiftDataModel({
    required this.shiftData,
    required this.message,
    required this.status,
  });

  factory GetShiftDataModel.fromJson(Map<String, dynamic> json) =>
      GetShiftDataModel(
        shiftData: List<ShiftDatum>.from(
            json["shiftData"].map((x) => ShiftDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "shiftData": List<dynamic>.from(shiftData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class ShiftDatum {
  String shiftId;
  String shiftName;

  ShiftDatum({
    required this.shiftId,
    required this.shiftName,
  });

  factory ShiftDatum.fromJson(Map<String, dynamic> json) => ShiftDatum(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
      };
}
