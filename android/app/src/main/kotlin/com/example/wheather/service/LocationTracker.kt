package com.example.wheather.service

import android.location.Location
import com.google.android.gms.location.FusedLocationProviderClient
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

class LocationTracker(private val locationClient: FusedLocationProviderClient) {

    suspend fun getCurrentLocation(): Location? {
        return suspendCancellableCoroutine { cont ->
            try {
                locationClient.lastLocation.apply {
                    if(isComplete) {
                        if(isSuccessful) {
                            cont.resume(result)
                        } else {
                            cont.resume(null)
                        }
                        return@suspendCancellableCoroutine
                    }
                    addOnSuccessListener {
                        cont.resume(it)
                    }
                    addOnFailureListener {
                        cont.resume(null)
                    }
                    addOnCanceledListener {
                        cont.cancel()
                    }
                }
            } catch (e: SecurityException) {
                cont.cancel(e)
            }
        }
    }
}