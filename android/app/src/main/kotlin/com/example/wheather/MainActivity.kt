package com.example.wheather

import com.example.wheather.channels.GeolocationChannel
import com.example.wheather.service.LocationTracker
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationServices
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine


class MainActivity : FlutterActivity() {
    private lateinit var locationTracker: LocationTracker
    private lateinit var locationClient: FusedLocationProviderClient

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        locationClient = LocationServices.getFusedLocationProviderClient(applicationContext)
        locationTracker = LocationTracker(locationClient)

        GeolocationChannel(flutterEngine, locationTracker).register()
    }
}
