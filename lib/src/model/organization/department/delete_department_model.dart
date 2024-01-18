import 'dart:convert';

DeleteDepartmentByIdModel deleteDepartmentByIdModelFromJson(String str) =>
    DeleteDepartmentByIdModel.fromJson(json.decode(str));

String deleteDepartmentByIdModelToJson(DeleteDepartmentByIdModel data) =>
    json.encode(data.toJson());

class DeleteDepartmentByIdModel {
  String deptCode;
  String modifiedBy;
  String comment;

  DeleteDepartmentByIdModel({
    required this.deptCode,
    required this.modifiedBy,
    required this.comment,
  });

  factory DeleteDepartmentByIdModel.fromJson(Map<String, dynamic> json) =>
      DeleteDepartmentByIdModel(
        deptCode: json["deptCode"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
