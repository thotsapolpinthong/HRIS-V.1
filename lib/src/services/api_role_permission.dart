import 'dart:convert';

import 'package:hris_app_prototype/src/model/response_modeld.dart';
import 'package:hris_app_prototype/src/model/role_permission/permission/create_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/permission/permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/permission/response_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/assign_role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/edit_role_permission.dart';
import 'package:hris_app_prototype/src/model/role_permission/role_permission/role_permission_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/create_roles_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/update_roles_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiRolesService {
  static String baseUrl = "http://192.168.0.205/StecApi/Hr";
  static String sharedToken = "";

//permission
  static Future<PermissionModel?> getPermissionData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetPermissionAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      PermissionModel? data = permissionModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future createPermission(CreatePermissionModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewPermission"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponsePermissionModel data =
          responsePermissionModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

//Roles
  static Future<RolesModel?> getRolesData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/GetRoleAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      RolesModel? data = rolesModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future createRoles(CreateRolesModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/NewRole"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseModel data = responseModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future updateRoles(UpdateRolesModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/EditRole"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseModel data = responseModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  //role permissions
  static Future<RolePermissionsModel?> getRolePermissionData(
      String roleId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/GetRolePermissionByRoleId?positionOrganizationId=$roleId"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      RolePermissionsModel? data = rolePermissionsModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future createRolePermissions(
      AssignRolePermissionsModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/AssignRolePermission"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      RolePermissionsModel data = rolePermissionsModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future EditRolePermissions(
      EditRolePermissionsModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/EditRolePermission"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      RolePermissionsModel data = rolePermissionsModelFromJson(response.body);
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
