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
          child: MyStepper(personId: widget.personId)),
    );
  }
}
