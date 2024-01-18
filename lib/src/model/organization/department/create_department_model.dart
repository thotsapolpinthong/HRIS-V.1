import 'dart:convert';

CreateDepartmentModel createDepartmentModelFromJson(String str) =>
    CreateDepartmentModel.fromJson(json.decode(str));

String createDepartmentModelToJson(CreateDepartmentModel data) =>
    json.encode(data.toJson());

class CreateDepartmentModel {
  String deptCode;
  String deptNameEn;
  String deptNameTh;

  CreateDepartmentModel({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
  });

  factory CreateDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CreateDepartmentModel(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
      };
}
