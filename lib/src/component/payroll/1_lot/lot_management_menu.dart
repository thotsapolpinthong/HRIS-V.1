import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/payroll/1_lot/create_edit_lot.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/payroll/lot_management/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/services/api_payroll_service.dart';

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
  List<Year> yearList = List.generate(27, (index) {
    int year = 2024 + index;
    return Year(id: year.toString(), year: year.toString());
  });
  String? lotNumberId;
  String? yearId;
  bool isLoading = true;
  bool lockHr = false;
  bool lockAcc = false;
  bool lockAccLabor = false;
  bool lockHrLabor = false;
  ////////////////////////////////

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
            startDate.text = e.startDate;
            finishDate.text = e.finishDate;
            salaryPaidDate.text = e.salaryPaidDate;
            otPaidDate.text = e.otPaidDate;
            lotNumberId = e.lotNumberId;
            lockHr = e.lockHr == "No data" ? false : true;
            lockAcc = e.lockAcc == "No data" ? false : true;
            lockAccLabor = e.lockAccLabor == "No data" ? false : true;
            lockHrLabor = e.lockHrLabor == "No data" ? false : true;
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
              title: "Create Lot Number",
              onPressed: () {
                Navigator.pop(context);
                // fetchData();
              },
            ),
            content: SizedBox(
              width: 400,
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        floatingActionButton: MyFloatingButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            createAndEditLotNumber(false, null);
          },
        ),
        body: isLoading == true
            ? myLoadingScreen
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Center(
                      child: Text("Lot Management",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const Gap(5),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: DropdownGlobal(
                                    labeltext: 'Lot year',
                                    value: yearId,
                                    items: yearList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.id,
                                        child: SizedBox(
                                            width: 58, child: Text(e.year)),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        yearId = newValue.toString();
                                        if (lotNumberData != null) {
                                          filterLotList = lotNumberData!
                                              .lotNumberData
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
                              ),
                              SizedBox(
                                width: 200,
                                child: DropdownGlobal(
                                    labeltext: 'Lot Number',
                                    value: lotNumberId,
                                    items: filterLotList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.lotNumberId,
                                        child: Container(
                                            width: 58,
                                            constraints: const BoxConstraints(
                                                maxWidth: 150, minWidth: 100),
                                            child: Text(
                                                "${e.lotYear} / ${e.lotMonth}")),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        lotNumberId = newValue.toString();
                                        Iterable<LotNumberDatum> result =
                                            filterLotList.where((element) =>
                                                element.lotNumberId ==
                                                newValue);
                                        if (result.isNotEmpty) {
                                          startDate.text =
                                              result.first.startDate.toString();
                                          finishDate.text = result
                                              .first.finishDate
                                              .toString();
                                          salaryPaidDate.text = result
                                              .first.salaryPaidDate
                                              .toString();
                                          otPaidDate.text = result
                                              .first.otPaidDate
                                              .toString();
                                          lockHr =
                                              result.first.lockHr == "No data"
                                                  ? false
                                                  : true;
                                          lockAcc =
                                              result.first.lockAcc == "No data"
                                                  ? false
                                                  : true;
                                          lockAccLabor =
                                              result.first.lockAccLabor ==
                                                      "No data"
                                                  ? false
                                                  : true;
                                          lockHrLabor =
                                              result.first.lockHrLabor ==
                                                      "No data"
                                                  ? false
                                                  : true;
                                        }
                                      });
                                    },
                                    validator: null),
                              ),
                              SizedBox(
                                width: 160,
                                child: TextFormFieldDatepickGlobal(
                                    controller: startDate,
                                    labelText: "Start Date",
                                    validatorless: null,
                                    ontap: () {}),
                              ),
                              SizedBox(
                                width: 160,
                                child: TextFormFieldDatepickGlobal(
                                    controller: finishDate,
                                    labelText: "Finish Date",
                                    validatorless: null,
                                    ontap: () {}),
                              ),
                              SizedBox(
                                width: 160,
                                child: TextFormFieldDatepickGlobal(
                                    controller: salaryPaidDate,
                                    labelText: "Salary paid date",
                                    validatorless: null,
                                    ontap: () {}),
                              ),
                              SizedBox(
                                width: 160,
                                child: TextFormFieldDatepickGlobal(
                                    controller: otPaidDate,
                                    labelText: "Ot paid date",
                                    validatorless: null,
                                    ontap: () {}),
                              ),
                              const Gap(4),
                              SizedBox(
                                height: 44,
                                width: 44,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(1),
                                        backgroundColor: myambercolors,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    onPressed: lotNumberId == null
                                        ? null
                                        : () {
                                            LotNumberDatum data = lotNumberData!
                                                .lotNumberData
                                                .firstWhere((element) =>
                                                    element.lotNumberId ==
                                                    lotNumberId);
                                            createAndEditLotNumber(true, data);
                                          },
                                    child: const Icon(
                                      Icons.edit,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    const Text("Management Lot status",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const Gap(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          containerStatus(
                              lockHr,
                              "HR Lock",
                              lotNumberId == null
                                  ? null
                                  : () {
                                      setState(() {
                                        lockHr = !lockHr;
                                      });
                                    }),
                          const Gap(15),
                          containerStatus(
                              lockAcc,
                              "ACC Lock",
                              lotNumberId == null
                                  ? null
                                  : () {
                                      setState(() {
                                        lockAcc = !lockAcc;
                                      });
                                    }),
                          const Gap(15),
                          containerStatus(
                              lockAccLabor,
                              "HR Labor Lock",
                              lotNumberId == null
                                  ? null
                                  : () {
                                      setState(() {
                                        lockAccLabor = !lockAccLabor;
                                      });
                                    }),
                          const Gap(15),
                          containerStatus(
                              lockHrLabor,
                              "ACC Labor Lock",
                              lotNumberId == null
                                  ? null
                                  : () {
                                      setState(() {
                                        lockHrLabor = !lockHrLabor;
                                      });
                                    }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }

  Widget containerStatus(bool status, String labelText, Function()? onPressed) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 250,
            height: 250,
            child: Card(
              color: status == false ? Colors.white : myredcolors,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Icon(
                      status == false
                          ? CupertinoIcons.doc_text_search
                          : Icons.lock_outline_rounded,
                      size: 140,
                      color: status == false ? Colors.black45 : mygreycolors,
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
        SizedBox(
          height: 34,
          width: 80,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(1),
                  backgroundColor: status == false ? myredcolors : mythemecolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: onPressed,
              child: Text(status == false ? "Lock" : "Unlock")),
        ),
      ],
    );
  }
}

class Year {
  final String id;
  final String year;

  Year({required this.id, required this.year});
}
