import CoreLocation
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var locationChannel: LocationChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        locationChannel = LocationChannel(controller: controller)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
