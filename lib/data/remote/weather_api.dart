import 'package:weather/data/remote/weather_dto.dart';

abstract class WeatherApi {

  Future<WeatherDto> getWeatherData(double latitude, double longitude);
}

