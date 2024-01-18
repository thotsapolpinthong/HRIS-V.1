import 'dart:convert';

UpdateHolidayModel updateHolidayModelFromJson(String str) =>
    UpdateHolidayModel.fromJson(json.decode(str));

String updateHolidayModelToJson(UpdateHolidayModel data) =>
    json.encode(data.toJson());

class UpdateHolidayModel {
  String holidayId;
  String crop;
  // String date;
  String holidayNameTh;
  String holidayNameEn;
  String validFrom;
  String endDate;
  bool holidayFlag;
  String note;
  String modifiedBy;
  String comment;

  UpdateHolidayModel({
    required this.holidayId,
    required this.crop,
    // required this.date,
    required this.holidayNameTh,
    required this.holidayNameEn,
    required this.validFrom,
    required this.endDate,
    required this.holidayFlag,
    required this.note,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateHolidayModel.fromJson(Map<String, dynamic> json) =>
      UpdateHolidayModel(
        holidayId: json["holidayId"],
        crop: json["crop"],
        // date: json["date"],
        holidayNameTh: json["holidayNameTh"],
        holidayNameEn: json["holidayNameEn"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        holidayFlag: json["holidayFlag"],
        note: json["note"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "holidayId": holidayId,
        "crop": crop,
        // "date": date,
        "holidayNameTh": holidayNameTh,
        "holidayNameEn": holidayNameEn,
        "validFrom": validFrom,
        "endDate": endDate,
        "holidayFlag": holidayFlag,
        "note": note,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
