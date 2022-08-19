//
//  OfferInfo.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 18/08/22.
//

import Foundation

// MARK: - OfferInfo
struct OfferInfo: Codable {
    let distance: Int
    let leadPrice: Int
    let title: String
    let embedded: InfoEmbedded
    let links: OfferLinks

    enum CodingKeys: String, CodingKey {
        case distance
        case leadPrice = "lead_price"
        case title
        case embedded = "_embedded"
        case links = "_links"
    }
}

// MARK: - InfoEmbedded
struct InfoEmbedded: Codable {
    let info: [Info]
    let user: UserInfo
    let address: AddressInfo
}

// MARK: - Address
struct AddressInfo: Codable {
    let city: String
    let neighborhood: String
    let uf: String
    let geolocation: Geolocation
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let latitude: Double
    let longitude: Double
}

// MARK: - Info
struct Info: Codable {
    let label: String
    let value: Value
}

enum Value: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - User
struct UserInfo: Codable {
    let name: String
    let email: String
    let embedded: UserEmbedded

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case embedded = "_embedded"
    }
}

// MARK: - UserEmbedded
struct UserEmbedded: Codable {
    let phones: [Phone]
}

// MARK: - Phone
struct Phone: Codable {
    let number: String
}

// MARK: - OfferLinks
struct OfferLinks: Codable {
    let accept: Accept
    let reject: Accept
}

// MARK: - Accept
struct Accept: Codable {
    let href: String
}

extension OfferInfo {
    
    // MARK: - Gets offer info

    static func load(_ url: String) async -> OfferInfo? {
        guard var components = URLComponents(string: url) else {
            return nil
        }
        components.scheme = "https"
        guard let url = components.url else {
            return nil
        }

        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(from: url)

            let offerInfo = try? JSONDecoder().decode(self, from: data)
            return offerInfo
        } catch {
            print(error)
        }
        
        return nil
    }
}
