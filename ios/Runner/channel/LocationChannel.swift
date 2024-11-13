import Foundation
import Flutter

class LocationChannel: LocationServiceDelegate {
    private final let locationChannel = "com.example.wheather/location_channel"
    private var locationService: LocationService
    private var result: FlutterResult?
    
    init(controller: FlutterViewController) {
        locationService = LocationService()
        locationService.delegate = self
        
        let geoChannel = FlutterMethodChannel(name: locationChannel, binaryMessenger: controller.binaryMessenger)
        
        geoChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard call.method == "getLocation" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.result = result
            self?.locationService.requestLocationPermission()
            self?.locationService.startUpdatingLocation()
        }
    }

    func didUpdateLocation(latitude: Double, longitude: Double) {
        let locationData: [String: Double] = ["latitude": latitude, "longitude": longitude]
        result?(locationData)
        locationService.stopUpdatingLocation()
    }
    
    func didFailWithError(error: Error) {
        result?(FlutterError(code: "LOCATION_ERROR", message: error.localizedDescription, details: nil))
    }
}
