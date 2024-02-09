import 'dart:convert';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_amount_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_approve_and_reject_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/self_service/leave/create_leave_request_online.dart';
import 'package:hris_app_prototype/src/model/self_service/leave/leave_request_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiEmployeeSelfService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

//createLeaveRequestOnline
  static Future createLeaveRequestOnline(
      LeaveQuotaOnlineByEmployeeModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewLeaveRequestOnline"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      LeaveRequestDataModel data = leaveRequestDataModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

// get leave data employee
  static Future<LeaveRequestByEmployeeModel?> getLeaveRequestByEmployeeId(
      String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetLeaveRequestByEmployeeId?employeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      LeaveRequestByEmployeeModel? data =
          leaveRequestByEmployeeModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // get leave data approve employee for manager
  static Future<LeaveRequestByEmployeeModel?> getLeaveRequestManager(
      String employeeId, String positionOrganization) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetLeaveRequestForApprove?employeeId=$employeeId&positionOrganization=$positionOrganization"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      LeaveRequestByEmployeeModel? data =
          leaveRequestByEmployeeModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // get leave amount employee
  static Future<LeaveRequestAmountModel?> getLeaveAmountByEmployeeId(
      String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetLeaveAmount?employeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      LeaveRequestAmountModel? data =
          leaveRequestAmountModelFromJson(response.body);
      // if (data.status == true) {
      //   return data;
      // } else {
      //   return null;
      // }
      return data;
    } else {
      return null;
    }
  }

  //Leave approve
  static Future leaveApprove(LeaveApproveModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/ApproveLeaveRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  //Leave reject
  static Future leaveReject(LeaveRejectModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/RejectLeaveRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }
}
