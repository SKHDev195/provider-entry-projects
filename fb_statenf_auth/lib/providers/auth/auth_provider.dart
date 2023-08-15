// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvider()
      : super(
          AuthState.unknown(),
        );

  @override
  void update(Locator watch) {
    final user = watch<fbAuth.User?>();
    if (user != null) {
      state = state.copyWith(
        authStatus: AuthStatus.authenticated,
        user: user,
      );
    } else {
      state = state.copyWith(
        authStatus: AuthStatus.unauthenticated,
      );
    }
    super.update(watch);
  }

  void signout() async {
    await read<AuthRepository>().signout();
  }
}
