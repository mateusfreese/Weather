import 'package:flutter/material.dart';
import 'package:weather/presentation/model/weather_type_ui.dart';

import '../../domain/model/weather_data.dart';
import '../utils/datetime_extensions.dart';

class HourlyWeatherDisplay extends StatelessWidget {
  final WeatherData weatherData;

  const HourlyWeatherDisplay({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final formattedTime = formatTime(weatherData.time);
    final weatherTypeUi =
        WeatherTypeUI.fromWeatherType(weatherData.weatherType);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            formattedTime,
            style: const TextStyle(color: Colors.grey),
          ),
          Icon(
            weatherTypeUi.icon, // Assuming asset path for icon
            size: 40,
            color: Colors.white,
          ),
          Text(
            "${weatherData.temperatureCelsius}°C",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
