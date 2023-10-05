import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_app_prototype/src/bloc/login_bloc/login_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/routes/routes.dart';
import 'src/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

final navigatorState = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider(create: (context) => LoginBloc());
    final personalBloc = BlocProvider(create: (context) => PersonalBloc());

    return MultiBlocProvider(
      providers: [loginBloc, personalBloc],
      child: MaterialApp(
        title: 'HRIS Demo',
        theme: ThemeData(
            // useMaterial3: true,
            ),
        routes: AppRoute.all,
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        navigatorKey: navigatorState,
      ),
    );
  }
}
