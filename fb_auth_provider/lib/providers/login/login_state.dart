// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'login_provider.dart';

enum LoginStatus {
  initial,
  submitting,
  success,
  error,
}

class LoginState extends Equatable {
  const LoginState({
    required this.loginStatus,
    required this.customError,
  });
  final LoginStatus loginStatus;
  final CustomError customError;

  factory LoginState.initial() {
    return const LoginState(
      loginStatus: LoginStatus.initial,
      customError: CustomError(),
    );
  }

  LoginState copyWith({
    LoginStatus? loginStatus,
    CustomError? customError,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      customError: customError ?? this.customError,
    );
  }

  @override
  List<Object> get props => [loginStatus, customError];

  @override
  bool get stringify => true;
}
