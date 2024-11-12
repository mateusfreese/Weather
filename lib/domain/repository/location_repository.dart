import 'package:weather/domain/model/location.dart';

abstract class LocationRepository {
  Future<Location> getLocation();
}