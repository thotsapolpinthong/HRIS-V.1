import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/0_update_layout.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/model/person/deleteperson_madel.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class ListPersonbyId extends StatefulWidget {
  const ListPersonbyId({super.key});

  @override
  State<ListPersonbyId> createState() => _ListPersonbyIdState();
}

class _ListPersonbyIdState extends State<ListPersonbyId> {
  PersonData? _personData;
  bool isloading = true;

  TextEditingController comment = TextEditingController();
  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  var pageNumber = 1;
  var pageSize = 100;
  void fetchUser() async {
    context.read<PersonalBloc>().add(FetchDataList());
    // _personData = await ApiService.fetchAllPersonalData(
    //   pageNumber.toString(),
    //   pageSize.toString(),
    // );
    setState(() {
      _personData;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalBloc, PersonalState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blueGrey, // Background color
                            // Text Color (Foreground color)
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded)),
                    ),
                    Expanded(
                      flex: 8,
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.greenAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 2,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Expanded(
                      flex: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('รหัสประจำตัว'),
                          Text('แผนก'),
                          Text('ชื่อ'),
                          Text('นามสกุล'),
                          Text('Name'),
                          Text('Lastname'),
                          Text('ประเภท'),
                          Text('สถานะ'),
                          Text('ตำแแหน่ง'),
                        ],
                      )),
                  Expanded(flex: 4, child: Text(""))
                ],
              ),
              Expanded(
                flex: 9,
                child: BlocBuilder<PersonalBloc, PersonalState>(
                  builder: (context, state) {
                    return FutureBuilder(builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      return isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: state.personData?.length,
                              itemBuilder: (context, index) {
                                var data = state.personData?[index];
                                final personid = data?.personId;
                                final nameTH = data?.fisrtNameTh;
                                final lastnameTH = data?.lastNameTh;
                                final nameEn = data?.firstNameEn;
                                final lastnamEN = data?.lastNameEn;
                                //แผนก
                                //ประเภทพนง.
                                //สถานะการทำงาน
                                //ตำแหน่ง
                                return Card(
                                  elevation: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Text(
                                          "   $personid        แผนก     $nameTH  $lastnameTH   $nameEn   $lastnamEN"),
                                      trailing: SizedBox(
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              splashRadius: 20,
                                              hoverColor: Colors.blue[100],
                                              color: Colors.black87,
                                              icon: const Icon(
                                                  Icons.list_alt_rounded),
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        icon: IconButton(
                                                          color:
                                                              Colors.red[600],
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        content: Stack(
                                                          children: [
                                                            Container(
                                                                child: Card(
                                                              color:
                                                                  myDefaultBackground,
                                                              elevation: 8,
                                                              child: SizedBox(
                                                                width: 1080,
                                                                height: 600,
                                                                child: ListView(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Card(
                                                                            color:
                                                                                Colors.amberAccent[100],
                                                                            elevation:
                                                                                8,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                children: [
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Card(
                                                                            color:
                                                                                Colors.blue[50],
                                                                            elevation:
                                                                                8,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                children: [
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                  TextFormField(),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Card(
                                                                      elevation:
                                                                          8,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          TextFormField(),
                                                                          TextFormField(),
                                                                          TextFormField(),
                                                                          TextFormField(),
                                                                          TextFormField(),
                                                                          TextFormField(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                            Card(
                                              elevation: 4,
                                              child: IconButton(
                                                  splashRadius: 25,
                                                  hoverColor:
                                                      Colors.yellow[100],
                                                  color: Colors.yellow[800],
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    showGeneralDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        barrierLabel:
                                                            MaterialLocalizations
                                                                    .of(context)
                                                                .modalBarrierDismissLabel,
                                                        barrierColor:
                                                            Colors.black45,
                                                        transitionDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                        pageBuilder: (BuildContext
                                                                buildContext,
                                                            Animation animation,
                                                            Animation
                                                                secondaryAnimation) {
                                                          return MyUpdateLayout(
                                                              personId: personid
                                                                  .toString());
                                                        });
                                                  }),
                                            ),
                                            Card(
                                              elevation: 4,
                                              child: IconButton(
                                                  splashRadius: 30,
                                                  hoverColor: Colors.red[100],
                                                  color: Colors.red,
                                                  icon: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: const Icon(
                                                        Icons.delete),
                                                  ),
                                                  onPressed: () {
                                                    showdialogDeletePerson(
                                                        personid.toString());
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showdialogDeletePerson(personid) {
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
                  fetchUser();
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
                                deletePerson(personid);
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

  void deletePerson(personId) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeletepersonModel delId = DeletepersonModel(
      personId: personId,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    bool success = await ApiService.delPerson(delId);

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
                  'ลบข้อมูลที่อยู่ สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchUser();
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
                  'ลบข้อมูลที่อยู่ ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              fetchUser();
            });
          },
        ).show();
      }
    });
  }
}
