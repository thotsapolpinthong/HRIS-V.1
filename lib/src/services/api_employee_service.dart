import 'dart:convert';

import 'package:hris_app_prototype/src/model/employee/create_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_positionorganization.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_staffstatus_model.dart';
import 'package:hris_app_prototype/src/model/employee/dropdown_stafftype_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/get_shift_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/create_leave_by_hr_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_employee_approve_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_quota_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_request_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/manual_workdate_menu/manual_workdate_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_request_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/ot_menu_model/dropdown_ot_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/promote_menu_model/dropdown_promote_type_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/promote_menu_model/new_promote_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/promote_menu_model/response_promote_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/resign_menu_model/new_resign_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/resign_menu_model/response_resign_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/transfer_menu_model/new_transfer_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/transfer_menu_model/response_transfer_model.dart';
import 'package:hris_app_prototype/src/model/employee/response_employee_model.dart';
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

  // getEmployeebyId
  static Future<EmployeeDatum?> fetchDataEmployeeId(String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetEmployeeById?employeeId=$employeeId"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetEmployeeAllDataModel data =
          getEmployeeAllDataModelFromJson(response.body);
      if (data.status == true) {
        return data.employeeData[0];
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
      ResponseEmployeeModel data = responseEmployeeModelFromJson(response.body);
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

//approve
  static getEmployeeApprove(
      String parentPositionOrganizationBusinessNode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetApproverByPositionBusinessNode?parentPositionOrganizationBusinessNode=$parentPositionOrganizationBusinessNode"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      EmployeeApproveModel data = employeeApproveModelFromJson(response.body);
      return data;
    } else {}
  }

//create leave request
  static Future createLeaveRquestByHr(LeaveRequestHrModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewLeaveRequestManaul"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetLeaveRequestByIdModel data =
          getLeaveRequestByIdModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //OT Menu
  //get ot request
  // static Future<GetOvertimeRequestModel?> getOtRequestById(
  //     String employeeId) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   sharedToken = preferences.getString("token")!;
  //   final response = await http.get(
  //     Uri.parse(
  //         "http://192.168.0.205/StecApi/Hr/GetOverTimeRequestByEmployeeId?employeeId=$employeeId"),
  //     headers: {"Authorization": "Bearer $sharedToken"},
  //   );
  //   if (response.statusCode == 200) {
  //     GetOvertimeRequestModel? data =
  //         getOvertimeRequestModelFromJson(response.body);
  //     if (data.status == true) {
  //       return data;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

//dropdown ot type
  static getOtTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOverTimeTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      OverTimeTypeModel data = overTimeTypeModelFromJson(response.body);
      return data;
    } else {}
  }

  //dropdown ot request type
  static getOtRequestTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOverTimeRequestTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      OverTimeRequestTypeModel data =
          overTimeRequestTypeModelFromJson(response.body);
      return data;
    } else {}
  }

  //dropdown manualworkdate type
  static getManualWorkdateTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetManualWorkDateTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ManualWorkDateTypeModel data =
          manualWorkDateTypeModelFromJson(response.body);
      return data;
    } else {
      return null;
    }
  }

// promote
//dropdown promoteType
  static getPromoteTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPromoteTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      DropdownPromoteType data = dropdownPromoteTypeFromJson(response.body);
      return data.promoteTypeData;
    } else {
      return null;
    }
  }

  static Future newPromoteEmployee(NewPromoteModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPromote"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponsePromoteModel data = responsePromoteModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //transfer
  static Future newTransferEmployee(NewTransferModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewEmployeeTransfer"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseTransferModel data = responseTransferModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //resign
  static Future newResignEmployee(NewResignModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewEmployeeDiscontinue"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseResignModel data = responseResignModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }
}
