import 'dart:convert';

import 'package:hris_app_prototype/src/model/payroll/lot_management/create_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/response_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/update_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_emp_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiPayrollService {
  static String baseUrl = "http://192.168.0.205/StecApi";
  static String sharedToken = "";

  static Future createLot(CreateLotModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/Acc/NewLotNumber"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseLotModel data = responseLotModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future updateLot(UpdateLotModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/Acc/EditLotNumber"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseLotModel data = responseLotModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future<TimeRecordModel?> getTimeRecord(
      String start, String end) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/Times/GetWorkTimeToPayroll?startDate=$start&endDate=$end"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TimeRecordModel? data = timeRecordModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<TimeRecordEmpModel?> getTimeRecordEmp(
      String empId, String start, String end) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/Times/GetEmployeeWorkTime?employeeId=$empId&startDate=$start&endDate=$end"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TimeRecordEmpModel? data = timeRecordEmpModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static hrLock(String start, String end, String by) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse(
          "$baseUrl/Times/HrLockLotNumber?startDate=$start&endDate=$end&lockBy=$by"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      // body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      TimeRecordEmpModel? data = timeRecordEmpModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static getLotNumberAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/Acc/GetLotNumberAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetLotNumberDropdownModel data =
          getLotNumberDropdownModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }
}
