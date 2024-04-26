import 'dart:convert';

CreateinstituteModel createinstituteModelFromJson(String str) =>
    CreateinstituteModel.fromJson(json.decode(str));

String createinstituteModelToJson(CreateinstituteModel data) =>
    json.encode(data.toJson());

class CreateinstituteModel {
  String instituteNameTh;

  CreateinstituteModel({
    required this.instituteNameTh,
  });

  factory CreateinstituteModel.fromJson(Map<String, dynamic> json) =>
      CreateinstituteModel(
        instituteNameTh: json["instituteNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "instituteNameTh": instituteNameTh,
      };
}
