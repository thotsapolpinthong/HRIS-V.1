import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_bloc/positions_bloc.dart';
import 'package:hris_app_prototype/src/component/Organization/department/datatable_department.dart';
import 'package:hris_app_prototype/src/page/organization/organization_layout.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/position_layout.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

import 'package:hris_app_prototype/src/page/organization/tree.dart';

class MyOrganizationLayout extends StatefulWidget {
  const MyOrganizationLayout({super.key});

  @override
  State<MyOrganizationLayout> createState() => _MyOrganizationLayoutState();
}

class _MyOrganizationLayoutState extends State<MyOrganizationLayout> {
  bool isOrganization = true;
  bool isDepartment = false;
  bool isPositions = false;
  bool isPositionsOrg = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView(
                  children: [
                    Column(children: [
                      Card(
                        color: isOrganization == true
                            ? mythemecolor
                            : Colors.white,
                        elevation: isOrganization == true ? 8 : 1,
                        child: ListTile(
                          title: const Text('Organization'),
                          selectedColor: Colors.white,
                          selected: isOrganization,
                          onTap: () {
                            setState(() {
                              isOrganization = true;
                              isDepartment = false;
                              isPositions = false;
                              isPositionsOrg = false;
                            });
                          },

                          // selected: true,
                        ),
                      ),
                      Card(
                        color:
                            isDepartment == true ? mythemecolor : Colors.white,
                        elevation: isDepartment == true ? 8 : 1,
                        child: ListTile(
                          title: const Text('Departments'),
                          selectedColor: Colors.white,
                          selected: isDepartment,
                          onTap: () {
                            setState(() {
                              isOrganization = false;
                              isDepartment = true;
                              isPositions = false;
                              isPositionsOrg = false;
                            });
                          },
                          // selected: true,
                        ),
                      ),
                      Card(
                        color:
                            isPositions == true ? mythemecolor : Colors.white,
                        elevation: isPositions == true ? 8 : 1,
                        child: ListTile(
                          title: const Text('Positions'),
                          selectedColor: Colors.white,
                          selected: isPositions,
                          onTap: () {
                            setState(() {
                              isOrganization = false;
                              isDepartment = false;
                              isPositions = true;
                              isPositionsOrg = false;
                              context
                                  .read<PositionsBloc>()
                                  .add(FetchDataEvent());
                            });
                          },
                          // selected: true,
                        ),
                      ),
                      Card(
                        color: isPositionsOrg == true
                            ? mythemecolor
                            : Colors.white,
                        elevation: isPositionsOrg == true ? 8 : 1,
                        child: ListTile(
                          title: const Text('Position Organization'),
                          selectedColor: Colors.white,
                          selected: isPositionsOrg,
                          onTap: () {
                            setState(() {
                              isOrganization = false;
                              isDepartment = false;
                              isPositions = false;
                              isPositionsOrg = true;
                            });
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            )),
        if (isOrganization == true)
          const Expanded(flex: 14, child: OrganizationLayout()),
        if (isDepartment == true)
          const Expanded(flex: 14, child: DepartmentDataTable()),
        if (isPositions == true)
          const Expanded(flex: 14, child: MyPositionsLayout()),
        if (isPositionsOrg == true)
          const Expanded(flex: 14, child: MyTreeView()),
      ],
    );
  }
}
