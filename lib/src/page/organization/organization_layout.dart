import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/component/Organization/department/datatable_department.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/create_edit_org.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/datatable_organization.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/graphtree_org.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/position_layout.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class OrganizationLayout extends StatefulWidget {
  const OrganizationLayout({super.key});

  @override
  State<OrganizationLayout> createState() => _OrganizationLayoutState();
}

class _OrganizationLayoutState extends State<OrganizationLayout> {
  int isExpandedPage = 0;
  void showDialogCreate() {
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
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'เพิ่มโครงสร้างองค์กร',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(fontSize: 18)),
                            ),
                            const TextSpan(
                              text: ' (Create Organization.)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
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
                      },
                    ),
                  ],
                ),
              ),
              content: const SizedBox(
                width: 450,
                height: 500,
                child: Column(
                  children: [
                    Expanded(
                        child: EditOrganization(
                      onEdit: false,
                      ongraph: false,
                    )),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: isExpandedPage == 1
            ? SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      showDialogCreate();
                    },
                    child: const Icon(Icons.add, size: 30)),
              )
            : null,
        body: Center(
            child: Column(
          children: [
            const Text(
              'Organization Management.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 0 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(10))),
                                backgroundColor: isExpandedPage == 0
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 0;
                                });
                              },
                              child: Text(
                                "Organization (Chart).",
                                style: TextStyle(
                                    color: isExpandedPage == 0
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 1 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(0))),
                                backgroundColor: isExpandedPage == 1
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 1;
                                });
                              },
                              child: Text(
                                "Organization (List).",
                                style: TextStyle(
                                    color: isExpandedPage == 1
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 2 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(0))),
                                backgroundColor: isExpandedPage == 2
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 2;
                                });
                              },
                              child: Text(
                                "Departments (List).",
                                style: TextStyle(
                                    color: isExpandedPage == 2
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: isExpandedPage == 3 ? 2 : 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(10))),
                                backgroundColor: isExpandedPage == 3
                                    ? mythemecolor
                                    : Colors.grey[350],
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpandedPage = 3;
                                });
                              },
                              child: Text(
                                "Position (List).",
                                style: TextStyle(
                                    color: isExpandedPage == 3
                                        ? Colors.white
                                        : Colors.black54),
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
            if (isExpandedPage == 0)
              const Expanded(flex: 19, child: TreeViewOrganization())
            else if (isExpandedPage == 1)
              const Expanded(flex: 19, child: OrganizationDataTable())
            else if (isExpandedPage == 2)
              const Expanded(flex: 19, child: DepartmentDataTable())
            else
              const Expanded(flex: 19, child: MyPositionsLayout())
          ],
        )),
      ),
    ));
  }
}
