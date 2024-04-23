import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphview/GraphView.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/organization_bloc/bloc/organization_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/create_edit_org.dart';
import 'package:hris_app_prototype/src/component/Organization/position_org/position_org_layout.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/model/organization/organization/delete_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';

import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreeViewOrganization extends StatefulWidget {
  const TreeViewOrganization({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TreeViewPageFromJsonState createState() => _TreeViewPageFromJsonState();
}

class _TreeViewPageFromJsonState extends State<TreeViewOrganization>
    with SingleTickerProviderStateMixin {
  List<OrganizationDatum>? orgData;
  GetOrganizationAllModel? datum;
  TextEditingController comment = TextEditingController();
  Node? nodetest;
  bool isLoading = true;
  bool isNodeEmpty = true;

  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  // var json = {
  //   'nodes': [
  //     {'id': 'HQ001', 'label': 'STEC.'},
  //     {'id': "ADM000", 'label': 'ADM000'},
  //     {'id': "AGM001", 'label': 'AGM001'},
  //     {'id': "EX001", 'label': 'EX001'},
  //     {'id': "INV001", 'label': 'INV001'},
  //     {'id': "IT001", 'label': 'IT001'},
  //     {'id': "SH001", 'label': 'SH001'},
  //   ],
  // };

  @override
  void initState() {
    context.read<OrganizationBloc>().add(FetchDataTableOrgEvent());
    super.initState();
  }

  nodedata(List<OrganizationDatum>? data) async {
    // datum = await ApiOrgService.fetchDataTableOrganization();
    // List<OrganizationDatum>? orgDataNode;
    // orgDataNode = data!.organizationData;
    var edges = data!;

    for (var element in edges) {
      var fromNodeId = element.parentOrganizationNodeData.organizationCode;
      var toNodeId = element.organizationCode;
      if (fromNodeId == 'HQ001' && toNodeId == 'HQ001' ||
          element.organizationStatus == 'Inactive') {
        //  print(element.organizationCode);
        if (element.organizationStatus == 'Inactive') {
          graph.removeNode(Node.Id(toNodeId));
        }
      } else {
        graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
        if (!graph.contains(node: Node.Id(toNodeId))) {
          graph.addNode(Node.Id(toNodeId));
        }
      }
    }
    if (graph.nodes.isEmpty) {
      isNodeEmpty = true;
    } else {
      isNodeEmpty = false;
    }

    // var edges = json['edges']!;
    // edges.forEach((element) {
    //   var fromNodeId = element['from'];
    //   var toNodeId = element['to'];
    //   if (fromNodeId == 'HQ001' && toNodeId == 'HQ001') {
    //   } else {
    //     graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    //   }
    // });

    builder
      ..siblingSeparation = (30)
      ..levelSeparation = (100)
      ..subtreeSeparation = (100)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    isLoading = false;
  }

// animate floating buttons.
  Alignment upperBtnAlign = const Alignment(0.968, 0.94);
  Alignment lowerBtnAlign = const Alignment(0.968, 0.94);
  bool fabClick = false;

  void changeBtnAlign() {
    if (fabClick) {
      setState(() {
        upperBtnAlign = const Alignment(0.94, 0.7);
        lowerBtnAlign = const Alignment(0.84, 0.89);
      });
    } else {
      setState(() {
        upperBtnAlign = const Alignment(0.97, 0.954);
        lowerBtnAlign = const Alignment(0.968, 0.94);
      });
    }
  }

//-----------------

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationBloc, OrganizationState>(
      builder: (context, state) {
        if (state.isDataLoading == false) {
          graph = Graph()..isTree = true;
          orgData = [];
          orgData = state.organizationDataTableModel?.organizationData;
          if (orgData != null) {
            nodedata(orgData);
          }
        }
        return Scaffold(
          backgroundColor: mygreycolors,
          body: state.isDataLoading == true ||
                  isLoading == true ||
                  orgData!.length <= 1
              ? myLoadingScreen
              : isNodeEmpty == true
                  ? Center(
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                              hoverColor: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                showDialogCreate(null);
                              },
                              child: const SizedBox(
                                height: 100,
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                      child:
                                          Text('Create Organization Chart.')),
                                ),
                              ))),
                    )
                  : Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: InteractiveViewer(
                                  constrained: false,
                                  boundaryMargin:
                                      const EdgeInsets.all(double.infinity),
                                  minScale: 0.01,
                                  maxScale: 5.6,
                                  child: GraphView(
                                    graph: graph,
                                    algorithm: BuchheimWalkerAlgorithm(
                                        builder, TreeEdgeRenderer(builder)),
                                    paint: Paint()
                                      ..color = Colors.grey[400]!
                                      ..strokeWidth = 2
                                      ..style = PaintingStyle.stroke,

                                    builder: (Node node) {
                                      // I can decide what widget should be shown here based on the id
                                      var a = node.key!.value;

                                      var nodes = orgData;
                                      var nodeValue = nodes?.firstWhere(
                                          (element) =>
                                              element.organizationCode == a);

                                      return rectangleWidget(
                                          nodeValue!.organizationCode
                                              .toString(),
                                          nodeValue.departMentData.deptNameEn
                                              .toString(),
                                          nodeValue);
                                    },
                                    //   var nodes = json['nodes']!;
                                    //   var nodeValue = nodes.firstWhere(
                                    //       (element) => element['id'] == a);
                                    //   return rectangleWidget(
                                    //       nodeValue['label'] as String?);
                                    // },
                                  )).animate().fadeIn(),
                            ),
                          ],
                        ),
                        // AnimatedAlign(
                        //   alignment: upperBtnAlign,
                        //   curve: Curves.easeOut,
                        //   duration: const Duration(milliseconds: 150),
                        //   onEnd: () {
                        //     debugPrint("ANIMATION ENDED");
                        //   },
                        //   child: SizedBox(
                        //     width: 50,
                        //     height: 50,
                        //     child: FloatingActionButton(
                        //       heroTag: "upperButton",
                        //       backgroundColor:
                        //           const Color.fromARGB(255, 58, 196, 129),
                        //       foregroundColor: Colors.white,
                        //       child: const Icon(Icons.edit),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                        // AnimatedAlign(
                        //   alignment: lowerBtnAlign,
                        //   curve: Curves.easeOut,
                        //   duration: const Duration(milliseconds: 250),
                        //   onEnd: () {
                        //     debugPrint("ANIMATION ENDED");
                        //   },
                        //   child: SizedBox(
                        //     width: 50,
                        //     height: 50,
                        //     child: FloatingActionButton(
                        //       heroTag: "lowerButton",
                        //       backgroundColor: Colors.red[600],
                        //       foregroundColor: Colors.white,
                        //       child: const Icon(Icons.delete_rounded),
                        //       onPressed: () {},
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
          // floatingActionButton: FloatingActionButton(
          //   heroTag: "addButton",
          //   backgroundColor: fabClick
          //       ? Colors.white
          //       : const Color.fromARGB(255, 13, 71, 161),
          //   foregroundColor: fabClick ? Colors.grey[600] : Colors.white,
          //   child: fabClick == false
          //       ? const Icon(
          //           Icons.menu_rounded,
          //           size: 30,
          //         )
          //       : Transform.flip(
          //           flipX: true,
          //           child: const Icon(
          //             Icons.arrow_back_ios_rounded,
          //             size: 20,
          //           ),
          //         ),
          //   onPressed: () {
          //     setState(() {
          //       fabClick = !fabClick;
          //     });
          //     changeBtnAlign();
          //   },
          // ).animate().shake(),
        );
      },
    );
  }

  Widget rectangleWidget(String? a, String? name, OrganizationDatum? data) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
                width: 160,
                constraints: const BoxConstraints(
                  minHeight: 50, // ความสูงขั้นต่ำที่ต้องการ
                ),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.white, spreadRadius: 1),
                  ],
                ),
                child: Center(
                    child: Tooltip(
                  message: a == "HQ001" ? "" : "View Position Organization.",
                  child: InkWell(
                      onTap: a == "HQ001"
                          ? null
                          : () {
                              editPositionOranization(data);
                            },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              color: mythemecolor,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${data!.departMentData.deptCode}.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Text('$name', textAlign: TextAlign.center),
                        ],
                      )),
                ))),
          ),
        ),
        Positioned(
          top: 10,
          right: -0.5,
          child: PopupMenuButton(
            splashRadius: 1,
            elevation: 10,
            iconSize: 22,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add',
                  child: Text('Add'),
                ),
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                if (a != "HQ001")
                  const PopupMenuItem<String>(
                    value: 'del',
                    child: Text('Delete'),
                  ),
              ];
            },
            onSelected: (value) {
              if (value == 'add') {
                showDialogCreate(data);
              } else if (value == 'edit') {
                showEditDialog(data);
              } else {
                showdialogDeletePerson(data.organizationId);
              }
            },
          ),
        ).animate().fade(delay: 200.ms).shake(delay: 500.ms),
        // if (a != "HQ001")
        //   Positioned(
        //       top: 1,
        //       child: Container(
        //         decoration: BoxDecoration(
        //             color:
        //                 data.organizationTypeData.organizationTypeName == "แผนก"
        //                     ? Colors.teal
        //                     : Colors.amber[700],
        //             borderRadius: BorderRadius.circular(4)),
        //         width: 40,
        //         height: 20,
        //         child: Center(
        //           child: TextThai(
        //             text: data.organizationTypeData.organizationTypeName,
        //             textStyle:
        //                 const TextStyle(color: Colors.white, fontSize: 12),
        //           ),
        //         ),
        //       )).animate().fade(delay: 200.ms).shake(delay: 500.ms),
      ],
    );
  }

//create
  showDialogCreate(orgData) {
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
                    const Text('เพิ่มโครงสร้างองค์กร (Create Organization.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<OrganizationBloc>()
                            .add(FetchDataTableOrgEvent());
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 450,
                height: 500,
                child: Column(
                  children: [
                    Expanded(
                        child: EditOrganization(
                      onEdit: false,
                      orgData: orgData,
                      ongraph: orgData == null ? false : true,
                    )),
                  ],
                ),
              ));
        });
  }

  //edit
  showEditDialog(orgData) {
    showDialog(
        barrierDismissible: false,
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
                        context
                            .read<OrganizationBloc>()
                            .add(FetchDataTableOrgEvent());
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 420,
                height: 450,
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
              Navigator.pop(context);
              comment.text = '';
            },
            controller: comment,
            onPressedOk: () {
              deleteData(id, comment.text);
              Navigator.pop(context);
              comment.text = '';
            },
          );

          // AlertDialog(
          //     backgroundColor: mygreycolors,
          //     icon: IconButton(
          //       color: Colors.red[600],
          //       icon: const Icon(
          //         Icons.cancel,
          //       ),
          //       onPressed: () {
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
          //                       deleteData(id, comment.text);
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

  editPositionOranization(orgData) {
    setState(() {
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Card(
                  color: mygreycolors,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: PositionOrganizationWidget(data: orgData)),
            );
          });
    });
  }

//delete
  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteOrganizationByIdModel deldata = DeleteOrganizationByIdModel(
      organizationId: id,
      modifiedBy: employeeId,
      comment: comment,
    );

    bool success = await ApiOrgService.deleteOrganizationById(deldata);
    alertDialog(success);
    setState(() {
      context.read<OrganizationBloc>().add(FetchDataTableOrgEvent());
    });
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
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           const MyHomepage()), // รีเรนเดอร์หน้าใหม่ที่คุณต้องการแสดง
          // );
        });
      },
    ).show();
  }

//-----------------
}
