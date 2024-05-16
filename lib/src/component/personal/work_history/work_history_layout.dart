// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WorkHistoryLayout extends StatefulWidget {
  final String personId;
  const WorkHistoryLayout({
    Key? key,
    required this.personId,
  }) : super(key: key);

  @override
  State<WorkHistoryLayout> createState() => _WorkHistoryLayoutState();
}

class _WorkHistoryLayoutState extends State<WorkHistoryLayout> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Card(
            color: Colors.red[800],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 2,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              leading: const Icon(
                Icons.history_rounded,
                color: Colors.white,
              ),
              title: const Text(
                  'บันทึกข้อมูลประวัติการทำงาน (Work History TH/EN)',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white)),
              trailing: ExpandIcon(
                isExpanded: _isExpanded,
                color: Colors.white,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          ).animate().fade(duration: 300.ms),
      ],
    );
  }
}
