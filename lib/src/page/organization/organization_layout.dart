import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/Organization/department/datatable_department.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/datatable_organization.dart';
import 'package:hris_app_prototype/src/component/Organization/organization/graphtree_org.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/datatable_position.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class OrganizationLayout extends StatefulWidget {
  const OrganizationLayout({super.key});

  @override
  State<OrganizationLayout> createState() => _OrganizationLayoutState();
}

class _OrganizationLayoutState extends State<OrganizationLayout> {
  int isExpandedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            // const Text(
            //   'Organization Management.',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const Gap(4),
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
              const Expanded(flex: 19, child: PositionDataTable())
          ],
        )),
      ),
    ));
  }
}
