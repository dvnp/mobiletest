//
//  OffersModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let offers = try? newJSONDecoder().decode(Offers.self, from: jsonData)

// MARK: - Offers
struct Offers: Codable {
    let offers: [Offer]
    let links: Links

    enum CodingKeys: String, CodingKey {
        case offers
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - Offer
struct Offer: Codable {
    let state: String
    let embedded: OfferEmbedded
    let links: Links

    enum CodingKeys: String, CodingKey {
        case state
        case embedded = "_embedded"
        case links = "_links"
    }
}

// MARK: - OfferEmbedded
struct OfferEmbedded: Codable {
    let request: Request
}

// MARK: - Request
struct Request: Codable {
    let createdAt: String
    let title: String
    let embedded: RequestEmbedded

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title
        case embedded = "_embedded"
    }
}

// MARK: - RequestEmbedded
struct RequestEmbedded: Codable {
    let user: User
    let address: Address
}

//// MARK: - Address
//struct Address: Codable {
//    let city, neighborhood, uf: String
//}

//// MARK: - User
//struct User: Codable {
//    let name: String
//}

extension Offers {
    
    // MARK: - Gets Offers list

    static func loadOffers(urlString: String) async -> Offers? {
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.scheme = "https"
        guard let url = components.url else {
            return nil
        }

        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(from: url)

            let offers = try? JSONDecoder().decode(Offers.self, from: data)
            return offers
        } catch {
            print(error)
        }
        
        return nil
    }
}
