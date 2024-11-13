import 'package:flutter/services.dart';
import 'package:weather/data/mappers/location_mappers.dart';
import 'package:weather/domain/model/location.dart';

var canoasLocation = Location(latitude: -29.923929, longitude: -51.190140);

class LocationService {
  static const channel = MethodChannel('com.example.wheather/location_channel');

  Future<Location> getLocation() {
    // TODO("Implement services in android and iOS")
    return channel
        .invokeMapMethod<String, double>("getLocation")
        .then((onValue) => onValue!.toLocation());
  }
}
