import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/contact_person/add/2_add_contact.dart';

class AddContactLayout extends StatefulWidget {
  final String personId;
  const AddContactLayout({super.key, required this.personId});

  @override
  State<AddContactLayout> createState() => _AddContactLayoutState();
}

class _AddContactLayoutState extends State<AddContactLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 565,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 557,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  Expanded(
                                    child: AddContactPerson(
                                      personId: widget.personId,
                                      addButton: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          const Expanded(
                            child: Card(
                                color: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8))),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                          'เพิ่มข้อมูลบุคคลที่สามารถติดต่อได้ (Contact Person Information)',
                                          style: TextStyle(fontSize: 16))),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          ),
        ).animate().fade(duration: 300.ms),
      ],
    );
  }
}
