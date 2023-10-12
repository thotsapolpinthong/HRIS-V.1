import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
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
                                child: BlocBuilder<PersonalBloc, PersonalState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.blue,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            padding: const EdgeInsets.all(4)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          context
                                              .read<PersonalBloc>()
                                              .add(StateClearEvent());
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Colors.black,
                                          size: 20,
                                        ));
                                  },
                                ),
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
