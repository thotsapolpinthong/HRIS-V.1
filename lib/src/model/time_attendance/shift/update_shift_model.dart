import 'dart:convert';

UpdateShiftModel updateShiftModelFromJson(String str) =>
    UpdateShiftModel.fromJson(json.decode(str));

String updateShiftModelToJson(UpdateShiftModel data) =>
    json.encode(data.toJson());

class UpdateShiftModel {
  String shiftId;
  String shiftName;
  String startTime;
  String endTime;
  String validFrom;
  String endDate;
  String shiftStatus;
  String modifiedBy;
  String comment;

  UpdateShiftModel({
    required this.shiftId,
    required this.shiftName,
    required this.startTime,
    required this.endTime,
    required this.validFrom,
    required this.endDate,
    required this.shiftStatus,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateShiftModel.fromJson(Map<String, dynamic> json) =>
      UpdateShiftModel(
        shiftId: json["shiftId"],
        shiftName: json["shiftName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        shiftStatus: json["shiftStatus"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "shiftId": shiftId,
        "shiftName": shiftName,
        "startTime": startTime,
        "endTime": endTime,
        "validFrom": validFrom,
        "endDate": endDate,
        "shiftStatus": shiftStatus,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
