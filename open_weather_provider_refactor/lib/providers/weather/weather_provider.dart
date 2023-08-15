// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';

part 'weather_state.dart';

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {
  WeatherProvider()
      : super(
          WeatherState.initial(),
        );

  Future<void> loadWeather(String city) async {
    final weatherRepository = read<WeatherRepository>();

    state = state.copyWith(
      status: WeatherStatus.loading,
    );

    try {
      final weather = await weatherRepository.fetchWeather(
        city,
      );

      state = state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        status: WeatherStatus.error,
        error: e,
      );
    }
  }
}
