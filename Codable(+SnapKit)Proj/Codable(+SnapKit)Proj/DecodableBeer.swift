// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let beer = try? newJSONDecoder().decode(Beer.self, from: jsonData)

import Foundation

// MARK: - Beer
struct Beer: Codable {
    let ibu: Int?
    let firstBrewed: String?
    let foodPairing: [String]?
    let ebc: Int?
    let boilVolume: BoilVolume?
    let name: String?
    let abv: Int?
    let contributedBy, tagline, brewersTips, beerDescription: String?
    let ingredients: Ingredients?
    let volume: BoilVolume?
    let imageURL: String?
    let ph: Double?
    let id: Int?
    let srm: Double?
    let targetFg: Int?
    let method: Method?
    let attenuationLevel: Double?
    let targetOg: Int?

    enum CodingKeys: String, CodingKey {
        case ibu
        case firstBrewed = "first_brewed"
        case foodPairing = "food_pairing"
        case ebc
        case boilVolume = "boil_volume"
        case name, abv
        case contributedBy = "contributed_by"
        case tagline
        case brewersTips = "brewers_tips"
        case beerDescription = "description"
        case ingredients, volume
        case imageURL = "image_url"
        case ph, id, srm
        case targetFg = "target_fg"
        case method
        case attenuationLevel = "attenuation_level"
        case targetOg = "target_og"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double?
    let unit: Unit?
}

enum Unit: String, Codable {
    case celsius = "celsius"
    case grams = "grams"
    case kilograms = "kilograms"
    case litres = "litres"
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let hops: [Hop]?
    let malt: [Malt]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    let name: String?
    let amount: BoilVolume?
    let attribute: Attribute?
    let add: String?
}

enum Attribute: String, Codable {
    case aroma = "aroma"
    case bitter = "bitter"
    case flavour = "flavour"
}

// MARK: - Malt
struct Malt: Codable {
    let amount: BoilVolume?
    let name: String?
}

// MARK: - Method
struct Method: Codable {
    let fermentation: Fermentation?
    let mashTemp: [MashTemp]?
    let twist: JSONNull?

    enum CodingKeys: String, CodingKey {
        case fermentation
        case mashTemp = "mash_temp"
        case twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume?
    let duration: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
