part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isAutlhened;
  final String error;
  final int pageNumber;
  const LoginState({
    this.pageNumber = 1,
    this.isAutlhened = false,
    this.error = "null",
  });

  LoginState copyWith({
    bool? isAutlhened,
    String? error,
    int? pageNumber,
  }) {
    return LoginState(
      isAutlhened: isAutlhened ?? this.isAutlhened,
      error: error ?? this.error,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object> get props => [isAutlhened, error, pageNumber];
}
