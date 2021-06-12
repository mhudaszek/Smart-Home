//
//  LocationService.swift
//  Smart Home
//
//  Created by Mirosław Hudaszek on 19/04/2021.
//

import Foundation
import CoreLocation
import RxCocoa
//import RxSwift

class LocationService: NSObject {
    static let shared = LocationService()
    private var locationManager = CLLocationManager()

    var currentLocation: CLLocation?
    var didUpdateLocations: BehaviorRelay<[CLLocation]> = BehaviorRelay(value: [])

    func start() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
}

extension LocationService: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        currentLocation = location
//        didUpdateLocations.accept(locations)
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
