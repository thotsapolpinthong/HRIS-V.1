import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/address/update/update_address_layout.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/1_update_cardinfo_layout.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/update/1_update_contact_layout.dart';
import 'package:hris_app_prototype/src/component/personal/education/update/1_update_education_layout.dart';
import 'package:hris_app_prototype/src/component/personal/family/update/1_update_family_layout.dart';
import 'package:hris_app_prototype/src/component/personal/person/update/update_by_personid.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyUpdateLayout extends StatefulWidget {
  final String personId;
  const MyUpdateLayout({super.key, required this.personId});

  @override
  State<MyUpdateLayout> createState() => _MyUpdateLayoutState();
}

class _MyUpdateLayoutState extends State<MyUpdateLayout> {
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
        child: ListView(
          children: [
            //header personal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  color: mygreycolors,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'แก้ไขข้อมูลส่วนบุคคล (Edit Personal).',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ).animate().fade().slide(),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red[700] // Background color
                                // Text Color (Foreground color)
                                ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("X",
                                style: TextStyle(color: Colors.white)))),
                    const SizedBox(width: 15)
                  ],
                ),
              ],
            ),
            //end header----------------------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                        flex: 4,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 10,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: UpdatePersonbyId(
                                personid: widget.personId.toString()),
                          ),
                        ))
                    .animate()
                    .fade(duration: 1000.ms)
                    .slideX(delay: 200.ms, duration: 200.ms),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: subtitleUpdateColors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 6,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: UpdateAddressbyperson(
                                    personId: widget.personId,
                                  )),
                            ],
                          ),
                        ).animate().fadeIn(delay: 500.ms),
                        Card(
                          color: subtitleUpdateColors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 6,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: CardInfoLayout(
                                    personId: widget.personId,
                                  )),
                            ],
                          ),
                        ).animate().fade(delay: 600.ms),
                        Card(
                          color: subtitleUpdateColors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 6,
                          child: Row(
                            children: [
                              Expanded(
                                  child: UpdateEducationbyperson(
                                      personId: widget.personId)),
                            ],
                          ),
                        ).animate().fade(delay: 700.ms),
                        Card(
                          color: subtitleUpdateColors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 6,
                          child: Row(
                            children: [
                              Expanded(
                                  child: UpdateFamilybyperson(
                                      personId: widget.personId)),
                            ],
                          ),
                        ).animate().fade(delay: 800.ms),
                        Card(
                          color: subtitleUpdateColors,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          elevation: 10,
                          child: Row(
                            children: [
                              Expanded(
                                  child: UpdateContactbyperson(
                                      personId: widget.personId)),
                            ],
                          ),
                        ).animate().fade(delay: 900.ms),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
