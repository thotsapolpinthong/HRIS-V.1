import 'dart:convert';

import 'package:hris_app_prototype/src/model/time_attendance/create_holiday_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/delete_holiday_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/get_holiday_data_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/create_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/get_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/lunch_break_half/update_lbh_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/create_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/delete_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/dropdown_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/get_shift_all_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/get_shift_by_id_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/create_shift_control.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/del_shift_control_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/get_shift_control.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/update_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/update_holiday_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/create_wd_sp.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/response_wd_sp.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/update_wd_sp.dart';
import 'package:hris_app_prototype/src/model/time_attendance/workdate_spacial/wd_sp_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiTimeAtendanceService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

  static Future<HolidayDataModel?> fetchHolidayDataTable() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetHolidayAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      HolidayDataModel data = holidayDataModelFromJson(response.body);
      return data;
    }
    return holidayDataModelFromJson(response.body);
  }

//Create
  static Future createHoliday(CreateHolidayModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewHoliday"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      HolidayDataModel data = holidayDataModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //Update
  static Future updatedHoliday(UpdateHolidayModel updateModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateHoliday"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  //delete
  static Future deleteHolidayById(DeleteHolidayModel deleteModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteHoliday"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteModel.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  //Shift

  //get
  static Future<GetShiftAllModel?> fetchDataTableShift() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetShiftAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetShiftAllModel data = getShiftAllModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  //create
  static Future createShift(CreateShiftModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewShift"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetShiftByIdModel data = getShiftByIdModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //update
  static Future updatedShit(UpdateShiftModel updateModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateShiftById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  //delete
  static Future deleteShiftById(DeleteShiftModel deleteModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteShiftById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteModel.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  //dropdown shift
  static getShiftDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetShiftForDropdown"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      DropdownShiftModel data = dropdownShiftModelFromJson(response.body);
      return data.shiftData;
    } else {}
  }

  // get shift control
  static Future<GetShiftControlModel?> getShiftControl(
      String shiftId, String validFrom, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Hr/GetShiftControl?shiftId=$shiftId&validFrom=$validFrom&endDate=$endDate"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      return getShiftControlModelFromJson(response.body);
    } else {
      return null;
    }
  }

//create shift control
  static Future createShiftControl(CreateShiftControlModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/EmployeeShiftAssignment"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetShiftControlModel data = getShiftControlModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //delete shift control
  static Future deleteShiftControl(DeleteShiftControlModel? deleteModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeteteShiftControl"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteModel!.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  //work spacial
  //get
  static Future<WorkdateSpaecialModel?> getDataWorkSp(
      String startDate, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrl/GetWorkDateSpecialAll?startDate=$startDate&endDate=$endDate"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      WorkdateSpaecialModel data = workdateSpaecialModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  //create WorkSp
  static Future createWorkSp(CreateWorkdateSpModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewWorkDateSpecial"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseWorkdateSpModel data =
          responseWorkdateSpModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future updateWorkSp(UpdateWorkdateSpModel updateModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/EditWorkDateSpecial"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseWorkdateSpModel data =
          responseWorkdateSpModelFromJson(response.body);
      if (data.status == true) {
        return isUpdate = true;
      } else {
        return isUpdate;
      }
    } else {
      return isUpdate;
    }
  }

  //create lunch break
  static Future createLbh(CreateLunchBreakModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewHalfHourLunchBreak"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseWorkdateSpModel data =
          responseWorkdateSpModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future updateLbh(UpdateLunchBreakModel updateModel) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/EditHalfHourLunchBreak"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseWorkdateSpModel data =
          responseWorkdateSpModelFromJson(response.body);
      if (data.status == true) {
        return isUpdate = true;
      } else {
        return isUpdate;
      }
    } else {
      return isUpdate;
    }
  }

  static Future<GetLunchBreakModel?> getDataLunchBreakHalf(
      String startDate, String endDate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrl/GetHalfHourLunchBreakAll?startDate=$startDate&endDate=$endDate"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetLunchBreakModel data = getLunchBreakModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }
}
