import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/idcard/add/2_add_idcard.dart';
import 'package:hris_app_prototype/src/component/personal/cardinfo/passport/add/2_add_passport.dart';

class AddCardInfoLayout extends StatefulWidget {
  final String personId;
  const AddCardInfoLayout({super.key, required this.personId});

  @override
  State<AddCardInfoLayout> createState() => _AddCardInfoLayoutState();
}

class _AddCardInfoLayoutState extends State<AddCardInfoLayout> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 485,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 14,
              child: Stack(
                children: [
                  AddIdCard(
                    personId: widget.personId,
                    addButton: false,
                  ),
                  Card(
                      color: Colors.blue[100],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8))),
                      child: const SizedBox(
                        height: 50,
                        child: Center(
                            child: Text(
                                'Identification Card : บัตรประจำตัวประชาชน',
                                style: TextStyle(fontSize: 16))),
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            const VerticalDivider(
              thickness: 2,
              indent: 40,
              endIndent: 40,
              width: 2,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 14,
              child: Stack(
                children: [
                  AddPassport(
                    personId: widget.personId,
                    addButton: false,
                  ),
                  const Card(
                       color: Color.fromARGB(255, 240, 210, 214),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.vertical(
                               top: Radius.circular(8))),
                       child: SizedBox(
                         height: 50,
                         child: Center(
                             child: Text('Passport : หนังสือเดินทาง',
                                 style: TextStyle(fontSize: 16))),
                       )),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 300.ms);
  }
}
