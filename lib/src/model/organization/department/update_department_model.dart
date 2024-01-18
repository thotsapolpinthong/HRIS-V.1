import 'dart:convert';

UpdateDepartmentModel updateDepartmentModelFromJson(String str) =>
    UpdateDepartmentModel.fromJson(json.decode(str));

String updateDepartmentModelToJson(UpdateDepartmentModel data) =>
    json.encode(data.toJson());

class UpdateDepartmentModel {
  String deptCode;
  String deptNameEn;
  String deptNameTh;
  String deptStatus;
  String modifiedBy;
  String comment;

  UpdateDepartmentModel({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
    required this.deptStatus,
    required this.modifiedBy,
    required this.comment,
  });

  factory UpdateDepartmentModel.fromJson(Map<String, dynamic> json) =>
      UpdateDepartmentModel(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
        deptStatus: json["deptStatus"],
        modifiedBy: json["modifiedBy"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
        "deptStatus": deptStatus,
        "modifiedBy": modifiedBy,
        "comment": comment,
      };
}
