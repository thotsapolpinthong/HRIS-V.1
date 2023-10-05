import 'dart:convert';

CreateeducationModel createeducationModelFromJson(String str) =>
    CreateeducationModel.fromJson(json.decode(str));

String createeducationModelToJson(CreateeducationModel data) =>
    json.encode(data.toJson());

class CreateeducationModel {
  String educationLevelId;
  String personId;
  String educationQualificationId;
  String institueId;
  String countryId;
  String admissionDate;
  String graduatedDate;
  String gpa;
  String majorId;

  CreateeducationModel({
    required this.educationLevelId,
    required this.personId,
    required this.educationQualificationId,
    required this.institueId,
    required this.countryId,
    required this.admissionDate,
    required this.graduatedDate,
    required this.gpa,
    required this.majorId,
  });

  factory CreateeducationModel.fromJson(Map<String, dynamic> json) =>
      CreateeducationModel(
        educationLevelId: json["educationLevelId"],
        personId: json["personId"],
        educationQualificationId: json["educationQualificationId"],
        institueId: json["institueId"],
        countryId: json["countryId"],
        admissionDate: json["admissionDate"],
        graduatedDate: json["graduatedDate"],
        gpa: json["gpa"],
        majorId: json["majorId"],
      );

  Map<String, dynamic> toJson() => {
        "educationLevelId": educationLevelId,
        "personId": personId,
        "educationQualificationId": educationQualificationId,
        "institueId": institueId,
        "countryId": countryId,
        "admissionDate": admissionDate,
        "graduatedDate": graduatedDate,
        "gpa": gpa,
        "majorId": majorId,
      };
}
