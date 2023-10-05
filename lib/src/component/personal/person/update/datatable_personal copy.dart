import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/personal/0_update_layout.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/model/person/deleteperson_madel.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class DataTablePerson2 extends StatefulWidget {
  const DataTablePerson2({super.key});

  @override
  State<DataTablePerson2> createState() => _DataTablePersonState();
}

class _DataTablePersonState extends State<DataTablePerson2> {
  PersonData? _personData;
  List<PersonDatum> personData = [];
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
    //context.read<PersonalBloc>().add(FetchDataList());
    _personData = await ApiService.fetchAllPersonalData();
    setState(() {
      personData = _personData!.personData.toList();
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
                flex: 9,
                child: BlocBuilder<PersonalBloc, PersonalState>(
                  builder: (context, state) {
                    return FutureBuilder(builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      return isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.grey[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 12),
                                    child: DataTable(
                                      decoration: BoxDecoration(),
                                      horizontalMargin: 1,
                                      columns: const [
                                        DataColumn(
                                            label: Icon(Icons.person_rounded)),
                                        DataColumn(label: Text('รหัสประจำตัว')),
                                        DataColumn(label: Text('แผนก')),
                                        DataColumn(label: Text('ชื่อ(TH)')),
                                        DataColumn(label: Text('นามสกุล(TH)')),
                                        DataColumn(label: Text('Name(EN)')),
                                        DataColumn(label: Text('Lastname(EN)')),
                                        DataColumn(label: Text('ประเภท')),
                                        DataColumn(label: Text('สถานะ')),
                                        DataColumn(label: Text('ตำแแหน่ง')),
                                        DataColumn(
                                            label: Text('  Edit/Remove')),
                                      ],
                                      rows: getRows(personData),
                                    ),
                                  ),
                                ),
                              )),
                            );
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

  List<DataRow> getRows(List<PersonDatum> personData) => personData
      .map((PersonDatum data) => DataRow(
            cells: [
              DataCell(Icon(Icons.person)),
              DataCell(Text(data.personId)),
              DataCell(Text('department')),
              DataCell(Text(data.fisrtNameTh)),
              DataCell(Text(data.lastNameTh)),
              DataCell(Text(data.firstNameEn)),
              DataCell(Text(data.lastNameEn)),
              DataCell(Text('ประเภท')),
              DataCell(Text('สถานะ')),
              DataCell(Text('ตำแแหน่ง')),
              DataCell(
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Card(
                    elevation: 4,
                    child: IconButton(
                        splashRadius: 25,
                        hoverColor: Colors.yellow[100],
                        color: Colors.yellow[800],
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showEditDialog(data.personId);
                        })),
                Card(
                    elevation: 4,
                    child: IconButton(
                        splashRadius: 30,
                        hoverColor: Colors.red[100],
                        color: Colors.red,
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.delete),
                        ),
                        onPressed: () {
                          showdialogDeletePerson(data.personId);
                        }))
              ])),
            ],
          ))
      .toList();

  showEditDialog(personId) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return MyUpdateLayout(personId: personId);
        });
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
