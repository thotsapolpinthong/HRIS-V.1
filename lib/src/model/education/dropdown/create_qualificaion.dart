import 'dart:convert';

CreateQualificaionThModel createQualificaionThModelFromJson(String str) =>
    CreateQualificaionThModel.fromJson(json.decode(str));

String createQualificaionThModelToJson(CreateQualificaionThModel data) =>
    json.encode(data.toJson());

class CreateQualificaionThModel {
  String educationQualificaionTh;

  CreateQualificaionThModel({
    required this.educationQualificaionTh,
  });

  factory CreateQualificaionThModel.fromJson(Map<String, dynamic> json) =>
      CreateQualificaionThModel(
        educationQualificaionTh: json["educationQualificaionTh"],
      );

  Map<String, dynamic> toJson() => {
        "educationQualificaionTh": educationQualificaionTh,
      };
}
