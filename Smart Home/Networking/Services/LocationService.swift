//
//  LocationService.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 19/04/2021.
//

import Foundation
import CoreLocation
import RxCocoa

class LocationService: NSObject {
    static let shared = LocationService()
    private var locationManager = CLLocationManager()

    var currentLocation: CLLocation?
//    var didUpdateLocations: BehaviorRelay<[CLLocation]> = BehaviorRelay(value: [])

    func start() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        currentLocation = manager.location
//        didChangeAuthorizationStatus.accept(status)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
//        Log.error("\(error)")
    }
}

/*
 <+50.01306152,+19.88056507> +/- 27.08m (speed 0.15 mps / course 79.02) @ 12/06/2021, 15:46:09 Central European Summer Time

 locations = 50.01312099059193 19.880571331092085
 locations = 50.01311819717853 19.88071473166365
 */
