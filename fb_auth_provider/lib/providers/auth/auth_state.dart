// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'auth_provider.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  const AuthState({
    required this.authStatus,
    this.user,
  });
  final AuthStatus authStatus;
  final fbAuth.User? user;

  factory AuthState.unknown() {
    return const AuthState(
      authStatus: AuthStatus.unknown,
    );
  }

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        authStatus,
        user,
      ];
}
