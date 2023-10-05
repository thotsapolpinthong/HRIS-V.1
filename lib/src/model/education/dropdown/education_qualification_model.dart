import 'dart:convert';

EducationQualificationModel educationQualificationModelFromJson(String str) =>
    EducationQualificationModel.fromJson(json.decode(str));

String educationQualificationModelToJson(EducationQualificationModel data) =>
    json.encode(data.toJson());

class EducationQualificationModel {
  List<EducationQualificationDatum> educationQualificationData;
  String message;
  bool status;

  EducationQualificationModel({
    required this.educationQualificationData,
    required this.message,
    required this.status,
  });

  factory EducationQualificationModel.fromJson(Map<String, dynamic> json) =>
      EducationQualificationModel(
        educationQualificationData: List<EducationQualificationDatum>.from(
            json["educationQualificationData"]
                .map((x) => EducationQualificationDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "educationQualificationData": List<dynamic>.from(
            educationQualificationData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EducationQualificationDatum {
  String educationQualificationId;
  String educationQualificaionTh;
  String educationQualificationEn;
  String educationQualificationInitialTh;
  String educationQualificationInitialEn;

  EducationQualificationDatum({
    required this.educationQualificationId,
    required this.educationQualificaionTh,
    required this.educationQualificationEn,
    required this.educationQualificationInitialTh,
    required this.educationQualificationInitialEn,
  });

  factory EducationQualificationDatum.fromJson(Map<String, dynamic> json) =>
      EducationQualificationDatum(
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
