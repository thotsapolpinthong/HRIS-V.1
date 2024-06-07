// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
var myAppBar = AppBar(
  backgroundColor: Colors.grey[300],
);
var mythemecolor = const Color.fromARGB(255, 9, 47, 105);
var mytextcolors = Colors.grey[350];
var myambercolors = Colors.amber[600];
var myredcolors = Colors.red[700];

var myLoadingScreen = SizedBox(
    height: 600,
    child: Center(
        child: Lottie.asset('assets/loading.json',
            width: 500, height: 250, frameRate: FrameRate(60))));

//floatingButtons
class MyFloatingButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget? icon;
  const MyFloatingButton({
    Key? key,
    this.onPressed,
    this.icon,
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
                  padding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: widget.onPressed,
              child: widget.icon),
        ).animate().shake());
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
  const MySaveButtons({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: const TextStyle(color: Colors.black87),
              ))),
    );
  }
}

// title dialog ชื่อ กับ x
class TitleDialog extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double? size;
  const TitleDialog({
    Key? key,
    required this.title,
    this.onPressed,
    this.size = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size),
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

// var myDrawer = SizedBox(
//   width: 280,
//   child: Drawer(
//     backgroundColor: Colors.blue[200],
//     child: ListView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         children: [
//           DrawerHeader(
//               child: Card(
//                   child: Image.network(
//                       "https://www.siamtobacco.com/STEC-logoLandScape.png"))),
//           const UserAccountsDrawerHeader(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(
//                         "https://s.isanook.com/tr/0/ud/201/1009004/222.jpg"),
//                     fit: BoxFit.fill)),
//             accountName: Text("Thotsapol Pinthong"),
//             accountEmail: Text("thotsapol@siamtobacco.com"),
//             currentAccountPicture: CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg"),
//             ),
//             otherAccountsPictures: [
//               CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg")),
//               CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://pbs.twimg.com/profile_images/794107415876747264/g5fWe6Oh_400x400.jpg")),
//             ],
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('H O M E P A G E'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.person_search_rounded),
//             title: const Text('E m p l o y e e'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.attach_money_rounded),
//             title: const Text('S A L A R Y'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.calendar_today_outlined),
//             title: const Text('C A L E N D A R'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('S E T T I N G'),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('L O G O U T'),
//             onTap: () {
//               // SharedPreferences preferences =
//               //     await SharedPreferences.getInstance();
//               // preferences.clear();
//               // // Navigator.popAndPushNamed(
//               // //     navigatorState.currentContext!, AppRoute.login);
//               // Navigator.of(navigatorState.currentContext!).pushAndRemoveUntil(
//               //     MaterialPageRoute(builder: (context) => const LoginPage()),
//               //     (Route route) => false);
//             },
//           ),
//           // BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//           //   return ListTile(
//           //     leading: const Icon(Icons.logout),
//           //     title: const Text('L O G O U T B L O C'),
//           //     onTap: () {
//           //       context.read<LoginBloc>().add(LoginEventLogout());
//           //     },
//           //   );
//           // }),
//           const ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('L O G O U T'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('L O G O U T'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('L O G O U T'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('L O G O U T'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('L O G O U T'),
//           ),
//         ]),
//   ),
// );
