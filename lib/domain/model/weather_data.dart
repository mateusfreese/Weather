import 'package:weather/domain/model/weather_type.dart';

class WeatherData {
  final DateTime time;
  final double temperatureCelsius;
  final double pressure;
  final double windSpeed;
  final double humidity;
  final WeatherType weatherType;

  WeatherData({
    required this.time,
    required this.temperatureCelsius,
    required this.pressure,
    required this.windSpeed,
    required this.humidity,
    required this.weatherType,
  });
}