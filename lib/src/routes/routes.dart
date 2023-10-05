import 'package:flutter/material.dart';
import 'package:hris_app_prototype/src/page/home_page.dart';
import 'package:hris_app_prototype/src/page/login_page.dart';
import 'package:hris_app_prototype/src/page/personal.dart/personal_page.dart';

class AppRoute {
  static const loginpage = 'loginpage';
  static const homepage = 'homepage';
  static const personal = 'personal';

  static get all => <String, WidgetBuilder>{
        loginpage: (context) => const LoginPage(),
        homepage: (context) => const HomePage(),
        personal: (context) => const PersonalPage(),
      };
}
