// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:open_weather_provider/constants/constants.dart';

import '../providers.dart';

part 'theme_state.dart';

class ThemeProvider {
  ThemeProvider({
    required this.weatherProvider,
  });
  final WeatherProvider weatherProvider;

  ThemeState get state {
    if (weatherProvider.state.weather.temp > kWarmOrNot) {
      return const ThemeState();
    } else {
      return const ThemeState(appTheme: AppTheme.dark);
    }
  }
}
