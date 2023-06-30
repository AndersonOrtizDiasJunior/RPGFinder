//
//  RouteResponse.swift
//  Navigator
//
//  Created by Anderson Ortiz Dias Junior on 14/06/23.
//

import Foundation

struct RouteResponse: Codable {
    let geocodedWaypoints: [GeocodedWaypoint]
    let routes: [Route]
    let status: String

    private enum CodingKeys: String, CodingKey {
        case geocodedWaypoints = "geocoded_waypoints"
        case routes, status
    }
}

struct GeocodedWaypoint: Codable {
    let geocoderStatus: String
    let placeID: String
    let types: [String]

    private enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
    }
}

struct Route: Codable {
    let bounds: Bounds
    let copyrights: String
    let legs: [Leg]
    let overviewPolyline: Polyline
    let summary: String
    let warnings: [String]
    let waypointOrder: [Int]

    private enum CodingKeys: String, CodingKey {
        case bounds, copyrights, legs
        case overviewPolyline = "overview_polyline"
        case summary, warnings, waypointOrder = "waypoint_order"
    }
}

struct Bounds: Codable {
    let northeast: Location
    let southwest: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Leg: Codable {
    let distance: Distance
    let duration: Duration
    let endAddress: String
    let endLocation: Location
    let startAddress: String
    let startLocation: Location
    let steps: [Step]
    let trafficSpeedEntry: [String]
    let viaWaypoint: [String]

    private enum CodingKeys: String, CodingKey {
        case distance, duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
        case steps
        case trafficSpeedEntry = "traffic_speed_entry"
        case viaWaypoint = "via_waypoint"
    }
}

struct Distance: Codable {
    let text: String
    let value: Int
}

struct Duration: Codable {
    let text: String
    let value: Int
}

struct Step: Codable {
    let distance: Distance
    let duration: Duration
    let endLocation: Location
    let htmlInstructions: String
    let polyline: Polyline
    let startLocation: Location
    let travelMode: String

    private enum CodingKeys: String, CodingKey {
        case distance, duration
        case endLocation = "end_location"
        case htmlInstructions = "html_instructions"
        case polyline
        case startLocation = "start_location"
        case travelMode = "travel_mode"
    }
}

struct Polyline: Codable {
    let points: String
}
