class WeatherException implements Exception {
  WeatherException({this.message = 'Something went wrong'}) {
    message = 'Weather Exception: $message';
  }
  String message;

  @override
  String toString() {
    return message;
  }
}
