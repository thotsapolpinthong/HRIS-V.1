import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/family/add/2_add_family.dart';
import 'package:hris_app_prototype/src/component/personal/family/update/2_update_family.dart';
import 'package:hris_app_prototype/src/model/education/delete/delete_education_model.dart';
import 'package:hris_app_prototype/src/model/family_member/get_family_by_id_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateFamilybyperson extends StatefulWidget {
  final String personId;
  const UpdateFamilybyperson({super.key, required this.personId});

  @override
  State<UpdateFamilybyperson> createState() =>
      _UpdateFamilybypersonbypersonState();
}

class _UpdateFamilybypersonbypersonState extends State<UpdateFamilybyperson> {
  bool _isFamilyExpanded = false;
  bool isloading = true;
  int itemCount = 1;
  bool datanull = true;
  TextEditingController comment = TextEditingController();
  FamilyMemberDataModel? familydata;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    familydata = await ApiService.getFamilyById(widget.personId);

    setState(() {
      if (familydata != null) {
        itemCount = familydata!.familyMemberData.length;

        datanull = false;
      }
      isloading = false;
    });
  }

  void showDialogEditFamily(data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('แก้ไขข้อมูลครอบครัว (Edit Family Member.)'),
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
                height: 480,
                width: 480,
                child: Column(
                  children: [
                    Expanded(
                        child: UpdateFamily(
                            personId: widget.personId, familydata: data))
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

  void showDialogAddFamily() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('เพิ่มข้อมูลครอบครัว (Add Family Member )'),
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
                  height: 480,
                  width: 500,
                  child: Column(
                    children: [
                      Expanded(
                        child: AddFamilymember(
                          personId: widget.personId,
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
            color: Colors.deepOrange[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 2,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isFamilyExpanded = !_isFamilyExpanded;
                });
              },
              leading: const Icon(Icons.family_restroom_rounded),
              title: const Text(
                  'บันทึกข้อมูลครอบครัว (Family Member Information TH/EN)'),
              trailing: ExpandIcon(
                isExpanded: _isFamilyExpanded,
                expandedColor: Colors.black,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isFamilyExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isFamilyExpanded)
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
                    child: FutureBuilder(builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      return isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: itemCount,
                              itemBuilder: (context, index) {
                                var data = familydata?.familyMemberData[index];
                                final familymembername = data
                                    ?.familyMemberTypeData.familyMemberTypeName;
                                final titlename =
                                    data?.titleNameData.titleNameTh;
                                final name = data?.firstName;
                                final lastname = data?.lastName;
                                final midname = data?.midName == 'ไม่ระบุข้อมูล'
                                    ? ''
                                    : data?.midName;
                                final vital =
                                    data?.vitalStatusData.vitalStatusName;
                                String durationString = '${data?.age}';
                                List<String> parts = durationString.split(' ');
                                int years = int.tryParse(parts[0]) ?? 0;

                                return datanull == true
                                    ? const Center(
                                        child: SizedBox(
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('ไม่พบข้อมูลครอบครัว'),
                                              ],
                                            )),
                                      )
                                    : Card(
                                        elevation: 4,
                                        child: ListTile(
                                          onTap: () {},
                                          leading: const Icon(Icons.person),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Text('ความสัมพันธ์ : '),
                                              Text(
                                                '$familymembername',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                              '$titlename $name $midname $lastname   |   อายุ : $years ปี   |   ปัจจุบัน : $vital'),
                                          trailing: SizedBox(
                                            width: 100,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        splashRadius: 30,
                                                        color:
                                                            Colors.yellow[800],
                                                        onPressed: () {
                                                          setState(() {
                                                            showDialogEditFamily(
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
                                                          // showdialogDelete(data!
                                                          //     .educaationId);
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
                      child: Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    showDialogAddFamily();
                                  },
                                  child: const Icon(Icons.add, size: 20)),
                            ],
                          )),
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
