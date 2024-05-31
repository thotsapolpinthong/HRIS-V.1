import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/lotnumber/get_lotnumber_dropdown_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';

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
  List<Year> yearList = [
    Year(id: "2024", year: "2024"),
    Year(id: "2025", year: "2025"),
    Year(id: "2026", year: "2026"),
    Year(id: "2027", year: "2027"),
    Year(id: "2028", year: "2028"),
    Year(id: "2029", year: "2029"),
    Year(id: "2030", year: "2030"),
    Year(id: "2031", year: "2031"),
    Year(id: "2032", year: "2032"),
    Year(id: "2033", year: "2033"),
    Year(id: "2034", year: "2034"),
    Year(id: "2035", year: "2035"),
    Year(id: "2036", year: "2036"),
    Year(id: "2037", year: "2037"),
    Year(id: "2038", year: "2038"),
    Year(id: "2039", year: "2039"),
    Year(id: "2040", year: "2040"),
  ];
  String? lotNumberId;
  String? yearId;
  bool isLoading = true;
  bool lockHr = true;
  bool lockAcc = false;
  bool lockAccLabor = false;
  bool lockHrLabor = false;
  ////////////////////////////////

  fetchData() async {
    //lotnumber data-------------
    lotNumberData = await ApiEmployeeSelfService.getLotNumberDropdown();
    setState(() {
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
            isLoading = false;
          }
        }
      }
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
          onPressed: () {},
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
                                          lockHr = result.first.lockHr == ""
                                              ? false
                                              : true;
                                          lockAcc = result.first.lockAcc == ""
                                              ? false
                                              : true;
                                          lockAccLabor =
                                              result.first.lockAccLabor == ""
                                                  ? false
                                                  : true;
                                          lockHrLabor =
                                              result.first.lockHrLabor == ""
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
                                    labelText: "วันที่เริ่มต้น",
                                    validatorless: null,
                                    ontap: () {}),
                              ),
                              SizedBox(
                                width: 160,
                                child: TextFormFieldDatepickGlobal(
                                    controller: finishDate,
                                    labelText: "วันที่สิ้นสุด",
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
                                    onPressed: () {},
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
