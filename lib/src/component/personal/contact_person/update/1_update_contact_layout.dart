import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/add/2_add_contact.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/update/2_update_contact.dart';
import 'package:hris_app_prototype/src/model/contact_person/delete/delete_contact_model.dart';
import 'package:hris_app_prototype/src/model/contact_person/getdata_contact_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateContactbyperson extends StatefulWidget {
  final String personId;
  const UpdateContactbyperson({super.key, required this.personId});

  @override
  State<UpdateContactbyperson> createState() => _UpdateContactbypersonState();
}

class _UpdateContactbypersonState extends State<UpdateContactbyperson> {
  bool _isContactExpanded = false;
  bool isloading = true;
  int itemCount = 1;
  bool datanull = true;
  TextEditingController comment = TextEditingController();
  GetDataContact? contactdata;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    contactdata = await ApiService.getContactById(widget.personId);

    setState(() {
      if (contactdata != null) {
        itemCount = contactdata!.contactPersonInfoData.length;

        datanull = false;
      }
      isloading = false;
    });
  }

  void showDialogEditContact(data) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('แก้ไขบุคคลที่ติดต่อได้ (Edit Contact)'),
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
                height: 500,
                width: 450,
                child: Column(
                  children: [
                    Expanded(
                        child: UpdateContactPerson(
                            personId: widget.personId, contactdata: data))
                  ],
                ),
              ));
        });
  }

  showdialogDelete(contactPersonInfoId) {
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
                                delete(contactPersonInfoId);
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

  void delete(contactPersonInfoId) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteContactModel delContact = DeleteContactModel(
      contactPersonInfoId: contactPersonInfoId,
      personId: widget.personId,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.deleteContactById(delContact);

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
                  'Delete Contact Person Information Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบุคคลที่สามารถติดต่อได้ สำเร็จ',
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
                  'Delete Contact Person Information Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบุคคลที่สามารถติดต่อได้ ไม่สำเร็จ',
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

  void showDialogAddContact() {
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
                    const Text('เพิ่มบุคคลที่ติดต่อได้ (Add Contact.)'),
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
                  height: 520,
                  width: 500,
                  child: Column(
                    children: [
                      Expanded(
                        child: AddContactPerson(
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
                  _isContactExpanded = !_isContactExpanded;
                });
              },
              leading: const Icon(
                Icons.contact_phone_rounded,
                color: Colors.white,
              ),
              title: const Text(
                  'บันทึกข้อมูลบุคคลที่สามารถติดต่อได้ (Contact Person Information TH/EN)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white)),
              trailing: ExpandIcon(
                isExpanded: _isContactExpanded,
                color: Colors.white,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isContactExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isContactExpanded)
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
                                    var data = contactdata
                                        ?.contactPersonInfoData[index];
                                    final title = data?.titleName.titleNameTh;
                                    final relationship = data?.relation;
                                    final firstname = data?.firstName;
                                    final lastname = data?.lastName;
                                    final occupation = data?.occupation ?? " -";
                                    final companyname =
                                        data?.companyName == 'ไม่พบข้อมูล'
                                            ? '  - '
                                            : data?.companyName;
                                    final positionname =
                                        data?.positionName == 'ไม่พบข้อมูล'
                                            ? '  - '
                                            : data?.positionName;
                                    final tel = data?.mobilePhone;
                                    final midname =
                                        data?.midName == 'ไม่พบข้อมูล'
                                            ? ''
                                            : data?.midName;

                                    return datanull == true
                                        ? const Center(
                                            child: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        'ไม่พบข้อมูลผู้ติดต่อ'),
                                                  ],
                                                )),
                                          )
                                        : Card(
                                            elevation: 4,
                                            child: ListTile(
                                              onTap: () {},
                                              leading: const Icon(Icons
                                                  .quick_contacts_dialer_rounded),
                                              title: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Text('ความสัมพันธ์ : '),
                                                  Text(
                                                    '$relationship',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Text(
                                                  '$title $firstname $midname $lastname   |   อาชีพ : $occupation   |   ชื่อ บริษัท : $companyname   |   ตำแหน่ง : $positionname   |   เบอร์โทรติดต่อ : $tel'),
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
                                                                showDialogEditContact(
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
                                                                  .contactPersonInfoId);
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
                                showDialogAddContact();
                              },
                              child: const Icon(Icons.add, size: 20)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ).animate().fade(duration: 300.ms),
      ],
    );
  }
}
