import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/component/personal/datatable_personal.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: const DataTablePerson(
        employee: false,
      ),
    ));
  }
}
