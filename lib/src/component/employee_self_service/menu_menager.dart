// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/employee/get_employee_all_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_approve_and_reject_model.dart';
import 'package:hris_app_prototype/src/model/employee/menu/leave_menu_model/leave_data_employee_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_approve_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/ot/ot_request_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/manual_approve_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/manual_reject_model.dart';
import 'package:hris_app_prototype/src/model/self_service/workdate/request_model.dart';
import 'package:hris_app_prototype/src/services/api_employee_self_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ManagerMenuService extends StatefulWidget {
  final EmployeeDatum? employeeData;
  const ManagerMenuService({
    Key? key,
    required this.employeeData,
  }) : super(key: key);

  @override
  State<ManagerMenuService> createState() => _ManagerMenuServiceState();
}

class _ManagerMenuServiceState extends State<ManagerMenuService> {
  LeaveRequestByEmployeeModel? leaveData;
  OtRequestModel? otData;
  ManualWorkDateRequestModel? manualWorkDateData;
  bool isLoading = true;

//slide
  int activeIndex = 0;

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
        widget.employeeData!.employeeId,
        widget.employeeData!.positionData.positionOrganizationId);
    otData = await ApiEmployeeSelfService.getOTRequestManager(
        widget.employeeData!.employeeId,
        widget.employeeData!.positionData.positionOrganizationId);
    manualWorkDateData =
        await ApiEmployeeSelfService.getManualWorkDateRequestManager(
            widget.employeeData!.employeeId,
            widget.employeeData!.positionData.positionOrganizationId);
    setState(() {
      leaveData;
      otData;
      manualWorkDateData;
      isLoading = false;
    });
  }

//functions for approve / reject
  leaveApprove(String requestId) async {
    LeaveApproveModel leaveModel = LeaveApproveModel(
        leaveRequestId: requestId, approveBy: widget.employeeData!.employeeId);
    bool success = await ApiEmployeeSelfService.leaveApprove(leaveModel);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 1);
  }

  leaveReject(String requestId) async {
    LeaveRejectModel leaveModel = LeaveRejectModel(
        leaveRequestId: requestId,
        rejectBy: widget.employeeData!.employeeId,
        comment: "Reject by Manager");
    bool success = await ApiEmployeeSelfService.leaveReject(leaveModel);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 2);
  }

  otApprove(String requestId) async {
    OtApproveModel model = OtApproveModel(
        otRequestId: requestId, approveBy: widget.employeeData!.employeeId);
    bool success = await ApiEmployeeSelfService.otApprove(model);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 1);
  }

  otReject(String requestId) async {
    OtRejectModel model = OtRejectModel(
        otRequestId: requestId,
        rejectBy: widget.employeeData!.employeeId,
        comment: "Reject by Manager");

    bool success = await ApiEmployeeSelfService.otReject(model);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 2);
  }

  manualWorkDateApprove(String requestId) async {
    ManualWorkdateApproveModel model = ManualWorkdateApproveModel(
        manualWorkDateRequestId: requestId,
        approveBy: widget.employeeData!.employeeId);
    bool success = await ApiEmployeeSelfService.manualWorkDateApprove(model);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 1);
  }

  manualWorkDateReject(String requestId) async {
    ManualWorkdateRejectModel model = ManualWorkdateRejectModel(
        manualWorkDateRequestId: requestId,
        rejectBy: widget.employeeData!.employeeId,
        comment: "Reject by Manager");

    bool success = await ApiEmployeeSelfService.manualWorkDateReject(model);
    if (success == true) {
      fetchData();
    }
    alertDialog(success, 2);
  }
//end functions for approve / reject----------------------------------------------------------------

  alertDialogInfo(String requestId, int type, String menu) {
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
              switch (menu) {
                case "leave":
                  if (type == 1) {
                    leaveApprove(requestId);
                  } else {
                    leaveReject(requestId);
                  }
                  break;
                case "ot":
                  if (type == 1) {
                    otApprove(requestId);
                  } else {
                    otReject(requestId);
                  }
                  break;
                case "manual":
                  if (type == 1) {
                    manualWorkDateApprove(requestId);
                  } else {
                    manualWorkDateReject(requestId);
                  }
                  break;
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                  items: [
                    //leave manage
                    Card(
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
                              trailing: const SizedBox(
                                width: 335,
                                child: IconStatus(),
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
                                child: leaveData == null
                                    ? isLoading == true
                                        ? myLoadingScreen
                                        : Center(
                                            child: Text(
                                            "ไม่มีคำร้อง",
                                            style: TextStyle(
                                                fontSize: 60,
                                                color: Colors.grey[200],
                                                fontWeight: FontWeight.bold),
                                          ))
                                    : ListView.builder(
                                        itemCount:
                                            leaveData?.leaveRequestData.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            color: mygreycolors,
                                            child: Tooltip(
                                              message: "",
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
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                    title: RichText(
                                                      text: TextSpan(
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style,
                                                          children: [
                                                            const TextSpan(
                                                                text: 'ชื่อ '),
                                                            TextSpan(
                                                              text:
                                                                  "${leaveData?.leaveRequestData[index].firstName} ${leaveData?.leaveRequestData[index].lastName}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    subtitle: RichText(
                                                      text: TextSpan(
                                                          style: DefaultTextStyle
                                                                  .of(context)
                                                              .style,
                                                          children: [
                                                            const TextSpan(
                                                                text: 'จำนวน '),
                                                            TextSpan(
                                                              text:
                                                                  "${leaveData?.leaveRequestData[index].leaveAmount}",
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                                text:
                                                                    ' วัน วันที่'),
                                                            TextSpan(
                                                              text: leaveData
                                                                  ?.leaveRequestData[
                                                                      index]
                                                                  .leaveDate
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    trailing: Tooltip(
                                                      message:
                                                          "รหัสพนักงาน : ${leaveData?.leaveRequestData[index].employeeId}\nชื่อ : ${leaveData?.leaveRequestData[index].firstName} ${leaveData?.leaveRequestData[index].lastName}\nตำแหน่ง : ${leaveData?.leaveRequestData[index].positionName}\nแผนก : ${leaveData?.leaveRequestData[index].departmentName}\nประเภท : ${leaveData?.leaveRequestData[index].leaveTypeData.leaveTypeNameTh}\nสถานะ : ${leaveData?.leaveRequestData[index].status}\nลาเพื่อ : ${leaveData?.leaveRequestData[index].leaveDecription}\nจำนวน : ${leaveData?.leaveRequestData[index].leaveAmount} วัน\nวันที่ : ${leaveData?.leaveRequestData[index].leaveDate}",
                                                      child: SizedBox(
                                                        width: 242,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            if (leaveData
                                                                    ?.leaveRequestData[
                                                                        index]
                                                                    .status ==
                                                                "request")
                                                              SizedBox(
                                                                width: 80,
                                                                height: 38,
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors
                                                                                .greenAccent,
                                                                            padding: const EdgeInsets.all(
                                                                                1)),
                                                                        onPressed:
                                                                            () {
                                                                          alertDialogInfo(
                                                                              leaveData!.leaveRequestData[index].leaveRequestId,
                                                                              1,
                                                                              "leave");
                                                                          // leaveApprove(leaveData!
                                                                          //     .leaveRequestData[
                                                                          //         index]
                                                                          //     .leaveRequestId);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Approve",
                                                                          style:
                                                                              TextStyle(color: Colors.black87),
                                                                        )),
                                                              ),
                                                            const Gap(5),
                                                            if (leaveData
                                                                    ?.leaveRequestData[
                                                                        index]
                                                                    .status !=
                                                                "reject")
                                                              SizedBox(
                                                                width: 80,
                                                                height: 38,
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Colors.red[
                                                                                700],
                                                                            padding: const EdgeInsets.all(
                                                                                1)),
                                                                        onPressed:
                                                                            () {
                                                                          alertDialogInfo(
                                                                              leaveData!.leaveRequestData[index].leaveRequestId,
                                                                              2,
                                                                              "leave");
                                                                          // leaveReject(leaveData!
                                                                          //     .leaveRequestData[
                                                                          //         index]
                                                                          //     .leaveRequestId);
                                                                        },
                                                                        child: const Text(
                                                                            "Reject")),
                                                              ),
                                                            const Gap(5),
                                                            // const Icon(
                                                            //   CupertinoIcons
                                                            //       .doc_plaintext,
                                                            //   size: 40,
                                                            // ),
                                                            leaveData
                                                                        ?.leaveRequestData[
                                                                            index]
                                                                        .status ==
                                                                    "request"
                                                                ? const Icon(
                                                                    Icons
                                                                        .timelapse_rounded,
                                                                    size: 30,
                                                                  )
                                                                : leaveData?.leaveRequestData[index]
                                                                            .status ==
                                                                        "approve"
                                                                    ? Icon(
                                                                        Icons
                                                                            .check_box_rounded,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .greenAccent[400],
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .cancel_rounded,
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .red[700],
                                                                      ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          );
                                        }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //ot manage
                    Card(
                      elevation: 4,
                      color: mythemecolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: SizedBox(
                        child: Column(
                          children: [
                            ListTile(
                              textColor: mygreycolors,
                              title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                              subtitle: const Text("OT"),
                              trailing: const SizedBox(
                                width: 335,
                                child: IconStatus(),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(14))),
                              child: isLoading == true
                                  ? myLoadingScreen
                                  : otData == null
                                      ? Center(
                                          child: Text(
                                          "ไม่มีคำร้อง",
                                          style: TextStyle(
                                              fontSize: 60,
                                              color: Colors.grey[200],
                                              fontWeight: FontWeight.bold),
                                        ))
                                      : isLoading == true
                                          ? myLoadingScreen
                                          : ListView.builder(
                                              itemCount: otData
                                                      ?.overTimeRequestData
                                                      .length ??
                                                  1,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  color: mygreycolors,
                                                  child: Center(
                                                    child: ListTile(
                                                        leading: leaveData ==
                                                                null
                                                            ? null
                                                            : Text(
                                                                "${otData?.overTimeRequestData[index].otTypeData.otTypeName}\n${otData?.overTimeRequestData[index].oTrequestTypeData.oTrequestTypeName}"),
                                                        title: Row(
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                  style: DefaultTextStyle.of(
                                                                          context)
                                                                      .style,
                                                                  children: [
                                                                    const TextSpan(
                                                                        text:
                                                                            'ชื่อ '),
                                                                    TextSpan(
                                                                      text:
                                                                          "${otData?.overTimeRequestData[index].employeeData.firstName} ${otData?.overTimeRequestData[index].employeeData.lastName}",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                            // Text(
                                                            //     "ชื่อ ${otData?.overTimeRequestData[index].employeeData.firstName} ${otData?.overTimeRequestData[index].employeeData.lastName}"),
                                                            Text(
                                                                " | Time Scan : ${otData?.overTimeRequestData[index].workTimeScan.startTime}"),
                                                            otData
                                                                        ?.overTimeRequestData[
                                                                            index]
                                                                        .workTimeScan
                                                                        .startTimeType ==
                                                                    ""
                                                                ? Container()
                                                                : Icon(
                                                                    otData?.overTimeRequestData[index].workTimeScan.startTimeType ==
                                                                            "time scan"
                                                                        ? Icons
                                                                            .fingerprint_rounded
                                                                        : otData?.overTimeRequestData[index].workTimeScan.startTimeType ==
                                                                                "manual work date"
                                                                            ? Icons.edit_document
                                                                            : Icons.abc,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 22,
                                                                  ),
                                                            const Gap(5),
                                                            Text(
                                                                "- ${otData?.overTimeRequestData[index].workTimeScan.endTime}"),
                                                            otData
                                                                        ?.overTimeRequestData[
                                                                            index]
                                                                        .workTimeScan
                                                                        .endTimeType ==
                                                                    ""
                                                                ? Container()
                                                                : Icon(
                                                                    otData?.overTimeRequestData[index].workTimeScan.endTimeType ==
                                                                            "time scan"
                                                                        ? Icons
                                                                            .fingerprint_rounded
                                                                        : otData?.overTimeRequestData[index].workTimeScan.endTimeType ==
                                                                                "manual work date"
                                                                            ? Icons.edit_document
                                                                            : Icons.abc,
                                                                    color: Colors
                                                                        .grey,
                                                                  )
                                                          ],
                                                        ),
                                                        subtitle: Text(
                                                            "วันที่ ${otData?.overTimeRequestData[index].otDate} เวลา ${otData?.overTimeRequestData[index].otData[0].otStartTime} - ${otData?.overTimeRequestData[index].otData[0].otEndTime} จำนวนชั่วโมง ${otData?.overTimeRequestData[index].otData[0].nCountOt}"),
                                                        trailing: SizedBox(
                                                          width: 242,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              if (otData
                                                                      ?.overTimeRequestData[
                                                                          index]
                                                                      .status ==
                                                                  "request")
                                                                SizedBox(
                                                                  width: 80,
                                                                  height: 38,
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, padding: const EdgeInsets.all(1)),
                                                                      onPressed: () {
                                                                        alertDialogInfo(
                                                                            otData!.overTimeRequestData[index].otRequestId,
                                                                            1,
                                                                            "ot");
                                                                      },
                                                                      child: const Text(
                                                                        "Approve",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black87),
                                                                      )),
                                                                ),
                                                              const Gap(5),
                                                              if (otData
                                                                      ?.overTimeRequestData[
                                                                          index]
                                                                      .status !=
                                                                  "reject")
                                                                SizedBox(
                                                                  width: 80,
                                                                  height: 38,
                                                                  child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], padding: const EdgeInsets.all(1)),
                                                                      onPressed: () {
                                                                        alertDialogInfo(
                                                                            otData!.overTimeRequestData[index].otRequestId,
                                                                            2,
                                                                            "ot");
                                                                      },
                                                                      child: const Text("Reject")),
                                                                ),
                                                              const Gap(5),
                                                              otData
                                                                          ?.overTimeRequestData[
                                                                              index]
                                                                          .status ==
                                                                      "request"
                                                                  ? const Icon(
                                                                      Icons
                                                                          .timelapse_rounded,
                                                                      size: 30,
                                                                    )
                                                                  : otData?.overTimeRequestData[index]
                                                                              .status ==
                                                                          "approve"
                                                                      ? Icon(
                                                                          Icons
                                                                              .check_box_rounded,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              Colors.greenAccent[400],
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .cancel_rounded,
                                                                          size:
                                                                              30,
                                                                          color:
                                                                              Colors.red[700],
                                                                        ),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                );
                                              }),
                            )),
                          ],
                        ),
                      ),
                    ),
                    // manual work date manage
                    Card(
                      elevation: 4,
                      color: mythemecolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      child: SizedBox(
                        child: Column(
                          children: [
                            ListTile(
                              textColor: mygreycolors,
                              title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                              subtitle: const Text("ManualWorkDate"),
                              trailing: const SizedBox(
                                width: 335,
                                child: IconStatus(),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(14))),
                              child: manualWorkDateData == null
                                  ? Center(
                                      child: Text(
                                      "ไม่มีคำร้อง",
                                      style: TextStyle(
                                          fontSize: 60,
                                          color: Colors.grey[200],
                                          fontWeight: FontWeight.bold),
                                    ))
                                  : isLoading == true
                                      ? myLoadingScreen
                                      : ListView.builder(
                                          itemCount: manualWorkDateData
                                                  ?.manualWorkDateRequestData
                                                  .length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: mygreycolors,
                                              child: Center(
                                                child: ListTile(
                                                    leading:
                                                        manualWorkDateData ==
                                                                null
                                                            ? null
                                                            : SizedBox(
                                                                height: 40,
                                                                child: Icon(
                                                                  manualWorkDateData
                                                                              ?.manualWorkDateRequestData[
                                                                                  index]
                                                                              .manualWorkDateTypeData
                                                                              .manualWorkDateTypeId ==
                                                                          "A01"
                                                                      ? CupertinoIcons
                                                                          .square_arrow_right
                                                                      : manualWorkDateData?.manualWorkDateRequestData[index].manualWorkDateTypeData.manualWorkDateTypeId ==
                                                                              "A02"
                                                                          ? CupertinoIcons
                                                                              .square_arrow_left
                                                                          : Icons
                                                                              .credit_card_off_rounded,
                                                                  color: manualWorkDateData
                                                                              ?.manualWorkDateRequestData[
                                                                                  index]
                                                                              .manualWorkDateTypeData
                                                                              .manualWorkDateTypeId ==
                                                                          "A01"
                                                                      ? mythemecolor
                                                                      : manualWorkDateData?.manualWorkDateRequestData[index].manualWorkDateTypeData.manualWorkDateTypeId ==
                                                                              "A02"
                                                                          ? Colors.red[
                                                                              700]
                                                                          : Colors
                                                                              .grey[600],
                                                                  size: 30,
                                                                )),
                                                    title: manualWorkDateData ==
                                                            null
                                                        ? const Center(
                                                            child: Text(
                                                            "ไม่มีใบคำร้อง",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ))
                                                        : Row(
                                                            children: [
                                                              Text(
                                                                  "ชื่อ ${manualWorkDateData?.manualWorkDateRequestData[index].firstName} ${manualWorkDateData?.manualWorkDateRequestData[index].lastName}"),
                                                              Text(
                                                                  " | ${manualWorkDateData?.manualWorkDateRequestData[index].manualWorkDateTypeData.manualWorkDateTypeNameTh}"),
                                                            ],
                                                          ),
                                                    subtitle:
                                                        manualWorkDateData ==
                                                                null
                                                            ? null
                                                            : Row(
                                                                children: [
                                                                  Text(
                                                                      "วันที่ ${manualWorkDateData?.manualWorkDateRequestData[index].date}  เวลาที่ขอ"),
                                                                  const Gap(5),
                                                                  manualWorkDateData
                                                                              ?.manualWorkDateRequestData[
                                                                                  index]
                                                                              .startTime ==
                                                                          "No data"
                                                                      ? Container()
                                                                      : Text(
                                                                          " ${manualWorkDateData?.manualWorkDateRequestData[index].startTime}"),
                                                                  const Gap(5),
                                                                  manualWorkDateData
                                                                              ?.manualWorkDateRequestData[
                                                                                  index]
                                                                              .endTime ==
                                                                          "No data"
                                                                      ? Container()
                                                                      : Text(
                                                                          "${manualWorkDateData?.manualWorkDateRequestData[index].endTime}")
                                                                ],
                                                              ),
                                                    trailing: SizedBox(
                                                      width: 242,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          if (manualWorkDateData
                                                                  ?.manualWorkDateRequestData[
                                                                      index]
                                                                  .status ==
                                                              "request")
                                                            SizedBox(
                                                              width: 80,
                                                              height: 38,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors
                                                                              .greenAccent,
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              1)),
                                                                      onPressed:
                                                                          () {
                                                                        alertDialogInfo(
                                                                            manualWorkDateData!.manualWorkDateRequestData[index].manualWorkDateRequestId,
                                                                            1,
                                                                            "manual");
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Approve",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black87),
                                                                      )),
                                                            ),
                                                          const Gap(5),
                                                          if (manualWorkDateData
                                                                  ?.manualWorkDateRequestData[
                                                                      index]
                                                                  .status !=
                                                              "reject")
                                                            SizedBox(
                                                              width: 80,
                                                              height: 38,
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors.red[
                                                                              700],
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              1)),
                                                                      onPressed:
                                                                          () {
                                                                        alertDialogInfo(
                                                                            manualWorkDateData!.manualWorkDateRequestData[index].manualWorkDateRequestId,
                                                                            2,
                                                                            "manual");
                                                                      },
                                                                      child: const Text(
                                                                          "Reject")),
                                                            ),
                                                          const Gap(5),
                                                          manualWorkDateData
                                                                      ?.manualWorkDateRequestData[
                                                                          index]
                                                                      .status ==
                                                                  "request"
                                                              ? const Icon(
                                                                  Icons
                                                                      .timelapse_rounded,
                                                                  size: 30,
                                                                )
                                                              : manualWorkDateData
                                                                          ?.manualWorkDateRequestData[
                                                                              index]
                                                                          .status ==
                                                                      "approve"
                                                                  ? Icon(
                                                                      Icons
                                                                          .check_box_rounded,
                                                                      size: 30,
                                                                      color: Colors
                                                                              .greenAccent[
                                                                          400],
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .cancel_rounded,
                                                                      size: 30,
                                                                      color: Colors
                                                                              .red[
                                                                          700],
                                                                    ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          }),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                buildIndicator(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 3,
      effect: WormEffect(
          dotHeight: 13,
          dotWidth: 13,
          activeDotColor: mythemecolor,
          type: WormType.thin,
          dotColor: Colors.grey[350]!),
    );
  }
}

class IconStatus extends StatelessWidget {
  const IconStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Status : "),
        Icon(
          Icons.check_box_rounded,
          size: 30,
          color: Colors.greenAccent[400],
        ),
        const Text("Approve "),
        const Gap(5),
        Icon(
          Icons.cancel_rounded,
          size: 30,
          color: Colors.red[700],
        ),
        const Text("Reject "),
        const Gap(5),
        Icon(
          Icons.timelapse_rounded,
          size: 30,
          color: mygreycolors,
        ),
        const Text("Request ")
      ],
    );
  }
}
