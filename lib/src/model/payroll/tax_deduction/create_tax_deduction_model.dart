import 'dart:convert';

CreateTaxDeductionModel createTaxDeductionModelFromJson(String str) =>
    CreateTaxDeductionModel.fromJson(json.decode(str));

String createTaxDeductionModelToJson(CreateTaxDeductionModel data) =>
    json.encode(data.toJson());

class CreateTaxDeductionModel {
  String year;
  String taxNumber;
  String employeeId;
  int personalStatus;
  int maritalStatus;
  bool spouseIncomeStatus;
  int totalOfChild;
  int numOfChild;
  int numOfSecondChild2561;
  bool dadSupport;
  bool momSupport;
  bool spouseDadSupport;
  bool spouseMomSupport;
  int crippleSupport;
  double dadHealthIns;
  double momHealthIns;
  double spouseDadHealthIns;
  double spouseMomHealthIns;
  double healthIns10000;
  double healthIns15000;
  double mfc;
  double rmf;
  double ssf;
  double esg;
  double loanInterest;
  double sso;
  double donateEducation;
  double donateOther;
  double easyEReceipt;
  String createBy;

  CreateTaxDeductionModel({
    required this.year,
    required this.taxNumber,
    required this.employeeId,
    required this.personalStatus,
    required this.maritalStatus,
    required this.spouseIncomeStatus,
    required this.totalOfChild,
    required this.numOfChild,
    required this.numOfSecondChild2561,
    required this.dadSupport,
    required this.momSupport,
    required this.spouseDadSupport,
    required this.spouseMomSupport,
    required this.crippleSupport,
    required this.dadHealthIns,
    required this.momHealthIns,
    required this.spouseDadHealthIns,
    required this.spouseMomHealthIns,
    required this.healthIns10000,
    required this.healthIns15000,
    required this.mfc,
    required this.rmf,
    required this.ssf,
    required this.esg,
    required this.loanInterest,
    required this.sso,
    required this.donateEducation,
    required this.donateOther,
    required this.easyEReceipt,
    required this.createBy,
  });

  factory CreateTaxDeductionModel.fromJson(Map<String, dynamic> json) =>
      CreateTaxDeductionModel(
        year: json["year"],
        taxNumber: json["taxNumber"],
        employeeId: json["employeeId"],
        personalStatus: json["personalStatus"],
        maritalStatus: json["maritalStatus"],
        spouseIncomeStatus: json["spouseIncomeStatus"],
        totalOfChild: json["totalOfChild"],
        numOfChild: json["numOfChild"],
        numOfSecondChild2561: json["numOfSecondChild2561"],
        dadSupport: json["dadSupport"],
        momSupport: json["momSupport"],
        spouseDadSupport: json["spouseDadSupport"],
        spouseMomSupport: json["spouseMomSupport"],
        crippleSupport: json["crippleSupport"],
        dadHealthIns: json["dadHealthIns"],
        momHealthIns: json["momHealthIns"],
        spouseDadHealthIns: json["spouseDadHealthIns"],
        spouseMomHealthIns: json["spouseMomHealthIns"],
        healthIns10000: json["healthIns10000"],
        healthIns15000: json["healthIns15000"],
        mfc: json["mfc"],
        rmf: json["rmf"],
        ssf: json["ssf"],
        esg: json["esg"],
        loanInterest: json["loanInterest"],
        sso: json["sso"],
        donateEducation: json["donateEducation"],
        donateOther: json["donateOther"],
        easyEReceipt: json["easyEReceipt"],
        createBy: json["createBy"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "taxNumber": taxNumber,
        "employeeId": employeeId,
        "personalStatus": personalStatus,
        "maritalStatus": maritalStatus,
        "spouseIncomeStatus": spouseIncomeStatus,
        "totalOfChild": totalOfChild,
        "numOfChild": numOfChild,
        "numOfSecondChild2561": numOfSecondChild2561,
        "dadSupport": dadSupport,
        "momSupport": momSupport,
        "spouseDadSupport": spouseDadSupport,
        "spouseMomSupport": spouseMomSupport,
        "crippleSupport": crippleSupport,
        "dadHealthIns": dadHealthIns,
        "momHealthIns": momHealthIns,
        "spouseDadHealthIns": spouseDadHealthIns,
        "spouseMomHealthIns": spouseMomHealthIns,
        "healthIns10000": healthIns10000,
        "healthIns15000": healthIns15000,
        "mfc": mfc,
        "rmf": rmf,
        "ssf": ssf,
        "esg": esg,
        "loanInterest": loanInterest,
        "sso": sso,
        "donateEducation": donateEducation,
        "donateOther": donateOther,
        "easyEReceipt": easyEReceipt,
        "createBy": createBy,
      };
}
