import 'dart:convert';

UpdatePositionByIdModel updatePositionByIdModelFromJson(String str) =>
    UpdatePositionByIdModel.fromJson(json.decode(str));

String updatePositionByIdModelToJson(UpdatePositionByIdModel data) =>
    json.encode(data.toJson());

class UpdatePositionByIdModel {
  String positionId;
  String positionNameTh;
  String positionNameEn;
  String jobSpecification;
  String validFrom;
  String endDate;
  String positionStatus;
  String modifiedBy;
  String comment;

  UpdatePositionByIdModel({
    required this.positionId,
    required this.positionNameTh,
    required this.positionNameEn,
    required this.jobSpecification,
    required this.validFrom,
    required this.endDate,
    required this.positionStatus,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdatePositionByIdModel.fromJson(Map<String, dynamic> json) =>
      UpdatePositionByIdModel(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
        positionNameEn: json["positionNameEn"],
        jobSpecification: json["jobSpecification"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        positionStatus: json["positionStatus"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
        "positionNameEn": positionNameEn,
        "jobSpecification": jobSpecification,
        "validFrom": validFrom,
        "endDate": endDate,
        "positionStatus": positionStatus,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
