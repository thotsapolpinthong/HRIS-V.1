import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/idcard/add/2_add_idcard.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/idcard/update/2_update_idcard.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/passport/add/2_add_passport.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/passport/update/2_update_passport.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/delete/delidcard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/idcard/update/getidentifycard_model.dart';
import 'package:hris_app_prototype/src/model/cardinfomation/passport/update/getpassport_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class CardInfoLayout extends StatefulWidget {
  final String personId;
  const CardInfoLayout({super.key, required this.personId});

  @override
  State<CardInfoLayout> createState() => _CardInfoLayoutState();
}

class _CardInfoLayoutState extends State<CardInfoLayout> {
  bool _isCardInfoExpanded = false;
  bool isloading = true;
  bool ispassportdata = false;
  bool isidentifycard = false;
  TextEditingController comment = TextEditingController();

  GetIdCardModel? idcardData;
  Getpassport? passportData;

  @override
  void initState() {
    fetchCardinfomation();
    super.initState();
  }

  fetchCardinfomation() async {
    idcardData = await ApiService.fetchIDcardData(widget.personId);

    passportData = await ApiService.fetchPassportData(widget.personId);

    setState(() {
      if (idcardData != null) {
        isidentifycard = true;
      }
      if (idcardData == null) {
        isidentifycard = false;
      }
      if (passportData != null) {
        ispassportdata = true;
      }
      if (passportData == null) {
        ispassportdata = false;
      }
      isloading = false;
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
                  _isCardInfoExpanded = !_isCardInfoExpanded;
                });
              },
              leading:
                  const Icon(Icons.credit_card_rounded, color: Colors.white),
              title: const Text(
                  'บันทึกข้อมูลบัตรประจำตัว (Card Information TH/ENG)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white)),
              trailing: ExpandIcon(
                isExpanded: _isCardInfoExpanded,
                color: Colors.white,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isCardInfoExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isCardInfoExpanded)
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: 265,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text("บัตรประจำตัวประชาชน (Identification Card)"),
                  ),
                  Expanded(
                    flex: 4,
                    child: FutureBuilder(
                        future: fetchCardinfomation(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return isloading == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    var data = idcardData?.personalCardData;
                                    final cardId = data?.cardId;
                                    final issuedDate = data?.issuedDate;
                                    final expiredDate = data?.expiredDate;
                                    final issueddistrict =
                                        data?.issuedAtDistrict.districtNameTh;
                                    final issuedprovince =
                                        data?.issuedAtProvince.provinceNameTh;

                                    return isidentifycard == false
                                        ? Center(
                                            child: Column(
                                              children: [
                                                const Text('ไม่พบข้อมูล'),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      showDialogAddidcard();
                                                    },
                                                    child: const Icon(Icons.add,
                                                        size: 18)),
                                              ],
                                            ),
                                          )
                                        : Card(
                                            elevation: 4,
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.assignment_ind_rounded),
                                              title: Text(
                                                  'เลขที่บัตรประชาชน $cardId'),
                                              subtitle: Text(
                                                  'วันที่ออกบัตร : $issuedDate | วันหมดอายุ : $expiredDate | ออกให้ ณ อำเภอ/เขต : $issueddistrict | ออกให้ ณ จังหวัด : $issuedprovince'),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          splashRadius: 30,
                                                          color: Colors
                                                              .yellow[800],
                                                          onPressed: () {
                                                            setState(() {
                                                              showDialogEditIdCard();
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
                                                      IconButton(
                                                          splashRadius: 30,
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            showdialogDeleteId(
                                                                data!.id);
                                                          },
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_outward_rounded,
                                                            size: 28,
                                                          )),
                                                    ]),
                                              ),
                                            ),
                                          );
                                  },
                                );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('หนังสือเดินทาง (Passport)'),
                  ),
                  Expanded(
                    flex: 4,
                    child: FutureBuilder(
                        future: fetchCardinfomation(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return isloading == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    var data = passportData?.passportData;
                                    final passportId = data?.passportId;
                                    final issueedCountry =
                                        data?.issuedAtCountry.countryNameTh;
                                    final exppassport =
                                        data?.expiredDatePassport;
                                    final expvisa = data?.expireDateVisa;

                                    return ispassportdata == false
                                        ? Center(
                                            child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text('ไม่พบข้อมูล'),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      showDialogAddPassport();
                                                    },
                                                    child: const Icon(Icons.add,
                                                        size: 18)),
                                              ],
                                            ),
                                          )
                                        : Card(
                                            elevation: 4,
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.menu_book_rounded),
                                              title: Text(
                                                  'เลขที่หนังสือเดินทาง $passportId'),
                                              subtitle: Text(
                                                  'วันหมดอายุพาสปอร์ต : $exppassport | วันหมดอายุวีซ่า : $expvisa | ออกให้ ณ ประเทศ : $issueedCountry'),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                          splashRadius: 30,
                                                          color: Colors
                                                              .yellow[800],
                                                          onPressed: () {
                                                            setState(() {
                                                              showDialogEditPassport();
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
                                                      IconButton(
                                                          splashRadius: 30,
                                                          color: Colors.red,
                                                          onPressed: () {
                                                            showdialogDeletePassport(
                                                                data!.id);
                                                          },
                                                          icon: const Icon(
                                                              Icons
                                                                  .arrow_outward_rounded,
                                                              size: 28)),
                                                    ]),
                                              ),
                                            ),
                                          );
                                  },
                                );
                        }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      // child: Expanded(
                      //     flex: 1,
                      //     child: ElevatedButton(
                      //         onPressed: null, child: Icon(Icons.add))
                      //         ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fade(duration: 200.ms),
      ],
    );
  }

  void showDialogEditIdCard() {
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
                    const Text('แก้ไขข้อมมูลบัตรปชช. (Edit ID Card.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchCardinfomation();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 420,
                height: 360,
                child: Column(
                  children: [
                    // Text(
                    //   'แก้ไขข้อมูลบัตรประชาชน',
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    UpdateIdCard(
                        personId: idcardData!.personalCardData.personId,
                        idcardData: idcardData)
                  ],
                ),
              ));
        });
  }

  void showDialogEditPassport() {
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
                    const Text('แก้ไขข้อมมูลพาสปอร์ต. (Edit Passport.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchCardinfomation();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 420,
                height: 360,
                child: Column(
                  children: [
                    // Text(
                    //   'แก้ไขข้อมูลบัตรประชาชน',
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    UpdatePassport(
                        personId: idcardData!.personalCardData.personId,
                        passportData: passportData)
                  ],
                ),
              ));
        });
  }

  showdialogDeleteId(id) {
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
                  fetchCardinfomation();
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
                                deleteIdcard(id);
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

  void deleteIdcard(_id) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteIdcardModel delId = DeleteIdcardModel(
      id: _id,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.delId(delId);

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
                  'Delete ID Card Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบัตรปชช. สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchCardinfomation();
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
                  'Delete ID Card Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบัตรปชช. ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              fetchCardinfomation();
            });
          },
        ).show();
      }
    });
  }

  showdialogDeletePassport(passportid) {
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
                  fetchCardinfomation();
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
                                deletePasspord(passportid);
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

  void deletePasspord(passportid) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteIdcardModel delId = DeleteIdcardModel(
      id: passportid,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.delPassport(delId);

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
                  'Delete Passpord Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลพาสปอร์ต สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchCardinfomation();
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
                  'Delete Passpord Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลพาสปอร์ต ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              fetchCardinfomation();
            });
          },
        ).show();
      }
    });
  }

  void showDialogAddidcard() {
    showDialog(
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
                    const Text('เพิ่มข้อมูลบัตรประชาชน (Create ID Card.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchCardinfomation();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 500,
                height: 350,
                child: Column(
                  children: [
                    Expanded(
                      child: AddIdCard(
                        personId: widget.personId,
                        addButton: true,
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  void showDialogAddPassport() {
    showDialog(
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
                    const Text('เพิ่มข้อมูลพาสปอร์ต (Create Passport.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchCardinfomation();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 500,
                height: 420,
                child: Column(
                  children: [
                    Expanded(
                      child: AddPassport(
                        personId: widget.personId,
                        addButton: true,
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
