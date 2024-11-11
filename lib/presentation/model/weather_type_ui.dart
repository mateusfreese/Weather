import 'package:flutter/material.dart';

import '../../domain/model/weather_type.dart';

class WeatherTypeUI {
  final IconData icon;
  final String description;

  WeatherTypeUI({required this.icon, required this.description});

  factory WeatherTypeUI.fromWeatherType(WeatherType weatherType) {
    switch (weatherType) {
      case WeatherType.clearSky:
        return WeatherTypeUI(icon: Icons.wb_sunny, description: "Clear sky");
      case WeatherType.mainlyClear:
        return WeatherTypeUI(icon: Icons.wb_cloudy, description: "Mainly clear");
      case WeatherType.partlyCloudy:
        return WeatherTypeUI(icon: Icons.cloud, description: "Partly cloudy");
      case WeatherType.overcast:
        return WeatherTypeUI(icon: Icons.cloud_queue, description: "Overcast");
      case WeatherType.foggy:
      case WeatherType.depositingRimeFog:
        return WeatherTypeUI(icon: Icons.foggy, description: "Foggy");
      case WeatherType.lightDrizzle:
      case WeatherType.moderateDrizzle:
      case WeatherType.denseDrizzle:
        return WeatherTypeUI(icon: Icons.grain, description: "Drizzle");
      case WeatherType.lightFreezingDrizzle:
      case WeatherType.denseFreezingDrizzle:
        return WeatherTypeUI(icon: Icons.ac_unit, description: "Freezing drizzle");
      case WeatherType.slightRain:
      case WeatherType.moderateRain:
      case WeatherType.heavyRain:
        return WeatherTypeUI(icon: Icons.umbrella, description: "Rain");
      case WeatherType.heavyFreezingRain:
        return WeatherTypeUI(icon: Icons.ac_unit, description: "Heavy Freezing rain");
      case WeatherType.slightSnowFall:
        return WeatherTypeUI(icon: Icons.ac_unit, description: "Slight Snowfall");
      case WeatherType.moderateSnowFall:
      case WeatherType.heavySnowFall:
        return WeatherTypeUI(icon: Icons.snowing, description: "Snowfall");
      case WeatherType.snowGrains:
        return WeatherTypeUI(icon: Icons.grain, description: "Snow Grains");
      case WeatherType.slightRainShowers:
      case WeatherType.moderateRainShowers:
      case WeatherType.violentRainShowers:
        return WeatherTypeUI(icon: Icons.shower, description: "Rain Showers");
      case WeatherType.slightSnowShowers:
      case WeatherType.heavySnowShowers:
        return WeatherTypeUI(icon: Icons.snowing, description: "Snow Showers");
      case WeatherType.moderateThunderstorm:
        return WeatherTypeUI(icon: Icons.bolt, description: "Thunderstorm");
      case WeatherType.slightHailThunderstorm:
      case WeatherType.heavyHailThunderstorm:
        return WeatherTypeUI(icon: Icons.hail, description: "Thunderstorm with hail");
      default:
        return WeatherTypeUI(icon: Icons.error, description: "Unknown");
    }
  }
}