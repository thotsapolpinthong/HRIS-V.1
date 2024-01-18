import 'dart:convert';

GetDepartmentByIdModel getDepartmentByIdModelFromJson(String str) =>
    GetDepartmentByIdModel.fromJson(json.decode(str));

String getDepartmentByIdModelToJson(GetDepartmentByIdModel data) =>
    json.encode(data.toJson());

class GetDepartmentByIdModel {
  DepartmentData departmentData;
  String message;
  bool status;

  GetDepartmentByIdModel({
    required this.departmentData,
    required this.message,
    required this.status,
  });

  factory GetDepartmentByIdModel.fromJson(Map<String, dynamic> json) =>
      GetDepartmentByIdModel(
        departmentData: DepartmentData.fromJson(json["departmentData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "departmentData": departmentData.toJson(),
        "message": message,
        "status": status,
      };
}

class DepartmentData {
  String deptCode;
  String deptNameEn;
  String deptNameTh;

  DepartmentData({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
  });

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
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
