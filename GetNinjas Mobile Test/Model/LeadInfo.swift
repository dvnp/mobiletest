//
//  LeadInfo.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 18/08/22.
//

import Foundation

// MARK: - LeadInfo
struct LeadInfo: Codable {
    let distance: Int
    let leadPrice: Int
    let title: String
    let embedded: InfoEmbedded

    enum CodingKeys: String, CodingKey {
        case distance
        case leadPrice = "lead_price"
        case title
        case embedded = "_embedded"
    }
}


extension LeadInfo {
    
    // MARK: - Gets lead info

    static func load(_ url: String) async -> LeadInfo? {
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

            let leadInfo = try? JSONDecoder().decode(LeadInfo.self, from: data)
            return leadInfo
        } catch {
            print(error)
        }
        
        return nil
    }
}
