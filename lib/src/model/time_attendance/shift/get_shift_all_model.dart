import 'dart:convert';

GetShiftAllModel getShiftAllModelFromJson(String str) =>
    GetShiftAllModel.fromJson(json.decode(str));

String getShiftAllModelToJson(GetShiftAllModel data) =>
    json.encode(data.toJson());

class GetShiftAllModel {
  List<ShiftDatum> shiftData;
  String message;
  bool status;

  GetShiftAllModel({
    required this.shiftData,
    required this.message,
    required this.status,
  });

  factory GetShiftAllModel.fromJson(Map<String, dynamic> json) =>
      GetShiftAllModel(
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
  String startTime;
  String endTime;
  String validFrom;
  String endDate;
  String shiftStatus;

  ShiftDatum({
    required this.shiftId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
    required this.shiftStatus,
  });

  factory ShiftDatum.fromJson(Map<String, dynamic> json) => ShiftDatum(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        shiftStatus: json["shiftStatus"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
        "shiftStatus": shiftStatus,
      };
}
