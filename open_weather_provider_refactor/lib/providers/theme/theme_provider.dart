// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:open_weather_provider/constants/constants.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

part 'theme_state.dart';

class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider()
      : super(
          ThemeState.initial(),
        );

  @override
  void update(Locator watch) {
    final weather = watch<WeatherState>().weather;

    if (weather.temp > kWarmOrNot) {
      state = state.copyWith(
        appTheme: AppTheme.light,
      );
    } else {
      state = state.copyWith(
        appTheme: AppTheme.dark,
      );
    }
    super.update(watch);
  }
}
