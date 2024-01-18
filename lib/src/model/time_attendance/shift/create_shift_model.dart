import 'dart:convert';

CreateShiftModel createShiftModelFromJson(String str) =>
    CreateShiftModel.fromJson(json.decode(str));

String createShiftModelToJson(CreateShiftModel data) =>
    json.encode(data.toJson());

class CreateShiftModel {
  String shiftName;
  String startTime;
  String endTime;
  String validFrom;
  String endDate;
  String shiftStatus;

  CreateShiftModel({
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
    required this.shiftStatus,
  });

  factory CreateShiftModel.fromJson(Map<String, dynamic> json) =>
      CreateShiftModel(
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        shiftStatus: json["shiftStatus"],
      );

  Map<String, dynamic> toJson() => {
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
        "shiftStatus": shiftStatus,
      };
}
