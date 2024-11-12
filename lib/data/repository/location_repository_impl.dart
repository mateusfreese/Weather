import 'package:weather/data/device/location_service.dart';
import 'package:weather/domain/model/location.dart';
import 'package:weather/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationService locationService;

  LocationRepositoryImpl({required this.locationService});

  @override
  Future<Location> getLocation() {
    return locationService.getLocation();
  }
}
