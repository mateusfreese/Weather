import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(latitude: Double, longitude: Double)
    func didFailWithError(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            delegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error: error)
    }
}
