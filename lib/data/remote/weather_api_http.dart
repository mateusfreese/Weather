import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/data/remote/models/weather_dto.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/domain/model/location.dart';

class WeatherApiHttp implements WeatherApi {
  final Uri baseUri = Uri().resolve("https://api.open-meteo.com/");

  @override
  Future<WeatherDto> getWeatherData(Location location) async {
    const String path = "/v1/forecast";
    final Map<String, dynamic> queryParameters = {
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString(),
      "hourly[]": [
        "temperature_2m",
        "weathercode",
        "relativehumidity_2m",
        "windspeed_10m",
        "pressure_msl",
      ]
    };
    Uri getWheaterDataUri =
        baseUri.replace(path: path, queryParameters: queryParameters);

    final response = await http.get(getWheaterDataUri);

    if (response.statusCode == 200) {
      return WeatherDto.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('fail to load wheather data');
    }
  }
}
