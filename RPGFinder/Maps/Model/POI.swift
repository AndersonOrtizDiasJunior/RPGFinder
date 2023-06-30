
import Foundation

struct POI: Codable {
    let id: Int
    let title: String
    let age: Int
    let description: String
    let system: String
    let lat: Double
    let long: Double
    let address: String
    let isAvailable: Bool
}
