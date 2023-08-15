// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_provider.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.customError,
  });
  final ProfileStatus profileStatus;
  final User user;
  final CustomError customError;

  factory ProfileState.initial() {
    return ProfileState(
      profileStatus: ProfileStatus.initial,
      user: User.initial(),
      customError: const CustomError(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        profileStatus,
        user,
        customError,
      ];

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? customError,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      customError: customError ?? this.customError,
    );
  }
}
