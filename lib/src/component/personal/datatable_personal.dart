import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee/create_employee.dart';
import 'package:hris_app_prototype/src/component/personal/0_create_person_stepper.dart.dart';
import 'package:hris_app_prototype/src/component/personal/0_update_layout.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/person/allperson_model.dart';
import 'package:hris_app_prototype/src/model/person/deleteperson_madel.dart';
import 'package:hris_app_prototype/src/model/person/generate_personId_model.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class DataTablePerson extends StatefulWidget {
  final bool employee;
  final PositionOrganizationDatum? positionOrgData;
  const DataTablePerson(
      {super.key, required this.employee, this.positionOrgData});

  @override
  State<DataTablePerson> createState() => _DataTablePersonState();
}

class _DataTablePersonState extends State<DataTablePerson> {
  PersonData? _personData;
  List<PersonDatum>? personData;
  bool isloading = false;
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
    if (widget.employee == true) {
      context.read<PersonalBloc>().add(FetchDataNotInEmployeeList());
    } else {
      context.read<PersonalBloc>().add(FetchDataList());
    }
    // _personData = await ApiService.fetchAllPersonalData();
    if (_personData != null) {
      personData = _personData!.personData.toList();
      filterData = personData;
      setState(() {
        // isloading = false;
      });
    }
  }

  void addPerson() async {
    AddModel? dataId = await ApiService.generatePersonId();
    if (dataId != null) {
      setState(() {
        isloading = false;
        showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black45,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.height - 40,
                    padding: const EdgeInsets.all(20),
                    child: MyStepper(personId: dataId.personId.toString())),
              );

              // MyAddPersonbyIDLayout(
              //   personId: dataId.personId.toString(),
              // );
            });
      });
    } else {
      isloading = true;
    }
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 1) {
      if (sort) {
        personData!.sort((a, b) => a.personId.compareTo(b.personId));
      } else {
        personData!.sort((a, b) => b.personId.compareTo(a.personId));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        personData!.sort((a, b) => a.fisrtNameTh.compareTo(b.fisrtNameTh));
      } else {
        personData!.sort((a, b) => b.fisrtNameTh.compareTo(a.fisrtNameTh));
      }
    }
    if (sortColumnIndex == 4) {
      if (sort) {
        personData!.sort((a, b) => a.firstNameEn.compareTo(b.firstNameEn));
      } else {
        personData!.sort((a, b) => b.firstNameEn.compareTo(a.firstNameEn));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 1) {
      if (sort) {
        filterData!.sort((a, b) => a.personId.compareTo(b.personId));
      } else {
        filterData!.sort((a, b) => b.personId.compareTo(a.personId));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        filterData!.sort((a, b) => a.fisrtNameTh.compareTo(b.fisrtNameTh));
      } else {
        filterData!.sort((a, b) => b.fisrtNameTh.compareTo(a.fisrtNameTh));
      }
    }
    if (sortColumnIndex == 5) {
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Tooltip(
        message: "Create a new person",
        child: widget.employee == true
            ? null
            : MyFloatingButton(
                onPressed: () {
                  setState(() {
                    isloading = !isloading;
                    addPerson();
                    isloading = !isloading;
                  });
                },
                icon: const Icon(
                  Icons.person_add_alt_1,
                  size: 28,
                  color: Colors.white,
                )),
      ),
      body: BlocBuilder<PersonalBloc, PersonalState>(
        builder: (context, state) {
          if (state.onSearchData == false) {
            personData = state.personData;
            filterData = state.personData;
          } else {}
          return state.isDataloading == true || personData == null
              ? myLoadingScreen
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: PaginatedDataTable(
                                showFirstLastButtons: true,
                                source: PersonDataTableSource(
                                    personData,
                                    context,
                                    fetchUser,
                                    deletePerson,
                                    widget.employee,
                                    widget.positionOrgData),
                                header: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: widget.employee == true ? 2 : 3,
                                        child: RichText(
                                          text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: [
                                                TextSpan(
                                                  text: widget.employee == true
                                                      ? "เลือกบุคคลเข้ารายงานตัว"
                                                      : 'บันทึกข้อมูลส่วนบุคคล',
                                                  style: GoogleFonts.kanit(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 19)),
                                                ),
                                                TextSpan(
                                                  text: widget.employee == true
                                                      ? "  (Select Your Person)"
                                                      : '  (Personel Profile)',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextFormFieldSearch(
                                                controller: nameEn,
                                                enabled: true,
                                                onChanged: (value) {
                                                  if (value == '') {
                                                    context
                                                        .read<PersonalBloc>()
                                                        .add(DissSearchEvent());
                                                  } else {
                                                    setState(() {
                                                      context
                                                          .read<PersonalBloc>()
                                                          .add(SearchEvent());
                                                      personData = filterData!
                                                          .where((element) {
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
                                                }),
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
                                  if (widget.employee == false)
                                    const DataColumn(
                                        label: Icon(
                                            Icons.photo_camera_front_sharp)),
                                  DataColumn(
                                      label: const TextThai(
                                        text: 'รหัสประจำตัว',
                                      ),
                                      onSort: (columnIndex, ascending) {
                                        setState(() {
                                          sort = !sort;
                                          sortColumnIndex = 1;

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
                                      label: TextThai(text: '  คำนำหน้า')),
                                  DataColumn(
                                      label: const TextThai(text: 'ชื่อ'),
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
                                      label: TextThai(text: 'นามสกุล')),
                                  DataColumn(
                                      label: const Text('Name',
                                          style: TextStyle(fontSize: 15)),
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
                                    label: Text('Lastname',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  // const DataColumn(
                                  //     label: Text('ประเภท',
                                  //         style: TextStyle(fontSize: 16))),
                                  if (widget.employee == false)
                                    const DataColumn(
                                        label: Text('    Status',
                                            style: TextStyle(fontSize: 15))),

                                  if (widget.employee == false)
                                    const DataColumn(
                                        label: Text('     Details/Remove',
                                            style: TextStyle(fontSize: 15))),
                                  if (widget.employee == true)
                                    const DataColumn(label: Text("   Select")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<PersonDatum>? data;
  final Function fetchFunction;
  final Function deletePerson;
  final bool employee;
  final PositionOrganizationDatum? positionOrg;

  PersonDataTableSource(this.data, this.context, this.fetchFunction,
      this.deletePerson, this.employee, this.positionOrg);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final person = data![index];
    return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return index % 2 == 0 ? Colors.white : myrowscolors;
        }),
        cells: [
          if (employee == false)
            DataCell(CircleAvatar(
              backgroundColor: mythemecolor,
              child: Icon(
                Icons.person,
                color: mygreycolors,
              ),
            )),
          DataCell(Text(person.personId)),
          DataCell(Text(
              '${person.titleName.titleNameEn} / ${person.titleName.titleNameTh}')),
          DataCell(Text(person.fisrtNameTh)),
          DataCell(Text(person.lastNameTh)),
          DataCell(Text(person.firstNameEn)),
          DataCell(Text(person.lastNameEn)),

          if (employee == false)
            DataCell(Container(
              constraints: const BoxConstraints(
                  minWidth: 90, maxWidth: 92 // ความสูงขั้นต่ำที่ต้องการ
                  ),
              child: person.personStatus == false
                  ? const Card(
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
                      ))
                  : Card(
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
          if (employee == false)
            DataCell(
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                width: 40,
                height: 38,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1)),
                    onPressed: () {
                      showEditDialog(person.personId);
                    },
                    child: const Icon(Icons.edit_document)),
              ),
              const Gap(5),
              SizedBox(
                width: 40,
                height: 38,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myredcolors,
                        padding: const EdgeInsets.all(1)),
                    onPressed: () {
                      showdialogDeletePerson(person.personId);
                    },
                    child: const Icon(Icons.delete_rounded)),
              ),
            ])),
          if (employee == true)
            DataCell(ElevatedButton(
                onPressed: () {
                  showDialogSelectd(person, positionOrg);
                },
                child: const Text('Select')))
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
                width: 300,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 2, child: Text('หมายเหตุ (โปรดระบุ)')),
                    Expanded(
                      flex: 12,
                      child: Center(
                        child: Card(
                          elevation: 2,
                          child: TextFormField(
                            validator: Validatorless.required('กรอกข้อความ'),
                            controller: comment,
                            minLines: 1,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                filled: true,
                                fillColor: Colors.white),
                          ),
                        ),
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

  showDialogSelectd(PersonDatum data, PositionOrganizationDatum? positionOrg) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'เพิ่มข้อมูลพนักงาน : ',
                              style: GoogleFonts.kanit(),
                            ),
                            TextSpan(
                              text:
                                  '${data.titleName.titleNameTh} ${data.fisrtNameTh} ${data.lastNameTh} ',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17)),
                            ),
                            TextSpan(
                              text: 'รหัส ',
                              style: GoogleFonts.kanit(),
                            ),
                            TextSpan(
                              text: data.personId,
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17)),
                            ),
                          ]),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // context
                        //     .read<OrganizationBloc>()
                        //     .add(FetchDataTableOrgEvent());
                      },
                    ),
                  ],
                ),
              ),
              content: SafeArea(
                child: SizedBox(
                  width: 520,
                  height: 550,
                  child: Column(
                    children: [
                      Expanded(
                          child: CreateEmployee(
                        person: data,
                        onEdit: false,
                        positionOrg: positionOrg,
                      )),
                    ],
                  ),
                ),
              ));
        });
  }
}
