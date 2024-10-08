// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
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

// Global <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
class DropdownMenuGlobal extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final String? label;
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  const DropdownMenuGlobal({
    Key? key,
    required this.label,
    required this.width,
    required this.controller,
    required this.onSelected,
    required this.dropdownMenuEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownMenu(
          requestFocusOnTap: true,
          controller: controller,
          width: width,
          trailingIcon:
              Icon(Icons.content_paste_search_rounded, color: mythemecolor),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.all(10.0),
              errorStyle: const TextStyle(height: 0.5),
              filled: true,
              fillColor: Colors.white,
              iconColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.black)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              )),
          label: Text(label.toString()),
          enableFilter: true,
          onSelected: onSelected,
          dropdownMenuEntries: dropdownMenuEntries),
    );
  }
}

class DropdownMenuGlobalOutline extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final String? label;
  final Function(dynamic)? onSelected;
  final List<DropdownMenuEntry<dynamic>> dropdownMenuEntries;
  const DropdownMenuGlobalOutline({
    Key? key,
    required this.label,
    required this.width,
    required this.controller,
    required this.onSelected,
    required this.dropdownMenuEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownMenu(
          controller: controller,
          width: width,
          hintText: "กรุณากรอกข้อมูล*",
          trailingIcon: Icon(
            Icons.content_paste_search_rounded,
            color: controller?.text == "" ? Colors.red[700]! : Colors.grey[600],
          ),
          inputDecorationTheme: InputDecorationTheme(
              errorStyle: const TextStyle(height: 0.5),
              hintStyle: TextStyle(color: Colors.red[700]),
              contentPadding: const EdgeInsets.all(10.0),
              filled: true,
              fillColor: Colors.white,
              labelStyle: const TextStyle(color: Colors.black),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      color: controller?.text == ""
                          ? Colors.red[800]!
                          : Colors.grey[400]!)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              )),
          label: Text(label.toString()),
          enableFilter: true,
          onSelected: onSelected,
          dropdownMenuEntries: dropdownMenuEntries),
    );
  }
}

class DropdownGlobal extends StatelessWidget {
  final String labeltext;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Function(Object?)? onChanged;
  final String? Function(String?)? validator;
  final Color? outlineColor;
  final Widget? suffixIcon;
  const DropdownGlobal({
    super.key,
    required this.labeltext,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.outlineColor,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0.5),
              contentPadding: const EdgeInsets.all(10.0),
              labelText: labeltext,
              labelStyle: const TextStyle(color: Colors.black87),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                      width: outlineColor == null ? 1 : 2,
                      color: outlineColor == null
                          ? Colors.black87
                          : outlineColor!)),
              fillColor: Colors.white,
              suffixIcon: suffixIcon),
          autovalidateMode: AutovalidateMode.always,
          validator: validator,
          borderRadius: BorderRadius.circular(8),
          value: value,
          items: items,
          onChanged: onChanged),
    );
  }
}

class DropdownGlobalOutline extends StatelessWidget {
  final String labeltext;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Function(Object?)? onChanged;
  final String? Function(String?)? validator;
  final bool enable;
  final Color? outlineColor;
  const DropdownGlobalOutline(
      {super.key,
      required this.labeltext,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.validator,
      this.outlineColor,
      this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0.5),
              contentPadding: const EdgeInsets.all(10.0),
              labelText: labeltext,
              labelStyle: const TextStyle(color: Colors.black87),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      // width: outlineColor == null ? 1 : 2,
                      color: outlineColor == null
                          ? Colors.black12
                          : outlineColor!)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              filled: true,
              enabled: enable,
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

//////////////////////////////////////////////////////////
class TextFormFieldGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validatorless;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Widget? suffixIcon;
  final String? suffixText;
  final Color? outlineColor;
  final Color? fillColor;
  final bool readOnly;
  const TextFormFieldGlobal(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.hintText,
      this.validatorless,
      required this.enabled,
      this.inputFormatters,
      this.onChanged,
      this.onTap,
      this.suffixIcon,
      this.suffixText,
      this.outlineColor,
      this.fillColor,
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        minLines: 1,
        maxLines: 4,
        enabled: enabled,
        readOnly: readOnly,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            errorStyle: const TextStyle(height: 0.5),
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            labelStyle: const TextStyle(color: Colors.black87),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  color: outlineColor == null ? Colors.black87 : outlineColor!),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            filled: true,
            fillColor: fillColor ?? Colors.white),
      ),
    );
  }
}

class TextFormFieldNormalGlobal extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validatorless;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Widget? suffixIcon;
  final String? suffixText;
  final Color? outlineColor;
  const TextFormFieldNormalGlobal({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validatorless,
    this.enabled,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    this.suffixText,
    this.outlineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: validatorless,
      inputFormatters: inputFormatters,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      minLines: 1,
      maxLines: 4,
      enabled: enabled,
      style: GoogleFonts.kanit(textStyle: TextStyle(color: Colors.grey[700])),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        errorStyle: const TextStyle(height: 0.5),
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        // suffixStyle: TextStyle(color: Colors.grey[700], fontSize: 16),
        labelStyle: const TextStyle(color: Colors.black87),
      ),
    );
  }
}

class TextFormFieldGlobalWithOutLine extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validatorless;
  final bool enabled;
  final Widget? suffixIcon;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  const TextFormFieldGlobalWithOutLine({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validatorless,
    required this.enabled,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        inputFormatters: inputFormatters,
        controller: controller,
        minLines: 1,
        maxLines: 4,
        enabled: enabled,
        readOnly: readOnly,
        onChanged: onChanged,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            errorStyle: const TextStyle(height: 0.5),
            hintText: hintText,
            labelText: labelText,
            suffixIcon: suffixIcon,
            labelStyle: TextStyle(
                color: enabled == false ? Colors.black54 : Colors.black87),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
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
  final bool? enabled;
  const TextFormFieldDatepickGlobal({
    Key? key,
    required this.controller,
    required this.labelText,
    this.validatorless,
    required this.ontap,
    this.onChanged,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0.5),
          contentPadding: const EdgeInsets.all(10.0),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconTheme(
              data: IconThemeData(color: mythemecolor),
              child: Icon(
                Icons.calendar_today_rounded,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black87),
          ),
          enabled: enabled ?? true,
        ),
        readOnly: true,
        onChanged: onChanged,
        onTap: ontap,
      ),
    );
  }
}

class TextFormFieldDatepickGlobalWithoutLine extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final Function(String)? onChanged;
  final bool enable;
  final Color? outlineColor;
  const TextFormFieldDatepickGlobalWithoutLine({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validatorless,
    required this.ontap,
    this.onChanged,
    this.enable = true,
    this.outlineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        validator: validatorless,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          errorStyle: const TextStyle(height: 0.5),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconTheme(
              data: IconThemeData(color: mythemecolor),
              child: Icon(
                Icons.calendar_today_rounded,
              )),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color:
                      outlineColor == null ? Colors.black12 : outlineColor!)),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black12),
          ),
        ),
        readOnly: true,
        onChanged: onChanged,
        onTap: ontap,
        enabled: enable,
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
            suffixIcon: Icon(
              Icons.watch_later_outlined,
              color: mythemecolor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black87),
            ),
          ),
          enabled: enabled,
          readOnly: true,
          onTap: ontap),
    );
  }
}

class TextFormFieldpicker extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validatorless;
  final Function()? ontap;
  final bool? enabled;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onChanged;
  final bool readOnly;
  const TextFormFieldpicker(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.validatorless,
      this.ontap,
      required this.enabled,
      this.suffixIcon,
      this.hintText,
      this.onChanged,
      this.readOnly = true})
      : super(key: key);

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
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
          ),
          enabled: enabled,
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: ontap),
    );
  }
}

class TextFormFieldSearch extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Function()? ontap;
  final bool? enabled;
  // final Widget? suffixIcon;
  // final Widget? prefixIcon;
  // final String? hintText;
  final Function(String)? onChanged;

  const TextFormFieldSearch(
      {Key? key,
      required this.controller,
      this.labelText,
      this.ontap,
      required this.enabled,
      // this.suffixIcon,
      // this.prefixIcon,
      // this.hintText,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            hintText: "Search (ENG/TH)",
            fillColor: Colors.white,
            suffixIcon: IconTheme(
                data: IconThemeData(color: myambercolors),
                child: Icon(
                  Icons.search_rounded,
                )),
            // prefixIcon: IconTheme(
            //     data: IconThemeData(color: myambercolors),
            //     child: Icon(
            //       Icons.search_rounded,
            //     )),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
        enabled: enabled,
        onChanged: onChanged,
        onTap: ontap);
  }
}
