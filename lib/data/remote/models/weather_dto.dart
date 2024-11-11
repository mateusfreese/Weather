import 'package:weather/data/remote/models/weather_data_dto.dart';

class WeatherDto {
  WeatherDataDto weatherData;

  WeatherDto(this.weatherData);

  WeatherDto.fromJson(Map<String, dynamic> json)
      : weatherData = WeatherDataDto.fromJson(json['hourly']);
}
