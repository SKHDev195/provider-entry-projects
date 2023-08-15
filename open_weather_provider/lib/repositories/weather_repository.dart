// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:open_weather_provider/exceptions/exceptions.dart';
import 'package:open_weather_provider/models/custom_error.dart';
import 'package:open_weather_provider/models/weather.dart';
import 'package:open_weather_provider/services/weather_api_services.dart';

class WeatherRepository {
  WeatherRepository({
    required this.weatherApiServices,
  });
  final WeatherApiServices weatherApiServices;

  Future<Weather> fetchWeather(String city) async {
    try {
      final directGeocoding = await weatherApiServices.getDirectGeocoding(city);
      final tempWeather = await weatherApiServices.getWeather(directGeocoding);

      final weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(
        errMsg: e.message,
      );
    } catch (e) {
      throw CustomError(
        errMsg: e.toString(),
      );
    }
  }
}
