import 'package:weather/domain/model/weather_data.dart';

class WeatherInfo {
  final Map<int, List<WeatherData>> weatherDataPerDay;
  final WeatherData? currentWeatherData;

  WeatherInfo({
    required this.weatherDataPerDay,
    this.currentWeatherData,
  });
}