import 'dart:convert';

GetAllDepartmentModel getAllDepartmentModelFromJson(String str) =>
    GetAllDepartmentModel.fromJson(json.decode(str));

String getAllDepartmentModelToJson(GetAllDepartmentModel data) =>
    json.encode(data.toJson());

class GetAllDepartmentModel {
  List<DepartmentDatum> departmentData;
  String message;
  bool status;

  GetAllDepartmentModel({
    required this.departmentData,
    required this.message,
    required this.status,
  });

  factory GetAllDepartmentModel.fromJson(Map<String, dynamic> json) =>
      GetAllDepartmentModel(
        departmentData: List<DepartmentDatum>.from(
            json["departmentData"].map((x) => DepartmentDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "departmentData":
            List<dynamic>.from(departmentData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class DepartmentDatum {
  String deptCode;
  String deptNameEn;
  String deptNameTh;
  String deptStatus;

  DepartmentDatum({
    required this.deptCode,
    required this.deptNameEn,
    required this.deptNameTh,
    required this.deptStatus,
  });

  factory DepartmentDatum.fromJson(Map<String, dynamic> json) =>
      DepartmentDatum(
        deptCode: json["deptCode"],
        deptNameEn: json["deptNameEn"],
        deptNameTh: json["deptNameTh"],
        deptStatus: json["deptStatus"],
      );

  Map<String, dynamic> toJson() => {
        "deptCode": deptCode,
        "deptNameEn": deptNameEn,
        "deptNameTh": deptNameTh,
        "deptStatus": deptStatus,
      };
}
