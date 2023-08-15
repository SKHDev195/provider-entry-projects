// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/custom_error.dart';

part 'login_state.dart';

class LoginProvider extends StateNotifier<LoginState> with LocatorMixin {
  LoginProvider()
      : super(
          LoginState.initial(),
        );

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loginStatus: LoginStatus.submitting);

    try {
      await read<AuthRepository>().signin(
        email: email,
        password: password,
      );

      state = state.copyWith(
        loginStatus: LoginStatus.success,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        loginStatus: LoginStatus.error,
        customError: e,
      );

      rethrow;
    }
  }
}
