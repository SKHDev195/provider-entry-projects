// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fb_auth_provider/models/custom_error.dart';
import 'package:fb_auth_provider/models/user_model.dart';
import 'package:fb_auth_provider/repositories/profile_repository.dart';
import 'package:flutter/material.dart';

part 'profile_state.dart';

class ProfileProvider with ChangeNotifier {
  ProfileProvider({
    required this.profileRepository,
  });
  ProfileState _state = ProfileState.initial();
  ProfileState get state => _state;

  final ProfileRepository profileRepository;

  Future<void> getProfile({required String uid}) async {
    _state = _state.copyWith(profileStatus: ProfileStatus.loading);
    notifyListeners();

    try {
      final User user = await profileRepository.getProfile(
        uid: uid,
      );

      _state = _state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: user,
      );
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(
        profileStatus: ProfileStatus.error,
        customError: e,
      );
      notifyListeners();
    }
  }
}
