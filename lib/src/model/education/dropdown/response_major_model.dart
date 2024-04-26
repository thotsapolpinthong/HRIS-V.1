import 'dart:convert';

ResponseMajorModel responseMajorModelFromJson(String str) =>
    ResponseMajorModel.fromJson(json.decode(str));

String responseMajorModelToJson(ResponseMajorModel data) =>
    json.encode(data.toJson());

class ResponseMajorModel {
  MajorData majorData;
  String message;
  bool status;

  ResponseMajorModel({
    required this.majorData,
    required this.message,
    required this.status,
  });

  factory ResponseMajorModel.fromJson(Map<String, dynamic> json) =>
      ResponseMajorModel(
        majorData: MajorData.fromJson(json["majorData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "majorData": majorData.toJson(),
        "message": message,
        "status": status,
      };
}

class MajorData {
  String majorId;
  String educationQualificationId;
  String majorTh;
  String majorEn;
  String majorInitialTh;
  String majorInitialEn;

  MajorData({
    required this.majorId,
    required this.educationQualificationId,
    required this.majorTh,
    required this.majorEn,
    required this.majorInitialTh,
    required this.majorInitialEn,
  });

  factory MajorData.fromJson(Map<String, dynamic> json) => MajorData(
        majorId: json["majorId"],
        educationQualificationId: json["educationQualificationId"],
        majorTh: json["majorTh"],
        majorEn: json["majorEn"],
        majorInitialTh: json["majorInitialTh"],
        majorInitialEn: json["majorInitialEn"],
      );

  Map<String, dynamic> toJson() => {
        "majorId": majorId,
        "educationQualificationId": educationQualificationId,
        "majorTh": majorTh,
        "majorEn": majorEn,
        "majorInitialTh": majorInitialTh,
        "majorInitialEn": majorInitialEn,
      };
}
