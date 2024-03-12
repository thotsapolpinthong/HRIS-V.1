import 'dart:convert';

OtTimeCountModel otTimeCountModelFromJson(String str) =>
    OtTimeCountModel.fromJson(json.decode(str));

String otTimeCountModelToJson(OtTimeCountModel data) =>
    json.encode(data.toJson());

class OtTimeCountModel {
  OverTimeCountData overTimeCountData;
  String message;
  bool status;

  OtTimeCountModel({
    required this.overTimeCountData,
    required this.message,
    required this.status,
  });

  factory OtTimeCountModel.fromJson(Map<String, dynamic> json) =>
      OtTimeCountModel(
        overTimeCountData:
            OverTimeCountData.fromJson(json["overTimeCountData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "overTimeCountData": overTimeCountData.toJson(),
        "message": message,
        "status": status,
      };
}

class OverTimeCountData {
  double holidayTotalAmount;
  double otNormalTotalAmount;
  double otHolidayTotalAmount;
  double otSpecialTotalAmount;

  OverTimeCountData({
    required this.holidayTotalAmount,
    required this.otNormalTotalAmount,
    required this.otHolidayTotalAmount,
    required this.otSpecialTotalAmount,
  });

  factory OverTimeCountData.fromJson(Map<String, dynamic> json) =>
      OverTimeCountData(
        holidayTotalAmount: json["holidayTotalAmount"].toDouble(),
        otNormalTotalAmount: json["otNormalTotalAmount"].toDouble(),
        otHolidayTotalAmount: json["otHolidayTotalAmount"].toDouble(),
        otSpecialTotalAmount: json["otSpecialTotalAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "holidayTotalAmount": holidayTotalAmount,
        "otNormalTotalAmount": otNormalTotalAmount,
        "otHolidayTotalAmount": otHolidayTotalAmount,
        "otSpecialTotalAmount": otSpecialTotalAmount,
      };
}
