//
//  MapsService.swift
//  Navigator
//
//  Created by Murilo Gomes Aureliano on 25/05/23.
//

import Foundation
import CoreLocation

typealias POIsResponse = Result<[POI], Error>
typealias RoutesAPIResponse = Result<[Route], Error>
final class MapsService {

    func fetchPOIs(completion: @escaping (_ response: POIsResponse) -> Void) {
        guard let url = URL(string: "https://my-json-server.typicode.com/AndersonOrtizDiasJunior/RPGFinderJson/POIS") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.app", code: 1, userInfo: nil)))
                return
            }
            do {
                let pois = try JSONDecoder().decode([POI].self, from: data)
                completion(.success(pois))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchRoutesToPOI(from location: CLLocationCoordinate2D, to poi: POI, completion: @escaping (_ response: RoutesAPIResponse) -> Void) {
        let sourceLocation = "\(location.latitude),\(location.longitude)"
        let destinationLocation = "\(poi.lat),\(poi.long)"
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&mode=walking&key=AIzaSyDgZPpZ_9GrBkiYagiOEV28Qmo3N6SYYD0") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.app", code: 1, userInfo: nil)))
                return
            }
            do {
                let routeResponse = try JSONDecoder().decode(RouteResponse.self, from: data)
                completion(.success(routeResponse.routes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
