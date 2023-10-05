import 'dart:convert';

GetEducationModel getEducationModelFromJson(String str) =>
    GetEducationModel.fromJson(json.decode(str));

String getEducationModelToJson(GetEducationModel data) =>
    json.encode(data.toJson());

class GetEducationModel {
  List<EducationDatum> educationData;
  String message;
  bool status;

  GetEducationModel({
    required this.educationData,
    required this.message,
    required this.status,
  });

  factory GetEducationModel.fromJson(Map<String, dynamic> json) =>
      GetEducationModel(
        educationData: List<EducationDatum>.from(
            json["educationData"].map((x) => EducationDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "educationData":
            List<dynamic>.from(educationData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class EducationDatum {
  String educaationId;
  String personId;
  EducationLevel educationLevel;
  EducationQualification educationQualification;
  Institute institute;
  Country country;
  String admissionDate;
  String graduatedDate;
  String gpa;
  Major major;

  EducationDatum({
    required this.educaationId,
    required this.personId,
    required this.educationLevel,
    required this.educationQualification,
    required this.institute,
    required this.country,
    required this.admissionDate,
    required this.graduatedDate,
    required this.gpa,
    required this.major,
  });

  factory EducationDatum.fromJson(Map<String, dynamic> json) => EducationDatum(
        educaationId: json["educaationId"],
        personId: json["personId"],
        educationLevel: EducationLevel.fromJson(json["educationLevel"]),
        educationQualification:
            EducationQualification.fromJson(json["educationQualification"]),
        institute: Institute.fromJson(json["institute"]),
        country: Country.fromJson(json["country"]),
        admissionDate: json["admissionDate"],
        graduatedDate: json["graduatedDate"],
        gpa: json["gpa"],
        major: Major.fromJson(json["major"]),
      );

  Map<String, dynamic> toJson() => {
        "educaationId": educaationId,
        "personId": personId,
        "educationLevel": educationLevel.toJson(),
        "educationQualification": educationQualification.toJson(),
        "institute": institute.toJson(),
        "country": country.toJson(),
        "admissionDate": admissionDate,
        "graduatedDate": graduatedDate,
        "gpa": gpa,
        "major": major.toJson(),
      };
}

class Country {
  String countryId;
  String countryNameTh;
  String countryNameEn;

  Country({
    required this.countryId,
    required this.countryNameTh,
    required this.countryNameEn,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["countryId"],
        countryNameTh: json["countryNameTh"],
        countryNameEn: json["countryNameEn"],
      );

  Map<String, dynamic> toJson() => {
        "countryId": countryId,
        "countryNameTh": countryNameTh,
        "countryNameEn": countryNameEn,
      };
}

class EducationLevel {
  String educationLevelId;
  String educationLevelTh;
  String educationLevelEn;

  EducationLevel({
    required this.educationLevelId,
    required this.educationLevelTh,
    required this.educationLevelEn,
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
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

class EducationQualification {
  String educationQualificationId;
  String educationQualificaionTh;
  String educationQualificationEn;
  String educationQualificationInitialTh;
  String educationQualificationInitialEn;

  EducationQualification({
    required this.educationQualificationId,
    required this.educationQualificaionTh,
    required this.educationQualificationEn,
    required this.educationQualificationInitialTh,
    required this.educationQualificationInitialEn,
  });

  factory EducationQualification.fromJson(Map<String, dynamic> json) =>
      EducationQualification(
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

class Institute {
  String instituteId;
  String instituteNameTh;

  Institute({
    required this.instituteId,
    required this.instituteNameTh,
  });

  factory Institute.fromJson(Map<String, dynamic> json) => Institute(
        instituteId: json["instituteId"],
        instituteNameTh: json["instituteNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "instituteId": instituteId,
        "instituteNameTh": instituteNameTh,
      };
}

class Major {
  String majorId;
  String educationQualificationId;
  String majorTh;
  String majorEn;
  String majorInitialTh;
  String majorInitialEn;

  Major({
    required this.majorId,
    required this.educationQualificationId,
    required this.majorTh,
    required this.majorEn,
    required this.majorInitialTh,
    required this.majorInitialEn,
  });

  factory Major.fromJson(Map<String, dynamic> json) => Major(
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
