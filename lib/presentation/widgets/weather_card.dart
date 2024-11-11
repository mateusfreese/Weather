import 'package:flutter/material.dart';
import 'package:weather/presentation/model/weather_type_ui.dart';
import 'package:weather/presentation/widgets/weather_card_display.dart';

import '../../domain/model/weather_data.dart';
import '../utils/datetime_extensions.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const WeatherCard({super.key,
    required this.weatherData,
    required this.backgroundColor,
    this.padding = const EdgeInsets.all(16.0)
  });

  @override
  Widget build(BuildContext context) {
    WeatherTypeUI weatherTypeUi = WeatherTypeUI.fromWeatherType(weatherData.weatherType);

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: padding,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Today ${formatTime(weatherData.time)}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Icon(
              weatherTypeUi.icon,
              size: 200,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              "${weatherData.temperatureCelsius}°C",
              style: const TextStyle(fontSize: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              weatherTypeUi.description,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherDataDisplay(
                  value: weatherData.pressure.round(),
                  unit: "hpa",
                  icon: Icons.arrow_upward,
                  iconColor: Colors.white,
                ),
                WeatherDataDisplay(
                  value: weatherData.humidity.round(),
                  unit: "%",
                  icon: Icons.water_drop,
                  iconColor: Colors.white,
                ),
                WeatherDataDisplay(
                  value: weatherData.windSpeed.round(),
                  unit: "km/h",
                  icon: Icons.air,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
