// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../models/custom_error.dart';

part 'login_state.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider({
    required this.authRepository,
  });
  LoginState _state = LoginState.initial();
  LoginState get state => _state;

  final AuthRepository authRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _state = _state.copyWith(loginStatus: LoginStatus.submitting);
    notifyListeners();

    try {
      await authRepository.signin(
        email: email,
        password: password,
      );

      _state = _state.copyWith(
        loginStatus: LoginStatus.success,
      );
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(
        loginStatus: LoginStatus.error,
        customError: e,
      );
      notifyListeners();
      rethrow;
    }
  }
}
