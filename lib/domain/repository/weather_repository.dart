import 'package:weather/domain/model/weather_info.dart';

abstract class WeatherRepository {
  Future<WeatherInfo> getWeatherInfo();
}
