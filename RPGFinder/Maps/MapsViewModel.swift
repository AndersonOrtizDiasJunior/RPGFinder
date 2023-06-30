//
//  MapsViewModel.swift
//  Navigator
//
//  Created by Anderson Ortiz Dias Junior on 01/06/23.
//

import Foundation
import SwiftUI
import CoreLocation
import GoogleMaps

final class MapsViewModel: NSObject, ObservableObject, GMSMapViewDelegate {
    private let mapsService: MapsService
    private let locationViewModel: LocationViewModel

    init (mapsService: MapsService = MapsService(),
          locationViewModel: LocationViewModel = LocationViewModel()) {
        self.mapsService = mapsService
        self.locationViewModel = locationViewModel
    }

    func updateView(mapView: GMSMapView) {
        fetchPOIs { response in
            switch response {
            case .success(let pois):
                DispatchQueue.main.async {
                    self.addPOIs(places: pois, mapView: mapView)
                    guard let location = self.locationViewModel.location else { return }
                    self.updateMapViewCamera(mapView: mapView, latitude: location.latitude, longitude: location.longitude)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Service Calls
private extension MapsViewModel {
    func fetchPOIs(completion: @escaping (POIsResponse) -> Void) {
        self.mapsService.fetchPOIs { response in
            completion(response)
        }
    }

    func fetchRoutesToPOI(from location: CLLocationCoordinate2D, to poi: POI, completion: @escaping (_ response: RoutesAPIResponse) -> Void) {
        self.mapsService.fetchRoutesToPOI(from: location, to: poi) { response in
            completion(response)
        }
    }
}

// MARK: - Location
extension MapsViewModel {
    func getLocation() {
        self.locationViewModel.getLocation()
    }
}

// MARK: - Map
extension MapsViewModel {
    func drawRoute(for poi: POI, mapView:GMSMapView) {
        guard let location = locationViewModel.location else { return }
        fetchRoutesToPOI(from: location, to: poi) { response in
            switch response {
            case .success(let routes):
                DispatchQueue.main.async {
                    for route in routes {
                        let overview_polyline = route.overviewPolyline
                        let points = overview_polyline.points
                        let path = GMSPath.init(fromEncodedPath: points )
                        let polyline = GMSPolyline.init(path: path)
                        polyline.strokeColor = .systemBlue
                        polyline.strokeWidth = 5
                        polyline.map = mapView
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func addPOIs(places: [POI], mapView: GMSMapView) {
        places.forEach { place in
            let marker = GMSMarker()
            marker.position = .init(latitude: place.lat, longitude: place.long)
            marker.title = place.title
            marker.snippet = place.address
            marker.map = mapView
        }
    }

    private func updateMapViewCamera(mapView: GMSMapView, latitude: Double, longitude: Double, zoom: Float = 18) {
        mapView.camera = .init(latitude: latitude, longitude: longitude, zoom: zoom)
    }
}
