import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/data/device/location_service.dart';
import 'package:weather/data/remote/weather_api.dart';
import 'package:weather/data/remote/weather_api_http.dart';
import 'package:weather/data/repository/location_repository_impl.dart';
import 'package:weather/data/repository/weather_repository_impl.dart';
import 'package:weather/domain/model/location.dart';
import 'package:weather/domain/model/weather_info.dart';
import 'package:weather/domain/repository/location_repository.dart';
import 'package:weather/domain/repository/weather_repository.dart';
import 'package:weather/presentation/widgets/weather_card.dart';
import 'package:weather/presentation/widgets/weather_forecast.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHome();
}

class _WeatherHome extends State<WeatherHome> {
  late final WeatherApi weatherApi;
  late final LocationService locationService;
  late final WeatherRepository weatherRepository;
  late final LocationRepository locationRepository;
  Future<WeatherInfo?> weatherInfo = Future.value();

  @override
  void initState() {
    super.initState();
    setupDependencies();
    getScreenData();
  }

  void setupDependencies() {
    weatherApi = WeatherApiHttp();
    weatherRepository = WeatherRepositoryImpl(weatherApi: weatherApi);

    locationService = LocationService();
    locationRepository =
        LocationRepositoryImpl(locationService: locationService);
  }

  Future<void> checkLocationPermission() async {
    switch(await Permission.location.request()) {
      case PermissionStatus.granted:
        return;
      default:
        throw Exception("No Location Permission");
    }
  }

  Future<void> getWeatherData() async {
    Location location = await locationRepository.getLocation();

    WeatherInfo newWeatherInfo =
        await weatherRepository.getWeatherInfo(location);

    setState(() {
      weatherInfo = Future<WeatherInfo>.value(newWeatherInfo);
    });
  }

  void getScreenData() async {
    try {
      await checkLocationPermission();
      await getWeatherData();
    } catch(e) {
      setState(() {
        weatherInfo = Future<WeatherInfo>.error(e);
      });
    }
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
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
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
                    ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
