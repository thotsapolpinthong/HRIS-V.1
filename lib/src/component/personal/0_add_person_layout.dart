import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/personal/0_create_person_stepper.dart.dart';

class MyAddPersonbyIDLayout extends StatefulWidget {
  final String personId;
  const MyAddPersonbyIDLayout({super.key, required this.personId});

  @override
  State<MyAddPersonbyIDLayout> createState() => _MyAddPersonbyIDLayoutState();
}

class _MyAddPersonbyIDLayoutState extends State<MyAddPersonbyIDLayout> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 20,
          padding: const EdgeInsets.all(20),
          child: MyWidget(personId: widget.personId)
          // ListView(
          //   children: [
          //     //header personal
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Card(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8.0)),
          //           elevation: 5,
          //           child: const Padding(
          //             padding: EdgeInsets.all(6.0),
          //             child: Text(
          //               'เพิ่มข้อมูลบุคคล (Create Personal).',
          //               style:
          //                   TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ),
          //         Row(
          //           children: [
          //             SizedBox(
          //                 height: 30,
          //                 width: 40,
          //                 child: ElevatedButton(
          //                     style: ElevatedButton.styleFrom(
          //                         backgroundColor:
          //                             Colors.red[800] // Background color
          //                         // Text Color (Foreground color)
          //                         ),
          //                     onPressed: () {
          //                       Navigator.of(context).pop();
          //                     },
          //                     child: const Text("X",
          //                         style: TextStyle(color: Colors.white)))),
          //             const SizedBox(width: 15)
          //           ],
          //         ),
          //       ],
          //     ),
          //     //end header----------------------------------------------------------------
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(
          //             flex: 4,
          //             child: Card(
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(12.0)),
          //               elevation: 4,
          //               color: Colors.grey[200],
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child:
          //                     Addpersonal(personId: widget.personId.toString()),
          //               ),
          //             )),
          //         Expanded(
          //           flex: 8,
          //           child: Card(
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(12.0)),
          //             elevation: 4,
          //             color: Colors.grey[200],
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   // Align(
          //                   //   alignment: Alignment.topLeft,
          //                   //   child: Card(
          //                   //     shape: RoundedRectangleBorder(
          //                   //         borderRadius: BorderRadius.circular(8.0)),
          //                   //     elevation: 5,
          //                   //     child: const Padding(
          //                   //       padding: EdgeInsets.all(6.0),
          //                   //       child: Text(
          //                   //         'เพิ่มข้อมูลที่อยู่ (Create Address).',
          //                   //         style: TextStyle(
          //                   //             fontSize: 20,
          //                   //             fontWeight: FontWeight.bold),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // Card(
          //                   //   color: Colors.white,
          //                   //   shape: RoundedRectangleBorder(
          //                   //       borderRadius: BorderRadius.circular(12.0)),
          //                   //   // elevation: 4,
          //                   //   child: Padding(
          //                   //     padding: const EdgeInsets.all(6.0),
          //                   //     child: Row(
          //                   //       children: [
          //                   //         Expanded(
          //                   //           flex: 2,
          //                   //           child: AddAddressbyperson(
          //                   //               personId: widget.personId.toString()),
          //                   //         ),
          //                   //       ],
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // const SizedBox(height: 10),
          //                   // Align(
          //                   //   alignment: Alignment.topLeft,
          //                   //   child: Card(
          //                   //     shape: RoundedRectangleBorder(
          //                   //         borderRadius: BorderRadius.circular(8.0)),
          //                   //     elevation: 5,
          //                   //     child: const Padding(
          //                   //       padding: EdgeInsets.all(6.0),
          //                   //       child: Text(
          //                   //         'เพิ่มข้อมูลบัตรประจำตัว (Create Card Information).',
          //                   //         style: TextStyle(
          //                   //             fontSize: 20,
          //                   //             fontWeight: FontWeight.bold),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // Card(
          //                   //   color: Colors.white,
          //                   //   shape: RoundedRectangleBorder(
          //                   //       borderRadius: BorderRadius.circular(12.0)),
          //                   //   child: Padding(
          //                   //     padding: const EdgeInsets.all(6.0),
          //                   //     child: Row(
          //                   //       children: [
          //                   //         Expanded(
          //                   //             flex: 2,
          //                   //             child: AddCardInfoLayout(
          //                   //                 personId: widget.personId)),
          //                   //       ],
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // const SizedBox(height: 10),
          //                   // Align(
          //                   //   alignment: Alignment.topLeft,
          //                   //   child: Card(
          //                   //     shape: RoundedRectangleBorder(
          //                   //         borderRadius: BorderRadius.circular(8.0)),
          //                   //     elevation: 5,
          //                   //     child: const Padding(
          //                   //       padding: EdgeInsets.all(6.0),
          //                   //       child: Text(
          //                   //         'บันทึกประวัติการศึกษา (Education Information).',
          //                   //         style: TextStyle(
          //                   //             fontSize: 20,
          //                   //             fontWeight: FontWeight.bold),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // Card(
          //                   //   color: Colors.grey[50],
          //                   //   shape: RoundedRectangleBorder(
          //                   //       borderRadius: BorderRadius.circular(12.0)),
          //                   //   elevation: 4,
          //                   //   child: Padding(
          //                   //     padding: const EdgeInsets.all(6.0),
          //                   //     child: Row(
          //                   //       children: [
          //                   //         Expanded(
          //                   //             flex: 2,
          //                   //             child: AddEducationLayout(
          //                   //                 personId: widget.personId)),
          //                   //       ],
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // const SizedBox(height: 10),
          //                   // Align(
          //                   //   alignment: Alignment.topLeft,
          //                   //   child: Card(
          //                   //     shape: RoundedRectangleBorder(
          //                   //         borderRadius: BorderRadius.circular(8.0)),
          //                   //     elevation: 5,
          //                   //     child: const Padding(
          //                   //       padding: EdgeInsets.all(6.0),
          //                   //       child: Text(
          //                   //         'บันทึกข้อมูลครอบครัว (Family Member Information).',
          //                   //         style: TextStyle(
          //                   //             fontSize: 20,
          //                   //             fontWeight: FontWeight.bold),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // Card(
          //                   //   color: Colors.grey[50],
          //                   //   shape: RoundedRectangleBorder(
          //                   //       borderRadius: BorderRadius.circular(12.0)),
          //                   //   elevation: 4,
          //                   //   child: Padding(
          //                   //     padding: const EdgeInsets.all(6.0),
          //                   //     child: Row(
          //                   //       children: [
          //                   //         Expanded(
          //                   //             flex: 2,
          //                   //             child: AddCardInfoLayout(
          //                   //                 personId: widget.personId)),
          //                   //       ],
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // const SizedBox(height: 10),
          //                   // Align(
          //                   //   alignment: Alignment.topLeft,
          //                   //   child: Card(
          //                   //     shape: RoundedRectangleBorder(
          //                   //         borderRadius: BorderRadius.circular(8.0)),
          //                   //     elevation: 5,
          //                   //     child: const Padding(
          //                   //       padding: EdgeInsets.all(6.0),
          //                   //       child: Text(
          //                   //         'บันทึกข้อมูลบุคคลที่สามารถติดต่อได้ (Contact Person Information).',
          //                   //         style: TextStyle(
          //                   //             fontSize: 20,
          //                   //             fontWeight: FontWeight.bold),
          //                   //       ),
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   // Card(
          //                   //   color: Colors.grey[50],
          //                   //   shape: RoundedRectangleBorder(
          //                   //       borderRadius: BorderRadius.circular(12.0)),
          //                   //   elevation: 4,
          //                   //   child: Padding(
          //                   //     padding: const EdgeInsets.all(6.0),
          //                   //     child: Row(
          //                   //       children: [
          //                   //         Expanded(
          //                   //             flex: 2,
          //                   //             child: AddCardInfoLayout(
          //                   //                 personId: widget.personId)),
          //                   //       ],
          //                   //     ),
          //                   //   ),
          //                   // ),
          //                   Card(
          //                     color: Colors.grey[50],
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(12.0)),
          //                     elevation: 4,
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(6.0),
          //                       child: Row(
          //                         children: [
          //                           Expanded(
          //                             child: Stepper(
          //                               steps: getSteps(),
          //                               currentStep: _currentStep,
          //                               onStepTapped: (step) {
          //                                 setState(() {
          //                                   _currentStep = step;
          //                                 });
          //                               },
          //                               onStepContinue: () {
          //                                 setState(() {
          //                                   if (_currentStep <
          //                                       getSteps().length - 1) {
          //                                     _currentStep++;
          //                                   }
          //                                 });
          //                               },
          //                               onStepCancel: () {
          //                                 setState(() {
          //                                   if (_currentStep > 0) {
          //                                     _currentStep--;
          //                                   }
          //                                 });
          //                               },
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     // Row(
          //     //   children: [Expanded(child: MyWidget())],
          //     // )
          //   ],
          // ),
          ),
    );
  }
}
