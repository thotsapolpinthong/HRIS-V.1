// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:validatorless/validatorless.dart';

var myDefaultBackground = Colors.grey[350];
var mysecondaryBackground = const Color.fromRGBO(147, 179, 239, 1);
var colorstone1fontwhite1 = const Color.fromRGBO(0, 129, 167, 1);
var colorstone1fontwhite2 = const Color.fromRGBO(0, 175, 185, 1);
var colorstone1fontblack1 = const Color.fromRGBO(254, 217, 183, 1);
var colorstone1fontblack2 = const Color.fromRGBO(253, 252, 220, 1);
var colorstone1fontwhite3 = const Color.fromRGBO(240, 113, 103, 1);

var titleUpdateColors = Colors.grey[200];
var subtitleUpdateColors = Colors.grey[100];
var mygreycolors = Colors.grey[200];
var myAppBar = AppBar(backgroundColor: Colors.grey[300]);
var mythemecolor = const Color.fromARGB(255, 9, 47, 105);
var mytextcolors = Colors.grey[350];
var myambercolors = Colors.amber[600];
var myredcolors = Colors.red[700];
var headerbluecolors = const Color.fromARGB(255, 0, 57, 143);

var myLoadingScreen = SizedBox(
    height: 600,
    child: Center(
        child: Lottie.asset('assets/loading.json',
            width: 500, height: 250, frameRate: FrameRate(60))));

//floatingButtons
class MyFloatingButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  const MyFloatingButton({
    Key? key,
    this.onPressed,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<MyFloatingButton> createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (detail) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (detail) {
          setState(() {
            isHovered = false;
          });
        },
        child: SizedBox(
          width: isHovered ? 55 : 50,
          height: isHovered ? 55 : 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.backgroundColor,
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: widget.onPressed,
              child: widget.icon),
        ).animate().fade());
  }
}

class MyFloatingUpload extends StatefulWidget {
  final void Function()? onPressed;

  final Color? backgroundColor;
  const MyFloatingUpload({
    Key? key,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<MyFloatingUpload> createState() => _MyFloatingUploadState();
}

class _MyFloatingUploadState extends State<MyFloatingUpload> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (detail) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (detail) {
          setState(() {
            isHovered = false;
          });
        },
        child: SizedBox(
          height: isHovered ? 53 : 48,
          width: isHovered ? 154 : 147,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: widget.backgroundColor,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Gap(10),
                const Text("Upload file"),
                const Gap(10),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 114, 29),
                        borderRadius: BorderRadius.circular(11)),
                    height: isHovered ? 52 : 50,
                    width: isHovered ? 48 : 45,
                    child: Icon(
                      Icons.upload_file_rounded,
                      size: isHovered ? 33 : 30,
                    )),
              ],
            ),
          ),
        ).animate().fade());
  }
}

// icon delete row table
class RowDeleteBox extends StatelessWidget {
  final void Function()? onPressed;
  const RowDeleteBox({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 38,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.all(1)),
          onPressed: onPressed,
          child: const Icon(Icons.delete_rounded)),
    );
  }
}

class TextThai extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  const TextThai({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.kanit(textStyle: textStyle),
      textAlign: textAlign,
    );
  }
}

class MySaveButtons extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? height;
  const MySaveButtons({
    Key? key,
    required this.text,
    this.onPressed,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: height,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                onPressed: onPressed,
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black87),
                )),
          )),
    );
  }
}

// title dialog ชื่อ กับ x
class TitleDialog extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? size;
  final Color? color;
  const TitleDialog({
    Key? key,
    required this.title,
    this.onPressed,
    this.size = 18,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: size, color: color),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
            onPressed: onPressed,
            child: const Text(
              'X',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDeleteBox extends StatelessWidget {
  final void Function()? onPressedCancel;
  final TextEditingController? controller;
  final void Function()? onPressedOk;
  const MyDeleteBox(
      {super.key,
      required this.onPressedCancel,
      required this.controller,
      required this.onPressedOk});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: mygreycolors,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        icon: IconButton(
            color: Colors.red[600],
            icon: const Icon(
              Icons.cancel,
            ),
            onPressed: onPressedCancel),
        content: SizedBox(
          width: 320,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 2, child: Text('หมายเหตุ (โปรดระบุ)')),
              Expanded(
                flex: 12,
                child: Center(
                  child: Card(
                    elevation: 2,
                    child: TextFormField(
                      validator: Validatorless.required('กรอกข้อความ'),
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          filled: true,
                          fillColor: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: onPressedOk, child: const Text("OK"))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class MyContainerShadows extends StatelessWidget {
  final double? height;
  final double? width;
  final Color mainColor;
  final Color shadowColor1;
  final Color shadowColor2;
  final Widget? child;
  const MyContainerShadows({
    Key? key,
    this.height,
    this.width,
    required this.mainColor,
    required this.shadowColor1,
    required this.shadowColor2,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: shadowColor1,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1.0),
            BoxShadow(
                color: shadowColor2,
                offset: const Offset(-4.0, -4.0),
                blurRadius: 5,
                spreadRadius: 1.0)
          ]),
      height: height,
      width: width,
      child: child,
    );
  }
}

class MyDialogSuccess {
  static void alertDialog(
      BuildContext context, bool success, bool onEdit, String messageEN) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      width: 500,
      context: context,
      animType: AnimType.topSlide,
      dialogType: success == true ? DialogType.success : DialogType.error,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                success == true
                    ? onEdit == false
                        ? 'Created $messageEN Success.'
                        : 'Edit $messageEN Success.'
                    : onEdit == false
                        ? 'Created $messageEN Fail.'
                        : 'Edit $messageEN Fail.',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              Text(
                success == true
                    ? onEdit == false
                        ? 'เพิ่มข้อมูลสำเร็จ'
                        : 'แก้ไขข้อมูลสำเร็จ'
                    : onEdit == false
                        ? 'เพิ่มข้อมูลไม่สำเร็จ'
                        : 'แก้ไขข้อมูลไม่สำเร็จ',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
      btnOkColor: success == true ? Colors.greenAccent : Colors.red,
      btnOkOnPress: () {
        if (success) {
          Navigator.pop(context);
        }
      },
    ).show();
  }
}
