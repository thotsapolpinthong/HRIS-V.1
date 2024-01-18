import 'dart:convert';

HolidayDataModel holidayDataModelFromJson(String str) =>
    HolidayDataModel.fromJson(json.decode(str));

String holidayDataModelToJson(HolidayDataModel data) =>
    json.encode(data.toJson());

class HolidayDataModel {
  List<HolidayDatum> holidayData;
  String message;
  bool status;

  HolidayDataModel({
    required this.holidayData,
    required this.message,
    required this.status,
  });

  factory HolidayDataModel.fromJson(Map<String, dynamic> json) =>
      HolidayDataModel(
        holidayData: List<HolidayDatum>.from(
            json["holidayData"].map((x) => HolidayDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "holidayData": List<dynamic>.from(holidayData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class HolidayDatum {
  String holidayId;
  String crop;
  String date;
  String holidayNameTh;
  String holidayNameEn;
  String validFrom;
  String endDate;
  bool holidayFlag;
  String note;

  HolidayDatum({
    required this.holidayId,
    required this.crop,
    required this.date,
    required this.holidayNameTh,
    required this.holidayNameEn,
    required this.validFrom,
    required this.endDate,
    required this.holidayFlag,
    required this.note,
  });

  factory HolidayDatum.fromJson(Map<String, dynamic> json) => HolidayDatum(
        holidayId: json["holidayId"],
        crop: json["crop"],
        date: json["date"],
        holidayNameTh: json["holidayNameTh"],
        holidayNameEn: json["holidayNameEn"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        holidayFlag: json["holidayFlag"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "holidayId": holidayId,
        "crop": crop,
        "date": date,
        "holidayNameTh": holidayNameTh,
        "holidayNameEn": holidayNameEn,
        "validFrom": validFrom,
        "endDate": endDate,
        "holidayFlag": holidayFlag,
        "note": note,
      };
}
