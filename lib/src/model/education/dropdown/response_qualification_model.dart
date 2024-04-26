import 'dart:convert';

ResponseQualificaionThModel responseQualificaionThModelFromJson(String str) =>
    ResponseQualificaionThModel.fromJson(json.decode(str));

String responseQualificaionThModelToJson(ResponseQualificaionThModel data) =>
    json.encode(data.toJson());

class ResponseQualificaionThModel {
  EducationQualificationData educationQualificationData;
  String message;
  bool status;

  ResponseQualificaionThModel({
    required this.educationQualificationData,
    required this.message,
    required this.status,
  });

  factory ResponseQualificaionThModel.fromJson(Map<String, dynamic> json) =>
      ResponseQualificaionThModel(
        educationQualificationData: EducationQualificationData.fromJson(
            json["educationQualificationData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "educationQualificationData": educationQualificationData.toJson(),
        "message": message,
        "status": status,
      };
}

class EducationQualificationData {
  String educationQualificationId;
  String educationQualificaionTh;
  String educationQualificationEn;
  String educationQualificationInitialTh;
  String educationQualificationInitialEn;

  EducationQualificationData({
    required this.educationQualificationId,
    required this.educationQualificaionTh,
    required this.educationQualificationEn,
    required this.educationQualificationInitialTh,
    required this.educationQualificationInitialEn,
  });

  factory EducationQualificationData.fromJson(Map<String, dynamic> json) =>
      EducationQualificationData(
        educationQualificationId: json["educationQualificationId"],
        educationQualificaionTh: json["educationQualificaionTh"],
        educationQualificationEn: json["educationQualificationEn"],
        educationQualificationInitialTh:
            json["educationQualificationInitialTh"],
        educationQualificationInitialEn:
            json["educationQualificationInitialEn"],
      );

  Map<String, dynamic> toJson() => {
        "educationQualificationId": educationQualificationId,
        "educationQualificaionTh": educationQualificaionTh,
        "educationQualificationEn": educationQualificationEn,
        "educationQualificationInitialTh": educationQualificationInitialTh,
        "educationQualificationInitialEn": educationQualificationInitialEn,
      };
}
