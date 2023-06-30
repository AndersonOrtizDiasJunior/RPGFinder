//
//  RPGFinderApp.swift
//  RPGFinder
//
//  Created by Anderson Ortiz Dias Junior on 26/06/23.
//

import SwiftUI
import GoogleMaps

@main
struct RPGFinderApp: App {
    init() {
        GMSServices.provideAPIKey("AIzaSyDnh0qG8oGSjWfJeVc7cpWq6LH9-LAvN-A")
    }
    var body: some Scene {
        WindowGroup {
            MapsView()
        }
    }
}
