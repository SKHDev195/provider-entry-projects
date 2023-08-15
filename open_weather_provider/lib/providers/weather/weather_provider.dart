// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider({
    required this.weatherRepository,
  });
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  final WeatherRepository weatherRepository;

  Future<void> loadWeather(String city) async {
    _state = _state.copyWith(
      status: WeatherStatus.loading,
    );
    notifyListeners();

    try {
      final weather = await weatherRepository.fetchWeather(
        city,
      );

      _state = _state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      );
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(
        status: WeatherStatus.error,
        error: e,
      );
      notifyListeners();
    }
  }
}
