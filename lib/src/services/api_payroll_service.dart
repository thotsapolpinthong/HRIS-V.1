import 'dart:convert';
import 'dart:io';

import 'package:hris_app_prototype/src/model/payroll/employee_salary/create_salary_model.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/get_salary_all.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/response_create_model.dart';
import 'package:hris_app_prototype/src/model/payroll/employee_salary/update_salary_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/create_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/response_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/update_lot_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/create_tax_deduction_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/create_tax_detail_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_by_id_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_detail_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_status_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/update_tax_deduction_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/update_tax_detail_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_emp_model.dart';
import 'package:hris_app_prototype/src/model/payroll/to_payroll/time_record_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiPayrollService {
  static String baseUrl = "http://192.168.0.205/StecApi";
  static String sharedToken = "";

//lot
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

// time record
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

// salary
  static Future<EmployeeSalaryModel?> getEmpSalaryAll(int type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetEmployeeSalaryAll?employeeType=$type"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      EmployeeSalaryModel? data = employeeSalaryModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future createSalary(CreateEmployeeSalaryModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/Acc/NewEmployeeSalary"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateModel data = responseCreateModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future updateSalary(UpdateEmployeeSalaryModel? updateModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/Acc/EditEmployeeSalary"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateModel data = responseCreateModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

// Tax Deduction - Details
//dropdown
  static Future<TaxPersonalStatusModel?> getTaxPersonalStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetTaxPersonalStatus"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TaxPersonalStatusModel? data =
          taxPersonalStatusModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<TaxMaritalStatusModel?> getTaxMaritalStatus(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetTaxMaritalStatus?taxPersonalStatusId=$id"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TaxMaritalStatusModel? data =
          taxMaritalStatusModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

//get tax
  static Future<TaxDeductionModel?> getTaxDeductionAll(String year) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetTaxDeducctionAll?year=$year"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TaxDeductionModel? data = taxDeductionModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<GetTaxDeductionIdModel?> getTaxDeductionById(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetTaxDeducctionById?id=$id"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      GetTaxDeductionIdModel? data =
          getTaxDeductionIdModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future createTaxDeduction(CreateTaxDeductionModel? createModel) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.post(
      Uri.parse("$baseUrl/Acc/NewTaxDeducction"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(createModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateModel data = responseCreateModelFromJson(response.body);
      if (data.status == true) {
        return create = true;
      } else {
        return create;
      }
    } else {
      return create;
    }
  }

  static Future<TaxDetailModel?> getTaxDetailsAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse("$baseUrl/Acc/GetTaxDetailAll"),
      headers: {"Authorization": "Bearer $sharedToken"},
    );
    if (response.statusCode == 200) {
      TaxDetailModel? data = taxDetailModelFromJson(response.body);
      if (data.status == true) {
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

//update deduction
  static Future updateTaxDeduction(UpdateTaxDeductionModel? updateModel) async {
    bool update = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/Acc/EditTaxDeducction"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateModel data = responseCreateModelFromJson(response.body);
      if (data.status == true) {
        return update = true;
      } else {
        return update;
      }
    } else {
      return update;
    }
  }

//update details
  static Future updateTaxDetails(UpdateTaxDetailModel? updateModel) async {
    bool update = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.put(
      Uri.parse("$baseUrl/Acc/EditTaxDetail"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $sharedToken"
      },
      body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {
      ResponseCreateModel data = responseCreateModelFromJson(response.body);
      if (data.status == true) {
        return update = true;
      } else {
        return update;
      }
    } else {
      return update;
    }
  }

  //report
  static getWorkTimePdf(String start, String end, String code) async {
    bool create = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedToken = preferences.getString("token")!;
    final response = await http.get(
      Uri.parse(
          "$baseUrl/Times/HrDownloadWorkTimeReport?startDate=$start&endDate=$end&organizationCode=$code"),
      headers: <String, String>{
        'Content-Type': 'application/pdf ',
        "Authorization": "Bearer $sharedToken"
      },
      // body: jsonEncode(updateModel!.toJson()),
    );
    if (response.statusCode == 200) {}
  }
}

class PdfDownloader {
  static Future<String> getWorkTimePdf(
      String start, String end, String code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? sharedToken = preferences.getString("token");
    if (sharedToken == null) {
      throw Exception("Token not found in SharedPreferences");
    }

    final response = await http.get(
      Uri.parse(
          "http://192.168.0.205/StecApi/Times/HrDownloadWorkTimeReport?startDate=$start&endDate=$end&organizationCode=$code"),
      headers: <String, String>{
        'Content-Type': 'application/pdf',
        "Authorization": "Bearer $sharedToken"
      },
    );

    if (response.statusCode == 200) {
      // Get the directory to save the PDF
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/work_time_report.pdf';

      // Write the PDF to the file
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return filePath;
    } else {
      throw Exception(
          "Failed to download PDF. Status code: ${response.statusCode}");
    }
  }
}
