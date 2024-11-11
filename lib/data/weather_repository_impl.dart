import 'package:weather/data/mappers/weather_mappers.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/domain/model/weather_info.dart';
import 'package:weather/domain/repository/weather_repository.dart';

// canoas location
const double latitude = -29.923929;
const double longitude = -51.190140;

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherApi weatherApi;
  WeatherRepositoryImpl({required this.weatherApi});

  @override
  Future<WeatherInfo> getWeatherInfo() {
    return weatherApi.getWeatherData(latitude, longitude)
      .then((data) => data.toWeatherInfo());
  }
}