// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/payroll/4_tax_deduction/create_update_tax_detail.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/create_tax_deduction_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_deduction_by_id_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_detail_all_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/tax_status_model.dart';
import 'package:hris_app_prototype/src/model/payroll/tax_deduction/update_tax_deduction_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTaxDeduction extends StatefulWidget {
  final bool onEdit;
  final TaxDeductionDatum? data;
  final Function() fetchData;
  final String yearId;
  const EditTaxDeduction({
    Key? key,
    required this.onEdit,
    this.data,
    required this.fetchData,
    required this.yearId,
  }) : super(key: key);

  @override
  State<EditTaxDeduction> createState() => _EditTaxDeductionState();
}

class _EditTaxDeductionState extends State<EditTaxDeduction> {
  bool isDataLoading = true;
  TextEditingController comment = TextEditingController();
  //deduction
//ข้อมูลผู้มีเงินได้
  List<TaxPersonalStatusDatum> personalStatusList = [];
  String? personalStatus;
  String? personalStatusName;
  List<TaxPersonalStatusDatum> maritalStatus = [];
  String? maritalStatusId;
  String? maritalStatusName;
//เงินได้คู่สมรส
  bool? isSpouseIncome = false;
//บุตร
  TextEditingController totalOfChild = TextEditingController();
  TextEditingController numOfChild = TextEditingController();
  TextEditingController numOfSecondChild2561 = TextEditingController();
//เลี้ยงดูบิดา มาารดา
  bool dadSupport = false;
  bool momSupport = false;
  bool spouseDadSupport = false;
  bool spouseMomSupport = false;
  //อุปการะ
  TextEditingController crippleSupport = TextEditingController();
//ประกันสุขภาพ บิดา มารดา
  TextEditingController dadHealthIns = TextEditingController();
  TextEditingController momHealthIns = TextEditingController();
  TextEditingController spouseDadHealthIns = TextEditingController();
  TextEditingController spouseMomHealthIns = TextEditingController();
//ประกันผู้มีเงินได้
  TextEditingController healthIns10000 = TextEditingController();
  TextEditingController healthIns15000 = TextEditingController();
//กองทุน
  TextEditingController mfc = TextEditingController();
  TextEditingController rmf = TextEditingController();
  TextEditingController ssf = TextEditingController();
  TextEditingController esg = TextEditingController();
//บริจาค
  TextEditingController loanInterest = TextEditingController();
  TextEditingController sso = TextEditingController();
  TextEditingController donateEducation = TextEditingController();
  TextEditingController donateOther = TextEditingController();
// โครงการรัฐ
  TextEditingController easyEReceipt = TextEditingController();
  // dropdown year
  final int currentYear = DateTime.now().year;
  List<int> yearList = [];
  String? yearId = DateTime.now().year.toString();

  TextEditingController employeeId = TextEditingController();
  TextEditingController taxNumber = TextEditingController();
//details
  List<TaxDetailDatum> taxDetailData = [];

  Future fetchData() async {
    isDataLoading = true;
    TaxDetailModel? data = await ApiPayrollService.getTaxDetailsAll();
    TaxPersonalStatusModel? d = await ApiPayrollService.getTaxPersonalStatus();
    setState(() {
      taxDetailData = data?.taxDetailData ?? [];
      personalStatusList = d?.taxPersonalStatusData ?? [];

      if (!widget.onEdit) {
        isDataLoading = false;
      } else {
        isDataLoading = true;
        fetchDataEdit();
      }
    });
  }

  Future fetchDataMarital() async {
    TaxMaritalStatusModel? d =
        await ApiPayrollService.getTaxMaritalStatus(int.parse(personalStatus!));
    setState(() {
      maritalStatus = d?.taxMaritalStatusData ?? [];
    });
  }

  Future fetchDataEdit() async {
    //data deduction on edit
    TaxDeductionData d;
    GetTaxDeductionIdModel? data =
        await ApiPayrollService.getTaxDeductionById(widget.data!.id.toString());
    if (data != null) {
      d = data.taxDeductionData;
      yearId = d.year;
      employeeId.text = d.employeeId;
      taxNumber.text = d.taxNumber.toString();
      personalStatus = d.personalStatus.id.toString();
      isSpouseIncome = d.spouseIncomeStatusData.spouseIncomeStatus;
      totalOfChild.text = d.totalOfChild.toString();
      numOfChild.text = d.numOfChildData.numOfChild.toString();
      numOfSecondChild2561.text =
          d.numOfSecondChild2561Data.numOfSecondChild2561.toString();
      dadSupport = d.supportData.dadSupport;
      momSupport = d.supportData.momSupport;
      spouseDadSupport = d.supportData.spouseDadSupport;
      spouseMomSupport = d.supportData.spouseMomSupport;
      crippleSupport.text = d.crippleSupportData.crippleSupport.toString();
      dadHealthIns.text = d.healthInsData.dadHealthIns.toString();
      momHealthIns.text = d.healthInsData.momHealthIns.toString();
      spouseDadHealthIns.text = d.healthInsData.spouseDadHealthIns.toString();
      spouseMomHealthIns.text = d.healthInsData.spouseMomHealthIns.toString();
      healthIns10000.text = d.healthIns10000Data.healthIns10000.toString();
      healthIns15000.text = d.healthIns15000Data.healthIns15000.toString();
      mfc.text = d.investmentData.mfc.toString();
      rmf.text = d.investmentData.rmf.toString();
      ssf.text = d.investmentData.ssf.toString();
      esg.text = d.esgData.esg.toString();
      loanInterest.text = d.loanInterestData.loanInterest.toString();
      sso.text = d.ssoData.sso.toString();
      donateEducation.text = d.donateEducationData.donateEducation.toString();
      donateOther.text = d.donateOtherData.donateOther.toString();
      easyEReceipt.text = d.easyEReceiptData.easyEReceipt.toString();
      maritalStatusId = d.maritalStatus.id.toString();
    }
    TaxMaritalStatusModel? e =
        await ApiPayrollService.getTaxMaritalStatus(int.parse(personalStatus!));
    setState(() {
      maritalStatus = e?.taxMaritalStatusData ?? [];
      isDataLoading = false;
    });
  }

  showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(8),
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Stack(
                children: [
                  SizedBox(
                      width: 1200,
                      height: MediaQuery.of(context).size.height - 20,
                      child: DatatableEmployee(
                        isSelected: true,
                        isSelectedOne: true,
                        typeSelected: "tax",
                        fetchDataTemp: fetchData,
                      )),
                  Positioned(
                      right: 0,
                      top: -5,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pop(context),
                          child: Transform.rotate(
                              angle: (45 * 22 / 7) / 180,
                              child: Icon(
                                Icons.add_rounded,
                                size: 32,
                                color: Colors.grey[700],
                              )))),
                ],
              ));
        });
  }

  functionUpdateDetails(TaxDetailDatum e) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: "Edit Tax Details",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            content: SizedBox(
                width: 400,
                height: 380,
                child: EditTaxDetails(
                  onEdit: true,
                  data: e,
                  fetchData: fetchData,
                )),
          );
        });
  }

  Future onCreate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    CreateTaxDeductionModel createModel = CreateTaxDeductionModel(
        year: yearId!,
        taxNumber: taxNumber.text,
        employeeId: employeeId.text,
        personalStatus: int.parse(personalStatus!),
        maritalStatus: int.parse(maritalStatusId ?? "0"),
        spouseIncomeStatus: isSpouseIncome ?? false,
        totalOfChild:
            int.parse(totalOfChild.text == "" ? "0" : totalOfChild.text),
        numOfChild: int.parse(numOfChild.text == "" ? "0" : numOfChild.text),
        numOfSecondChild2561: int.parse(
            numOfSecondChild2561.text == "" ? "0" : numOfSecondChild2561.text),
        dadSupport: dadSupport,
        momSupport: momSupport,
        spouseDadSupport: spouseDadSupport,
        spouseMomSupport: spouseMomSupport,
        crippleSupport:
            int.parse(crippleSupport.text == "" ? "0" : crippleSupport.text),
        dadHealthIns:
            double.parse(dadHealthIns.text == "" ? "0" : dadHealthIns.text),
        momHealthIns:
            double.parse(momHealthIns.text == "" ? "0" : momHealthIns.text),
        spouseDadHealthIns: double.parse(
            spouseDadHealthIns.text == "" ? "0" : spouseDadHealthIns.text),
        spouseMomHealthIns: double.parse(
            spouseMomHealthIns.text == "" ? "0" : spouseMomHealthIns.text),
        healthIns10000:
            double.parse(healthIns10000.text == "" ? "0" : healthIns10000.text),
        healthIns15000:
            double.parse(healthIns15000.text == "" ? "0" : healthIns15000.text),
        mfc: double.parse(mfc.text == "" ? "0" : mfc.text),
        rmf: double.parse(rmf.text == "" ? "0" : rmf.text),
        ssf: double.parse(ssf.text == "" ? "0" : ssf.text),
        esg: double.parse(esg.text == "" ? "0" : esg.text),
        loanInterest:
            double.parse(loanInterest.text == "" ? "0" : loanInterest.text),
        sso: double.parse(sso.text == "" ? "0" : sso.text),
        donateEducation: double.parse(
            donateEducation.text == "" ? "0" : donateEducation.text),
        donateOther:
            double.parse(donateOther.text == "" ? "0" : donateOther.text),
        easyEReceipt:
            double.parse(easyEReceipt.text == "" ? "0" : easyEReceipt.text),
        createBy: userEmployeeId);
    bool success = await ApiPayrollService.createTaxDeduction(createModel);
    alertDialog(success);
    if (success) {
      widget.fetchData();
    }
  }

  Future onUpdate() async {
    String userEmployeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userEmployeeId = preferences.getString("employeeId")!;
    UpdateTaxDeductionModel updateModel = UpdateTaxDeductionModel(
        id: widget.data!.id,
        year: yearId!,
        taxNumber: taxNumber.text,
        employeeId: employeeId.text,
        personalStatus: int.parse(personalStatus!),
        maritalStatus: int.parse(maritalStatusId!),
        spouseIncomeStatus: isSpouseIncome ?? false,
        totalOfChild:
            int.parse(totalOfChild.text == "" ? "0" : totalOfChild.text),
        numOfChild: int.parse(numOfChild.text == "" ? "0" : numOfChild.text),
        numOfSecondChild2561: int.parse(
            numOfSecondChild2561.text == "" ? "0" : numOfSecondChild2561.text),
        dadSupport: dadSupport,
        momSupport: momSupport,
        spouseDadSupport: spouseDadSupport,
        spouseMomSupport: spouseMomSupport,
        crippleSupport:
            int.parse(crippleSupport.text == "" ? "0" : crippleSupport.text),
        dadHealthIns:
            double.parse(dadHealthIns.text == "" ? "0" : dadHealthIns.text),
        momHealthIns:
            double.parse(momHealthIns.text == "" ? "0" : momHealthIns.text),
        spouseDadHealthIns: double.parse(
            spouseDadHealthIns.text == "" ? "0" : spouseDadHealthIns.text),
        spouseMomHealthIns: double.parse(
            spouseMomHealthIns.text == "" ? "0" : spouseMomHealthIns.text),
        healthIns10000:
            double.parse(healthIns10000.text == "" ? "0" : healthIns10000.text),
        healthIns15000:
            double.parse(healthIns15000.text == "" ? "0" : healthIns15000.text),
        mfc: double.parse(mfc.text == "" ? "0" : mfc.text),
        rmf: double.parse(rmf.text == "" ? "0" : rmf.text),
        ssf: double.parse(ssf.text == "" ? "0" : ssf.text),
        esg: double.parse(esg.text == "" ? "0" : esg.text),
        loanInterest:
            double.parse(loanInterest.text == "" ? "0" : loanInterest.text),
        sso: double.parse(sso.text == "" ? "0" : sso.text),
        donateEducation: double.parse(
            donateEducation.text == "" ? "0" : donateEducation.text),
        donateOther:
            double.parse(donateOther.text == "" ? "0" : donateOther.text),
        easyEReceipt:
            double.parse(easyEReceipt.text == "" ? "0" : easyEReceipt.text),
        modifyBy: userEmployeeId,
        comment: comment.text);
    bool success = await ApiPayrollService.updateTaxDeduction(updateModel);
    alertDialog(success);
    if (success) widget.fetchData();
  }

  alertDialog(bool success) {
    MyDialogSuccess.alertDialog(
        context, success, widget.onEdit, "Tax Deduction");
  }

  @override
  void initState() {
    super.initState();
    yearList = [for (int i = currentYear - 20; i <= currentYear + 5; i++) i];
    yearId = widget.yearId;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoading
        ? myLoadingScreen
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      const Gap(5),
                      const TextThai(
                          text: "รายการหักลดหย่อนภาษี",
                          textStyle: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Container(
                          color: mygreycolors,
                          child: ListView.builder(
                              // padding: const EdgeInsets.all(8),
                              itemCount: taxDetailData.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                int number = index + 1;
                                if (index == 0) {
                                  return firstTaxDetails();
                                } else {
                                  TaxDetailDatum e = taxDetailData[index - 1];
                                  TextEditingController amount =
                                      TextEditingController();
                                  amount.text = e.amount.toString();
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    margin: const EdgeInsets.all(4),
                                    height: 130,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(16)),
                                              color: mythemecolor,
                                            ),
                                            width: 80,
                                            child: Center(
                                                child: Text(
                                              number.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: mygreycolors),
                                            ))),
                                        const VerticalDivider(
                                          width: 0,
                                          thickness: 1.5,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                            child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextThai(
                                                    text: e.topic,
                                                    textStyle: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ))),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 130,
                                                          height: 50,
                                                          child:
                                                              TextFormFieldGlobal(
                                                            controller: amount,
                                                            labelText:
                                                                "ลดหย่อนสูงสุด",
                                                            enabled: false,
                                                            suffixText: "บ.",
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            functionUpdateDetails(
                                                                e);
                                                          },
                                                          child: const Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    deductionDetail(e.id)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: document())
              ],
            ),
          );
  }

  Widget firstTaxDetails() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(4),
      height: 230,
      width: double.infinity,
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16)),
                color: mythemecolor,
              ),
              width: 80,
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: mygreycolors),
              ))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextThai(
                      text: "ข้อมูลผู้มีเงินได้",
                      textStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: DropdownGlobal(
                                labeltext: 'Year',
                                value: yearId,
                                items: yearList.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.toString(),
                                    child: SizedBox(
                                        width: 50, child: Text(e.toString())),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    yearId = newValue.toString();
                                  });
                                },
                                outlineColor:
                                    (yearId == null) ? myredcolors : null)),
                        Expanded(
                          flex: 2,
                          child: TextFormFieldGlobal(
                              controller: employeeId,
                              labelText: "EmployeeId",
                              onChanged: (value) {
                                setState(() {});
                              },
                              enabled: true,
                              outlineColor:
                                  employeeId.text == "" ? myredcolors : null,
                              suffixIcon: employeeId.text == ""
                                  ? Icon(
                                      Icons.error_outline_rounded,
                                      color: myredcolors,
                                    )
                                  : null),
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsets.all(0)),
                              onPressed: () => showDialogCreate(),
                              child: Icon(
                                Icons.person_search_rounded,
                                size: 28,
                                color: mygreycolors,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Gap(3),
                  SizedBox(
                    height: 50,
                    child: TextFormFieldGlobal(
                        controller: taxNumber,
                        labelText: "Tax identification number",
                        onChanged: (value) {
                          setState(() {});
                        },
                        enabled: true,
                        outlineColor: taxNumber.text == "" ? myredcolors : null,
                        suffixIcon: taxNumber.text == ""
                            ? Icon(
                                Icons.error_outline_rounded,
                                color: myredcolors,
                              )
                            : null),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "สถานะภาพ",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 50,
                                child: DropdownGlobal(
                                    labeltext: '',
                                    value: personalStatus,
                                    items: personalStatusList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id.toString(),
                                        child: SizedBox(
                                          width: 100,
                                          child: Text(e.name.toString()),
                                        ),
                                        onTap: () {
                                          personalStatusName = e.name;
                                        },
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        personalStatus = newValue.toString();
                                        maritalStatusId = null;
                                        fetchDataMarital();
                                      });
                                    },
                                    validator: null,
                                    outlineColor: (personalStatus == "M000" ||
                                            personalStatus == null)
                                        ? myredcolors
                                        : null),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "สถานะภาพการสมรส",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 50,
                                child: DropdownGlobal(
                                    labeltext: '',
                                    value: maritalStatusId,
                                    items: maritalStatus.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id.toString(),
                                        child: SizedBox(
                                            width: 200, child: Text(e.name)),
                                        onTap: () => setState(() {
                                          maritalStatusName = e.name;
                                        }),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        maritalStatusId = newValue.toString();
                                      });
                                    },
                                    outlineColor: maritalStatusId == null &&
                                            personalStatus != "1"
                                        ? myredcolors
                                        : maritalStatusId == null
                                            ? mygreycolors
                                            : null),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget deductionDetail(String id) {
    switch (id) {
      case "TX00000":
        return Card(
          color: mygreycolors,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const TextThai(text: "คู่สมรสเป็นผู้มีเงินได้"),
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  activeColor: mythemecolor,
                  side: BorderSide(
                      color: (personalStatus == "1" && personalStatus != null ||
                              personalStatus == null)
                          ? Colors.grey
                          : mythemecolor,
                      width: 2),
                  value: isSpouseIncome,
                  onChanged: (personalStatus == "1" && personalStatus != null ||
                          personalStatus == null)
                      ? null
                      : (bool? value) {
                          setState(() {
                            isSpouseIncome = value;
                          });
                        },
                ),
              ],
            ),
          ),
        );
      case "TX00001":
        return Row(
          children: [
            Tooltip(
              message: "ระบุจำนวนบุตรรวม (คน)",
              child: MyBoxDetails(
                  text: "บุตรทั้งหมด",
                  child: SizedBox(
                      width: 100,
                      height: 50,
                      child: TextFormFieldGlobal(
                        controller: totalOfChild,
                        labelText: "",
                        enabled: true,
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        suffixText: "คน",
                      ))),
            ),
            Tooltip(
              message:
                  "ระบุจำนวนบุตร คนละ 30,000 บาท มีสิทธินำมาหักลดหย่อน (คน)",
              child: MyBoxDetails(
                text: "บุตรรับสิทธิปกติ",
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: TextFormFieldGlobal(
                    controller: numOfChild,
                    labelText: "",
                    enabled: true,
                    onChanged: (p0) {
                      setState(() {});
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                    ],
                    suffixText: "คน",
                    suffixIcon: int.parse(numOfChild.text == ""
                                    ? "0"
                                    : numOfChild.text) +
                                int.parse(numOfSecondChild2561.text == ""
                                    ? "0"
                                    : numOfSecondChild2561.text) >
                            3
                        ? Tooltip(
                            message: "ใช้สิทธิลดหย่อนบุตรได้ไม่เกิน 3 คน",
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: myredcolors,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        );
      case "TX00002":
        return Tooltip(
          message:
              "ระบุจำนวนบุตรตั้งแต่คนที่สองเป็นต้นไป ที่เกิดในหรือหลังปี พ.ศ. 2561 (คน)",
          child: MyBoxDetails(
            text: "บุตรหลังปี 2561",
            child: SizedBox(
              width: 100,
              height: 50,
              child: TextFormFieldGlobal(
                controller: numOfSecondChild2561,
                labelText: "",
                enabled: true,
                onChanged: (p0) {
                  setState(() {});
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "คน",
                suffixIcon:
                    int.parse(numOfChild.text == "" ? "0" : numOfChild.text) +
                                int.parse(numOfSecondChild2561.text == ""
                                    ? "0"
                                    : numOfSecondChild2561.text) >
                            3
                        ? Tooltip(
                            message: "ใช้สิทธิลดหย่อนบุตรได้ไม่เกิน 3 คน",
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: myredcolors,
                            ),
                          )
                        : null,
              ),
            ),
          ),
        );
      case "TX00003": //อุปการะ
        return Card(
          color: mygreycolors,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      activeColor: mythemecolor,
                      side: BorderSide(color: mythemecolor, width: 2),
                      value: dadSupport,
                      onChanged: (bool? value) {
                        setState(() {
                          dadSupport = value ?? false;
                        });
                      }),
                  const TextThai(text: "บิดา"),
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    activeColor: mythemecolor,
                    side: BorderSide(color: mythemecolor, width: 2),
                    value: momSupport,
                    onChanged: (bool? value) {
                      setState(() {
                        momSupport = value ?? false;
                      });
                    },
                  ),
                  const TextThai(text: "มารดา"),
                  const Gap(10),
                  const TextThai(text: "ของผู้มีเงินได้"),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      activeColor: mythemecolor,
                      side: BorderSide(
                          color: !isSpouseIncome! ? mythemecolor : Colors.grey,
                          width: 2),
                      value: spouseDadSupport,
                      onChanged: isSpouseIncome!
                          ? null
                          : (bool? value) {
                              setState(() {
                                spouseDadSupport = value ?? false;
                              });
                            },
                    ),
                    const TextThai(text: "บิดา"),
                    Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        activeColor: mythemecolor,
                        side: BorderSide(
                            color:
                                !isSpouseIncome! ? mythemecolor : Colors.grey,
                            width: 2),
                        value: spouseMomSupport,
                        onChanged: isSpouseIncome!
                            ? null
                            : (bool? value) {
                                setState(() {
                                  spouseMomSupport = value ?? false;
                                });
                              }),
                    const TextThai(text: "มารดา"),
                    const Gap(10),
                    const TextThai(text: "ของคู่สมรสที่ไม่มีเงินได้"),
                  ],
                ),
              ],
            ),
          ),
        );
      case "TX00004":
        return Tooltip(
          message: "ค่าอุปการะเลี้ยงดูคนพิการหรือคนทุพพลภาพ",
          child: MyBoxDetails(
            text: "จำนวนที่อุปการะ",
            child: SizedBox(
              width: 100,
              height: 50,
              child: TextFormFieldGlobal(
                  controller: crippleSupport,
                  labelText: "",
                  enabled: true,
                  onChanged: (p0) => setState(() {}),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                  ],
                  suffixText: "คน"),
            ),
          ),
        );
      case "TX00005":
        return Card(
          color: mygreycolors,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(
                    width: 125,
                    height: 42,
                    child: TextFormFieldGlobal(
                        controller: dadHealthIns,
                        labelText: "บิดา",
                        enabled: true,
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        suffixText: "บ."),
                  ),
                  SizedBox(
                    width: 125,
                    height: 42,
                    child: TextFormFieldGlobal(
                        controller: momHealthIns,
                        labelText: "มารดา",
                        enabled: true,
                        onChanged: (p0) => setState(() {}),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        suffixText: "บ."),
                  ),
                  const Gap(10),
                  const TextThai(text: "ของผู้มีเงินได้"),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 125,
                      height: 42,
                      child: TextFormFieldGlobal(
                          controller: spouseDadHealthIns,
                          labelText: "บิดา",
                          enabled: !isSpouseIncome! ? true : false,
                          onChanged: (p0) => setState(() {}),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                          ],
                          suffixText: "บ."),
                    ),
                    SizedBox(
                      width: 125,
                      height: 42,
                      child: TextFormFieldGlobal(
                          controller: spouseMomHealthIns,
                          labelText: "มารดา",
                          enabled: !isSpouseIncome! ? true : false,
                          onChanged: (p0) => setState(() {}),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                          ],
                          suffixText: "บ."),
                    ),
                    const Gap(10),
                    const TextThai(text: "ของคู่สมรสที่ไม่มีเงินได้"),
                    const Gap(10),
                  ],
                ),
              ],
            ),
          ),
        );
      case "TX00006": //เบี้ยประกันชีวิตที่จ่ายภายในปีภาษ
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: healthIns10000,
                labelText: "จำนวนเงิน",
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                enabled: true,
                suffixText: "บ."),
          ),
        );
      case "TX00007":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: healthIns15000,
                labelText: "จำนวนเงิน",
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                enabled: true,
                suffixText: "บ."),
          ),
        );
      case "TX00008":
        return Row(
          children: [
            Tooltip(
              message: "",
              child: SizedBox(
                width: 130,
                height: 50,
                child: TextFormFieldGlobal(
                    controller: mfc,
                    labelText: "กอช.",
                    enabled: true,
                    onChanged: (p0) => setState(() {}),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                    ],
                    suffixText: "บ."),
              ),
            ),
            Tooltip(
              message:
                  "ค่าซื้อหน่วยลงทุนในกองทุนรวมเพื่อการเลี้ยงชีพ\n( เฉพาะส่วนที่ไม่เกินร้อยละ 15 ของเงินได้โดยเมื่อรวมกับเงินสะสม ที่จ่ายเข้ากองทุนสำรองเลี้ยงชีพ\nหรือกองทุนการออมแห่งชาติหรือกองทุน กบข. หรือกองทุนสงเคราะห์ครูโรงเรียนเอกชนแล้ว\nไม่เกิน 500,000 บาท ) ภายในปีภาษี",
              child: SizedBox(
                width: 130,
                height: 50,
                child: TextFormFieldGlobal(
                    controller: rmf,
                    labelText: "RMF",
                    enabled: true,
                    onChanged: (p0) => setState(() {}),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                    ],
                    suffixText: "บ."),
              ),
            ),
            Tooltip(
              message: "",
              child: SizedBox(
                width: 130,
                height: 50,
                child: TextFormFieldGlobal(
                    controller: ssf,
                    labelText: "SSF",
                    enabled: true,
                    onChanged: (p0) => setState(() {}),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                    ],
                    suffixText: "บ."),
              ),
            ),
          ],
        );

      case "TX00009":
        return Tooltip(
          message: "กองทุนรวมเพื่อความยั่งยืน หรือ Thailand ESG Fund\n",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
              controller: esg,
              labelText: "ESG",
              enabled: true,
              onChanged: (p0) => setState(() {}),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
              ],
              suffixText: "บ.",
            ),
          ),
        );
      case "TX00010":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: loanInterest,
                labelText: "จำนวนเงิน",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "บ."),
          ),
        );
      case "TX00011":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: sso,
                labelText: "จำนวนเงิน",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "บ."),
          ),
        );

      case "TX00012":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: donateEducation,
                labelText: "จำนวนเงิน",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "บ."),
          ),
        );
      case "TX00013":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: donateOther,
                labelText: "จำนวนเงิน",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "บ."),
          ),
        );
      case "TX00014":
        return Tooltip(
          message: "",
          child: SizedBox(
            width: 130,
            height: 50,
            child: TextFormFieldGlobal(
                controller: easyEReceipt,
                labelText: "จำนวนเงิน",
                enabled: true,
                onChanged: (p0) => setState(() {}),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                ],
                suffixText: "บ."),
          ),
        );
      default:
        return Container();
    }
  }

//สรุปรายการ
  Widget document() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextThai(
              text: "สรุปรายการ",
              textStyle: TextStyle(fontSize: 16),
            ),
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.black54,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(3),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          if (yearId != null)
                            Text("ลดหย่อนภาษีประจำปี $yearId"),
                          if (employeeId.text != "")
                            Text("รหัสพนักงาน ${employeeId.text}"),
                          if (taxNumber.text != "")
                            Text("เลขประจำตัวผู้เสียภาษี ${taxNumber.text}"),
                          if (personalStatusName != null)
                            RichText(
                              text: TextSpan(
                                text: 'สถานะภาพ ',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: personalStatusName),
                                  if (maritalStatusName != null)
                                    TextSpan(text: "\t:\t$maritalStatusName"),
                                ],
                              ),
                            ),
                          if (personalStatus == "2")
                            Text(isSpouseIncome!
                                ? "คู่สมรสเป็นผู้มีเงินได้"
                                : "คู่สมรสไม่มีเงินได้"),
                          if (totalOfChild.text != "")
                            RichText(
                              text: TextSpan(
                                text: 'มีบุตรทั้งหมด\t',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(text: totalOfChild.text),
                                  const TextSpan(text: "\tคน"),
                                ],
                              ),
                            ),
                          if (totalOfChild.text != "")
                            Text(
                                "แบ่งเป็น สิทธิปกติ จำนวน ${numOfChild.text == "" ? "0" : numOfChild.text} คน | สิทธิหลังปี 61 จำนวน ${numOfSecondChild2561.text == "" ? "0" : numOfSecondChild2561.text} คน"),
                          if (dadSupport ||
                              momSupport ||
                              spouseDadSupport ||
                              spouseMomSupport)
                            RichText(
                              text: TextSpan(
                                text: 'อุปการะเลี้ยงดู\t',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  if (dadSupport) const TextSpan(text: "บิดา"),
                                  if (momSupport)
                                    const TextSpan(text: "\tมารดา"),
                                  const TextSpan(text: "\tของผู้มีเงินได้"),
                                  if (spouseDadSupport || spouseMomSupport)
                                    const TextSpan(text: "\tและ"),
                                  if (spouseDadSupport)
                                    const TextSpan(text: "\tบิดา"),
                                  if (spouseMomSupport)
                                    const TextSpan(text: "\tมารดา"),
                                  if (spouseDadSupport || spouseMomSupport)
                                    const TextSpan(text: "\tของคู่สมรส"),
                                ],
                              ),
                            ),
                          if (crippleSupport.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "ค่าอุปการะเลี้ยงดูคนพิการหรือคนทุพพลภาพ"),
                                  Text("${crippleSupport.text}\t\t\t\t\tคน"),
                                ],
                              ),
                            ),
                          if (dadHealthIns.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันสุขภาพบิดา ของผู้มีเงินได้"),
                                  Text("${dadHealthIns.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (momHealthIns.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันสุขภาพมารดา ของผู้มีเงินได้"),
                                  Text("${momHealthIns.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (spouseDadHealthIns.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันสุขภาพบิดา ของคู่สมรส"),
                                  Text("${spouseDadHealthIns.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (spouseMomHealthIns.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันสุขภาพมารดา ของคู่สมรส"),
                                  Text("${spouseMomHealthIns.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (healthIns10000.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันชีวิตที่จ่ายภายในปีภาษี"),
                                  Text("${healthIns10000.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (healthIns15000.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "เบี้ยประกันสุขภาพที่จ่ายภายในปีภาษี"),
                                  Text("${healthIns15000.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),

                          //rmf
                          if (rmf.text != "" ||
                              ssf.text != "" ||
                              esg.text != "" ||
                              mfc.text != "")
                            const Text("ค่าซื้อหน่วยลงทุนในกองทุนรวม"),
                          if (mfc.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("กองทุนการออมแห่งชาติ (กอช)"),
                                  Text("${mfc.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (rmf.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "กองทุนรวมเพื่อการเลี้ยงชีพ (RMF)"),
                                  Text("${rmf.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (ssf.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("กองทุนเพื่อส่งเสริมการออม (SSF)"),
                                  Text("${ssf.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (esg.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("กองทุนรวมเพื่อความยั่งยืน (ESG)"),
                                  Text("${esg.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (rmf.text != "" ||
                              ssf.text != "" ||
                              esg.text != "")
                            const Text(""),
                          //
                          if (loanInterest.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("ดอกเบี้ยเงินกู้ ที่อยู่อาศัย"),
                                  Text("${loanInterest.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (sso.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("เงินสมทบกองทุนประกันสังคม"),
                                  Text("${sso.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (donateEducation.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("บริจาคสนับสนุนการศึกษา"),
                                  Text("${donateEducation.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (donateOther.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("เงินบริจาคอื่น ๆ"),
                                  Text("${donateOther.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                          if (easyEReceipt.text != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("โครงการรัฐฯ"),
                                  Text("${easyEReceipt.text}\t\t\t\tบาท"),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: widget.onEdit
                      ? SizedBox(
                          height: 46,
                          child: TextFormFieldGlobal(
                            controller: comment,
                            labelText: "Comment",
                            enabled: true,
                            onChanged: (p0) => setState(() {}),
                            outlineColor:
                                comment.text == "" ? myredcolors : null,
                          ),
                        )
                      : Container(),
                ),
                const Gap(20),
                MySaveButtons(
                  height: 38,
                  text: "Submit",
                  onPressed: widget.onEdit && comment.text == ""
                      ? null
                      : () {
                          setState(() {
                            if (widget.onEdit) {
                              onUpdate();
                            } else {
                              onCreate();
                            }
                          });
                        },
                ),
              ],
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}

class Model {
  final int id;
  final String text;
  Model({
    required this.id,
    required this.text,
  });
}

class MyBoxDetails extends StatelessWidget {
  final String text;
  final Widget child;
  final Widget? childDetails;
  final Color? color;
  const MyBoxDetails({
    Key? key,
    required this.text,
    required this.child,
    this.childDetails,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: color ?? mygreycolors,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [Text(text), childDetails ?? Container()],
            ),
            const Gap(5),
            child
          ],
        ),
      ),
    );
  }
}

class MyCheckDetails extends StatelessWidget {
  final bool? checked;
  final Function(bool?)? onChanged;
  final String text;
  const MyCheckDetails({
    Key? key,
    required this.checked,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: mygreycolors,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextThai(text: text),
            Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                activeColor: mythemecolor,
                side: BorderSide(color: mythemecolor, width: 2),
                value: checked,
                onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
