import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/employee_self_service/user_leave_menu.dart';

class UserMenuService extends StatefulWidget {
  const UserMenuService({super.key});

  @override
  State<UserMenuService> createState() => _UserMenuServiceState();
}

class _UserMenuServiceState extends State<UserMenuService> {
  showDialoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    backgroundColor: mygreycolors,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: TitleDialog(
                      title: "บันทึกข้อมูลวันลา",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    content: const SizedBox(
                        width: 460, height: 360, child: Text("test")),
                  ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: Colors.amber,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
              tag: "leave",
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LeaveManage())),
                  child: SizedBox(
                    width: 340,
                    height: 540,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const ListTile(
                            title: Text("ข้อมูลบันทึกการลา"),
                            subtitle: Text("Leave"),
                          ),
                          const Text(
                            "Quota :",
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: mygreycolors,
                                  child: const Center(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.airplane_ticket_outlined,
                                        size: 40,
                                      ),
                                      title: Text(
                                          "Vacation Leave.\nลาพักผ่อนประจำปี"),
                                      subtitle: Text("คงเหลือ 14 วัน"),
                                      trailing: Icon(
                                        Icons.check_box_rounded,
                                        color: Colors.greenAccent,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: mygreycolors,
                                  child: const Center(
                                    child: ListTile(
                                      leading: Icon(Icons.card_travel_rounded,
                                          size: 40),
                                      title: Text("Bussiness Leave\nลากิจ"),
                                      subtitle: Text("คงเหลือ 0 วัน"),
                                      trailing: Icon(
                                          Icons.indeterminate_check_box_rounded,
                                          color: Colors.amber,
                                          size: 40),
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: mygreycolors,
                                  child: const Center(
                                    child: ListTile(
                                      leading:
                                          Icon(Icons.sick_outlined, size: 40),
                                      title: Text("Sick Leave\nลาป่วย"),
                                      subtitle: Text("ลาไปแล้ว 4 วัน"),
                                      trailing: Icon(Icons.check_box_rounded,
                                          color: Colors.greenAccent, size: 40),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          )),
                          // Align(
                          //     alignment: Alignment.bottomRight,
                          //     child: ElevatedButton(
                          //         onPressed: () {}, child: Text("ขอใบลาออนไลน์")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Hero(
              tag: "ot",
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OTManage())),
                  child: const SizedBox(
                    width: 340,
                    height: 540,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
                            subtitle: Text("OT"),
                          ),
                          Expanded(child: Text("test")),
                          // Align(
                          //     alignment: Alignment.bottomRight,
                          //     child: ElevatedButton(
                          //         onPressed: () {}, child: Text("ขอใบลาออนไลน์")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Hero(
              tag: "time",
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TimeStampManage())),
                  child: const SizedBox(
                    width: 340,
                    height: 540,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("ข้อมูลบันทึกเวลาเข้า ออกงาน"),
                            subtitle: Text("Time Stamp"),
                          ),
                          Expanded(child: Text("test")),
                          // Align(
                          //     alignment: Alignment.bottomRight,
                          //     child: ElevatedButton(
                          //         onPressed: () {}, child: Text("ขอใบลาออนไลน์")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}

class OTManage extends StatefulWidget {
  const OTManage({super.key});

  @override
  State<OTManage> createState() => _OTManageState();
}

class _OTManageState extends State<OTManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกการทำงานล่วงเวลา"),
      ),
      body: Hero(
          tag: "ot",
          child: Column(
            children: [
              Container(
                color: Colors.amber,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("pop"))
            ],
          )),
    );
  }
}

class TimeStampManage extends StatefulWidget {
  const TimeStampManage({super.key});

  @override
  State<TimeStampManage> createState() => _TimeStampManageState();
}

class _TimeStampManageState extends State<TimeStampManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลบันทึกเวลาเข้า ออกงาน"),
      ),
      body: Hero(
          tag: "time",
          child: Column(
            children: [
              Container(
                color: Colors.amber,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("pop"))
            ],
          )),
    );
  }
}
