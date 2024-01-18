import 'dart:convert';

DeleteHolidayModel deleteHolidayModelFromJson(String str) =>
    DeleteHolidayModel.fromJson(json.decode(str));

String deleteHolidayModelToJson(DeleteHolidayModel data) =>
    json.encode(data.toJson());

class DeleteHolidayModel {
  String holidayId;
  String modifiedBy;
  String comment;

  DeleteHolidayModel({
    required this.holidayId,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteHolidayModel.fromJson(Map<String, dynamic> json) =>
      DeleteHolidayModel(
        holidayId: json["holidayId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "holidayId": holidayId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
