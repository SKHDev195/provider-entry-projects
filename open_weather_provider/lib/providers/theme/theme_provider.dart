import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_provider/constants/constants.dart';

import '../providers.dart';
part 'theme_state.dart';

class ThemeProvider with ChangeNotifier {
  ThemeState _state = ThemeState.initial();
  ThemeState get state => _state;

  void toggleTheme(WeatherProvider weatherProvider) {
    _state = _state.copyWith(
      appTheme: (weatherProvider.state.weather.temp > kWarmOrNot)
          ? AppTheme.light
          : AppTheme.dark,
    );
    notifyListeners();
  }
}
