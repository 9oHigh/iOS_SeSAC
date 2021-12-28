// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beer = try? newJSONDecoder().decode(Beer.self, from: jsonData)

import Foundation

// MARK: - Beer
struct Beer: Codable {
    var foodPairing: [String]
    var name: String
    var tagline: String
    var beerDescription: String
    var imageURL: String
    var id: Int

    enum CodingKeys: String, CodingKey {
        case foodPairing = "food_pairing"
        case name
        case tagline
        case beerDescription = "description"
        case imageURL = "image_url"
        case id
    }
}
