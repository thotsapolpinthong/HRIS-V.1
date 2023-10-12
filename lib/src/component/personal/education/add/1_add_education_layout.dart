import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/education/add/2_add_education.dart';

class AddEducationLayout extends StatefulWidget {
  final String personId;

  const AddEducationLayout({super.key, required this.personId});

  @override
  State<AddEducationLayout> createState() => _AddEducationLayoutState();
}

class _AddEducationLayoutState extends State<AddEducationLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 482,
                        child: Column(
                          children: [
                            const SizedBox(height: 45),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: AddEducation(
                                  personId: widget.personId,
                                  addButton: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Card(
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8))),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'เพิ่มประวัติการศึกษา (Education Information.)',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
        ),
      ],
    ).animate().fade(duration: 300.ms);
  }
}
