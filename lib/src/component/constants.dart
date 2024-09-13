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
var mygreenxls = const Color.fromARGB(255, 13, 114, 57);
var mygreencolors = const Color.fromARGB(255, 50, 163, 99);
var mybluecolors = Colors.lightBlue[600];
var myrowscolors = Color.fromARGB(132, 230, 242, 248);

var myLoadingScreen = Center(
        child: Lottie.asset('assets/loading.json',
            width: 500, height: 250, frameRate: FrameRate(60)))
    .animate()
    .fadeIn(duration: 600.milliseconds);

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
                backgroundColor:
                    // ignore: prefer_const_constructors
                    Color.fromARGB(255, 13, 114, 57), // widget.backgroundColor,
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
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(11)),
                    height: isHovered ? 53 : 50,
                    width: isHovered ? 48 : 45,
                    child: Image.asset(
                      'assets/xls.png',
                    )
                    //  Icon(
                    //   Icons.upload_file_rounded,
                    //   size: isHovered ? 33 : 30,
                    // )
                    ),
              ],
            ),
          ),
        ).animate().fade());
  }
}

class UploadButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool? isUploaded;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final void Function()? onPressed;
  const UploadButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.isUploaded,
      this.iconColor,
      this.backgroundColor,
      this.textColor,
      this.icon,
      required this.onPressed})
      : super(key: key);

// UploadButton(
  // width: 120,
  // height: 40,
  // text: "อัพโหลดไฟล์ กยศ.",
  // isUploaded: true,
  // onPressed: () {})
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 24,
      height: height + 5,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  backgroundColor ?? mygreycolors, // widget.backgroundColor,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconTheme(
                  data: IconThemeData(color: iconColor ?? mygreencolors),
                  child: Icon(isUploaded ?? false
                      ? Icons.check_circle_outlined
                      : icon ?? Icons.upload_rounded)),
              TextThai(
                  text: text,
                  textStyle: TextStyle(color: textColor ?? Colors.black)),
            ],
          ),
        ),
      ).animate().fade(),
    );
  }
}

class ButtonTableMenu extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final bool? isUploaded;
  final Color? iconColor;
  final Color? fontColor;
  final Widget child;
  final void Function()? onPressed;
  const ButtonTableMenu(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.isUploaded,
      required this.child,
      this.iconColor,
      this.fontColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 32,
      height: height + 5,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: mygreycolors, // widget.backgroundColor,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconTheme(
                  data: IconThemeData(color: iconColor ?? mygreencolors),
                  child: child),
              TextThai(
                  text: text,
                  textStyle: TextStyle(color: fontColor ?? Colors.black)),
            ],
          ),
        ),
      ).animate().fade(),
    );
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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
          InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.pop(context),
              child: Transform.rotate(
                  angle: (45 * 22 / 7) / 180,
                  child: Icon(
                    Icons.add_rounded,
                    size: 32,
                    color: Colors.grey[700],
                  )))
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

class MyDialogChoice {
  static void alertDialog(
      BuildContext context, String message, Function()? btnOkOnPress) {
    AwesomeDialog(
            dismissOnTouchOutside: false,
            width: 400,
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.infoReverse,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(),
                ),
              ),
            ),
            btnOkColor: mythemecolor,
            btnOkOnPress: btnOkOnPress,
            btnCancelOnPress: () {})
        .show();
  }
}

class MainDialog {
  static alertDialog(BuildContext context, String messageEN, Widget child,
      double width, double height) {
    AlertDialog(
        contentPadding: const EdgeInsets.all(8),
        backgroundColor: mygreycolors,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Stack(
          children: [
            SizedBox(width: width, height: height, child: child),
            Positioned(
                right: 0,
                top: -5,
                child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Navigator.pop(context),
                    child: Transform.rotate(
                        angle: (45 * 22 / 7) / 180,
                        child: Icon(
                          Icons.add_rounded,
                          size: 32,
                          color: Colors.grey[700],
                        )))),
          ],
        ));
  }
}
