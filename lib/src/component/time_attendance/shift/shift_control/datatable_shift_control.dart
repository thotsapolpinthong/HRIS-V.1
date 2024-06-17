import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/datatable_employee.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';

import 'package:hris_app_prototype/src/model/time_attendance/shift/dropdown_shift_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/create_shift_control.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/del_shift_control_model.dart';
import 'package:hris_app_prototype/src/model/time_attendance/shift/shift_control/get_shift_control.dart';

import 'package:hris_app_prototype/src/services/api_time_attendance_service.dart';
import 'package:intl/intl.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';

class ShiftControlDataTable extends StatefulWidget {
  const ShiftControlDataTable({super.key});

  @override
  State<ShiftControlDataTable> createState() => _ShiftControlDataTableState();
}

// radio
List<String> options = ['1', '2', '3'];

class _ShiftControlDataTableState extends State<ShiftControlDataTable> {
  //Main Data Table
  List<EmployeeDatum>? employeeData;
  // List<EmployeeDatum>? filterData;
  // ข้อมูลพนักงานที่มาจากตาราง Add
  List<String> selectedData = [];
  // ข้อมูล Checkbox จากตารางหลัก
  //List<EmployeeDatum> selectedEmployee = [];
  List<ShiftAssignmentDatum> selectedEmployee = [];
  // ส่วนประกอบตาราง
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  TextEditingController validFrom = TextEditingController();
  TextEditingController expFrom = TextEditingController();
  TextEditingController comment = TextEditingController();
  bool disableExp = false;
  bool isLoading = true;
//Shift Dropdown Data
  List<ShiftDatum>? shiftList;
  String? shiftData;
  String? shiftTime;
  String? shiftName;

//ย้ายกะทำงาน
  String? changeshiftId;
  TextEditingController startShift = TextEditingController();
  TextEditingController endShift = TextEditingController();

// Get shift data
  GetShiftControlModel? shiftControlData;
//delete shift
  DeleteShiftControlModel deleteShiftControlData =
      DeleteShiftControlModel(shiftControlId: []);

  // radio
  String cerrentOption = options[0];

  // List<DataRow> getRows(List<EmployeeDatum>? empData) =>
  //     empData.map((EmployeeDatum data) { DataRow(cells: DataCell(Text(data.employeeId)))

  //     }).toList();
  fetchData() async {
    shiftList = await ApiTimeAtendanceService.getShiftDropdown();
    setState(() {
      shiftList;
    });
  }

  void showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SafeArea(
                child: SizedBox(
                    width: 1200,
                    height: MediaQuery.of(context).size.height - 20,
                    child: const DatatableEmployee(
                      isSelected: true,
                      isSelectedOne: false,
                    )),
              ));
        });
  }

  Future fetchDataShiftControl() async {
    if (shiftData != null &&
        validFrom.text.isNotEmpty &&
        expFrom.text.isNotEmpty) {
      shiftControlData = await ApiTimeAtendanceService.getShiftControl(
          shiftData!, validFrom.text, expFrom.text);

      isLoading = true;
      shiftControlData;

      setState(() {
        isLoading = false;
      });

      // if (shiftControlData!.shiftAssignmentData.isNotEmpty) {
      //   setState(() {
      //     isLoading = true;
      //     shiftControlData;
      //     isLoading = false;
      //   });
      // } else {
      //   setState(() {
      //     if (shiftControlData!.shiftAssignmentData.isNotEmpty) {
      //       isLoading = true;
      //       shiftControlData = null;
      //       isLoading = false;
      //     } else {}
      //   });
      // }
    } else {}
  }

  showDialogShiftControl(data, int count, bool create) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
                backgroundColor: mygreycolors,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        create == true
                            ? 'รายละเอียดการบันทึก'
                            : 'รายละเอียดการย้ายกะการทำงาน',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text(
                          'X',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          changeshiftId = null;
                          startShift = TextEditingController();
                          endShift = TextEditingController();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                content: SizedBox(
                  width: create == true ? 300 : 450,
                  height: create == true ? 200 : 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      create == true
                          ? Expanded(
                              child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "ชื่อกะการทำงาน :   $shiftName \nเวลา : $shiftTime  "),
                                  Text("เริ่มวันที่ : ${validFrom.text}"),
                                  Text("สิ้นสุดวันที่ : ${expFrom.text}"),
                                  Text(data.toString()),
                                ],
                              ),
                            ))
                          : Expanded(
                              child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownGlobal(
                                    labeltext: 'Shift',
                                    value: changeshiftId,
                                    validator: null,
                                    items: shiftList?.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.shiftId.toString(),
                                        child: Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 260),
                                            child: Text(
                                                "${e.shiftName}  ${e.startTime} : ${e.endTime}")),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        changeshiftId = newValue.toString();
                                      });
                                    },
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldDatepickGlobal(
                                          controller: startShift,
                                          labelText: "From Date.",
                                          validatorless: null,
                                          ontap: () {
                                            selectStartDate();
                                          },
                                        ),
                                      ),
                                      const Text(
                                        '-',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child:
                                            TextFormFieldDatepickGlobalDisable(
                                          controller: endShift,
                                          labelText: "To Date.",
                                          validatorless: null,
                                          ontap: () {
                                            selectEndDate();
                                          },
                                          enabled: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('เพิ่มกะทำงาน'),
                                          leading: Radio(
                                              value: options[0],
                                              groupValue: cerrentOption,
                                              onChanged: (value) {
                                                setState(() => cerrentOption =
                                                    value.toString());
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('ย้ายกะทำงาน'),
                                          leading: Radio(
                                              value: options[1],
                                              groupValue: cerrentOption,
                                              onChanged: (value) {
                                                setState(() => cerrentOption =
                                                    value.toString());
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Text('ควบกะทำงาน'),
                                          leading: Radio(
                                              value: options[2],
                                              groupValue: cerrentOption,
                                              onChanged: (value) {
                                                setState(() => cerrentOption =
                                                    value.toString());
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Center(child: Text(data.toString())),
                                ],
                              ),
                            )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("รวม $count รายการ"),
                            ElevatedButton(
                                onPressed: create == true
                                    ? () async {
                                        CreateShiftControlModel createdModel =
                                            CreateShiftControlModel(
                                                shiftId: shiftData.toString(),
                                                employeeId: data,
                                                validFrom: validFrom.text,
                                                endDate: expFrom.text,
                                                noted: "test",
                                                assingType: '1');
                                        setState(() {});
                                        bool success =
                                            await ApiTimeAtendanceService
                                                .createShiftControl(
                                                    createdModel);
                                        alertDialog(success, false, false);
                                      }
                                    : changeshiftId == "" &&
                                            startShift.text.isEmpty &&
                                            endShift.text.isEmpty
                                        ? null
                                        : () async {
                                            CreateShiftControlModel
                                                createdModel =
                                                CreateShiftControlModel(
                                                    shiftId: changeshiftId
                                                        .toString(),
                                                    employeeId: data,
                                                    validFrom: startShift.text,
                                                    endDate: endShift.text,
                                                    noted: "test",
                                                    assingType: cerrentOption);
                                            setState(() {});
                                            bool success =
                                                await ApiTimeAtendanceService
                                                    .createShiftControl(
                                                        createdModel);
                                            alertDialog(success, false, false);
                                          },
                                child: const Text('Submit')),
                          ],
                        ),
                      )
                      // Expanded(
                      //     child: CreateUpdateCalendar(
                      //   onEdit: true,
                      //   subData: data,
                      // )),
                    ],
                  ),
                )),
          );
        });
  }

  alertDialog(bool success, bool del, bool delEmployee) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
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
                    ? del == false
                        ? 'Assign Shift Control Success.'
                        : 'Delete Shift Control Success.'
                    : del == false
                        ? 'Assign Shift Control Fail.'
                        : 'Delete Shift Control Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? del == false
                        ? 'เพิ่มข้อมูลกะการทำงาน สำเร็จ'
                        : 'ลบกะการทำงาน สำเร็จ'
                    : del == false
                        ? 'เพิ่มข้อมูลกะการทำงาน ไม่สำเร็จ'
                        : 'ลบกะการทำงาน ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        selectedEmployee = [];
        if (delEmployee == false) {
          fetchDataShiftControl();
        } else {}
        if (success == true && del == true && delEmployee == true) {
          fetchDataShiftControl();
        } else {}
      },
    ).show();
  }

  Future<void> selectvalidFromDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        validFrom.text = picker.toString().split(" ")[0];
        disableExp = true;
        expFrom.text = "";
        fetchDataShiftControl();
      });
    }
  }

  Future<void> selectexpDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(validFrom.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        expFrom.text = picker.toString().split(" ")[0];
        fetchDataShiftControl();
      });
    }
  }

  Future<void> selectStartDate() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(9999),
    );
    if (picker != null) {
      setState(() {
        startShift.text = picker.toString().split(" ")[0];

        endShift.text = "";
      });
    }
  }

  Future<void> selectEndDate() async {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime dateTime = format.parse(startShift.text);
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime,
      lastDate: DateTime(9999, 12, 31),
    );
    if (picker != null) {
      setState(() {
        endShift.text = picker.toString().split(" ")[0];
      });
    }
  }

  onSelectedRow(bool selected, ShiftAssignmentDatum user) async {
    setState(() {
      if (selected) {
        selectedEmployee.add(user);
      } else {
        selectedEmployee.remove(user);
      }
    });
  }

  functionAddAllListData(EmployeeDatum data) {
    ShiftAssignmentDatum addListData = ShiftAssignmentDatum(
        shiftControlId: "",
        shiftData: ShiftDatam(
            shiftId: shiftData.toString(),
            shiftName: "",
            startTime: "",
            endTime: "",
            validFrom: "",
            endDate: "",
            shiftStatus: ""),
        employeeData: EmployeeDatam(
            employeeId: data.employeeId,
            firstName: data.personData.fisrtNameTh,
            lastName: data.personData.lastNameTh,
            positionName: data.positionData.positionData.positionNameTh,
            departmentName: data.departmentData.deptNameTh),
        validFrom: validFrom.text,
        endDate: expFrom.text,
        noted: "AssignmentDataFromEmployee");
    shiftControlData?.shiftAssignmentData.add(addListData);
  }

//ลบกะทำงาน
  void functionDelAllListData(ShiftAssignmentDatum data) {
    String delData = data.shiftControlId;

    deleteShiftControlData.shiftControlId.add(delData);
  }

//ลบที่ละคน
  void deleteData(ShiftAssignmentDatum data) async {
    DeleteShiftControlModel delModel =
        DeleteShiftControlModel(shiftControlId: []);
    String delData = data.shiftControlId;
    delModel.shiftControlId.add(delData);
    setState(() {});
    bool success = await ApiTimeAtendanceService.deleteShiftControl(delModel);
    alertDialog(success, true, true);
    delModel.shiftControlId = [];
    if (success == true) {
      shiftControlData?.shiftAssignmentData.remove(data);
    } else {}
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    employeeData;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: BlocBuilder<TimeattendanceBloc, TimeattendanceState>(
          builder: (context, state) {
            // employeeData = state.selectedemployeeData;

            // if (employeeData != null) {
            //   selectedData = employeeData!.map((e) => e.employeeId).toList();
            // } else {
            //   selectedData = [];
            // }
            if (shiftControlData?.shiftAssignmentData == null) {
              employeeData = state.selectedemployeeData;
              employeeData?.forEach((element) {
                functionAddAllListData(element);
              });
              // employeeData = null;
            } else if (shiftControlData?.shiftAssignmentData != null) {
              state.selectedemployeeData?.forEach((i) {
                var eiei = shiftControlData!.shiftAssignmentData
                    .where((e) => e.employeeData.employeeId == i.employeeId);
                if (eiei.isNotEmpty) {
                } else {
                  functionAddAllListData(i);
                  context.read<TimeattendanceBloc>().add(CloseEvent());
                }
              });
            } else {}
            //SelectedData to create shift control
            if (shiftControlData?.shiftAssignmentData != null) {
              var data = shiftControlData?.shiftAssignmentData.where(
                  (element) => element.noted == "AssignmentDataFromEmployee");
              selectedData = data!
                  .map(
                    (e) => e.employeeData.employeeId,
                  )
                  .toList();
            } else {
              selectedData = [];
            }
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(3),
                      SizedBox(
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container()),
                            if (shiftList == null)
                              const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  )),
                            Expanded(
                              flex: 2,
                              child: DropdownGlobal(
                                labeltext: 'Shift',
                                value: shiftData,
                                validator: null,
                                items: shiftList?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.shiftId.toString(),
                                    child: Container(
                                        constraints:
                                            const BoxConstraints(maxWidth: 300),
                                        child: Text(
                                            "${e.shiftName} : ${e.startTime} - ${e.endTime}")),
                                    onTap: () {
                                      shiftTime =
                                          "${e.startTime} - ${e.endTime}";
                                      shiftName = e.shiftName.toString();
                                      print(e.shiftName);
                                    },
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    shiftData = newValue.toString();
                                    selectedEmployee = [];
                                  });
                                  fetchDataShiftControl();
                                  employeeData = null;
                                  context
                                      .read<TimeattendanceBloc>()
                                      .add(DissSelectedEvent());
                                  context
                                      .read<TimeattendanceBloc>()
                                      .add(CloseEvent());
                                },
                              ),
                            ),
                            Expanded(
                              child: TextFormFieldDatepickGlobal(
                                controller: validFrom,
                                labelText: "From Date.",
                                validatorless: null,
                                ontap: () {
                                  selectvalidFromDate();
                                },
                              ),
                            ),
                            const Text(
                              '-',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: TextFormFieldDatepickGlobalDisable(
                                controller: expFrom,
                                labelText: "To Date.",
                                validatorless: null,
                                onChanged: (newValue) {
                                  fetchDataShiftControl();
                                  employeeData = null;
                                  context
                                      .read<TimeattendanceBloc>()
                                      .add(DissSelectedEvent());
                                  context
                                      .read<TimeattendanceBloc>()
                                      .add(CloseEvent());
                                },
                                ontap: () {
                                  selectexpDate();
                                  selectedEmployee = [];
                                },
                                enabled: disableExp,
                              ),
                            ),
                            const Gap(5),
                            SizedBox(
                              height: 38,
                              width: 42,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(1)),
                                  onPressed: expFrom.text.isEmpty
                                      ? null
                                      : () {
                                          employeeData = null;
                                          context
                                              .read<TimeattendanceBloc>()
                                              .add(DissSelectedEvent());
                                          context
                                              .read<TimeattendanceBloc>()
                                              .add(CloseEvent());
                                          showDialogCreate();
                                        },
                                  child: const Icon(Icons.person_add_rounded)),
                            ),
                            const Gap(5),
                            SizedBox(
                              height: 38,
                              width: 84,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(1),
                                      backgroundColor: Colors.red[600]),
                                  onPressed:
                                      shiftControlData?.shiftAssignmentData ==
                                              null
                                          ? null
                                          : shiftControlData!
                                                  .shiftAssignmentData.isEmpty
                                              ? null
                                              : () async {
                                                  //
                                                  for (var element
                                                      in shiftControlData!
                                                          .shiftAssignmentData) {
                                                    if (element
                                                        .validFrom.isNotEmpty) {
                                                      functionDelAllListData(
                                                          element);
                                                    }
                                                  }

                                                  deleteShiftControlData;

                                                  if (deleteShiftControlData
                                                      .shiftControlId
                                                      .isNotEmpty) {
                                                    bool success =
                                                        await ApiTimeAtendanceService
                                                            .deleteShiftControl(
                                                                deleteShiftControlData);

                                                    alertDialog(
                                                        success, true, false);
                                                    deleteShiftControlData
                                                        .shiftControlId = [];
                                                  } else {}
                                                },
                                  child: const Text("ลบกะทำงาน")),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      shiftControlData?.shiftAssignmentData != null ||
                              isLoading == false
                          ? DataTable(
                              headingRowHeight: 45,
                              horizontalMargin: 10,
                              columnSpacing: 20,
                              columns: const [
                                DataColumn(
                                    numeric: true,
                                    label: Text('รหัสพนักงาน',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('แผนก',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ชื่อ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('นามสกุล',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ประเภทพนักงาน',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ตั้งแต่วันที่',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ถึงวันที่',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ยกเลิก',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: shiftControlData!.shiftAssignmentData
                                  .map((index) => DataRow(
                                          selected:
                                              selectedEmployee.contains(index),
                                          onSelectChanged: index.validFrom == ""
                                              ? null
                                              : (value) {
                                                  onSelectedRow(value!, index);
                                                },
                                          cells: [
                                            DataCell(Text(
                                                index.employeeData.employeeId)),
                                            DataCell(Text(index
                                                .employeeData.departmentName)),
                                            DataCell(Text(
                                                index.employeeData.firstName)),
                                            DataCell(Text(
                                                index.employeeData.lastName)),
                                            DataCell(Text(index
                                                .employeeData.positionName)),
                                            DataCell(Text(index.validFrom == ""
                                                ? "ค่าเริ่มต้น"
                                                : index.validFrom)),
                                            DataCell(Text(index.endDate == ""
                                                ? "ค่าเริ่มต้น"
                                                : index.endDate)),
                                            DataCell(
                                              Row(
                                                children: [
                                                  // SizedBox(
                                                  //   width: 32,
                                                  //   height: 32,
                                                  //   child: ElevatedButton(
                                                  //       style: ElevatedButton
                                                  //           .styleFrom(
                                                  //               backgroundColor:
                                                  //                   Colors.amber[
                                                  //                       700],
                                                  //               padding:
                                                  //                   const EdgeInsets
                                                  //                       .all(
                                                  //                       1)),
                                                  //       onPressed: () {
                                                  //         // showdialogDelete(subData.holidayId);
                                                  //         setState(() {});
                                                  //       },
                                                  //       child: const Icon(
                                                  //           Icons.edit)),
                                                  // ),
                                                  const Gap(5),
                                                  SizedBox(
                                                    width: 32,
                                                    height: 32,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: index
                                                                        .noted ==
                                                                    "AssignmentDataFromEmployee"
                                                                ? Colors
                                                                    .amber[700]
                                                                : Colors
                                                                    .red[600],
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1)),
                                                        onPressed: index
                                                                    .validFrom ==
                                                                ""
                                                            ? null
                                                            : index.noted ==
                                                                    "AssignmentDataFromEmployee"
                                                                ? () {
                                                                    // showdialogDelete(subData.holidayId);
                                                                    context
                                                                        .read<
                                                                            TimeattendanceBloc>()
                                                                        .add(
                                                                            CloseEvent());
                                                                    setState(
                                                                        () {
                                                                      selectedEmployee
                                                                          .remove(
                                                                              index);
                                                                      shiftControlData!
                                                                          .shiftAssignmentData
                                                                          .remove(
                                                                              index);
                                                                    });
                                                                  }
                                                                : () {
                                                                    //-----------
                                                                    deleteData(
                                                                        index);
                                                                    //---------
                                                                  },
                                                        child: const Text(
                                                          'X',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]))
                                  .toList(),
                            )
                          : DataTable(columns: const [
                              DataColumn(
                                  label: Text(
                                'แผนก',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataColumn(
                                  label: Text('ชื่อ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('นามสกุล',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('ประเภทพนักงาน',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('ตั้งแต่วันที่',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('ถึงวันที่',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('จำนวนวัน',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ], rows: const [
                              DataRow(cells: [
                                DataCell(Text("")),
                                DataCell(Text("")),
                                DataCell(Text("")),
                                DataCell(Text("")),
                                DataCell(Text("")),
                                DataCell(Text("")),
                                DataCell(Text("")),
                              ])
                            ]),
                    ],
                  ),
                ),
              ),
              floatingActionButton: shiftControlData?.shiftAssignmentData ==
                      null
                  ? null
                  : shiftControlData!.shiftAssignmentData.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //     width: 100,
                            //     height: 48,
                            //     child: OutlinedButton(
                            //         style: OutlinedButton.styleFrom(
                            //             shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12))),
                            //         onPressed: () {},
                            //         child: const Text('test1'))),
                            // const Gap(20),
                            SizedBox(
                                width: 120,
                                height: 58,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: selectedData.isEmpty
                                        ? null
                                        : () {
                                            // selectedData = employeeData;
                                            showDialogShiftControl(selectedData,
                                                selectedData.length, true);
                                          },
                                    child: Text(
                                      'บันทึกพนักงานลงในกะทำงาน',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: selectedData.isEmpty
                                              ? Colors.black38
                                              : Colors.black87),
                                    ))),
                            const Gap(20),
                            SizedBox(
                                width: 120,
                                height: 58,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.tealAccent[700],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: selectedEmployee.isEmpty
                                        ? null
                                        : () {
                                            List<String>? data = [];
                                            data = selectedEmployee
                                                .map((e) =>
                                                    e.employeeData.employeeId)
                                                .toList();

                                            showDialogShiftControl(
                                                data, data.length, false);
                                          },
                                    child: const Text(
                                      'กำหนดกะการทำงานเพิ่มเติม',
                                      textAlign: TextAlign.center,
                                    ))),
                          ],
                        )
                      : null,
            );
          },
        ),
      )),
    );
  }
}
