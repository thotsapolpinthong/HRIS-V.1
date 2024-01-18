import 'dart:convert';

CreateHolidayModel createHolidayModelFromJson(String str) =>
    CreateHolidayModel.fromJson(json.decode(str));

String createHolidayModelToJson(CreateHolidayModel data) =>
    json.encode(data.toJson());

class CreateHolidayModel {
  String crop;
  List<String> date;
  String holidayNameTh;
  String holidayNameEn;
  String validFrom;
  String endDate;
  bool holidayFlag;
  String note;

  CreateHolidayModel({
    required this.crop,
    required this.date,
    required this.holidayNameTh,
    required this.holidayNameEn,
    required this.validFrom,
    required this.endDate,
    required this.holidayFlag,
    required this.note,
  });

  factory CreateHolidayModel.fromJson(Map<String, dynamic> json) =>
      CreateHolidayModel(
        crop: json["crop"],
        date: List<String>.from(json["date"].map((x) => x)),
        holidayNameTh: json["holidayNameTh"],
        holidayNameEn: json["holidayNameEn"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        holidayFlag: json["holidayFlag"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "crop": crop,
        "date": List<dynamic>.from(date.map((x) => x)),
        "holidayNameTh": holidayNameTh,
        "holidayNameEn": holidayNameEn,
        "validFrom": validFrom,
        "endDate": endDate,
        "holidayFlag": holidayFlag,
        "note": note,
      };
}
