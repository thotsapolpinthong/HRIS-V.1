part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final String username;
  final String password;

  LoginEventLogin({required this.username, required this.password});
}
