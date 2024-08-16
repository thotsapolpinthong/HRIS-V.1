// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/bloc/trip_bloc/trip_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/component/trip/trip/change_car.dart';
import 'package:hris_app_prototype/src/component/trip/trip/setting_trip.dart';
import 'package:hris_app_prototype/src/model/trip/cancel_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/finish_trip_model.dart';
import 'package:hris_app_prototype/src/model/trip/trip_data_all_model.dart';
import 'package:hris_app_prototype/src/services/api_trip_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class TripDatatable extends StatefulWidget {
  const TripDatatable({super.key});

  @override
  State<TripDatatable> createState() => _TripDatatableState();
}

class _TripDatatableState extends State<TripDatatable> {
  //table
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;
  TextEditingController search = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  List<TripDatum> filterData = [];
//
// data model
  List<TripDatum>? dataTripModel;
//functions Search
  // onSortSearchColumn(int columnIndex, bool ascending) {
  //   if (sortColumnIndex == 0) {
  //     if (sort) {
  //       orgData!
  //           .sort((a, b) => a.organizationCode.compareTo(b.organizationCode));
  //     } else {
  //       orgData!
  //           .sort((a, b) => b.organizationCode.compareTo(a.organizationCode));
  //     }
  //   }
  //   if (sortColumnIndex == 2) {
  //     if (sort) {
  //       orgData!.sort((a, b) =>
  //           a.departMentData.deptNameTh.compareTo(b.departMentData.deptNameTh));
  //     } else {
  //       orgData!.sort((a, b) =>
  //           b.departMentData.deptNameTh.compareTo(a.departMentData.deptNameTh));
  //     }
  //   }
  //   if (sortColumnIndex == 3) {
  //     if (sort) {
  //       orgData!.sort((a, b) =>
  //           a.departMentData.deptNameEn.compareTo(b.departMentData.deptNameEn));
  //     } else {
  //       orgData!.sort((a, b) =>
  //           b.departMentData.deptNameEn.compareTo(a.departMentData.deptNameEn));
  //     }
  //   }
  //   if (sortColumnIndex == 4) {
  //     if (sort) {
  //       orgData!.sort((a, b) => a.parentOrganizationNodeData.organizationName
  //           .compareTo(b.parentOrganizationNodeData.organizationName));
  //     } else {
  //       orgData!.sort((a, b) => b.parentOrganizationNodeData.organizationName
  //           .compareTo(a.parentOrganizationNodeData.organizationName));
  //     }
  //   }
  // }

  // onSortColumn(int columnIndex, bool ascending) {
  //   if (sortColumnIndex == 0) {
  //     if (sort) {
  //       filterData!
  //           .sort((a, b) => a.organizationCode.compareTo(b.organizationCode));
  //     } else {
  //       filterData!
  //           .sort((a, b) => b.organizationCode.compareTo(a.organizationCode));
  //     }
  //   }
  //   if (sortColumnIndex == 2) {
  //     if (sort) {
  //       filterData!.sort((a, b) =>
  //           a.departMentData.deptNameTh.compareTo(b.departMentData.deptNameTh));
  //     } else {
  //       filterData!.sort((a, b) =>
  //           b.departMentData.deptNameTh.compareTo(a.departMentData.deptNameTh));
  //     }
  //   }
  //   if (sortColumnIndex == 3) {
  //     if (sort) {
  //       filterData!.sort((a, b) =>
  //           a.departMentData.deptNameEn.compareTo(b.departMentData.deptNameEn));
  //     } else {
  //       filterData!.sort((a, b) =>
  //           b.departMentData.deptNameEn.compareTo(a.departMentData.deptNameEn));
  //     }
  //   }
  //   if (sortColumnIndex == 4) {
  //     if (sort) {
  //       filterData!.sort((a, b) => a.parentOrganizationNodeData.organizationName
  //           .compareTo(b.parentOrganizationNodeData.organizationName));
  //     } else {
  //       filterData!.sort((a, b) => b.parentOrganizationNodeData.organizationName
  //           .compareTo(a.parentOrganizationNodeData.organizationName));
  //     }
  //   }
  // }

// end function search

  DateTime firstDayOfMonth(DateTime date) {
    //หาวันแรกของเดือน
    return DateTime(date.year, date.month, 1);
  }

  DateTime lastDayOfMonth(DateTime date) {
    //หาวันสุดท้ายของเดือน
    return DateTime(date.year, date.month + 1, 0);
  }

// Select date
  Future<void> selectvalidFromDate(int type) async {
//type 0 = start , 1 = end
    DateTime? picker = await showDatePicker(
      // selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        if (type == 0) {
          startDate.text = picker.toString().split(" ")[0];
        } else {
          endDate.text = picker.toString().split(" ")[0];
        }
        context.read<TripBloc>().add(GetAllTripDataEvents(
            startDate: startDate.text, endDate: endDate.text));
      });
    }
  }

//create trip
  showCreateTrip(int type) {
    // type 0 == create , type 1 == edit
    setState(() {
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Card(
                color: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Gap(5),
                        TitleDialog(
                            title: "Create Trip.",
                            size: 20,
                            onPressed: () => Navigator.pop(context)),
                        const Gap(5),
                        const Divider(
                          color: Colors.black26,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                        const Gap(5),
                        const Row(children: [
                          Expanded(
                            flex: 2,
                            child: Text("  Trip details.",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text("  Triper details.",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          )
                        ]),
                        SettingTrip(
                          type: type,
                          startDate: startDate.text,
                          endDate: endDate.text,
                        ),
                      ],
                    )));
          });
    });
  }

//change car

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime firstDate = firstDayOfMonth(now);
    DateTime lastDate = lastDayOfMonth(now);
    startDate.text = firstDate.toString().split(" ")[0];
    endDate.text = lastDate.toString().split(" ")[0];
    context.read<TripBloc>().add(
        GetAllTripDataEvents(startDate: startDate.text, endDate: endDate.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Tooltip(
            message: 'Create Trip',
            child: MyFloatingButton(
              icon: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
              onPressed: () {
                showCreateTrip(0);
              },
            ),
          ),
          body: BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state.onSearchData == false || dataTripModel == null) {
                dataTripModel = state.tripAllDataModel?.tripData ?? [];
                filterData = state.tripAllDataModel?.tripData ?? [];
              } else {}
              return state.isAllTripDataLoading == true
                  ? myLoadingScreen
                  : SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: PaginatedDataTable(
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Trip Table.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "ระหว่างวันที่",
                                              style: GoogleFonts.kanit(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: 150,
                                              child: TextFormFieldSearch(
                                                controller: startDate,
                                                labelText: "ตั้งแต่วันที่",
                                                ontap: () {
                                                  selectvalidFromDate(0);
                                                },
                                                enabled: true,
                                                suffixIcon: const Icon(Icons
                                                    .calendar_today_rounded),
                                              ),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: 150,
                                              child: TextFormFieldSearch(
                                                controller: endDate,
                                                labelText: "ถึงวันที่",
                                                ontap: () {
                                                  selectvalidFromDate(1);
                                                },
                                                enabled: true,
                                                suffixIcon: const Icon(Icons
                                                    .calendar_today_rounded),
                                              ),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: 300,
                                              child: TextFormFieldSearch(
                                                controller: search,
                                                hintText: "Search(EN/TH)",
                                                onChanged: (value) {
                                                  if (value == '') {
                                                    context.read<TripBloc>().add(
                                                        DissSearchTripEvent());
                                                  } else {
                                                    setState(() {
                                                      context
                                                          .read<TripBloc>()
                                                          .add(
                                                              SearchTripEvent());
                                                      dataTripModel = filterData
                                                          .where((element) {
                                                        final destination = element
                                                            .destination
                                                            .map((e) => e
                                                                .provinceNameTh
                                                                .toString())
                                                            .join(', ')
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final startDate = element
                                                            .startDate
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final endDate = element
                                                            .endDate
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final carId = element
                                                            .carData
                                                            .carRegistation
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());
                                                        final description = element
                                                            .tripDescription
                                                            .toLowerCase()
                                                            .contains(value
                                                                .toLowerCase());

                                                        return destination ||
                                                            startDate ||
                                                            endDate ||
                                                            carId ||
                                                            description;
                                                      }).toList();
                                                    });
                                                  }
                                                },
                                                enabled: true,
                                                readOnly: false,
                                                suffixIcon: const Icon(
                                                    Icons.search_rounded),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                columnSpacing: 18,
                                showFirstLastButtons: true,
                                rowsPerPage: rowIndex,
                                availableRowsPerPage: const [5, 10, 20],
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sort,
                                onRowsPerPageChanged: (value) {
                                  setState(() {
                                    rowIndex = value!;
                                  });
                                },
                                columns: [
                                  DataColumn(label: textThai("สถานะ")),
                                  DataColumn(label: textThai("การจัดการ")),
                                  DataColumn(label: textThai("จุดหมาย")),
                                  DataColumn(label: textThai("วันเริ่มต้น")),
                                  DataColumn(label: textThai("วันสิ้นสุด")),
                                  DataColumn(
                                      label: textThai("ทะเบียนรถ - รุ่น")),
                                  DataColumn(
                                      numeric: true,
                                      label: textThai("เลขไมล์ปัจจุบัน")),
                                  DataColumn(
                                      numeric: true,
                                      label: textThai("เลขไมล์สิ้นสุดทริป")),
                                  // DataColumn(label: textThai("ผู้ขับขี่")),
                                  DataColumn(label: textThai("รายละเอียดทริป")),
                                ],
                                source: DataTable(
                                  startDate.text,
                                  endDate.text,
                                  context,
                                  dataTripModel,
                                )),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ));
  }

  Widget textThai(String text) {
    return TextThai(
      textStyle: const TextStyle(fontWeight: FontWeight.w500),
      text: text,
    );
  }
}

class DataTable extends DataTableSource {
  final String startDate;
  final String endDate;
  final BuildContext context;
  final List<TripDatum>? tripData;
  DataTable(
    this.startDate,
    this.endDate,
    this.context,
    this.tripData,
  );
  //test data
  List<TestSource> data = [
    TestSource(
        goal: "Phrea",
        startDate: "2024-03-21",
        endDate: "2024-03-24",
        carId: "2กก 678",
        startRange: "12222",
        endRange: "-",
        driver: "ทศพล พิณทอง",
        description: "ติดตั้งอุปกรณ์รับซื้อ",
        status: "Cancal"),
    TestSource(
        goal: "Phrea",
        startDate: "2024-03-01",
        endDate: "2024-03-03",
        carId: "2กก 678",
        startRange: "12222",
        endRange: "12666",
        driver: "ทศพล พิณทอง",
        description: "ติดตั้งอุปกรณ์รับซื้อ",
        status: "Success"),
    TestSource(
        goal: "Phayao",
        startDate: "2024-03-19",
        endDate: "2024-03-23",
        carId: "3กก 168",
        startRange: "12222",
        endRange: "-",
        driver: "ทศพฤษ พิณทอง",
        description: "ติดตั้งอุปกรณ์รับซื้อ",
        status: "Prepare"),
    TestSource(
        goal: "Sukhothai",
        startDate: "2024-03-15",
        endDate: "2024-03-27",
        carId: "4กก 328",
        startRange: "12222",
        endRange: "-",
        driver: "ทศพัก พิณทอง",
        description: "ติดตั้งอุปกรณ์รับซื้อ",
        status: "On-trip"),
  ];

  //change car
  changeCarDialog(TripDatum data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "สลับรถ ( Change Car. )",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: SizedBox(
                        width: 560,
                        height: 360,
                        child: ChangeCarOnTrip(
                          tripData: data,
                          startDate: startDate,
                          endDate: endDate,
                        )),
                  ));
        });
  }

  alertDialog(bool success, int type) {
    AwesomeDialog(
      // 0 cancel , 1 finish
      dismissOnTouchOutside: false,
      width: 400,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true
                    ? type == 0
                        ? 'Cancel Success.'
                        : 'Finish Success.'
                    : type == 0
                        ? 'Cancel Fail.'
                        : 'Finish Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              TextThai(
                text: success == true
                    ? type == 0
                        ? 'ยกเลิกทริป สำเร็จ'
                        : 'สิ้นสุดทริป สำเร็จ'
                    : type == 0
                        ? 'ยกเลิกทริป ไม่สำเร็จ'
                        : 'สิ้นสุดทริป ไม่สำเร็จ',
                textStyle: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success == true) {
          // Navigator.pop(context);
          context.read<TripBloc>().add(
              GetAllTripDataEvents(startDate: startDate, endDate: endDate));
        } else {}
      },
    ).show();
  }

  cancelDialog(String tripId) async {
    TextEditingController comment = TextEditingController();
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            dialogBackgroundColor: mygreycolors,
            dialogBorderRadius: BorderRadius.circular(14),
            body: Column(
              children: [
                const TextThai(text: "ต้องการยกเลิกทริป"),
                const Gap(5),
                TextFormFieldGlobal(
                    controller: comment,
                    labelText: "หมายเหตุ",
                    hintText: "",
                    validatorless: Validatorless.required("โปรดระบุ"),
                    enabled: true),
                const Gap(5),
              ],
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              String? employeeId;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              employeeId = preferences.getString("employeeId")!;
              CancelTripModel cancelModel = CancelTripModel(
                  tripId: tripId,
                  cancelBy: employeeId,
                  condition: "cancel",
                  comment: comment.text);
              bool success = await ApiTripService.cancelTrip(cancelModel);
              alertDialog(success, 0);
            },
            btnOkColor: mythemecolor)
        .show();
  }

// finish trip
  finishTripDialog(String tripId) {
    TextEditingController endMileage = TextEditingController();
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            dialogBackgroundColor: mygreycolors,
            dialogBorderRadius: BorderRadius.circular(14),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const TextThai(text: "สิ้นสุดทริป"),
                  const Gap(5),
                  TextFormFieldGlobal(
                      controller: endMileage,
                      labelText: "เลขไมล์",
                      hintText: "โปรดระบุเลขไมล์",
                      validatorless: Validatorless.number("กรอกเฉพาะตัวเลข"),
                      enabled: true),
                  const Gap(5),
                ],
              ),
            ),
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              String? employeeId;
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              employeeId = preferences.getString("employeeId")!;
              FinishTripModel finishModel = FinishTripModel(
                  tripId: tripId,
                  endMileageNumber: endMileage.text,
                  finishBy: employeeId);
              bool success = await ApiTripService.finishTrip(finishModel);
              alertDialog(success, 1);
            },
            btnOkColor: mythemecolor)
        .show();
  }

  showEditTrip(int type, String tripId, String status) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Card(
              color: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Gap(5),
                      TitleDialog(
                          title: "Edit Trip.",
                          size: 20,
                          onPressed: () => Navigator.pop(context)),
                      const Gap(5),
                      const Divider(
                        color: Colors.black26,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                      const Gap(5),
                      const Row(children: [
                        Expanded(
                          flex: 2,
                          child: Text("  Trip details.",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text("  Triper details.",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        )
                      ]),
                      SettingTrip(
                          type: type,
                          tripId: tripId,
                          statusType: status,
                          startDate: startDate,
                          endDate: endDate),
                    ],
                  )));
        });
  }

  @override
  DataRow getRow(int index) {
    final datarow = tripData?[index];
    String destination =
        datarow!.destination.map((e) => e.provinceNameTh.toString()).join(', ');
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : Colors.grey[100]!;
        }),
        cells: [
          DataCell(
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 40,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 2,
                      color: datarow.tripStatus == "on-trip"
                          ? Colors.greenAccent
                          : datarow.tripStatus == "prepare"
                              ? Colors.amberAccent
                              : datarow.tripStatus == "finish"
                                  ? mythemecolor
                                  : Colors.red[700],
                      child: Center(
                        child: Text(
                          datarow.tripStatus,
                          style: TextStyle(
                              color: datarow.tripStatus == "cancel" ||
                                      datarow.tripStatus == "finish"
                                  ? Colors.white
                                  : Colors.grey[800]),
                        ),
                      )),
                ),
                if (datarow.oldTripId != "" && datarow.oldTripId != "No data")
                  const Tooltip(
                      message: "มีการสลับรถระหว่างทริป",
                      child: Icon(Icons.autorenew_rounded))
              ],
            ),
          ),
          DataCell(datarow.tripStatus == "cancel" ||
                  datarow.tripStatus == "finish"
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (datarow.tripStatus == "on-trip") const Gap(2),
                    if (datarow.tripStatus == "on-trip")
                      Tooltip(
                        message: 'change car on-trip',
                        child: SizedBox(
                          height: 34,
                          width: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[600],
                                padding: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                            child: const Icon(Icons.drive_eta_rounded),
                            onPressed: () {
                              changeCarDialog(datarow);
                            },
                          ),
                        ),
                      ),
                    if (datarow.tripStatus == "on-trip") const Gap(3),
                    if (datarow.tripStatus == "on-trip")
                      Tooltip(
                        message: "finish trip.",
                        child: SizedBox(
                          height: 34,
                          width: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mygreencolors,
                                padding: const EdgeInsets.all(1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                            child: const Icon(Icons.check_circle_rounded),
                            onPressed: () {
                              finishTripDialog(datarow.tripId);
                            },
                          ),
                        ),
                      ),
                    if (datarow.tripStatus != "on-trip") const Gap(3),
                    if (datarow.tripStatus != "on-trip")
                      SizedBox(
                        height: 34,
                        width: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              padding: const EdgeInsets.all(1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: const Icon(Icons.cancel),
                          onPressed: () {
                            cancelDialog(datarow.tripId);
                          },
                        ),
                      ),
                    const Gap(3),
                    SizedBox(
                      height: 34,
                      width: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Icon(Icons.settings_rounded),
                        onPressed: () {
                          showEditTrip(1, datarow.tripId, datarow.tripStatus);
                        },
                      ),
                    ),
                  ],
                )),

          // DataCell(Text(datarow.tripId)),
          DataCell(Text(destination)),
          DataCell(Text(datarow.startDate)),
          DataCell(Text(datarow.endDate)),
          DataCell(Text(
              "${datarow.carData.carRegistation} - ${datarow.carData.carModel}")),
          DataCell(Text(datarow.startMileageNumber)),
          DataCell(Text(datarow.endMileageNumber)),
          // DataCell(Text("")),
          DataCell(Text(datarow.tripDescription)),
        ]);
  }

  @override
  int get rowCount => tripData?.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class TestSource {
  final String goal;
  final String startDate;
  final String endDate;
  final String carId;
  final String startRange;
  final String endRange;
  final String driver;
  final String description;
  final String status;
  TestSource({
    required this.goal,
    required this.startDate,
    required this.endDate,
    required this.carId,
    required this.startRange,
    required this.endRange,
    required this.driver,
    required this.description,
    required this.status,
  });
}
