import 'dart:convert';

import 'package:hris_app_prototype/src/model/payroll/payroll/payroll_data_model.dart';

PayrollByIdModel payrollByIdModelFromJson(String str) =>
    PayrollByIdModel.fromJson(json.decode(str));

String payrollByIdModelToJson(PayrollByIdModel data) =>
    json.encode(data.toJson());

class PayrollByIdModel {
  PayrollDatum payrollData;
  String message;
  bool status;

  PayrollByIdModel({
    required this.payrollData,
    required this.message,
    required this.status,
  });

  factory PayrollByIdModel.fromJson(Map<String, dynamic> json) =>
      PayrollByIdModel(
        payrollData: PayrollDatum.fromJson(json["payrollData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "payrollData": payrollData.toJson(),
        "message": message,
        "status": status,
      };
}
