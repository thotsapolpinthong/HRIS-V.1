import 'dart:convert';

MajorModel majorModelFromJson(String str) =>
    MajorModel.fromJson(json.decode(str));

String majorModelToJson(MajorModel data) => json.encode(data.toJson());

class MajorModel {
  List<MajorDatum> majorData;
  String message;
  bool status;

  MajorModel({
    required this.majorData,
    required this.message,
    required this.status,
  });

  factory MajorModel.fromJson(Map<String, dynamic> json) => MajorModel(
        majorData: List<MajorDatum>.from(
            json["majorData"].map((x) => MajorDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "majorData": List<dynamic>.from(majorData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class MajorDatum {
  String majorId;
  String educationQualificationId;
  String majorTh;
  String majorEn;
  String majorInitialTh;
  String majorInitialEn;

  MajorDatum({
    required this.majorId,
    required this.educationQualificationId,
    required this.majorTh,
    required this.majorEn,
    required this.majorInitialTh,
    required this.majorInitialEn,
  });

  factory MajorDatum.fromJson(Map<String, dynamic> json) => MajorDatum(
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
