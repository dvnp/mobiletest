//
//  OfferInfo.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 18/08/22.
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
