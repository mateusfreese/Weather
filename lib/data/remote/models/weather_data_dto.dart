import 'package:weather/data/remote/utils.dart';

class WeatherDataDto {
  List<String> time;
  List<double> temperatures;
  List<int> weatherCodes;
  List<double> pressures;
  List<double> windSpeeds;
  List<double> humidities;

  WeatherDataDto(
    this.time,
    this.temperatures,
    this.weatherCodes,
    this.pressures,
    this.windSpeeds,
    this.humidities,
  );

  factory WeatherDataDto.fromJson(Map<String, dynamic> json) {

    return WeatherDataDto(
      convertList<String>(json['time']),
      convertList<double>(json['temperature_2m']),
      convertList<int>(json['weathercode']),
      convertList<double>(json['pressure_msl']),
      convertList<double>(json['windspeed_10m']),
      convertList<double>(json['relativehumidity_2m']),
    );
  }
}
