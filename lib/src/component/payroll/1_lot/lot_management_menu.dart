import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/1_lot/create_edit_lot.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/Login/login_model.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:intl/intl.dart';

class LotManagement extends StatefulWidget {
  const LotManagement({super.key});

  @override
  State<LotManagement> createState() => _LotManagementState();
}

class _LotManagementState extends State<LotManagement> {
  //Lot
  TextEditingController startDate = TextEditingController();
  TextEditingController finishDate = TextEditingController();
  TextEditingController salaryPaidDate = TextEditingController();
  TextEditingController otPaidDate = TextEditingController();

  GetLotNumberDropdownModel? lotNumberData;
  List<LotNumberDatum> filterLotList = [];
  List<int> yearList = [];
  final int currentYear = DateTime.now().year;
  String? lotNumberId;
  String? yearId;
  bool isLoading = true;
  bool lockHr = false;
  bool lockAcc = false;
  bool lockAccLabor = false;
  bool lockHrLabor = false;
  //sso
  int ssoPercent = 0;
  double ssoMin = 0;
  double ssoMax = 0;
  double ssoMinSalary = 0;
  double ssoMaxSalary = 0;
  ////////////////////////////////
  LoginData? _loginData;
  bool Acc = false;
  fetchDataLogin() async {
    _loginData = await ApiRolesService.getUserData();
    setState(() {
      if (_loginData != null) {
        if (_loginData?.role.roleId == 'R000000000' ||
            _loginData?.role.roleId == "R000000005") {
          Acc = true;
        } // dev,acc manager
        ;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: myredcolors,
            content: const Text("Load Role Permissions Fail")));
      }
    });
  }

  fetchData() async {
    //lotnumber data-------------
    lotNumberData = await ApiPayrollService.getLotNumberAll();
    setState(() {
      isLoading = true;
      lotNumberData;
      yearId = DateTime.now().year.toString();
      //เงื่อนไขหาเดือนล่าสุด
      if (lotNumberData != null) {
        filterLotList = lotNumberData!.lotNumberData.where((element) {
          return element.lotYear == yearId;
        }).toList();
        String maxLotMonth = '';
        for (var e in lotNumberData!.lotNumberData) {
          if (e.lotMonth.compareTo(maxLotMonth) > 0) {
            startDate.text = e.startDate.substring(0, 10);
            finishDate.text = e.finishDate.substring(0, 10);
            salaryPaidDate.text = e.salaryPaidDate.substring(0, 10);
            otPaidDate.text = e.otPaidDate.substring(0, 10);
            lotNumberId = e.lotNumberId;
            lockHr = e.lockHr == "No data" ? false : true;
            lockAcc = e.lockAcc == "No data" ? false : true;
            lockAccLabor = e.lockAccLabor == "No data" ? false : true;
            lockHrLabor = e.lockHrLabor == "No data" ? false : true;
            ssoPercent = e.ssoPercent;
            ssoMin = e.ssoMin;
            ssoMax = e.ssoMax;
            ssoMinSalary = e.ssoMinSalary;
            ssoMaxSalary = e.ssoMaxSalary;
            isLoading = false;
          }
        }
      }
    });
  }

  void createAndEditLotNumber(bool onEdit, LotNumberDatum? onLotNumber) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: mygreycolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: TitleDialog(
              title: onEdit ? "Edit Lot Number" : "Create Lot Number",
              onPressed: () {
                Navigator.pop(context);
                // fetchData();
              },
            ),
            content: SizedBox(
              width: 700,
              height: 450,
              child: onEdit == false
                  ? EditLotNumber(
                      onEdit: false,
                      onYearList: yearList,
                      fetchData: fetchData,
                    )
                  : EditLotNumber(
                      onEdit: true,
                      onYearList: yearList,
                      fetchData: fetchData,
                      onLotNumber: onLotNumber),
            ),
          );
        });
  }

  getNumberDesimal(double value) {
    String number;
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    if (value == 0) {
      number = "0";
    } else {
      number = numberFormat.format(value);
    }
    return number;
  }

  Widget valueTextfield(double value, String label, String? suffix) {
    TextEditingController data = TextEditingController();
    data.text = getNumberDesimal(value);
    return TextFormFieldGlobal(
      controller: data,
      labelText: label,
      enabled: true,
      suffixText: suffix ?? "บาท",
      readOnly: true,
    );
  }

  Widget lotMenu() {
    return Column(
      children: [
        const Text("LOT",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const Gap(10),
        Expanded(
            flex: 2,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Gap(10),
                      DropdownGlobal(
                          outlineColor: mythemecolor,
                          labeltext: 'Lot year',
                          value: yearId,
                          items: yearList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.toString(),
                              child: SizedBox(
                                  width: 58, child: Text(e.toString())),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            setState(() {
                              yearId = newValue.toString();
                              if (lotNumberData != null) {
                                filterLotList = lotNumberData!.lotNumberData
                                    .where((element) {
                                  return element.lotYear == yearId;
                                }).toList();

                                lotNumberId = null;
                                startDate.text = "";
                                finishDate.text = "";
                                salaryPaidDate.text = "";
                                otPaidDate.text = "";
                              }
                            });
                          },
                          validator: null),
                      const Gap(2),
                      DropdownGlobal(
                          outlineColor: mythemecolor,
                          labeltext: 'Lot Number',
                          value: lotNumberId,
                          items: filterLotList.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.lotNumberId,
                              child: Container(
                                  width: 58,
                                  constraints: const BoxConstraints(
                                      maxWidth: 150, minWidth: 100),
                                  child: Text("${e.lotYear} / ${e.lotMonth}")),
                            );
                          }).toList(),
                          onChanged: (newValue) async {
                            setState(() {
                              lotNumberId = newValue.toString();
                              isLoading = true;
                            });
                            lotNumberData =
                                await ApiPayrollService.getLotNumberAll();

                            Iterable<LotNumberDatum> result =
                                filterLotList.where((element) =>
                                    element.lotNumberId == newValue);
                            if (result.isNotEmpty) {
                              setState(() {
                                startDate.text =
                                    result.first.startDate.substring(0, 10);
                                finishDate.text =
                                    result.first.finishDate.substring(0, 10);
                                salaryPaidDate.text = result
                                    .first.salaryPaidDate
                                    .substring(0, 10);
                                otPaidDate.text =
                                    result.first.otPaidDate.substring(0, 10);
                                lockHr = result.first.lockHr == "No data"
                                    ? false
                                    : true;
                                lockAcc = result.first.lockAcc == "No data"
                                    ? false
                                    : true;
                                lockAccLabor =
                                    result.first.lockAccLabor == "No data"
                                        ? false
                                        : true;
                                lockHrLabor =
                                    result.first.lockHrLabor == "No data"
                                        ? false
                                        : true;
                                ssoPercent = result.first.ssoPercent;
                                ssoMin = result.first.ssoMin;
                                ssoMax = result.first.ssoMax;
                                ssoMinSalary = result.first.ssoMinSalary;
                                ssoMaxSalary = result.first.ssoMaxSalary;
                                isLoading = false;
                              });
                            }
                          },
                          validator: null),
                    ],
                  ),
                ),
              ),
            )),
        Expanded(
          flex: 5,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(10),
                    TextFormFieldDatepickGlobal(
                        controller: startDate,
                        labelText: "Start Date",
                        validatorless: null,
                        ontap: () {}),
                    const Gap(2),
                    TextFormFieldDatepickGlobal(
                        controller: finishDate,
                        labelText: "Finish Date",
                        validatorless: null,
                        ontap: () {}),
                    const Gap(2),
                    TextFormFieldDatepickGlobal(
                        controller: salaryPaidDate,
                        labelText: "Salary paid date",
                        validatorless: null,
                        ontap: () {}),
                    const Gap(2),
                    TextFormFieldDatepickGlobal(
                        controller: otPaidDate,
                        labelText: "Ot paid date",
                        validatorless: null,
                        ontap: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
        // const Gap(80)
      ],
    );
  }

  Widget ssoBar() {
    ssoPercent;
    ssoMin;
    ssoMax;
    ssoMinSalary;
    ssoMaxSalary;
    return Column(
      children: [
        const Text("SSO",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const Gap(10),
        Expanded(
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            const Expanded(
                                child: TextThai(
                              text: "ประกันสังคม :",
                              textAlign: TextAlign.center,
                            )),
                            SizedBox(
                                width: 80,
                                child: valueTextfield(
                                    double.parse(ssoPercent.toString()),
                                    "เบี้ยประกัน",
                                    "%")),
                          ],
                        ),
                        const Gap(2),
                        valueTextfield(double.parse(ssoMinSalary.toString()),
                            "ฐานเงินเดือนต่ำสุด", null),
                        const Gap(2),
                        valueTextfield(
                            double.parse(ssoMin.toString()), "หักต่ำสุด", null),
                        const Gap(2),
                        valueTextfield(double.parse(ssoMaxSalary.toString()),
                            "ฐานเงินเดือนสูงสุด", null),
                        const Gap(2),
                        valueTextfield(
                            double.parse(ssoMax.toString()), "หักสูงสุด", null)
                      ],
                    ),
                  ))),
        ),
        // const Gap(80)
      ],
    );
  }

  Widget editButton() {
    return Tooltip(
      message: 'Edit Lot number',
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(1),
            backgroundColor: myambercolors,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        onPressed: lotNumberId == null
            ? null
            : () {
                LotNumberDatum data = lotNumberData!.lotNumberData.firstWhere(
                    (element) => element.lotNumberId == lotNumberId);
                createAndEditLotNumber(true, data);
              },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget containerStatus(
      bool status, String labelText, Function()? onPressed, bool acc) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          // onTap: onPressed,
          child: SizedBox(
            width: 250,
            height: 250,
            child: Card(
              color: status == false ? Colors.white : myredcolors,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: status == false
                            ? Icon(
                                CupertinoIcons.doc_text_search,
                                size: 130,
                                color: mythemecolor,
                              )
                            : Icon(
                                Icons.lock_rounded,
                                size: 130,
                                color: mygreycolors,
                              )),
                    Text(
                      labelText,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:
                              status == false ? Colors.black87 : mygreycolors),
                    ),
                    const Gap(15)
                  ],
                ),
              ),
            ),
          ),
        ),
        const Gap(5),
        !acc
            ? SizedBox(
                height: 34,
                width: 80,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                        backgroundColor:
                            status == false ? myredcolors : mythemecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: onPressed,
                    child: const Text("Unlock")),
              )
            : Container(),
      ],
    );
  }

  Widget statusMenu() {
    return Column(
      children: [
        const Text("STATUS",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const Gap(10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  containerStatus(
                      lockHr,
                      "HR ${lockHr ? 'Lock' : 'Processing'}",
                      lotNumberId == null
                          ? null
                          : !lockHr
                              ? null
                              : () {
                                  MyDialogChoice.alertDialog(
                                      context, 'Confirm ?', () {
                                    setState(() {
                                      lockHr = !lockHr;
                                    });
                                  });
                                },
                      false),
                  const Gap(4),
                  containerStatus(
                      lockHrLabor,
                      "HR Labor ${lockHrLabor ? 'Lock' : 'Processing'}",
                      lotNumberId == null
                          ? null
                          : !lockHrLabor
                              ? null
                              : () {
                                  MyDialogChoice.alertDialog(
                                      context, 'Confirm ?', () {
                                    setState(() {
                                      lockHrLabor = !lockHrLabor;
                                    });
                                  });
                                },
                      false),
                ]),
              ),
              const Gap(5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    containerStatus(
                        lockAcc,
                        "ACC ${lockAcc ? 'Lock' : 'Processing'}",
                        lotNumberId == null
                            ? null
                            : !lockAcc
                                ? null
                                : () {
                                    MyDialogChoice.alertDialog(
                                        context, 'Confirm ?', () {
                                      setState(() {
                                        lockAcc = !lockAcc;
                                      });
                                    });
                                  },
                        true),
                    const Gap(4),
                    containerStatus(
                        lockAccLabor,
                        "ACC Labor ${lockAccLabor ? 'Lock' : 'Processing'}",
                        lotNumberId == null
                            ? null
                            : !lockAccLabor
                                ? null
                                : () {
                                    MyDialogChoice.alertDialog(
                                        context, 'Confirm ?', () {
                                      setState(() {
                                        lockAccLabor = !lockAccLabor;
                                      });
                                    });
                                  },
                        true)
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    yearList = [for (int i = currentYear - 5; i <= currentYear + 5; i++) i];
    fetchData();
    fetchDataLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        floatingActionButton: Acc
            ? //dev,acc
            MyFloatingButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  createAndEditLotNumber(false, null);
                },
              )
            : null,
        body: isLoading == true
            ? myLoadingScreen
            : Column(
                children: [
                  const Center(
                    child: Text("Lot Management",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const Gap(10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: lotMenu()),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: ssoBar()),
                                  ],
                                ),
                              ),
                              const Gap(5),
                              if (Acc)
                                SizedBox(
                                    height: 34,
                                    width: MediaQuery.of(context).size.width /
                                        2.54,
                                    child: editButton()),
                              const Gap(44)
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 1.2,
                            width: MediaQuery.of(context).size.width / 3,
                            child: statusMenu())
                      ]),
                    ),
                  ),
                ],
              ),
      ),
    ));
  }
}

class Year {
  final String id;
  final String year;

  Year({required this.id, required this.year});
}
