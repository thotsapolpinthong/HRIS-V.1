import 'dart:convert';

GetShiftByIdModel getShiftByIdModelFromJson(String str) =>
    GetShiftByIdModel.fromJson(json.decode(str));

String getShiftByIdModelToJson(GetShiftByIdModel data) =>
    json.encode(data.toJson());

class GetShiftByIdModel {
  ShiftData shiftData;
  String message;
  bool status;

  GetShiftByIdModel({
    required this.shiftData,
    required this.message,
    required this.status,
  });

  factory GetShiftByIdModel.fromJson(Map<String, dynamic> json) =>
      GetShiftByIdModel(
        shiftData: ShiftData.fromJson(json["shiftData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "shiftData": shiftData.toJson(),
        "message": message,
        "status": status,
      };
}

class ShiftData {
  String shiftId;
  String shiftName;
  String startTime;
  String endTime;
  String validFrom;
  String endDate;

  ShiftData({
    required this.shiftId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
  });

  factory ShiftData.fromJson(Map<String, dynamic> json) => ShiftData(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
      };
}
