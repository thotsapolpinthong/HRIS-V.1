import 'dart:convert';

import 'package:hris_app_prototype/src/model/organization/department/create_department_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/delete_department_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_departmen_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/get_department_by_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/department/update_department_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/create_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/delete_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/org_type_dd_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/dropdown/parent_org_dd_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_by_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/update_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/created_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/delete_position_byid_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/dropdown_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/dropdown_position_type_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/get_position_by_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/getpositionall_model.dart';
import 'package:hris_app_prototype/src/model/organization/position/update_position_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/create_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/delete_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/dropdown_jobtitle_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/dropdown_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/dropdown_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/update_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/stucture/org_stucture.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiOrgService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

//Organization-------------------------------
//get
// dropdown
  static getParentOrgDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetParentOrganizationDropdrownAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      DropDownParentOrgModel data =
          dropDownParentOrgModelFromJson(response.body);
      return data.organizationData;
    } else {}
  }

  static getTypeOrgDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOrganizationTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      DropDownOrgTypeModel data = dropDownOrgTypeModelFromJson(response.body);
      return data.organizationTypeData;
    } else {
      return null;
    }
  }

// DataTable--
  static Future<GetOrganizationAllModel?> fetchDataTableOrganization() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOrganizationAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetOrganizationAllModel data =
          getOrganizationAllModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//Tree------------------------
  static Future<GetOrganizationStuctureModel?>
      fetchDataOrganizationStucture() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOrganizationStucture"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetOrganizationStuctureModel data =
          getOrganizationStuctureModelFromJson(response.body);
      return data;
    }
    return null;
  }

//get by id
  static Future<GetOrganizationByIdModel?> fetchDataOrganizationById() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetOrganizationById"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetOrganizationByIdModel data =
          getOrganizationByIdModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//created
  static Future createdOrganization(
      CreateOrganizationModel? createOrganization) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewOrganization"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createOrganization!.toJson()),
    );
    if (response.statusCode == 200) {
      GetOrganizationByIdModel data =
          getOrganizationByIdModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//updated
  static Future updatedOrganizationById(
      UpdateOrganizationByIdModel updateOrganization) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateOrganizationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateOrganization.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//delete
  static Future deleteOrganizationById(
      DeleteOrganizationByIdModel deleteOrganization) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteOrganizationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteOrganization.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

// Position ----------------------------
//get
  static Future<GetPositionModel?> fetchAllPosition() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPositionAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetPositionModel data = getPositionModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

//dropdown
  static getPositionDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPositionDropdrown"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetDropdownPositionModel data =
          getDropdownPositionModelFromJson(response.body);
      return data.positionData;
    } else {}
  }

  static getPositionTypeDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPositionTypeAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetDropdownPositionTypeModel data =
          getDropdownPositionTypeModelFromJson(response.body);
      return data.positionTypeData;
    } else {}
  }

//create
  static Future createdPositions(CreatedPositionModel? createdPosition) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPosition"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createdPosition!.toJson()),
    );
    if (response.statusCode == 200) {
      GetPositionByIdModel data = getPositionByIdModelFromJson(response.body);
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

  static Future updatedPositionById(
      UpdatePositionByIdModel updatedPosition) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdatePositionById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updatedPosition.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

//delete
  static Future deletePositionById(
      DeletePositionByIdModel deletePositionByIdModel) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeletePositionById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deletePositionByIdModel.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  //department -----------------
  static getdepartmentDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetDepartmentAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetAllDepartmentModel data = getAllDepartmentModelFromJson(response.body);
      return data.departmentData;
    } else {}
  }

  //get
  static Future<GetAllDepartmentModel?> fetchAllDepartment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetDepartmentAll"),
      headers: {
        "Authorization": "Bearer $sharedToken",
      },
    );
    if (response.statusCode == 200) {
      GetAllDepartmentModel data = getAllDepartmentModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  //create
  static Future createdDepartment(
      CreateDepartmentModel? createDepartment) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewDepartment"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createDepartment!.toJson()),
    );
    if (response.statusCode == 200) {
      GetDepartmentByIdModel data =
          getDepartmentByIdModelFromJson(response.body);
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
  static Future updatedDepartmentById(
      UpdateDepartmentModel updatedDepartment) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdateDepartmentById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updatedDepartment.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }
  //delete

  static Future deleteDepartmentById(
      DeleteDepartmentByIdModel deleteDepartmentById) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeleteDepartmentById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deleteDepartmentById.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }

  //Position Organization -------
//get position organization by org id

  static Future<GetPositionOrgByOrgIdModel?> fetchPositionOrgByOrgId(
      String organizationId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          '$baseUrl/GetPositionOrganizationByOrganizationId?organizationId=$organizationId'),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetPositionOrgByOrgIdModel data =
          getPositionOrgByOrgIdModelFromJson(response.body);
      if (data.status == true) {
        return data;
      }
    }
    return null;
  }

  // static Future<EmployeeData?> fetchEmployeeByPositionOrgId(
  //     String positionOrganizationId) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   sharedToken = preferences.getString("token")!;
  //   var response = await http.get(
  //     Uri.parse(
  //         '$baseUrl/GetEmployeeByPositionOrganizationId?positionOrganizationId=$positionOrganizationId'),
  //     headers: {"Authorization": "Bearer $sharedToken"},
  //   );
  //   if (response.statusCode == 200) {
  //     GetEmployeeByPositionOrgId data =
  //         getEmployeeByPositionOrgIdFromJson(response.body);
  //     if (data.status == true) {
  //       return data.employeeData;
  //     }
  //   }
  //   return null;
  // }

//dropdown
  static getJobtitleDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetJobTitleAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetDropdownJobtitleModel data =
          getDropdownJobtitleModelFromJson(response.body);
      return data.jobTitleData;
    } else {}
  }

  static getPositionOrgDropdown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse("$baseUrl/GetPositionOrganizationFordropdown"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      PositionOrganizationDropdownModel data =
          positionOrganizationDropdownModelFromJson(response.body);
      return data.positionOrganizationData;
    } else {}
  }

  static getPositionOrgByIdDropdown(String organizationCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          "$baseUrl/GetPositionOrganizationByOrganizationCodedropdown?organizationCode=$organizationCode"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetPositionOrgByIdDropdownModel data =
          getPositionOrgByIdDropdownModelFromJson(response.body);
      return data.positionOrganizationData;
    } else {}
  }

  //create
  static Future createPositionOrg(
      CreatePositionOrganizationModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPositionOrganization"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      GetPositionOrgByIdModel data =
          getPositionOrgByIdModelFromJson(response.body);
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
  static Future updatedPositionOrg(UpdatePositionOrgModel updated) async {
    bool isUpdate = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.put(
      Uri.parse("$baseUrl/UpdatePositionOrganizationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updated.toJson()),
    );
    if (response.statusCode == 200) {
      isUpdate = true;
      return isUpdate;
    } else {
      return isUpdate;
    }
  }

  //delete
  static Future deletePositionOrgById(
      DeletePositionOrgByIdModel deletePositionOrgById) async {
    bool isdel = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    var response = await http.delete(
      Uri.parse("$baseUrl/DeletePositionOrganizationById"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(deletePositionOrgById.toJson()),
    );
    if (response.statusCode == 200) {
      isdel = true;
      return isdel;
    } else {
      return isdel;
    }
  }
}
