import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hris_app_prototype/main.dart';
import 'package:hris_app_prototype/src/model/Login/login_model.dart';
import 'package:hris_app_prototype/src/routes/routes.dart';
import 'package:hris_app_prototype/src/services/api_personal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEvent>((event, emit) {});

    on<LoginEventLogin>((event, emit) async {
      emit(state.copyWith(isAutlhened: false));
      LoginModel? data;
      try {
        data = await ApiService.postApiLoginn(event.username, event.password);
      } catch (e) {
        print("login error $e");
        return;
      }

      if (data!.status == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("token", data.loginData.token);
        preferences.setString("personId", data.loginData.personId);
        preferences.setString("employeeId", data.loginData.employeeId);
        preferences.setString("departmentCode", data.loginData.departmentCode);
        emit(state.copyWith(isAutlhened: true, error: null));
        Navigator.pushNamed(navigatorState.currentContext!, AppRoute.homepage);
      } else {
        emit(state.copyWith(isAutlhened: false, error: 'Login failed.'));
      }
      emit(state.copyWith(isAutlhened: true, error: null));
    });
  }
}
