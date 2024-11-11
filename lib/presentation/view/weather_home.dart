import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/data/remote/weather_api_mock.dart';
import 'package:weather/data/weather_repository_impl.dart';
import 'package:weather/domain/repository/weather_repository.dart';

import '../../domain/model/weather_info.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_forecast.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHome();
}

class _WeatherHome extends State<WeatherHome> {
  late final WeatherApi weatherApi;
  late final WeatherRepository weatherRepository;
  late Future<WeatherInfo> weatherInfo;

  @override
  void initState() {
    super.initState();
    setupDependencies();
    getWeatherData();
  }

  void setupDependencies() {
    weatherApi = WeatherApiMock();
    weatherRepository = WeatherRepositoryImpl(weatherApi: weatherApi);
  }

  void getWeatherData() {
    developer.log('Get Weather Info');

    weatherInfo = weatherRepository.getWeatherInfo();

    weatherInfo.then((onValue) {
      developer.log('GetWeatherInfo then: ${onValue.toString()}');
    }).catchError((onError) {
      developer.log('Error on getWeatherData', error: onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Weather",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
            future: weatherInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data?.currentWeatherData != null) {
                return Container(
                  color: Colors.blue[900],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WeatherCard(
                          weatherData: snapshot.data!.currentWeatherData!,
                          backgroundColor: Colors.blue[700]!),
                      const SizedBox(height: 16),
                      WeatherForecast(
                          weatherDataList:
                              snapshot.data!.weatherDataPerDay[0] ?? []),
                    ],
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
