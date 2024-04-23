import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/page/examgraphview/main.dart';
import 'package:hris_app_prototype/src/page/organization/test_organization_page.dart';

import 'package:hris_app_prototype/src/page/personal/personal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container()
        // SafeArea(
        //     child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       TextButton(
        //         child: const Text("Personal Profile"),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const PersonalPage()),
        //           );
        //         },
        //       ),

        //       TextButton(
        //         child: const Text("Organization"),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const MyOrganizationLayout()),
        //           );
        //         },
        //       ),
        //       TextButton(
        //         child: const Text("Example GraphView"),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const Homemain()),
        //           );
        //         },
        //       ),
        //       // TextButton(
        //       //   child: const Text('EIEIEIEIEIEIIEIEI'),
        //       //   onPressed: () {
        //       //     showGeneralDialog(
        //       //         context: context,
        //       //         barrierDismissible: false,
        //       //         barrierLabel: MaterialLocalizations.of(context)
        //       //             .modalBarrierDismissLabel,
        //       //         barrierColor: Colors.black45,
        //       //         transitionDuration: const Duration(milliseconds: 200),
        //       //         pageBuilder: (BuildContext buildContext,
        //       //             Animation animation, Animation secondaryAnimation) {
        //       //           return Center(
        //       //             child: Container(
        //       //               width: MediaQuery.of(context).size.width - 40,
        //       //               height: MediaQuery.of(context).size.height - 40,
        //       //               padding: const EdgeInsets.all(20),
        //       //               color: Colors.white,
        //       //               child: Column(
        //       //                 children: [
        //       //                   ElevatedButton(
        //       //                     onPressed: () {
        //       //                       Navigator.of(context).pop();
        //       //                     },
        //       //                     child: const Text(
        //       //                       "Close",
        //       //                       style: TextStyle(color: Colors.white),
        //       //                     ),
        //       //                   )
        //       //                 ],
        //       //               ),
        //       //             ),
        //       //           );
        //       //         });
        //       //   },
        //       // ),
        //       ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             fixedSize: const Size.square(40),
        //           ),
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: const Icon(Icons.arrow_back_ios_new_rounded)),
        //     ],
        //   ),
        // )),
        );
  }
}
