import 'package:weather/data/remote/models/weather_dto.dart';

abstract class WeatherApi {

  Future<WeatherDto> getWeatherData(double latitude, double longitude);
}

