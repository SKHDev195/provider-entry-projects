// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({
    required this.authRepository,
  });
  AuthState _state = AuthState.unknown();
  AuthState get state => _state;

  final AuthRepository authRepository;

  void update(fbAuth.User? user) {
    if (user != null) {
      _state = _state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
      );
    } else {
      _state = _state.copyWith(
        authStatus: AuthStatus.unauthenticated,
      );
    }
    notifyListeners();
  }

  void signout() async {
    await authRepository.signout();
  }
}
