// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_by_id_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_approve_and_reject_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model.dart/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';

class ManagerMenuService extends StatefulWidget {
  final EmployeeIdModel? employeeData;
  const ManagerMenuService({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<ManagerMenuService> createState() => _ManagerMenuServiceState();
}

class _ManagerMenuServiceState extends State<ManagerMenuService> {
  LeaveRequestByEmployeeModel? leaveData;

  List test = [
    "request1",
    "request2",
    "request3",
    "request4",
    "request5",
    "request2",
    "request3",
    "request4",
    "request5",
    "request2",
    "request3",
    "request4",
    "request5"
  ];

  showDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "บันทึกข้อมูลวันลา",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: const SizedBox(
                        width: 460, height: 360, child: Text("test")),
                  ));
        });
  }

  fetchData() async {
    leaveData = await ApiEmployeeSelfService.getLeaveRequestManager(
        widget.employeeData!.employeeData[0].employeeId,
        widget
            .employeeData!.employeeData[0].positionData.positionOrganizationId);
    setState(() {
      leaveData;
    });
  }

  leaveApprove(String requestId) async {
    LeaveApproveModel leaveModel = LeaveApproveModel(
        leaveRequestId: requestId,
        approveBy: widget.employeeData!.employeeData[0].employeeId);
    bool success = await ApiEmployeeSelfService.leaveApprove(leaveModel);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 1);
  }

  leaveReject(String requestId) async {
    LeaveRejectModel leaveModel = LeaveRejectModel(
        leaveRequestId: requestId,
        rejectBy: widget.employeeData!.employeeData[0].employeeId,
        comment: "Reject by Manager");
    bool success = await ApiEmployeeSelfService.leaveReject(leaveModel);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 2);
  }

  alertDialogInfo(String requestId, int type) {
    //  type 1 = approve and type 2 = reject
    AwesomeDialog(
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.info,
            title: type == 1 ? 'Approve' : 'Reject',
            desc: type == 1 ? 'อนุมัติ' : 'ปฏิเสธ',
            btnOkColor: mythemecolor,
            btnOkOnPress: () {
              if (type == 1) {
                leaveApprove(requestId);
              } else {
                leaveReject(requestId);
              }
            },
            btnCancelOnPress: () {})
        .show();
  }

  alertDialog(bool success, int type) {
    //  type 1 = approve and type 2 = reject
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 450,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              type == 1
                  ? Text(
                      success == true ? 'Approve Success.' : 'Approve Fail.',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(
                      success == true ? 'Reject Success.' : 'Reject Fail.',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
              type == 1
                  ? Text(
                      success == true ? 'อนุมัติ สำเร็จ' : 'อนุมัติ ไม่สำเร็จ',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(success == true ? 'ปฏิเสธ สำเร็จ' : 'ปฏิเสธ ไม่สำเร็จ',
                      style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {});
      },
    ).show();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.amber,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Card(
                color: mythemecolor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                  child: Column(
                    children: [
                      ListTile(
                        textColor: mygreycolors,
                        title: const Text("คำร้องการลา"),
                        subtitle: const Text("Leave"),
                        trailing: SizedBox(
                          width: 316,
                          child: Row(
                            children: [
                              const Text("Status : "),
                              Icon(
                                Icons.check_box_rounded,
                                size: 30,
                                color: Colors.greenAccent[400],
                              ),
                              const Text("Approve "),
                              Icon(
                                Icons.cancel_rounded,
                                size: 30,
                                color: Colors.red[700],
                              ),
                              const Text("Reject "),
                              Tooltip(
                                  message: "",
                                  child: Icon(
                                    Icons.timelapse_rounded,
                                    size: 30,
                                    color: mygreycolors,
                                  )),
                              const Text("Request ")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(14))),
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: leaveData?.leaveRequestData.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: mygreycolors,
                                  child: Center(
                                    child: ListTile(
                                        leading: leaveData == null
                                            ? null
                                            : SizedBox(
                                                width: 70,
                                                child: Text(
                                                  "${leaveData?.leaveRequestData[index].leaveTypeData.leaveTypeNameTh}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                        title: Text(
                                            "${leaveData?.leaveRequestData[index].firstName} ${leaveData?.leaveRequestData[index].lastName}"),
                                        subtitle: Text(
                                            "จำนวน ${leaveData?.leaveRequestData[index].leaveAmount} วัน\nวันที่ ${leaveData?.leaveRequestData[index].leaveDate}"),
                                        trailing: SizedBox(
                                          width: 242,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (leaveData
                                                      ?.leaveRequestData[index]
                                                      .status ==
                                                  "request")
                                                SizedBox(
                                                  width: 80,
                                                  height: 38,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .greenAccent,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1)),
                                                      onPressed: () {
                                                        alertDialogInfo(
                                                            leaveData!
                                                                .leaveRequestData[
                                                                    index]
                                                                .leaveRequestId,
                                                            1);
                                                        // leaveApprove(leaveData!
                                                        //     .leaveRequestData[
                                                        //         index]
                                                        //     .leaveRequestId);
                                                      },
                                                      child: const Text(
                                                        "Approve",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black87),
                                                      )),
                                                ),
                                              const Gap(5),
                                              if (leaveData
                                                      ?.leaveRequestData[index]
                                                      .status !=
                                                  "reject")
                                                SizedBox(
                                                  width: 80,
                                                  height: 38,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .red[700],
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1)),
                                                      onPressed: () {
                                                        alertDialogInfo(
                                                            leaveData!
                                                                .leaveRequestData[
                                                                    index]
                                                                .leaveRequestId,
                                                            2);
                                                        // leaveReject(leaveData!
                                                        //     .leaveRequestData[
                                                        //         index]
                                                        //     .leaveRequestId);
                                                      },
                                                      child:
                                                          const Text("Reject")),
                                                ),
                                              const Gap(5),
                                              Tooltip(
                                                textAlign: TextAlign.start,
                                                message:
                                                    "รหัสพนักงาน : ${leaveData?.leaveRequestData[index].employeeId}\nชื่อ : ${leaveData?.leaveRequestData[index].firstName} ${leaveData?.leaveRequestData[index].lastName}\nตำแหน่ง : ${leaveData?.leaveRequestData[index].positionName}\nแผนก : ${leaveData?.leaveRequestData[index].departmentName}\nประเภท : ${leaveData?.leaveRequestData[index].leaveTypeData.leaveTypeNameTh}\nสถานะ : ${leaveData?.leaveRequestData[index].status}\nลาเพื่อ : ${leaveData?.leaveRequestData[index].leaveDecription}\nจำนวน : ${leaveData?.leaveRequestData[index].leaveAmount} วัน\nวันที่ : ${leaveData?.leaveRequestData[index].leaveDate}",
                                                child: const Icon(
                                                  CupertinoIcons.doc_plaintext,
                                                  size: 40,
                                                ),
                                              ),
                                              leaveData?.leaveRequestData[index]
                                                          .status ==
                                                      "request"
                                                  ? const Icon(
                                                      Icons.timelapse_rounded,
                                                      size: 30,
                                                    )
                                                  : leaveData
                                                              ?.leaveRequestData[
                                                                  index]
                                                              .status ==
                                                          "approve"
                                                      ? Icon(
                                                          Icons
                                                              .check_box_rounded,
                                                          size: 30,
                                                          color: Colors
                                                              .greenAccent[400],
                                                        )
                                                      : Icon(
                                                          Icons.cancel_rounded,
                                                          size: 30,
                                                          color:
                                                              Colors.red[700],
                                                        ),
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                          subtitle: Text("OT"),
                        ),
                        Expanded(child: Text("test")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}

class OTManage extends StatefulWidget {
  const OTManage({super.key});

  @override
  State<OTManage> createState() => _OTManageState();
}

class _OTManageState extends State<OTManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
      ),
      body: Hero(
          tag: "ot",
          child: Column(
            children: [
              Container(
                color: Colors.amber,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("pop"))
            ],
          )),
    );
  }
}
