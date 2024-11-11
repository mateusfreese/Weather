import 'package:flutter/material.dart';

import '../../domain/model/weather_data.dart';
import 'hourly_weather_display.dart';

class WeatherForecast extends StatelessWidget {
  final List<WeatherData> weatherDataList;

  const WeatherForecast({super.key, required this.weatherDataList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: weatherDataList.map((weather) {
                return HourlyWeatherDisplay(weatherData: weather);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
