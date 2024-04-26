import 'dart:convert';

CreateMajorModel createMajorModelFromJson(String str) =>
    CreateMajorModel.fromJson(json.decode(str));

String createMajorModelToJson(CreateMajorModel data) =>
    json.encode(data.toJson());

class CreateMajorModel {
  String educationQualificationId;
  String majorTh;

  CreateMajorModel({
    required this.educationQualificationId,
    required this.majorTh,
  });

  factory CreateMajorModel.fromJson(Map<String, dynamic> json) =>
      CreateMajorModel(
        educationQualificationId: json["educationQualificationId"],
        majorTh: json["majorTh"],
      );

  Map<String, dynamic> toJson() => {
        "educationQualificationId": educationQualificationId,
        "majorTh": majorTh,
      };
}
