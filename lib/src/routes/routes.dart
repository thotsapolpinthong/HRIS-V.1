import 'package:flutter/material.dart';

import 'package:hris_app_prototype/src/page/home_page_gen2.dart';
import 'package:hris_app_prototype/src/page/login_page.dart';

class AppRoute {
  static const loginpage = 'loginpage';
  static const homepage = 'homepage';
  static const personal = 'personal';
  static const testpage = 'testpage';

  static get all => <String, WidgetBuilder>{
        loginpage: (context) => const LoginPage(),
        homepage: (context) => const MyHomepage(),
        // personal: (context) => const PersonalPage(),
      };
}
