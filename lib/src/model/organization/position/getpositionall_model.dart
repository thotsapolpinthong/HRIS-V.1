import 'dart:convert';

GetPositionModel getPositionModelFromJson(String str) =>
    GetPositionModel.fromJson(json.decode(str));

String getPositionModelToJson(GetPositionModel data) =>
    json.encode(data.toJson());

class GetPositionModel {
  List<PositionDatum> positionData;
  String message;
  bool status;

  GetPositionModel({
    required this.positionData,
    required this.message,
    required this.status,
  });

  factory GetPositionModel.fromJson(Map<String, dynamic> json) =>
      GetPositionModel(
        positionData: List<PositionDatum>.from(
            json["positionData"].map((x) => PositionDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "positionData": List<dynamic>.from(positionData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PositionDatum {
  String positionId;
  String positionNameTh;
  String positionNameEn;
  String jobSpecification;
  String validFrom;
  String endDate;
  String positionStatus;

  PositionDatum({
    required this.positionId,
    required this.positionNameTh,
    required this.positionNameEn,
    required this.jobSpecification,
    required this.validFrom,
    required this.endDate,
    required this.positionStatus,
  });

  factory PositionDatum.fromJson(Map<String, dynamic> json) => PositionDatum(
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
