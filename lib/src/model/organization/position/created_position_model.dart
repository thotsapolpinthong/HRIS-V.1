import 'dart:convert';

CreatedPositionModel createdPositionModelFromJson(String str) =>
    CreatedPositionModel.fromJson(json.decode(str));

String createdPositionModelToJson(CreatedPositionModel data) =>
    json.encode(data.toJson());

class CreatedPositionModel {
  String positionNameTh;
  String positionNameEn;
  String jobSpecification;
  String validFrom;
  String endDate;

  CreatedPositionModel({
    required this.positionNameTh,
    required this.positionNameEn,
    required this.jobSpecification,
    required this.validFrom,
    required this.endDate,
  });

  factory CreatedPositionModel.fromJson(Map<String, dynamic> json) =>
      CreatedPositionModel(
        positionNameTh: json["positionNameTh"],
        positionNameEn: json["positionNameEn"],
        jobSpecification: json["jobSpecification"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "positionNameTh": positionNameTh,
        "positionNameEn": positionNameEn,
        "jobSpecification": jobSpecification,
        "validFrom": validFrom,
        "endDate": endDate,
      };
}
