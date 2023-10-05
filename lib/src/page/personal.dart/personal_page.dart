import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/0_add_person_layout.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';
import 'package:hris_app_prototype/src/model/person/generate_personId_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  bool isloading = false;
  //bool isExpandedList = true;
  bool isExpandedTable = true;

  void addPerson() async {
    AddModel? dataId = await ApiService.generatePersonId();
    if (dataId != null) {
      setState(() {
        isloading = false;
        showGeneralDialog(
            context: context,
            barrierDismissible: false,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black45,
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return MyAddPersonbyIDLayout(
                personId: dataId.personId.toString(),
              );
            });
      });
    } else {
      isloading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       child: const Icon(Icons.swap_horizontal_circle_rounded),
      //       onPressed: () {
      //         setState(() {
      //            isExpandedList = !isExpandedList;
      //           isExpandedTable = !isExpandedTable;
      //         });
      //       },
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     ElevatedButton(
      //       child: const Icon(Icons.refresh),
      //       onPressed: () {
      //         context.read<PersonalBloc>().add(FetchDataList());
      //         Navigator.pushReplacement(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (BuildContext context) => super.widget));
      //       },
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     ElevatedButton(
      //       child: const Icon(Icons.navigate_before_rounded),
      //       onPressed: () {
      //         context.read<PersonalBloc>().add(BackPage());
      //       },
      //     ),
      //     const SizedBox(
      //       width: 5,
      //     ),
      //     BlocBuilder<PersonalBloc, PersonalState>(
      //       builder: (context, state) {
      //         return ElevatedButton(
      //           child: const Icon(Icons.navigate_next_rounded),
      //           onPressed: () {
      //             context.read<PersonalBloc>().add(NextPage());
      //           },
      //         );
      //       },
      //     ),
      //   ],
      // ),
      backgroundColor: myDefaultBackground,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 125,
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 40,
                              height: double.infinity,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        primary: Colors.white,
                                        onPrimary: Colors.blue,
                                        padding: const EdgeInsets.all(4)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.black,
                                      size: 20,
                                    )),
                              )
                                  .animate()
                                  .slideX(duration: 350.milliseconds)
                                  .fadeIn(),
                            ),
                            Expanded(
                                    flex: 6,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      elevation: 4,
                                      child: const Center(
                                          child: Text(
                                        'บันทึกข้อมูลส่วนบุคคล (Personnel Profile)',
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500),
                                      )),
                                    ))
                                .animate()
                                .slideY(duration: 350.milliseconds)
                                .fadeIn(),
                            const SizedBox(width: 5),
                            const Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Create New Person',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                            width: 55,
                            height: 45,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue[900]!),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(10)),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isloading = !isloading;
                                    addPerson();
                                    isloading = !isloading;
                                  });
                                },
                                child: isloading == true
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.person_add_alt_1,
                                        size: 28,
                                      )))
                        .animate()
                        .slideX(
                            begin: 2,
                            duration: 350.milliseconds,
                            delay: 200.milliseconds)
                        .fadeIn(),
                  )
                      .animate()
                      .slideX(
                          begin: 2,
                          duration: 350.milliseconds,
                          delay: 200.milliseconds)
                      .fadeIn(),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 112,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Expanded(
                            //     flex: 1,
                            //     child: Container(
                            //       color: Colors.amber,
                            //       child: Card(
                            //         elevation: 8,
                            //         color: mysecondaryBackground,
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Expanded(
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Column(
                            //                   children: [
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder(
                            //                             borderSide: BorderSide(
                            //                               color: Colors.blue,
                            //                             ),
                            //                           )),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //             Expanded(
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(8.0),
                            //                 child: Column(
                            //                   children: [
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                     TextFormField(
                            //                       decoration: InputDecoration(
                            //                           filled: true,
                            //                           fillColor: myDefaultBackground,
                            //                           border:
                            //                               const OutlineInputBorder()),
                            //                     ),
                            //                     const SizedBox(height: 8),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     )),
                            // if (isExpandedList)
                            //   Expanded(
                            //       flex: 3,
                            //       child: Container(
                            //         //  color: Colors.black,
                            //         child: const ListPersonbyId(),
                            //       )),
                            if (isExpandedTable)
                              const Expanded(flex: 3, child: DataTablePerson()),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ).animate().fadeIn(duration: 600.milliseconds),
            ],
          ),
        ),
      )),
    );
  }
}
