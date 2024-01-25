import 'dart:convert';

import 'package:hris_app_prototype/src/model/employee/create_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_positionorganization.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_staffstatus_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_stafftype_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_shift_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_quota_employee_model.dart';
import 'package:http/http.dart' as http;

import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiEmployeeService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

//Employee
//DataTable--------------------------------
  static Future<GetEmployeeAllDataModel?> fetchDataTableEmployee(
      String staffStatus) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetEmployeeAll?staffStatus=$staffStatus"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetEmployeeAllDataModel data =
          getEmployeeAllDataModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  //Create
  static Future createEmployee(CreateEmployeeModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewEmployee"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetEmployeeByIdModel data = getEmployeeByIdModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //Dropdown--------------------------------
  static getStaffStatueDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetStaffStatusAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      StaffStatusDropdown data = staffStatusDropdownFromJson(response.body);
      return data.staffStatusData;
    } else {}
  }

  static getStaffTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetStaffTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      StaffTypeDropdown data = staffTypeDropdownFromJson(response.body);
      return data.staffTypeData;
    } else {}
  }

  static getShiftData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetShiftAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetShiftDataModel data = getShiftDataModelFromJson(response.body);
      return data.shiftData;
    } else {}
  }

  static getPositionOrganizationDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPositionOrganizationFordropdown"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetPositionorganizationDropdown data =
          getPositionorganizationDropdownFromJson(response.body);
      return data.positionOrganizationData;
    } else {}
  }

  //MENU
  // Leave Menu
  //get leaveQuota by ID
  static Future<LeaveQuotaByEmployeeModel?> getLeaveQuotaById(
      String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetLeaveQuotaByEmployeeId?EmployeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      LeaveQuotaByEmployeeModel? data =
          leaveQuotaByEmployeeModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
