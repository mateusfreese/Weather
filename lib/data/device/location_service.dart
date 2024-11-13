import 'package:flutter/services.dart';
import 'package:weather/data/mappers/location_mappers.dart';
import 'package:weather/domain/model/location.dart';

class LocationService {
  static const channel = MethodChannel('com.example.wheather/location_channel');

  Future<Location> getLocation() {
    return channel
        .invokeMapMethod<String, double>("getLocation")
        .then((onValue) => onValue!.toLocation());
  }
}
