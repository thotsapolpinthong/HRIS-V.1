import 'dart:convert';

EducationLevelModel educationLevelModelFromJson(String str) =>
    EducationLevelModel.fromJson(json.decode(str));

String educationLevelModelToJson(EducationLevelModel data) =>
    json.encode(data.toJson());

class EducationLevelModel {
  List<EducationLevelDatum> educationLevelData;
  String message;
  bool status;

  EducationLevelModel({
    required this.educationLevelData,
    required this.message,
    required this.status,
  });

  factory EducationLevelModel.fromJson(Map<String, dynamic> json) =>
      EducationLevelModel(
        educationLevelData: List<EducationLevelDatum>.from(
            json["educationLevelData"]
                .map((x) => EducationLevelDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "educationLevelData":
            List<dynamic>.from(educationLevelData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EducationLevelDatum {
  String educationLevelId;
  String educationLevelTh;
  String educationLevelEn;

  EducationLevelDatum({
    required this.educationLevelId,
    required this.educationLevelTh,
    required this.educationLevelEn,
  });

  factory EducationLevelDatum.fromJson(Map<String, dynamic> json) =>
      EducationLevelDatum(
        educationLevelId: json["educationLevelId"],
        educationLevelTh: json["educationLevelTh"],
        educationLevelEn: json["educationLevelEn"],
      );

  Map<String, dynamic> toJson() => {
        "educationLevelId": educationLevelId,
        "educationLevelTh": educationLevelTh,
        "educationLevelEn": educationLevelEn,
      };
}
