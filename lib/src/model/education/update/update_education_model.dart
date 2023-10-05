import 'dart:convert';

UpdateEducationModel updateEducationModelFromJson(String str) =>
    UpdateEducationModel.fromJson(json.decode(str));

String updateEducationModelToJson(UpdateEducationModel data) =>
    json.encode(data.toJson());

class UpdateEducationModel {
  String educationId;
  String educationLevelId;
  String personId;
  String educationQualificationId;
  String institueId;
  String countryId;
  String admissionDate;
  String graduatedDate;
  String gpa;
  String majorId;
  String modifiedBy;
  String comment;

  UpdateEducationModel({
    required this.educationId,
    required this.educationLevelId,
    required this.personId,
    required this.educationQualificationId,
    required this.institueId,
    required this.countryId,
    required this.admissionDate,
    required this.graduatedDate,
    required this.gpa,
    required this.majorId,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateEducationModel.fromJson(Map<String, dynamic> json) =>
      UpdateEducationModel(
        educationId: json["educationId"],
        educationLevelId: json["educationLevelId"],
        personId: json["personId"],
        educationQualificationId: json["educationQualificationId"],
        institueId: json["institueId"],
        countryId: json["countryId"],
        admissionDate: json["admissionDate"],
        graduatedDate: json["graduatedDate"],
        gpa: json["gpa"],
        majorId: json["majorId"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "educationId": educationId,
        "educationLevelId": educationLevelId,
        "personId": personId,
        "educationQualificationId": educationQualificationId,
        "institueId": institueId,
        "countryId": countryId,
        "admissionDate": admissionDate,
        "graduatedDate": graduatedDate,
        "gpa": gpa,
        "majorId": majorId,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
