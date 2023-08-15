part of 'signup_provider.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  const SignupState({
    required this.signupStatus,
    required this.customError,
  });
  final SignupStatus signupStatus;
  final CustomError customError;

  factory SignupState.initial() {
    return const SignupState(
      signupStatus: SignupStatus.initial,
      customError: CustomError(),
    );
  }

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? customError,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      customError: customError ?? this.customError,
    );
  }

  @override
  List<Object> get props => [signupStatus, customError];

  @override
  bool get stringify => true;
}
