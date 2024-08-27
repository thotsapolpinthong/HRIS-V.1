import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(body: Container()
            //  Row(children: [
            //   Expanded(
            //       flex: 2,
            //       child: Column(
            //         children: [
            //           Expanded(
            //               flex: 2,
            //               child: Container(
            //                 color: mygreycolors,
            //               )
            //               //  TimeAttendancePageLayout(
            //               //   dashboard: true,
            //               // )
            //               ),
            //           Expanded(
            //               flex: 1,
            //               child: Card(
            //                 elevation: 4,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(16)),
            //                 child: SingleChildScrollView(
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       children: [
            //                         Card(
            //                           shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(12)),
            //                           color: Colors.grey[200],
            //                           child: ListTile(
            //                             title: Container(),
            //                           ),
            //                         ),
            //                         Card(
            //                           shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(12)),
            //                           color: Colors.grey[200],
            //                           child: ListTile(
            //                             title: Container(),
            //                           ),
            //                         ),
            //                         Card(
            //                           shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(12)),
            //                           color: Colors.grey[200],
            //                           child: ListTile(
            //                             title: Container(),
            //                           ),
            //                         ),
            //                         Card(
            //                           shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(12)),
            //                           color: Colors.grey[200],
            //                           child: ListTile(
            //                             title: Container(),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               )),
            //         ],
            //       )),
            //   Expanded(
            //       flex: 1,
            //       child: Card(
            //           elevation: 4,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(16)),
            //           child: Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Column(children: [
            //               Expanded(
            //                   child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(12)),
            //                       color: Colors.grey[200],
            //                       child: Container())),
            //               Expanded(
            //                   child: Card(
            //                       shape: RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.circular(12)),
            //                       color: Colors.grey[200],
            //                       child: Container())),
            //             ]),
            //           ))),
            // ]),
            ),
      ),
    );
  }
}
