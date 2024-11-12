import 'package:weather/domain/model/location.dart';

extension LocationMappers on Map<String, double> {
  Location toLocation() {
    return Location(
      latitude: this['latitude']!,
      longitude: this['longitude']!
    );
  }
}