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
import 'package:lottie/lottie.dart';

class DataTablePerson extends StatefulWidget {
  const DataTablePerson({super.key});

  @override
  State<DataTablePerson> createState() => _DataTablePersonState();
}

class _DataTablePersonState extends State<DataTablePerson> {
  PersonData? _personData;
  List<PersonDatum>? personData;
  bool isloading = true;
  int? sortColumnIndex;
  int rowIndex = 10;
  bool sortAscending = false;
  bool sort = true;
  List<PersonDatum>? filterData;
  TextEditingController nameTh = TextEditingController();
  TextEditingController nameEn = TextEditingController();

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  var pageNumber = 1;
  var pageSize = 100;
  void fetchUser() async {
    //  isloading = true;
    context.read<PersonalBloc>().add(FetchDataList());
    // _personData = await ApiService.fetchAllPersonalData();
    if (_personData != null) {
      personData = _personData!.personData.toList();
      filterData = personData;
      setState(() {
        // isloading = false;
      });
    }
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 3) {
      if (sort) {
        personData!.sort((a, b) => a.personId.compareTo(b.personId));
      } else {
        personData!.sort((a, b) => b.personId.compareTo(a.personId));
      }
    }
    if (sortColumnIndex == 5) {
      if (sort) {
        personData!.sort((a, b) => a.fisrtNameTh.compareTo(b.fisrtNameTh));
      } else {
        personData!.sort((a, b) => b.fisrtNameTh.compareTo(a.fisrtNameTh));
      }
    }
    if (sortColumnIndex == 7) {
      if (sort) {
        personData!.sort((a, b) => a.firstNameEn.compareTo(b.firstNameEn));
      } else {
        personData!.sort((a, b) => b.firstNameEn.compareTo(a.firstNameEn));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 3) {
      if (sort) {
        filterData!.sort((a, b) => a.personId.compareTo(b.personId));
      } else {
        filterData!.sort((a, b) => b.personId.compareTo(a.personId));
      }
    }
    if (sortColumnIndex == 5) {
      if (sort) {
        filterData!.sort((a, b) => a.fisrtNameTh.compareTo(b.fisrtNameTh));
      } else {
        filterData!.sort((a, b) => b.fisrtNameTh.compareTo(a.fisrtNameTh));
      }
    }
    if (sortColumnIndex == 7) {
      if (sort) {
        filterData!.sort((a, b) => a.firstNameEn.compareTo(b.firstNameEn));
      } else {
        filterData!.sort((a, b) => b.firstNameEn.compareTo(a.firstNameEn));
      }
    }
  }

  void deletePerson(personId, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeletepersonModel delId = DeletepersonModel(
      personId: personId,
      modifiedBy: employeeId,
      comment: comment,
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
                  'Delete Personal Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบุคคล สำเร็จ',
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
                  'Delete Personal Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลบุคคล ไม่สำเร็จ',
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalBloc, PersonalState>(
      builder: (context, state) {
        if (state.onSearchData == false) {
          personData = state.personData;
          filterData = state.personData;
        } else {}
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Expanded(
                    child: state.isDataloading == true
                        ? SizedBox(
                            height: 600,
                            child: Center(
                                child: Lottie.asset('assets/loading.json',
                                    width: 500,
                                    height: 250,
                                    frameRate: FrameRate(60))))
                        : SingleChildScrollView(
                            child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: PaginatedDataTable(
                                showFirstLastButtons: true,
                                source: PersonDataTableSource(personData,
                                    context, fetchUser, deletePerson),
                                header: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(flex: 4, child: Container()),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.search_rounded),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: TextFormField(
                                                    controller: nameEn,
                                                    onChanged: (value) {
                                                      if (value == '') {
                                                        context
                                                            .read<
                                                                PersonalBloc>()
                                                            .add(
                                                                DissSearchEvent());
                                                      } else {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  PersonalBloc>()
                                                              .add(
                                                                  SearchEvent());
                                                          personData =
                                                              filterData!.where(
                                                                  (element) {
                                                            final nameId = element
                                                                .personId
                                                                .toLowerCase()
                                                                .contains(value
                                                                    .toLowerCase());
                                                            final nameEn = element
                                                                .firstNameEn
                                                                .toLowerCase()
                                                                .contains(value
                                                                    .toLowerCase());
                                                            final nameTh = element
                                                                .fisrtNameTh
                                                                .toLowerCase()
                                                                .contains(value
                                                                    .toLowerCase());
                                                            final lastnameTh = element
                                                                .lastNameTh
                                                                .toLowerCase()
                                                                .contains(value
                                                                    .toLowerCase());
                                                            final lastNameEn = element
                                                                .lastNameEn
                                                                .toLowerCase()
                                                                .contains(value
                                                                    .toLowerCase());
                                                            return nameId ||
                                                                nameEn ||
                                                                nameTh ||
                                                                lastnameTh ||
                                                                lastNameEn;
                                                          }).toList();
                                                        });
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        hintText:
                                                            'Search (EN/TH)',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                                availableRowsPerPage: const [5, 10, 20],
                                onRowsPerPageChanged: (value) {
                                  setState(() {
                                    rowIndex = value!;
                                  });
                                },
                                rowsPerPage: rowIndex,
                                columnSpacing: 40,
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sort,
                                columns: [
                                  const DataColumn(label: Text('')),
                                  const DataColumn(
                                      label: Icon(Icons.person_rounded)),
                                  const DataColumn(label: Text('')),
                                  DataColumn(
                                      label: const Text(
                                        'รหัสประจำตัว',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        setState(() {
                                          sort = !sort;
                                          sortColumnIndex = 3;

                                          if (state.onSearchData == true) {
                                            onSortSearchColumn(
                                                columnIndex, ascending);
                                          } else {
                                            onSortColumn(
                                                columnIndex, ascending);
                                          }
                                        });
                                      }),

                                  const DataColumn(
                                      label: Text('  คำนำหน้า',
                                          style: TextStyle(fontSize: 16))),
                                  DataColumn(
                                      label: const Text('ชื่อ(TH)',
                                          style: TextStyle(fontSize: 16)),
                                      onSort: (columnIndex, ascending) {
                                        setState(() {
                                          sort = !sort;
                                          sortColumnIndex = 5;

                                          if (state.onSearchData == true) {
                                            onSortSearchColumn(
                                                columnIndex, ascending);
                                          } else {
                                            onSortColumn(
                                                columnIndex, ascending);
                                          }
                                        });
                                      }),
                                  const DataColumn(
                                      label: Text('นามสกุล(TH)',
                                          style: TextStyle(fontSize: 16))),
                                  DataColumn(
                                      label: const Text('Name(EN)',
                                          style: TextStyle(fontSize: 16)),
                                      onSort: (columnIndex, ascending) {
                                        setState(() {
                                          sort = !sort;
                                          sortColumnIndex = 7;

                                          if (state.onSearchData == true) {
                                            onSortSearchColumn(
                                                columnIndex, ascending);
                                          } else {
                                            onSortColumn(
                                                columnIndex, ascending);
                                          }
                                        });
                                      }),
                                  const DataColumn(
                                    label: Text('Lastname(EN)',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  // const DataColumn(
                                  //     label: Text('ประเภท',
                                  //         style: TextStyle(fontSize: 16))),
                                  const DataColumn(
                                      label: Text('    สถานะ',
                                          style: TextStyle(fontSize: 16))),

                                  const DataColumn(
                                      label: Text('     Edit/Remove',
                                          style: TextStyle(fontSize: 16))),
                                  const DataColumn(label: Text('')),
                                ],
                              ),
                            ),
                          )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<PersonDatum>? data;
  final Function fetchFunction;
  final Function deletePerson;

  PersonDataTableSource(
      this.data, this.context, this.fetchFunction, this.deletePerson);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final person = data![index];
    return DataRow(cells: [
      const DataCell(Text('')),
      const DataCell(Icon(Icons.person)),
      const DataCell(Text('')),
      DataCell(Text(person.personId)),
      DataCell(Text(
          '${person.titleName.titleNameEn} / ${person.titleName.titleNameTh}')),
      DataCell(Text(person.fisrtNameTh)),
      DataCell(Text(person.lastNameTh)),
      DataCell(Text(person.firstNameEn)),
      DataCell(Text(person.lastNameEn)),

      DataCell(person.personStatus == false
          ? const SizedBox(
              width: 84,
              child: Card(
                  elevation: 2,
                  color: Colors.redAccent,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          ' Inactive',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )),
            )
          : SizedBox(
              width: 84,
              child: Card(
                  elevation: 2,
                  color: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(' Active',
                            style: TextStyle(color: Colors.grey[800]))
                      ],
                    ),
                  )),
            )),
      // const DataCell(Text('ตำแแหน่ง')),
      DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
            elevation: 4,
            child: IconButton(
                splashRadius: 25,
                hoverColor: Colors.yellow[100],
                color: Colors.yellow[800],
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showEditDialog(person.personId);
                })),
        Card(
            elevation: 4,
            child: IconButton(
                splashRadius: 30,
                hoverColor: Colors.red[100],
                color: Colors.red,
                icon: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.delete),
                ),
                onPressed: () {
                  showdialogDeletePerson(person.personId);
                }))
      ])),
      const DataCell(Text('')),
    ]);
  }

  @override
  int get rowCount => data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

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
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              icon: IconButton(
                color: Colors.red[600],
                icon: const Icon(
                  Icons.cancel,
                ),
                onPressed: () {
                  fetchFunction;
                  Navigator.pop(context);
                  comment.text = '';
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
                                deletePerson(personid, comment.text);
                                fetchFunction;
                                Navigator.pop(context);
                                comment.text = '';
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
}
