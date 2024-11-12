import 'package:weather/data/mappers/weather_mappers.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/domain/model/location.dart';
import 'package:weather/domain/model/weather_info.dart';
import 'package:weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherApi weatherApi;
  WeatherRepositoryImpl({required this.weatherApi});

  @override
  Future<WeatherInfo> getWeatherInfo(Location location) {
    return weatherApi.getWeatherData(location)
      .then((data) => data.toWeatherInfo());
  }
}