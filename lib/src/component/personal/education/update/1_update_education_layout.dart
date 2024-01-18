import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/education/add/2_add_education.dart';
import 'package:hris_app_prototype/src/component/personal/education/update/2_update_education.dart';
import 'package:hris_app_prototype/src/model/education/delete/delete_education_model.dart';
import 'package:hris_app_prototype/src/model/education/getdata_education_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateEducationbyperson extends StatefulWidget {
  final String personId;
  const UpdateEducationbyperson({super.key, required this.personId});

  @override
  State<UpdateEducationbyperson> createState() =>
      _UpdateEducationbypersonState();
}

class _UpdateEducationbypersonState extends State<UpdateEducationbyperson> {
  bool _isEducationExpanded = false;
  bool isloading = true;
  int itemCount = 1;
  bool datanull = true;
  TextEditingController comment = TextEditingController();
  GetEducationModel? educationData;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    educationData = await ApiService.getEducationById(widget.personId);

    setState(() {
      if (educationData != null) {
        itemCount = educationData!.educationData.length;

        datanull = false;
      }
      isloading = false;
    });
  }

  void showDialogEditEducation(data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'แก้ไขประวัติการศึกษา (Edit Education Information)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchData();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                height: 360,
                child: Column(
                  children: [
                    Expanded(
                      child: UpdateEducation(
                          personId: widget.personId, educationData: data),
                    )
                  ],
                ),
              ));
        });
  }

  showdialogDelete(educationId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              icon: IconButton(
                color: Colors.red[600],
                icon: const Icon(
                  Icons.cancel,
                ),
                onPressed: () {
                  fetchData();
                  Navigator.pop(context);
                },
              ),
              content: SizedBox(
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('หมายเหตุ (โปรดระบุ)')),
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        validator: Validatorless.required('กรอกข้อความ'),
                        controller: comment,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                delete(educationId);
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  void delete(educationId) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteEducationModel delEducation = DeleteEducationModel(
      educationId: educationId,
      personId: widget.personId,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.deleteEducation(delEducation);

    setState(() {
      if (success == true) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Delete Education Infomation Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลประวัติการศึกษา สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchData();
            });
          },
        ).show();
      } else {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.error,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Delete Education Infomation Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลประวัติการศึกษา ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              fetchData();
            });
          },
        ).show();
      }
    });
  }

  void showDialogAddAddress() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'เพิ่มประวัติการศึกษา (Add Education Information)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchData();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  height: 440,
                  child: Column(
                    children: [
                      Expanded(
                        child: AddEducation(
                          personId: widget.personId,
                          addButton: true,
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Card(
            color: mythemecolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 2,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isEducationExpanded = !_isEducationExpanded;
                });
              },
              leading: const Icon(Icons.school_rounded, color: Colors.white),
              title: const Text(
                  'บันทึกประวัติการศึกษา (Education Information  TH/ENG)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white)),
              trailing: ExpandIcon(
                isExpanded: _isEducationExpanded,
                color: Colors.white,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isEducationExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isEducationExpanded)
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: FutureBuilder(
                        future: fetchData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return isloading == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: itemCount,
                                  itemBuilder: (context, index) {
                                    var data =
                                        educationData?.educationData[index];
                                    final educationLevel =
                                        data?.educationLevel.educationLevelTh;
                                    final educationQualification = data
                                        ?.educationQualification
                                        .educationQualificaionTh;
                                    final institue =
                                        data?.institute.instituteNameTh;
                                    final country = data?.country.countryNameTh;
                                    final gpa = data?.gpa;
                                    final major = data?.major.majorTh;

                                    return datanull == true
                                        ? const Center(
                                            child: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('ไม่พบข้อมูลการศึกษา'),
                                                  ],
                                                )),
                                          )
                                        : Card(
                                            elevation: 4,
                                            child: ListTile(
                                              onTap: () {},
                                              leading: const Icon(
                                                  Icons.school_rounded),
                                              title: Text(
                                                  'ระดับการศึกษา : $educationLevel  วุฒิการศึกษา : $educationQualification '),
                                              subtitle: Text(
                                                  'ประเทศที่สำเร็จการศึกษา : $country | สถาบัน : $institue | วิชาเอก : $major | เกรดเฉลี่ย : $gpa'),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        child: IconButton(
                                                            splashRadius: 30,
                                                            color: Colors
                                                                .yellow[800],
                                                            onPressed: () {
                                                              setState(() {
                                                                showDialogEditEducation(
                                                                    data);
                                                              });
                                                            },
                                                            icon: const Icon(
                                                                Icons.edit)),
                                                      ),
                                                      Container(
                                                        child: IconButton(
                                                            splashRadius: 30,
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              showdialogDelete(data!
                                                                  .educaationId);
                                                            },
                                                            icon: const Icon(Icons
                                                                .delete_rounded)),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                  },
                                );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                showDialogAddAddress();
                              },
                              child: const Icon(Icons.add, size: 20)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ).animate().fade(duration: 200.ms),
      ],
    );
  }
}
