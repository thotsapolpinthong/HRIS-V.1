import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/permission/permission/permission_table.dart';
import 'package:hris_app_prototype/src/component/permission/role_permission/role_permission_manage.dart';
import 'package:hris_app_prototype/src/component/permission/role_permission/role_permission_table.dart';
import 'package:hris_app_prototype/src/component/permission/roles/roles_table.dart';

class RolePermissionLayout extends StatefulWidget {
  const RolePermissionLayout({super.key});

  @override
  State<RolePermissionLayout> createState() => _RolePermissionLayoutState();
}

class _RolePermissionLayoutState extends State<RolePermissionLayout> {
  int isExpandedPage = 0; // 0 = Rolepermission 1 = role 2= permissions

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(8),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: SizedBox(
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: isExpandedPage == 0 ? 2 : 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10))),
                      backgroundColor:
                          isExpandedPage == 0 ? mythemecolor : Colors.grey[350],
                    ),
                    onPressed: () {
                      setState(() {
                        isExpandedPage = 0;
                      });
                    },
                    child: Text(
                      "Role Permissions.",
                      style: TextStyle(
                          color: isExpandedPage == 0
                              ? Colors.white
                              : Colors.black54),
                    )),
              ),
            ),
            const Gap(1),
            Expanded(
              child: SizedBox(
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: isExpandedPage == 1 ? 2 : 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(0))),
                      backgroundColor:
                          isExpandedPage == 1 ? mythemecolor : Colors.grey[350],
                    ),
                    onPressed: () {
                      setState(() {
                        isExpandedPage = 1;
                      });
                    },
                    child: Text(
                      "Roles.",
                      style: TextStyle(
                          color: isExpandedPage == 1
                              ? Colors.white
                              : Colors.black54),
                    )),
              ),
            ),
            const Gap(1),
            Expanded(
              child: SizedBox(
                height: 35,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: isExpandedPage == 2 ? 2 : 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(10))),
                      backgroundColor:
                          isExpandedPage == 2 ? mythemecolor : Colors.grey[350],
                    ),
                    onPressed: () {
                      setState(() {
                        isExpandedPage = 2;
                      });
                    },
                    child: Text(
                      "Permissions.",
                      style: TextStyle(
                          color: isExpandedPage == 2
                              ? Colors.white
                              : Colors.black54),
                    )),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        if (isExpandedPage == 0)
          Expanded(child: RolePermissionManage())
        else if (isExpandedPage == 1)
          Expanded(child: RolesTable())
        else
          Expanded(child: PermissionTable())
      ],
    );
  }
}
