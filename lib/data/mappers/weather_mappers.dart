import '../../domain/model/weather_data.dart';
import '../../domain/model/weather_info.dart';
import '../../domain/model/weather_type.dart';
import '../remote/models/weather_data_dto.dart';
import '../remote/models/weather_dto.dart';

class IndexedWeatherData {
  final int index;
  final WeatherData data;

  IndexedWeatherData({
    required this.index,
    required this.data,
  });
}

extension WeatherDataDtoExtension on WeatherDataDto {
  Map<int, List<WeatherData>> toWeatherDataMap() {
    // Parsing times and mapping data to WeatherData instances
    List<IndexedWeatherData> indexedData = List.generate(time.length, (index) {
      DateTime parsedTime = DateTime.parse(time[index]);
      double temperature = temperatures[index];
      int weatherCode = weatherCodes[index];
      double windSpeed = windSpeeds[index];
      double pressure = pressures[index];
      double humidity = humidities[index];

      return IndexedWeatherData(
        index: index,
        data: WeatherData(
          time: parsedTime,
          temperatureCelsius: temperature,
          pressure: pressure,
          windSpeed: windSpeed,
          humidity: humidity,
          weatherType: getWeatherType(weatherCode),
        ),
      );
    });

    // Group by index / 24 (each day)
    Map<int, List<WeatherData>> groupedData = {};
    for (var item in indexedData) {
      int dayIndex = item.index ~/ 24;
      if (groupedData[dayIndex] == null) {
        groupedData[dayIndex] = [];
      }
      groupedData[dayIndex]!.add(item.data);
    }

    return groupedData;
  }
}

extension WeatherDtoExtension on WeatherDto {
  WeatherInfo toWeatherInfo() {
    const todayIndex = 0;
    const weatherAheadTime = Duration(minutes: 30);

    var now = DateTime.now().add(weatherAheadTime);
    var weatherDataMap = weatherData.toWeatherDataMap();

    WeatherData? currentWeatherData = weatherDataMap[todayIndex]?.firstWhere(
          (data) => data.time.hour == now.hour
    );

    return WeatherInfo(
      weatherDataPerDay: weatherDataMap,
      currentWeatherData: currentWeatherData,
    );
  }
}

WeatherType getWeatherType(int code) {
  switch(code) {
    case 0:
      return WeatherType.clearSky;
    case 1:
      return WeatherType.mainlyClear;
    case 2:
      return WeatherType.partlyCloudy;
    case 3:
      return WeatherType.overcast;
    case 45:
      return WeatherType.foggy;
    case 48:
      return WeatherType.depositingRimeFog;
    case 51:
      return WeatherType.lightDrizzle;
    case 53:
      return WeatherType.moderateDrizzle;
    case 55:
      return WeatherType.denseDrizzle;
    case 56:
      return WeatherType.lightFreezingDrizzle;
    case 57:
      return WeatherType.denseFreezingDrizzle;
    case 61:
      return WeatherType.slightRain;
    case 63:
      return WeatherType.moderateRain;
    case 65:
      return WeatherType.heavyRain;
    case 66:
      return WeatherType.lightFreezingDrizzle;
    case 67:
      return WeatherType.heavyFreezingRain;
    case 71:
      return WeatherType.slightSnowFall;
    case 73:
      return WeatherType.moderateSnowFall;
    case 75:
      return WeatherType.heavySnowFall;
    case 77:
      return WeatherType.snowGrains;
    case 80:
      return WeatherType.slightRainShowers;
    case 81:
      return WeatherType.moderateRainShowers;
    case 82:
      return WeatherType.violentRainShowers;
    case 85:
      return WeatherType.slightSnowShowers;
    case 86:
      return WeatherType.heavySnowShowers;
    case 95:
      return WeatherType.moderateThunderstorm;
    case 96:
      return WeatherType.slightHailThunderstorm;
    case 99:
      return WeatherType.heavyHailThunderstorm;
    default:
      return throw Exception("Error on get Weather Type from code: $code");
  }
}