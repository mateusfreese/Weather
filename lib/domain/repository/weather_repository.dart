import 'package:weather/domain/model/location.dart';
import 'package:weather/domain/model/weather_info.dart';

abstract class WeatherRepository {
  Future<WeatherInfo> getWeatherInfo(Location location);
}
