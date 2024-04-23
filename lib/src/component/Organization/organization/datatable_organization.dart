import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/organization_bloc/bloc/organization_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/create_edit_org.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/organization/organization/delete_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';

import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrganizationDataTable extends StatefulWidget {
  const OrganizationDataTable({super.key});

  @override
  State<OrganizationDataTable> createState() => _OrganizationDataTableState();
}

class _OrganizationDataTableState extends State<OrganizationDataTable> {
  List<OrganizationDatum>? orgData;
  List<OrganizationDatum>? filterData;
  TextEditingController search = TextEditingController();
  int rowIndex = 10;
  int? sortColumnIndex;
  bool sort = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() {
    context.read<OrganizationBloc>().add(FetchDataTableOrgEvent());
  }

  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteOrganizationByIdModel deldata = DeleteOrganizationByIdModel(
      organizationId: id,
      modifiedBy: employeeId,
      comment: comment,
    );
    setState(() {});
    bool success = await ApiOrgService.deleteOrganizationById(deldata);
    alertDialog(success);
  }

  alertDialog(bool success) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true ? 'Deleted  Success.' : 'Deleted  Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true ? 'ลบข้อมูล สำเร็จ' : 'ลบข้อมูล ไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        setState(() {
          context.read<OrganizationBloc>().add(FetchDataTableOrgEvent());
        });
      },
    ).show();
  }

  onSortSearchColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        orgData!
            .sort((a, b) => a.organizationCode.compareTo(b.organizationCode));
      } else {
        orgData!
            .sort((a, b) => b.organizationCode.compareTo(a.organizationCode));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        orgData!.sort((a, b) =>
            a.departMentData.deptNameTh.compareTo(b.departMentData.deptNameTh));
      } else {
        orgData!.sort((a, b) =>
            b.departMentData.deptNameTh.compareTo(a.departMentData.deptNameTh));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        orgData!.sort((a, b) =>
            a.departMentData.deptNameEn.compareTo(b.departMentData.deptNameEn));
      } else {
        orgData!.sort((a, b) =>
            b.departMentData.deptNameEn.compareTo(a.departMentData.deptNameEn));
      }
    }
    if (sortColumnIndex == 4) {
      if (sort) {
        orgData!.sort((a, b) => a.parentOrganizationNodeData.organizationName
            .compareTo(b.parentOrganizationNodeData.organizationName));
      } else {
        orgData!.sort((a, b) => b.parentOrganizationNodeData.organizationName
            .compareTo(a.parentOrganizationNodeData.organizationName));
      }
    }
  }

  onSortColumn(int columnIndex, bool ascending) {
    if (sortColumnIndex == 0) {
      if (sort) {
        filterData!
            .sort((a, b) => a.organizationCode.compareTo(b.organizationCode));
      } else {
        filterData!
            .sort((a, b) => b.organizationCode.compareTo(a.organizationCode));
      }
    }
    if (sortColumnIndex == 2) {
      if (sort) {
        filterData!.sort((a, b) =>
            a.departMentData.deptNameTh.compareTo(b.departMentData.deptNameTh));
      } else {
        filterData!.sort((a, b) =>
            b.departMentData.deptNameTh.compareTo(a.departMentData.deptNameTh));
      }
    }
    if (sortColumnIndex == 3) {
      if (sort) {
        filterData!.sort((a, b) =>
            a.departMentData.deptNameEn.compareTo(b.departMentData.deptNameEn));
      } else {
        filterData!.sort((a, b) =>
            b.departMentData.deptNameEn.compareTo(a.departMentData.deptNameEn));
      }
    }
    if (sortColumnIndex == 4) {
      if (sort) {
        filterData!.sort((a, b) => a.parentOrganizationNodeData.organizationName
            .compareTo(b.parentOrganizationNodeData.organizationName));
      } else {
        filterData!.sort((a, b) => b.parentOrganizationNodeData.organizationName
            .compareTo(a.parentOrganizationNodeData.organizationName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationBloc, OrganizationState>(
      builder: (context, state) {
        if (state.onSearchData == false || orgData == null) {
          orgData = state.organizationDataTableModel?.organizationData;
          filterData = state.organizationDataTableModel?.organizationData;
        } else {}
        return state.isDataLoading == true && orgData == null
            ? myLoadingScreen
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: PaginatedDataTable(
                          columnSpacing: 30,
                          showFirstLastButtons: true,
                          rowsPerPage: rowIndex,
                          availableRowsPerPage: const [5, 10, 20],
                          sortColumnIndex: sortColumnIndex,
                          sortAscending: sort,
                          onRowsPerPageChanged: (value) {
                            setState(() {
                              rowIndex = value!;
                            });
                          },
                          header: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text('Organizations Table.')),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.search_rounded),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextFormField(
                                              controller: search,
                                              onChanged: (value) {
                                                if (value == '') {
                                                  context
                                                      .read<OrganizationBloc>()
                                                      .add(DissSearchEvent());
                                                } else {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            OrganizationBloc>()
                                                        .add(SearchEvent());
                                                    orgData = filterData!
                                                        .where((element) {
                                                      final nameId = element
                                                          .organizationCode
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      final type = element
                                                          .organizationTypeData
                                                          .organizationTypeName
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      final nameTH = element
                                                          .departMentData
                                                          .deptNameTh
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());
                                                      final nameEn = element
                                                          .departMentData
                                                          .deptNameEn
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase());

                                                      return nameId ||
                                                          nameEn ||
                                                          type ||
                                                          nameTH;
                                                    }).toList();
                                                  });
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(
                                                          10.0),
                                                  hintText: 'Search (EN/TH)',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          columns: [
                            DataColumn(
                                numeric: true,
                                label: const Text('Organization (Code)'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 0;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            const DataColumn(label: Text('Type')),
                            DataColumn(
                                label: const Text('Name (TH)'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 2;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            DataColumn(
                                label: const Text('Name (EN)'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 3;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            DataColumn(
                                label: const Text('Parent'),
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = !sort;
                                    sortColumnIndex = 4;
                                    if (state.onSearchData == true) {
                                      onSortSearchColumn(
                                          columnIndex, ascending);
                                    } else {
                                      onSortColumn(columnIndex, ascending);
                                    }
                                  });
                                }),
                            const DataColumn(
                                numeric: true, label: Text('Status      ')),
                            const DataColumn(
                                numeric: true,
                                label: Text('Edit/Remove    ',
                                    style: TextStyle(fontSize: 16))),
                          ],
                          source: PersonDataTableSource(
                              orgData, context, fetchData, deleteData),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(),
                ),
              );
      },
    );
  }
}

class PersonDataTableSource extends DataTableSource {
  final BuildContext context;
  List<OrganizationDatum>? data;
  final Function fetchFunction;
  final Function deleteFunction;

  PersonDataTableSource(
      this.data, this.context, this.fetchFunction, this.deleteFunction);
  TextEditingController comment = TextEditingController();
  @override
  DataRow getRow(int index) {
    final orgData = data![index];
    return DataRow(cells: [
      DataCell(Text(orgData.organizationCode)),
      DataCell(Text(orgData.organizationTypeData.organizationTypeName)),
      DataCell(Text(orgData.departMentData.deptNameTh)),
      DataCell(SizedBox(
        width: 150,
        child: Text(orgData.departMentData.deptNameEn == 'No data'
            ? ' - '
            : orgData.departMentData.deptNameEn),
      )),
      DataCell(SizedBox(
          width: 150,
          child: Text(orgData.parentOrganizationNodeData.organizationName))),
      DataCell(orgData.organizationStatus == "Inactive"
          ? Container(
              constraints: const BoxConstraints(
                  minWidth: 92, maxWidth: 92 // ความสูงขั้นต่ำที่ต้องการ
                  ),
              child: const Card(
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
          : Container(
              constraints: const BoxConstraints(
                  minWidth: 90, maxWidth: 90 // ความสูงขั้นต่ำที่ต้องการ
                  ),
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
      DataCell(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 40,
          height: 38,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  padding: const EdgeInsets.all(1)),
              onPressed: () {
                showEditDialog(orgData);
              },
              child: const Icon(Icons.edit)),
        ),
        const Gap(5),
        SizedBox(
          width: 40,
          height: 38,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding: const EdgeInsets.all(1)),
              onPressed: () {
                showdialogDeletePerson(orgData.organizationId);
              },
              child: const Icon(Icons.delete_rounded)),
        ),
      ])),
    ]);
  }

  @override
  int get rowCount => data!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  showEditDialog(orgData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('แก้ไขโครงสร้างองค์กร (Edit Organization.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 420,
                height: 480,
                child: Column(
                  children: [
                    Expanded(
                        child: EditOrganization(
                      onEdit: true,
                      orgData: orgData,
                      ongraph: false,
                    )),
                  ],
                ),
              ));
        });
  }

  showdialogDeletePerson(id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return MyDeleteBox(
            onPressedCancel: () {
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              deleteFunction(id, comment.text);
              fetchFunction;
              Navigator.pop(context);
              comment.text = '';
            },
          );

          // AlertDialog(
          //     icon: IconButton(
          //       color: Colors.red[600],
          //       icon: const Icon(
          //         Icons.cancel,
          //       ),
          //       onPressed: () {
          //         fetchFunction;
          //         Navigator.pop(context);
          //         comment.text = '';
          //       },
          //     ),
          //     content: SizedBox(
          //       width: 300,
          //       height: 200,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Expanded(flex: 2, child: Text('หมายเหตุ (โปรดระบุ)')),
          //           Expanded(
          //             flex: 12,
          //             child: Center(
          //               child: Card(
          //                 elevation: 2,
          //                 child: TextFormField(
          //                   validator: Validatorless.required('กรอกข้อความ'),
          //                   controller: comment,
          //                   minLines: 1,
          //                   maxLines: 4,
          //                   decoration: const InputDecoration(
          //                       labelStyle: TextStyle(color: Colors.black),
          //                       border: OutlineInputBorder(
          //                           borderSide:
          //                               BorderSide(color: Colors.black)),
          //                       filled: true,
          //                       fillColor: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //                 ElevatedButton(
          //                     onPressed: () {
          //                       deleteFunction(id, comment.text);
          //                       fetchFunction;
          //                       Navigator.pop(context);
          //                       comment.text = '';
          //                     },
          //                     child: const Text("OK"))
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //     ));
        });
  }
}
