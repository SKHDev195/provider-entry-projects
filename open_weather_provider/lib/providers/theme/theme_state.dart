// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theme_provider.dart';

enum AppTheme {
  light,
  dark,
}

class ThemeState extends Equatable {
  const ThemeState({
    this.appTheme = AppTheme.light,
  });
  final AppTheme appTheme;

  factory ThemeState.initial() {
    return const ThemeState();
  }

  @override
  List<Object> get props => [appTheme];

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
