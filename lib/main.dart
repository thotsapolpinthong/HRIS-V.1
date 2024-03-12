import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_app_prototype/src/bloc/employee_bloc/employee_bloc.dart';
import 'package:hris_app_prototype/src/bloc/homepage_bloc/homepage_bloc.dart';
import 'package:hris_app_prototype/src/bloc/login_bloc/login_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/department_bloc/bloc/department_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/organization_bloc/bloc/organization_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_bloc/positions_bloc.dart';
import 'package:hris_app_prototype/src/bloc/organization_bloc/position_org_bloc/position_org_bloc.dart';
import 'package:hris_app_prototype/src/bloc/personal_bloc/personal_bloc.dart';
import 'package:hris_app_prototype/src/bloc/selfservice_bloc/selfservice_bloc.dart';
import 'package:hris_app_prototype/src/bloc/timeattendance_bloc/timeattendance_bloc.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
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
    final positionsBloc = BlocProvider(create: (context) => PositionsBloc());
    final organizationBloc =
        BlocProvider(create: (context) => OrganizationBloc());
    final departmentBloc = BlocProvider(create: (context) => DepartmentBloc());
    final positionOrgBloc =
        BlocProvider(create: (context) => PositionOrgBloc());
    final homePageBloc = BlocProvider(create: (context) => HomepageBloc());
    final employeeBloc = BlocProvider(create: (context) => EmployeeBloc());
    final timeAttendanceBloc =
        BlocProvider(create: (context) => TimeattendanceBloc());
    final selfServiceBloc =
        BlocProvider(create: (context) => SelfServiceBloc());

    return MultiBlocProvider(
      providers: [
        loginBloc,
        homePageBloc,
        personalBloc,
        positionsBloc,
        organizationBloc,
        departmentBloc,
        employeeBloc,
        positionOrgBloc,
        timeAttendanceBloc,
        selfServiceBloc,
      ],
      child: MaterialApp(
        supportedLocales: const [
          Locale('en', 'us'),
          Locale('en', 'gb'),
        ],
        title: 'HRIS Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: mygreycolors,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.light(primary: mythemecolor),
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
