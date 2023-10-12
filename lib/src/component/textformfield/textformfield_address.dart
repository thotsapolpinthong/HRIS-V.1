import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:validatorless/validatorless.dart';

class MyTextFormfieldAddress extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const MyTextFormfieldAddress({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class MyTextFormfieldAddressunvalidator extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const MyTextFormfieldAddressunvalidator({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class MyTextFormfieldphone extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const MyTextFormfieldphone({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        validator: Validatorless.multiple([
          Validatorless.number('Only number.'),
          Validatorless.numbersBetweenInterval(9, 10, 'เบอร์โทร 10 หลัก')
        ]),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class MyTextFormfieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const MyTextFormfieldNumber({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator:
            Validatorless.multiple([Validatorless.required('กรุณากรอกข้อมูล')]),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(
              r'[0-9/]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
        ],
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.red),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}
