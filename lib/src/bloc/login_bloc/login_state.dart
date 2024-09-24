part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isAutlhened;
  final bool error;
  final int pageNumber;
  const LoginState({
    this.pageNumber = 1,
    this.isAutlhened = true,
    this.error = false,
  });

  LoginState copyWith({
    bool? isAutlhened,
    required bool error,
    int? pageNumber,
  }) {
    return LoginState(
      isAutlhened: isAutlhened ?? this.isAutlhened,
      error: error,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }

  @override
  List<Object> get props => [isAutlhened, error, pageNumber];
}
