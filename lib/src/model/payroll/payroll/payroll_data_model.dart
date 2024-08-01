import 'dart:convert';

PayrollDataModel payrollDataModelFromJson(String str) =>
    PayrollDataModel.fromJson(json.decode(str));

String payrollDataModelToJson(PayrollDataModel data) =>
    json.encode(data.toJson());

class PayrollDataModel {
  List<PayrollDatum> payrollData;
  String message;
  bool status;

  PayrollDataModel({
    required this.payrollData,
    required this.message,
    required this.status,
  });

  factory PayrollDataModel.fromJson(Map<String, dynamic> json) =>
      PayrollDataModel(
        payrollData: List<PayrollDatum>.from(
            json["payrollData"].map((x) => PayrollDatum.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "payrollData": List<dynamic>.from(payrollData.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PayrollDatum {
  String lotYear;
  String lotMonth;
  String idCard;
  String employeeId;
  String firstName;
  String lastName;
  String organizationCode;
  String positionName;
  String staffType;
  double salary;
  double wage;
  double workAmount;
  double normalOt;
  double normalOtWage;
  double holidayOt;
  double holidayOtWage;
  double workHoliday;
  double workHolidayWage;
  double extraWage;
  double bonus;
  double shiftFee;
  double allowance;
  double totalSalary;
  double leaveExceeds;
  double sso;
  double tax;
  double deductWage;
  double studentLoans;
  double netSalary;

  PayrollDatum({
    required this.lotYear,
    required this.lotMonth,
    required this.idCard,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.organizationCode,
    required this.positionName,
    required this.staffType,
    required this.salary,
    required this.wage,
    required this.workAmount,
    required this.normalOt,
    required this.normalOtWage,
    required this.holidayOt,
    required this.holidayOtWage,
    required this.workHoliday,
    required this.workHolidayWage,
    required this.extraWage,
    required this.bonus,
    required this.shiftFee,
    required this.allowance,
    required this.totalSalary,
    required this.leaveExceeds,
    required this.sso,
    required this.tax,
    required this.deductWage,
    required this.studentLoans,
    required this.netSalary,
  });

  factory PayrollDatum.fromJson(Map<String, dynamic> json) => PayrollDatum(
        lotYear: json["lotYear"],
        lotMonth: json["lotMonth"],
        idCard: json["idCard"],
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        organizationCode: json["organizationCode"],
        positionName: json["positionName"],
        staffType: json["staffType"],
        salary: json["salary"],
        wage: json["wage"],
        workAmount: json["workAmount"].toDouble(),
        normalOt: json["normalOt"],
        normalOtWage: json["normalOtWage"],
        holidayOt: json["holidayOt"],
        holidayOtWage: json["holidayOtWage"],
        workHoliday: json["workHoliday"],
        workHolidayWage: json["workHolidayWage"],
        extraWage: json["extraWage"],
        bonus: json["bonus"],
        shiftFee: json["shiftFee"],
        allowance: json["allowance"],
        totalSalary: json["totalSalary"],
        leaveExceeds: json["leaveExceeds"].toDouble(),
        sso: json["sso"],
        tax: json["tax"].toDouble(),
        deductWage: json["deductWage"],
        studentLoans: json["studentLoans"],
        netSalary: json["netSalary"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lotYear": lotYear,
        "lotMonth": lotMonth,
        "idCard": idCard,
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "organizationCode": organizationCode,
        "positionName": positionName,
        "staffType": staffType,
        "salary": salary,
        "wage": wage,
        "workAmount": workAmount,
        "normalOt": normalOt,
        "normalOtWage": normalOtWage,
        "holidayOt": holidayOt,
        "holidayOtWage": holidayOtWage,
        "workHoliday": workHoliday,
        "workHolidayWage": workHolidayWage,
        "extraWage": extraWage,
        "bonus": bonus,
        "shiftFee": shiftFee,
        "allowance": allowance,
        "totalSalary": totalSalary,
        "leaveExceeds": leaveExceeds,
        "sso": sso,
        "tax": tax,
        "deductWage": deductWage,
        "studentLoans": studentLoans,
        "netSalary": netSalary,
      };
}
