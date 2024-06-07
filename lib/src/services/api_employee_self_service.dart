import 'dart:convert';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_amount_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_approve_and_reject_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/response_leave_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/manual_workdate_menu/create_manual_workdate_hr_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/self_service/leave/create_leave_request_online.dart';
import 'package:hris_app_prototype/src/model/self_service/leave/leave_request_data_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/create_ot_request_manual_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/create_ot_request_online_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_approve_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_request_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_time_count_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/return_create_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_date_model.dart';
import 'package:hris_app_prototype/src/model/self_service/user_info/get_user_info_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/create_online_manual_workdate.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/get_manual_workdate_time.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/manual_approve_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/manual_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/request_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/return_create_model.dart';
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
      ResponseLeaveModel data = responseLeaveModelFromJson(response.body);
      if (data.message == "Requester's email is empty.") {
        isUpdate == false;
      } else {
        isUpdate = true;
      }
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  static Future leaveManualReject(LeaveRejectModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/ManualRejectLeaveRequest"),
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

  //get ot request
  static Future<OtRequestModel?> getOtRequestByEmployeeId(
      String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetOverTimeRequestByEmployeeId?employeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      OtRequestModel? data = otRequestModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //createOTRequestOnline
  static Future createOTRequestOnline(CreateOtRequestModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewOverTimeRequestOnline"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ReturnOtRequestModel data = returnOtRequestModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //createOTRequestManual
  static Future createOTRequestManual(
      CreateOtRequestManualModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewOverTimeRequestManual"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ReturnOtRequestModel data = returnOtRequestModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  // get OT Request approve employee for manager
  static Future<OtRequestModel?> getOTRequestManager(
      String employeeId, String positionOrganization) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetOverTimeRequestForApprove?employeeId=$employeeId&positionOrganizationId=$positionOrganization"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      OtRequestModel? data = otRequestModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //Ot approve
  static Future otApprove(OtApproveModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/ApproveOverTimeRequest"),
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

  //Ot reject
  static Future otReject(OtRejectModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/RejectOverTimeRequest"),
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

  //Manual work date approve
  static Future manualWorkDateApprove(ManualWorkdateApproveModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/ApproveManualWorkDateRequest"),
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

  //Manual work date reject
  static Future manualWorkDateReject(ManualWorkdateRejectModel model) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/RejectManualWorkDateRequest"),
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

  //get manualworkdate request
  static Future<ManualWorkDateRequestModel?>
      getRequestManualWorkDateByEmployeeId(String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetManualWorkDateRequestByEmployeeId?employeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ManualWorkDateRequestModel? data =
          manualWorkDateRequestModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  // get manual work date Request approve employee for manager
  static Future<ManualWorkDateRequestModel?> getManualWorkDateRequestManager(
      String employeeId, String positionOrganization) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetManualWorkDateRequestForApprove?employeeId=$employeeId&positionOrganizationId=$positionOrganization"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ManualWorkDateRequestModel? data =
          manualWorkDateRequestModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

// create manual work date request "Online"
  static Future createManualWorkDateRequestOnline(
      CreateManualWorkDateOnlineModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewManualWorkDateRequestOnline"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ReturnManualWorkDateRequestModel data =
          returnManualWorkDateRequestModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  // create manual work date request "Manual"
  static Future createManualWorkDateRequestManual(
      CreateManualWorkDateManualModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewManualWorkDateRequestManual"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ReturnManualWorkDateRequestModel data =
          returnManualWorkDateRequestModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //get manual workdate by date (time stamp)
  static Future<ManualWorkDateTimeModel?> getManualWorkDateTime(
      String employeeId, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/GetManualWorkDateByDate?employeeId=$employeeId&date=$date"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      ManualWorkDateTimeModel? data =
          manualWorkDateTimeModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //get Userinfo by Employee (time stamp)
  static Future<UserInfoEmployeeModel?> getUserInfoByEmployee(
      String badgenumber, String startDate, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Times/GetUserInfoByEmployee?badgenumber=$badgenumber&startDate=$startDate&endDate=$endDate"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      UserInfoEmployeeModel? data =
          userInfoEmployeeModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //get Userinfo by date (time stamp)
  static Future<UserInfoDateModel?> getUserInfoByDate(
      String badgenumber, String date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Times/GetUserInfoByDate?badgenumber=$badgenumber&date=$date"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      UserInfoDateModel? data = userInfoDateModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

//dropdown lotnumber
  static getLotNumberDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("http://192.168.0.205/StecApi/Acc/GetLotNumberForDropdown"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetLotNumberDropdownModel data =
          getLotNumberDropdownModelFromJson(response.body);
      return data;
    } else {}
  }

  //Ot Time Count
  static Future<OtTimeCountModel?> getOtTimeCount(String employeeId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetOverTimeCount?employeeId=$employeeId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      OtTimeCountModel? data = otTimeCountModelFromJson(response.body);
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
