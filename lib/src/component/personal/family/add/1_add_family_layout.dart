import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/family/add/2_add_family.dart';

class AddFamilyLayout extends StatefulWidget {
  final String personId;
  const AddFamilyLayout({super.key, required this.personId});

  @override
  State<AddFamilyLayout> createState() => _AddFamilyLayoutState();
}

class _AddFamilyLayoutState extends State<AddFamilyLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 490,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 482,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Expanded(
                                child: AddFamilymember(
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
                                      'เพิ่มข้อมูลครอบครัว (Family Member Information)',
                                      style: TextStyle(fontSize: 16))),
                            )),
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
