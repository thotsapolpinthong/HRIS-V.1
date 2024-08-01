import 'dart:convert';

GetTaxDeductionIdModel getTaxDeductionIdModelFromJson(String str) =>
    GetTaxDeductionIdModel.fromJson(json.decode(str));

String getTaxDeductionIdModelToJson(GetTaxDeductionIdModel data) =>
    json.encode(data.toJson());

class GetTaxDeductionIdModel {
  TaxDeductionData taxDeductionData;
  String message;
  bool status;

  GetTaxDeductionIdModel({
    required this.taxDeductionData,
    required this.message,
    required this.status,
  });

  factory GetTaxDeductionIdModel.fromJson(Map<String, dynamic> json) =>
      GetTaxDeductionIdModel(
        taxDeductionData: TaxDeductionData.fromJson(json["taxDeductionData"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "taxDeductionData": taxDeductionData.toJson(),
        "message": message,
        "status": status,
      };
}

class TaxDeductionData {
  int id;
  String year;
  String taxNumber;
  String employeeId;
  String firstName;
  String lastName;
  AlStatus personalStatus;
  AlStatus maritalStatus;
  SpouseIncomeStatusData spouseIncomeStatusData;
  int totalOfChild;
  NumOfChildData numOfChildData;
  NumOfSecondChild2561Data numOfSecondChild2561Data;
  SupportData supportData;
  CrippleSupportData crippleSupportData;
  HealthInsData healthInsData;
  HealthIns10000Data healthIns10000Data;
  HealthIns15000Data healthIns15000Data;
  InvestmentData investmentData;
  EsgData esgData;
  LoanInterestData loanInterestData;
  SsoData ssoData;
  DonateEducationData donateEducationData;
  DonateOtherData donateOtherData;
  EasyEReceiptData easyEReceiptData;

  TaxDeductionData({
    required this.id,
    required this.year,
    required this.taxNumber,
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.personalStatus,
    required this.maritalStatus,
    required this.spouseIncomeStatusData,
    required this.totalOfChild,
    required this.numOfChildData,
    required this.numOfSecondChild2561Data,
    required this.supportData,
    required this.crippleSupportData,
    required this.healthInsData,
    required this.healthIns10000Data,
    required this.healthIns15000Data,
    required this.investmentData,
    required this.esgData,
    required this.loanInterestData,
    required this.ssoData,
    required this.donateEducationData,
    required this.donateOtherData,
    required this.easyEReceiptData,
  });

  factory TaxDeductionData.fromJson(Map<String, dynamic> json) =>
      TaxDeductionData(
        id: json["id"],
        year: json["year"],
        taxNumber: json["taxNumber"],
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        personalStatus: AlStatus.fromJson(json["personalStatus"]),
        maritalStatus: AlStatus.fromJson(json["maritalStatus"]),
        spouseIncomeStatusData:
            SpouseIncomeStatusData.fromJson(json["spouseIncomeStatusData"]),
        totalOfChild: json["totalOfChild"],
        numOfChildData: NumOfChildData.fromJson(json["numOfChildData"]),
        numOfSecondChild2561Data:
            NumOfSecondChild2561Data.fromJson(json["numOfSecondChild2561Data"]),
        supportData: SupportData.fromJson(json["supportData"]),
        crippleSupportData:
            CrippleSupportData.fromJson(json["crippleSupportData"]),
        healthInsData: HealthInsData.fromJson(json["healthInsData"]),
        healthIns10000Data:
            HealthIns10000Data.fromJson(json["healthIns10000Data"]),
        healthIns15000Data:
            HealthIns15000Data.fromJson(json["healthIns15000Data"]),
        investmentData: InvestmentData.fromJson(json["investmentData"]),
        esgData: EsgData.fromJson(json["esgData"]),
        loanInterestData: LoanInterestData.fromJson(json["loanInterestData"]),
        ssoData: SsoData.fromJson(json["ssoData"]),
        donateEducationData:
            DonateEducationData.fromJson(json["donateEducationData"]),
        donateOtherData: DonateOtherData.fromJson(json["donateOtherData"]),
        easyEReceiptData: EasyEReceiptData.fromJson(json["easyEReceiptData"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "taxNumber": taxNumber,
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "personalStatus": personalStatus.toJson(),
        "maritalStatus": maritalStatus.toJson(),
        "spouseIncomeStatusData": spouseIncomeStatusData.toJson(),
        "totalOfChild": totalOfChild,
        "numOfChildData": numOfChildData.toJson(),
        "numOfSecondChild2561Data": numOfSecondChild2561Data.toJson(),
        "supportData": supportData.toJson(),
        "crippleSupportData": crippleSupportData.toJson(),
        "healthInsData": healthInsData.toJson(),
        "healthIns10000Data": healthIns10000Data.toJson(),
        "healthIns15000Data": healthIns15000Data.toJson(),
        "investmentData": investmentData.toJson(),
        "esgData": esgData.toJson(),
        "loanInterestData": loanInterestData.toJson(),
        "ssoData": ssoData.toJson(),
        "donateEducationData": donateEducationData.toJson(),
        "donateOtherData": donateOtherData.toJson(),
        "easyEReceiptData": easyEReceiptData.toJson(),
      };
}

class CrippleSupportData {
  int crippleSupport;
  double amountForDeduction;

  CrippleSupportData({
    required this.crippleSupport,
    required this.amountForDeduction,
  });

  factory CrippleSupportData.fromJson(Map<String, dynamic> json) =>
      CrippleSupportData(
        crippleSupport: json["crippleSupport"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "crippleSupport": crippleSupport,
        "amountForDeduction": amountForDeduction,
      };
}

class DonateEducationData {
  double donateEducation;
  double amountForDeduction;

  DonateEducationData({
    required this.donateEducation,
    required this.amountForDeduction,
  });

  factory DonateEducationData.fromJson(Map<String, dynamic> json) =>
      DonateEducationData(
        donateEducation: json["donateEducation"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "donateEducation": donateEducation,
        "amountForDeduction": amountForDeduction,
      };
}

class DonateOtherData {
  double donateOther;
  double amountForDeduction;

  DonateOtherData({
    required this.donateOther,
    required this.amountForDeduction,
  });

  factory DonateOtherData.fromJson(Map<String, dynamic> json) =>
      DonateOtherData(
        donateOther: json["donateOther"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "donateOther": donateOther,
        "amountForDeduction": amountForDeduction,
      };
}

class EasyEReceiptData {
  double easyEReceipt;
  double amountForDeduction;

  EasyEReceiptData({
    required this.easyEReceipt,
    required this.amountForDeduction,
  });

  factory EasyEReceiptData.fromJson(Map<String, dynamic> json) =>
      EasyEReceiptData(
        easyEReceipt: json["easyEReceipt"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "easyEReceipt": easyEReceipt,
        "amountForDeduction": amountForDeduction,
      };
}

class HealthIns10000Data {
  double healthIns10000;
  double amountForDeduction;

  HealthIns10000Data({
    required this.healthIns10000,
    required this.amountForDeduction,
  });

  factory HealthIns10000Data.fromJson(Map<String, dynamic> json) =>
      HealthIns10000Data(
        healthIns10000: json["healthIns10000"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "healthIns10000": healthIns10000,
        "amountForDeduction": amountForDeduction,
      };
}

class HealthIns15000Data {
  double healthIns15000;
  double amountForDeduction;

  HealthIns15000Data({
    required this.healthIns15000,
    required this.amountForDeduction,
  });

  factory HealthIns15000Data.fromJson(Map<String, dynamic> json) =>
      HealthIns15000Data(
        healthIns15000: json["healthIns15000"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "healthIns15000": healthIns15000,
        "amountForDeduction": amountForDeduction,
      };
}

class HealthInsData {
  double dadHealthIns;
  double momHealthIns;
  double spouseDadHealthIns;
  double spouseMomHealthIns;
  double amountForDeduction;

  HealthInsData({
    required this.dadHealthIns,
    required this.momHealthIns,
    required this.spouseDadHealthIns,
    required this.spouseMomHealthIns,
    required this.amountForDeduction,
  });

  factory HealthInsData.fromJson(Map<String, dynamic> json) => HealthInsData(
        dadHealthIns: json["dadHealthIns"],
        momHealthIns: json["momHealthIns"],
        spouseDadHealthIns: json["spouseDadHealthIns"],
        spouseMomHealthIns: json["spouseMomHealthIns"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "dadHealthIns": dadHealthIns,
        "momHealthIns": momHealthIns,
        "spouseDadHealthIns": spouseDadHealthIns,
        "spouseMomHealthIns": spouseMomHealthIns,
        "amountForDeduction": amountForDeduction,
      };
}

class InvestmentData {
  double rmf;
  double mfc;
  double ssf;
  double amountForDeduction;

  InvestmentData({
    required this.rmf,
    required this.mfc,
    required this.ssf,
    required this.amountForDeduction,
  });

  factory InvestmentData.fromJson(Map<String, dynamic> json) => InvestmentData(
        rmf: json["rmf"],
        mfc: json["mfc"],
        ssf: json["ssf"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "rmf": rmf,
        "mfc": mfc,
        "ssf": ssf,
        "amountForDeduction": amountForDeduction,
      };
}

class LoanInterestData {
  double loanInterest;
  double amountForDeduction;

  LoanInterestData({
    required this.loanInterest,
    required this.amountForDeduction,
  });

  factory LoanInterestData.fromJson(Map<String, dynamic> json) =>
      LoanInterestData(
        loanInterest: json["loanInterest"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "loanInterest": loanInterest,
        "amountForDeduction": amountForDeduction,
      };
}

class AlStatus {
  int id;
  String name;

  AlStatus({
    required this.id,
    required this.name,
  });

  factory AlStatus.fromJson(Map<String, dynamic> json) => AlStatus(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class NumOfChildData {
  int numOfChild;
  double amountForDeduction;

  NumOfChildData({
    required this.numOfChild,
    required this.amountForDeduction,
  });

  factory NumOfChildData.fromJson(Map<String, dynamic> json) => NumOfChildData(
        numOfChild: json["numOfChild"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "numOfChild": numOfChild,
        "amountForDeduction": amountForDeduction,
      };
}

class NumOfSecondChild2561Data {
  int numOfSecondChild2561;
  double amountForDeduction;

  NumOfSecondChild2561Data({
    required this.numOfSecondChild2561,
    required this.amountForDeduction,
  });

  factory NumOfSecondChild2561Data.fromJson(Map<String, dynamic> json) =>
      NumOfSecondChild2561Data(
        numOfSecondChild2561: json["numOfSecondChild2561"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "numOfSecondChild2561": numOfSecondChild2561,
        "amountForDeduction": amountForDeduction,
      };
}

class SpouseIncomeStatusData {
  bool spouseIncomeStatus;
  int amountForDeduction;

  SpouseIncomeStatusData({
    required this.spouseIncomeStatus,
    required this.amountForDeduction,
  });

  factory SpouseIncomeStatusData.fromJson(Map<String, dynamic> json) =>
      SpouseIncomeStatusData(
        spouseIncomeStatus: json["spouseIncomeStatus"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "spouseIncomeStatus": spouseIncomeStatus,
        "amountForDeduction": amountForDeduction,
      };
}

class SsoData {
  double sso;
  double amountForDeduction;

  SsoData({
    required this.sso,
    required this.amountForDeduction,
  });

  factory SsoData.fromJson(Map<String, dynamic> json) => SsoData(
        sso: json["sso"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "sso": sso,
        "amountForDeduction": amountForDeduction,
      };
}

class SupportData {
  bool dadSupport;
  bool momSupport;
  bool spouseDadSupport;
  bool spouseMomSupport;
  double amountForDeduction;

  SupportData({
    required this.dadSupport,
    required this.momSupport,
    required this.spouseDadSupport,
    required this.spouseMomSupport,
    required this.amountForDeduction,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) => SupportData(
        dadSupport: json["dadSupport"],
        momSupport: json["momSupport"],
        spouseDadSupport: json["spouseDadSupport"],
        spouseMomSupport: json["spouseMomSupport"],
        amountForDeduction: (json["amountForDeduction"] is int)
            ? (json["amountForDeduction"] as int).toDouble()
            : json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "dadSupport": dadSupport,
        "momSupport": momSupport,
        "spouseDadSupport": spouseDadSupport,
        "spouseMomSupport": spouseMomSupport,
        "amountForDeduction": amountForDeduction,
      };
}

class EsgData {
  double esg;
  double amountForDeduction;

  EsgData({
    required this.esg,
    required this.amountForDeduction,
  });

  factory EsgData.fromJson(Map<String, dynamic> json) => EsgData(
        esg: json["esg"],
        amountForDeduction: json["amountForDeduction"],
      );

  Map<String, dynamic> toJson() => {
        "esg": esg,
        "amountForDeduction": amountForDeduction,
      };
}
