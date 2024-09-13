// ignore_for_file: prefer_const_constructors
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hris_app_prototype/src/bloc/login_bloc/login_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text = 'dev';
    _passwordController.text = '@dev123';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(child: MoveWindow()),
                  MinimizeWindowButton(
                      colors: WindowButtonColors(iconNormal: mythemecolor)),
                  MaximizeWindowButton(
                      colors: WindowButtonColors(iconNormal: mythemecolor)),
                  CloseWindowButton(
                      colors: WindowButtonColors(
                          iconNormal: mythemecolor, mouseOver: myredcolors))
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 430),
                              child: Image.asset('assets/stec2.png'),
                            ))
                        .animate()
                        .fade(
                          // delay: 300.ms,
                          duration: 1400.ms,
                        )
                        .slideX(
                          begin: 1,
                          end: 0,
                          duration: 1000.ms,
                        ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 420,
                      height: 890,
                      decoration: BoxDecoration(
                          color: mythemecolor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(40),
                            Text(
                              "H R I S",
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: mytextcolors),
                            ),
                            Gap(60),
                            Icon(
                              Icons.lock,
                              size: 110,
                              color: mytextcolors,
                            ).animate().shake(delay: 1400.ms),
                            const SizedBox(height: 15),
                            Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: mytextcolors),
                            ),
                            const SizedBox(height: 35),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " Username",
                                  style: TextStyle(color: mytextcolors),
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " Password",
                                  style: TextStyle(color: mytextcolors),
                                )),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: 280,
                                  height: 40,
                                  child: ElevatedButton(
                                    // style: const ButtonStyle(
                                    //     backgroundColor: MaterialStatePropertyAll(
                                    //   Color.fromRGBO(69, 93, 219, 1),
                                    // )),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber[700]),
                                    child: state.isAutlhened == false
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  color: mythemecolor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('Please Wait...',
                                                  style: TextStyle(
                                                      color: mythemecolor))
                                            ],
                                          )
                                        : Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: mythemecolor),
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        isloading = !isloading;

                                        context.read<LoginBloc>().add(
                                            LoginEventLogin(
                                                username:
                                                    _usernameController.text,
                                                password:
                                                    _passwordController.text));
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _usernameController.text = 'dev';
                                        _passwordController.text = '@dev123';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.admin_panel_settings_rounded,
                                      color: mygreycolors,
                                      size: 40,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _usernameController.text = 'thotsapol';
                                        _passwordController.text =
                                            '!Vcxz321654987';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.person_search_rounded,
                                      color: mygreycolors,
                                      size: 40,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ).animate().slideX(duration: 300.ms)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
