package com.example.wheather.channels

import com.example.wheather.service.LocationTracker
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

const val GEOLOCATION_CHANNEL = "com.example.wheather/location_channel"

class GeolocationChannel(
    flutterEngine: FlutterEngine,
    private val locationManager: LocationTracker,
) : MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GEOLOCATION_CHANNEL) {

    fun register() {
        setMethodCallHandler(::handleOnMethodCall)
    }

    private fun handleOnMethodCall(call: MethodCall, result: Result) {
        MainScope().launch {
            when (call.method) {
                "getLocation" -> handleGetGeolocation(result)
            }
        }
    }

    private suspend fun handleGetGeolocation(result: Result) {
        try {
            val location = locationManager.getCurrentLocation()!!
            val locationResponse = hashMapOf(
                "latitude" to location.latitude,
                "longitude" to location.longitude,
            )

            result.success(locationResponse)
        } catch (e: SecurityException) {
            result.error("PermissionError", null, null)
        } catch (e: Exception) {
            result.error("Error on get geolocation", null, null)
        }
    }
}