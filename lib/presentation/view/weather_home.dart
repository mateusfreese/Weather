import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/data/remote/weather_api_mock.dart';
import 'package:weather/data/weather_repository_impl.dart';
import 'package:weather/domain/repository/weather_repository.dart';

import '../../domain/model/weather_info.dart';

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
    return FutureBuilder(
        future: weatherInfo,
        builder: (context, snapshot) {
          return Center(
              child: snapshot.hasData
                  ? const Text('Success on getting weather info')
                  : const CircularProgressIndicator());
        });
  }
}
