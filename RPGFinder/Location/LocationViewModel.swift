//
//  LocationViewModel.swift
//  Navigator
//
//  Created by Anderson Ortiz Dias Junior on 14/06/23.
//

import Foundation
import CoreLocation

final class LocationViewModel: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?

    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        checkStatusAndTryToStartLocation()
    }

    private func checkStatusAndTryToStartLocation() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        default:
            locationManager.delegate = nil
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        self.location = location
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkStatusAndTryToStartLocation()
    }
}
