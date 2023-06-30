//
//  GoogleMapView.swift
//  Navigator
//
//  Created by Anderson Ortiz Dias Junior on 14/06/23.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView : UIViewRepresentable {
    typealias UIViewType = GMSMapView
    @EnvironmentObject private var mapsViewModel: MapsViewModel

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -23.560278, longitude: -46.652386, zoom: 10)
        let mapID = GMSMapID(identifier: "825aa777af6f8e9b")
        let mapView = GMSMapView(frame: .zero, mapID: mapID, camera: camera)
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true

        let southWest = CLLocationCoordinate2D(latitude: -23.558910, longitude: -46.651769)
        let northEast = CLLocationCoordinate2D(latitude: -23.562063, longitude: -46.653535)
        let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        let icon = UIImage(named: "Mapa")

        let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = 50
        overlay.opacity = 0.3
        overlay.map = mapView

        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        context.coordinator.updateView(mapView: uiView)
    }

    func makeCoordinator() -> MapsViewModel {
        return mapsViewModel
    }
}
