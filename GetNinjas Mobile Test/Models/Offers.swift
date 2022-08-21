//
//  OffersModel.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 16/08/22.
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

extension Offers {
    
    // MARK: - Gets offers list

    static func load(_ url: String) async -> Offers? {
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
