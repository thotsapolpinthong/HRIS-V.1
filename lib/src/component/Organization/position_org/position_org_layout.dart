import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphview/GraphView.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/position_org/create_edit_position_org.dart';
import 'package:hris_app_prototype/src/component/Organization/position_org/datatable_position_org.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/permission/role_permission/role_permission_manage.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';
import 'package:hris_app_prototype/src/component/textformfield/textformfield_custom.dart';
import 'package:hris_app_prototype/src/model/organization/organization/get_org_all_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/delete_position_org_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/get_position_org_by_org_id_model.dart';
import 'package:hris_app_prototype/src/model/organization/position_org/update_position_org_model.dart';
import 'package:hris_app_prototype/src/model/role_permission/roles/roles_model.dart';
import 'package:hris_app_prototype/src/services/api_org_service.dart';
import 'package:hris_app_prototype/src/services/api_role_permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class PositionOrganizationWidget extends StatefulWidget {
  final OrganizationDatum? data;
  const PositionOrganizationWidget({super.key, required this.data});

  @override
  State<PositionOrganizationWidget> createState() =>
      _PositionOrganizationWidgetState();
}

class _PositionOrganizationWidgetState extends State<PositionOrganizationWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController comment = TextEditingController();
  GetPositionOrgByOrgIdModel? positionOrgData;
  bool isLoading = true;
  bool isNodeEmpty = true;
  bool isExpandedPage = false;

//role
  List<RoleDatum> roleList = [];
  TextEditingController roleId = TextEditingController();

  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  nodedata(List<PositionOrganizationDatum>? data) async {
    // datum = await ApiOrgService.fetchDataTableOrganization();
    // List<OrganizationDatum>? orgDataNode;
    // orgDataNode = data!.organizationData;
    if (data != null) {
      var edges = data;

      for (var element in edges) {
        var fromNodeId = element.parentPositionNodeId.positionOrganizationId;
        var toNodeId = element.positionOrganizationId;
        if (fromNodeId == toNodeId) {
          // print(element.positionOrganizationId);
          //  graph.addNode(Node.Id(toNodeId));
        } else if (fromNodeId == "") {
          //ลบ dev หรือ โหนดที่ไม่มีเส้นเชื่อม
          graph.removeNode(Node.Id(toNodeId));
        } else {
          graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
          if (!graph.contains(node: Node.Id(toNodeId))) {
            graph.addNode(Node.Id(toNodeId));
          }
        }
      }
    } else {
      isNodeEmpty = true;
    }

    if (graph.nodes.isEmpty) {
      isNodeEmpty = true;
    } else {
      isNodeEmpty = false;
    }

    builder
      ..siblingSeparation = (30)
      ..levelSeparation = (80)
      ..subtreeSeparation = (100)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    isLoading = false;
  }

  showDialogCreate(positionOrgData, bool edit) {
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
                    // const Text('เพิ่มโต๊ะทำงาน (Position Organization.)'),
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: edit == false
                                  ? 'เพิ่มโต๊ะทำงาน'
                                  : 'แก้ไขโต๊ะทำงาน',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(fontSize: 18)),
                            ),
                            const TextSpan(
                              text: ' ( Position Organization.)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700]),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // context.read<PositionOrgBloc>().add(
                        //     FetchDataPositionOrgEvent(
                        //         organizationId: widget.data!.organizationId));
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                width: 450,
                height: 600,
                child: edit == false
                    ? EditPositionOrganization(
                        onEdit: false,
                        positionOrgData:
                            null, //positionOrgData ?? positionOrgData,//null
                        orgData: widget.data,
                        ongraph: positionOrgData == null ? false : true, //false
                        firstNode:
                            positionOrgData == null ? true : false, //true
                        positionOrgDataAddNode: positionOrgData,
                      )
                    : EditPositionOrganization(
                        onEdit: true,
                        positionOrgData: positionOrgData,
                        orgData: widget.data,
                        ongraph: true,
                        firstNode: false),
              ));
        });
  }

  showDialogSearch(data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              content: SafeArea(
                child: SizedBox(
                  width: 1000,
                  height: 800,
                  child: Column(
                    children: [
                      Expanded(
                          child: DataTablePerson(
                        employee: true,
                        positionOrgData: data,
                      )),
                    ],
                  ),
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
              context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
                  organizationId: widget.data!.organizationCode));
              graph.removeNode(Node.Id(id));
              Navigator.pop(context);
              comment.text = '';
            },
          );
        });
  }

  void deleteData(id, comment) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeletePositionOrgByIdModel deldata = DeletePositionOrgByIdModel(
      positionOrganizationId: id,
      modifiedBy: employeeId,
      comment: comment,
    );

    bool success = await ApiOrgService.deletePositionOrgById(deldata);
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
      btnOkOnPress: () {},
    ).show();
  }

  @override
  void initState() {
    context.read<PositionOrgBloc>().add(FetchDataPositionOrgEvent(
        organizationId: widget.data!.organizationCode));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionOrgBloc, PositionOrgState>(
      builder: (context, state) {
        graph = Graph()..isTree = true;
        positionOrgData = null;
        if (state.isDataLoading == false) {
          positionOrgData?.positionOrganizationData = [];
          positionOrgData = state.positionOrganizationDataModel;
          nodedata(positionOrgData?.positionOrganizationData);
        } else {
          nodedata(null);
        }
        return SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Position Organization ( ${widget.data!.organizationCode} : ${widget.data!.departMentData.deptNameEn} )",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ).animate().fade().slide(),
                      ),
                    ),
                    Expanded(
                      child: positionOrgData?.positionOrganizationData.length ==
                              1
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Tooltip(
                                  message: "แสดงข้อมูลรูปแบบตาราง",
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation:
                                              isExpandedPage == true ? 2 : 1,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          backgroundColor:
                                              isExpandedPage == true
                                                  ? mythemecolor
                                                  : Colors.grey[350],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isExpandedPage = !isExpandedPage;
                                          });
                                        },
                                        child: Text(
                                          "   Position Organization (List).   ",
                                          style: TextStyle(
                                              color: isExpandedPage == true
                                                  ? Colors.white
                                                  : Colors.black54),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                    ).animate().fade(delay: 250.ms).slide(delay: 250.ms),
                    const Gap(20),
                    SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700]),
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<PositionOrgBloc>().add(CloseEvent());
                            },
                            child: const Text("X",
                                style: TextStyle(color: Colors.white)))),
                  ],
                ),
                state.isDataLoading == true
                    ? myLoadingScreen
                    : positionOrgData == null
                        ? ElevatedButton(
                            onPressed: () {
                              showDialogCreate(null, false);
                            },
                            child: const Text("+"))
                        : positionOrgData!.positionOrganizationData.length == 1
                            ? rectangleWidget(
                                positionOrgData!.positionOrganizationData[0])
                            : Expanded(
                                child: Center(
                                  child: Row(children: [
                                    // if (isExpandedPage == 0)
                                    Expanded(
                                        flex: 1,
                                        child: InteractiveViewer(
                                            constrained: false,
                                            boundaryMargin:
                                                const EdgeInsets.all(
                                                    double.infinity),
                                            minScale: 0.01,
                                            maxScale: 5.0,
                                            child: GraphView(
                                                graph: graph,
                                                algorithm:
                                                    BuchheimWalkerAlgorithm(
                                                        builder,
                                                        TreeEdgeRenderer(
                                                            builder)),
                                                paint: Paint()
                                                  ..color = Colors.grey[400]!
                                                  ..strokeWidth = 2
                                                  ..style =
                                                      PaintingStyle.stroke,
                                                builder: (Node node) {
                                                  var a = node.key!.value;
                                                  var nodes = positionOrgData
                                                      ?.positionOrganizationData;
                                                  // nodes?.removeWhere((element) =>
                                                  //     element
                                                  //         .parentPositionNodeId ==
                                                  //     "");

                                                  var nodeValue = nodes
                                                      ?.firstWhere((element) =>
                                                          element
                                                              .positionOrganizationId ==
                                                          a);

                                                  //var nodeData = employeeData;
                                                  return rectangleWidget(
                                                      nodeValue);
                                                }))),
                                    if (isExpandedPage == true)
                                      Expanded(
                                          child: PositionOrganizationTable(
                                        orgdata: widget.data,
                                        positionOrgData: positionOrgData,
                                      ))
                                  ]),
                                ),
                              ),
              ],
            ),
          ),
        ));
      },
    );
  }

  Widget rectangleWidget(PositionOrganizationDatum? data) {
    List<Edge> outEdges =
        graph.getOutEdges(Node.Id(data!.positionOrganizationId));
    return SizedBox(
      width: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 38, 4, 4),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                  width: 200,
                  constraints: BoxConstraints(
                    minHeight: data.positionData.positionId == "259"
                        ? 100
                        : 60, // ความสูงขั้นต่ำที่ต้องการ
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: data.positionData.positionId == "259"
                              ? mythemecolor
                              : Colors.white,
                          spreadRadius: 1),
                    ],
                  ),
                  child: data.positionData.positionId == "259"
                      ? Center(
                          child: Column(
                            children: [
                              const Gap(15),
                              Text(
                                "\nBoard of Directors.",
                                style: TextStyle(
                                  color: mygreycolors,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                          child: Tooltip(
                            message:
                                "ID : ${data.positionOrganizationId}\nชื่อตำแหน่งงาน : ${data.positionData.positionNameTh}\nแผนก : ${data.organizationData.departMentData.deptNameTh}\nประเภทพนักงาน : ${data.positionTypeData.positionTypeNameTh}\nรายละเอียดงาน : ${data.jobTitleData.jobTitleName}\nวันที่เริ่มตำแหน่งงาน : ${data.validFromDate}\nวันที่ตำแหน่งงานสิ้นสุด : ${data.endDate}",
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  color: mythemecolor,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    child: Text(
                                      data.positionData.positionNameTh,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TextThai(
                                  text: data.employeeData.employeeId == ""
                                      ? "ว่าง*"
                                      : "คุณ ${data.employeeData.employeeFirstNameTh}  ${data.employeeData.employeeLastNameTh}",
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: data.employeeData.employeeId == ""
                                          ? Colors.red[700]
                                          : Colors.black),
                                )
                              ],
                            ),
                          ),
                        ))),
            ),
          ),
          data.positionData.positionId == "259"
              ? Icon(
                  Icons.group_rounded,
                  color: Colors.amber[400],
                  size: 48,
                )
              : Positioned(
                  top: -8,
                  child: SizedBox(
                      width: 60,
                      child: CircleAvatar(
                          backgroundColor: mythemecolor,
                          radius: 40,
                          child: SizedBox(
                            height: 55,
                            child: Tooltip(
                              message: data.employeeData.employeeId == ""
                                  ? "เพิ่มพนักงาน"
                                  : "",
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(360))),
                                  onPressed: data.employeeData.employeeId == ""
                                      ? () {
                                          showDialogSearch(data);
                                        }
                                      : null,
                                  child: Icon(
                                    data.employeeData.employeeId == ""
                                        ? Icons.search
                                        : Icons.person,
                                    color: data.employeeData.employeeId == ""
                                        ? Colors.amberAccent
                                        : Colors.white,
                                  )),
                            ),
                          )))),
          Positioned(
            right: 40,
            child: PopupMenuButton(
              iconColor: data.positionData.positionId == "259"
                  ? mygreycolors
                  : Colors.black,
              splashRadius: 1,
              elevation: 10,
              iconSize: 22,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'add',
                    child: Text('Add'),
                  ),
                  if (data.employeeData.employeeId == "")
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                  if (data.employeeData.employeeId == "" && outEdges.isEmpty)
                    const PopupMenuItem<String>(
                      value: 'del',
                      child: Text('Delete'),
                    ),
                ];
              },
              onSelected: (value) {
                if (value == 'add') {
                  showDialogCreate(data, false);
                } else if (value == 'edit') {
                  showDialogCreate(data, true);
                } else {
                  showdialogDeletePerson(data.positionOrganizationId);
                }
              },
            ),
          ).animate().fade(delay: 200.ms).shake(delay: 500.ms),
          data.roleData.roleId == ""
              ? Positioned(
                  right: 4,
                  bottom: 6,
                  child: SizedBox(
                    width: 40,
                    height: 38,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mygreencolors,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.all(1)),
                        onPressed: () {
                          fetchRoleData(data.roleData.roleId);
                          updateDialog(data);
                        },
                        child: Transform.flip(
                            flipX: true, child: const Icon(Icons.key))),
                  ),
                ).animate().fade(duration: 1.seconds)
              : Icon(
                  Icons.key_rounded,
                  color: mythemecolor,
                ),
        ],
      ),
    );
  }

  fetchRoleData(String roleId) async {
    RolesModel? dataRole = await ApiRolesService.getRolesData();
    roleList = dataRole?.roleData ?? [];
    roleId = roleId;
    setState(() {});
  }

  Future onSave(PositionOrganizationDatum data) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;

    UpdatePositionOrgModel updatePositionOrganizationModel =
        UpdatePositionOrgModel(
      positionOrganizationId: data.positionOrganizationId,
      positionId: data.positionData.positionId,
      organizationCode: data.organizationData.organizationCode,
      jobTitleId: data.jobTitleData.toString(),
      positionTypeId: data.positionTypeData.toString(),
      status: 'Active',
      parentPositionNodeId: data.parentPositionNodeId.toString(),
      parentPositionBusinessNodeId:
          data.parentPositionBusinessNodeId.toString(),
      roleId: roleId.text,
      startingSalary: data.startingSalary,
      validFromDate: data.validFromDate,
      endDate: data.endDate,
      modifiedBy: employeeId,
      comment: comment.text,
    );
    setState(() {});
    bool success =
        await ApiOrgService.updatedPositionOrg(updatePositionOrganizationModel);

    alertDialog(success);
  }

  updateDialog(PositionOrganizationDatum data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(8),
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Stack(
                children: [
                  Container(
                    height: 200,
                    width: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(10),
                        DropdownMenuGlobal(
                            label: "Role Permissions",
                            width: 380,
                            controller: roleId,
                            onSelected: (value) {
                              setState(() {
                                roleId.text = value.toString();
                              });
                            },
                            dropdownMenuEntries: roleList.map((RoleDatum e) {
                              return DropdownMenuEntry(
                                  value: e.roleId,
                                  label: e.roleName,
                                  style: MenuItemButton.styleFrom());
                            }).toList()),
                        SizedBox(
                          width: 388,
                          child: TextFormFieldGlobal(
                            controller: comment,
                            labelText: "Comment",
                            enabled: true,
                            validatorless: Validatorless.required('required'),
                          ),
                        ),
                        MySaveButtons(
                          text: "Update",
                          onPressed: () {
                            onSave;
                          },
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: -5,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => Navigator.pop(context),
                          child: Transform.rotate(
                              angle: (45 * 22 / 7) / 180,
                              child: Icon(
                                Icons.add_rounded,
                                size: 32,
                                color: Colors.grey[700],
                              )))),
                ],
              ));
        });
  }
}
