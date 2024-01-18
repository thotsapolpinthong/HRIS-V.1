import 'dart:convert';

GetPositionByIdModel getPositionByIdModelFromJson(String str) =>
    GetPositionByIdModel.fromJson(json.decode(str));

String getPositionByIdModelToJson(GetPositionByIdModel data) =>
    json.encode(data.toJson());

class GetPositionByIdModel {
  PositionData positionData;
  String message;
  bool status;

  GetPositionByIdModel({
    required this.positionData,
    required this.message,
    required this.status,
  });

  factory GetPositionByIdModel.fromJson(Map<String, dynamic> json) =>
      GetPositionByIdModel(
        positionData: PositionData.fromJson(json["positionData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionData": positionData.toJson(),
        "message": message,
        "status": status,
      };
}

class PositionData {
  String positionId;
  String positionNameTh;
  String positionNameEn;
  String jobSpecification;
  String validFrom;
  String endDate;
  String positionStatus;

  PositionData({
    required this.positionId,
    required this.positionNameTh,
    required this.positionNameEn,
    required this.jobSpecification,
    required this.validFrom,
    required this.endDate,
    required this.positionStatus,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) => PositionData(
        positionId: json["positionId"],
        positionNameTh: json["positionNameTh"],
        positionNameEn: json["positionNameEn"],
        jobSpecification: json["jobSpecification"],
        validFrom: json["validFrom"],
        endDate: json["endDate"],
        positionStatus: json["positionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "positionId": positionId,
        "positionNameTh": positionNameTh,
        "positionNameEn": positionNameEn,
        "jobSpecification": jobSpecification,
        "validFrom": validFrom,
        "endDate": endDate,
        "positionStatus": positionStatus,
      };
}
