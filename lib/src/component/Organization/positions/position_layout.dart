import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/add/created_position.dart';
import 'package:hris_app_prototype/src/component/Organization/positions/datatable_position.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class MyPositionsLayout extends StatefulWidget {
  const MyPositionsLayout({super.key});

  @override
  State<MyPositionsLayout> createState() => _MyPositionsLayoutState();
}

class _MyPositionsLayoutState extends State<MyPositionsLayout> {
  void showDialogCreate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: mygreycolors,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'เพิ่มตำแหน่งพนักงาน',
                              style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(fontSize: 18)),
                            ),
                            const TextSpan(
                              text: ' (Create Position.)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: const SizedBox(
                width: 420,
                height: 480,
                child: EditPositions(
                  onEdit: false,
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              showDialogCreate();
            },
            child: const Icon(Icons.add, size: 30)),
      ).animate().shake(),
      body: const PositionDataTable(),
    ));
  }
}
