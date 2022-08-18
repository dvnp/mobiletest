//
//  OffersModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import Foundation

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

extension Offers {
    
    // MARK: - Gets offers list

    static func loadOffers(url: String) async -> Offers? {
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

            let offers = try? JSONDecoder().decode(self, from: data)
            return offers
        } catch {
            print(error)
        }
        
        return nil
    }
}
