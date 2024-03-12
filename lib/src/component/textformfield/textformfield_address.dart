// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class TextFormFieldgraphview extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const TextFormFieldgraphview({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 45,
        child: TextFormField(
          // autovalidateMode: AutovalidateMode.always,
          // validator:
          //     Validatorless.multiple([Validatorless.required('กรุณากรอกข้อมูล')]),
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp(
          //       r'[0-9/]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
          // ],
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.red),
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.black87),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
              ),
              filled: true,
              fillColor: Colors.white),
        ),
      ),
    );
  }
}

class TextFormFieldPosition extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validatorless;
  const TextFormFieldPosition({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validatorless,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class TextFormFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validatorless;
  const TextFormFieldNumber({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validatorless,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(
              r'[0-9/]')), // ใช้ input formatter เพื่อจำกัดให้เป็นตัวเลขเท่านั้น
        ],
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class TextFormFieldPositionDescription extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validatorless;
  const TextFormFieldPositionDescription({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validatorless,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        controller: controller,
        minLines: 1,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class DropdownOrg extends StatelessWidget {
  final String labeltext;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Function(Object?)? onChanged;
  final String? Function(String?)? validator;
  const DropdownOrg(
      {super.key,
      required this.labeltext,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DropdownButtonFormField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              labelText: labeltext,
              labelStyle: const TextStyle(color: Colors.black87),
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white),
          autovalidateMode: AutovalidateMode.always,
          validator: validator,
          borderRadius: BorderRadius.circular(8),
          value: value,
          items: items,
          onChanged: onChanged),
    );
  }
}

class TextFormFieldGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validatorless;
  final bool enabled;
  const TextFormFieldGlobal({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validatorless,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        controller: controller,
        minLines: 1,
        maxLines: 4,
        enabled: enabled,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}

class TextFormFieldDatepickGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final Function(String)? onChanged;
  const TextFormFieldDatepickGlobal({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validatorless,
    required this.ontap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.calendar_today_rounded,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
        ),
        readOnly: true,
        onChanged: onChanged,
        onTap: ontap,
      ),
    );
  }
}

class TextFormFieldDatepickGlobalDisable extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final Function(String)? onChanged;
  final bool? enabled;
  const TextFormFieldDatepickGlobalDisable({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validatorless,
    required this.ontap,
    required this.enabled,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          validator: validatorless,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(
              Icons.calendar_today_rounded,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
          ),
          enabled: enabled,
          readOnly: true,
          onChanged: onChanged,
          onTap: ontap),
    );
  }
}

class TextFormFieldTimepickGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final bool? enabled;
  const TextFormFieldTimepickGlobal({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validatorless,
    required this.ontap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          validator: validatorless,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(
              Icons.watch_later_outlined,
            ),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
          ),
          enabled: enabled,
          readOnly: true,
          onTap: ontap),
    );
  }
}

class TextFormFieldTimepickerOt extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final bool? enabled;
  final Widget? suffixIcon;
  const TextFormFieldTimepickerOt({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validatorless,
    required this.ontap,
    required this.enabled,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.always,
          validator: validatorless,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
          ),
          enabled: enabled,
          readOnly: true,
          onTap: ontap),
    );
  }
}
