import 'package:weather/data/remote/models/weather_dto.dart';
import 'package:weather/domain/model/location.dart';

abstract class WeatherApi {

  Future<WeatherDto> getWeatherData(Location location);
}

