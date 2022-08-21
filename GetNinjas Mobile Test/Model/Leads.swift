//
//  Leads.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 16/08/22.
//

import Foundation

// MARK: - Leads
struct Leads: Codable {
    let leads: [Lead]
    let links: Links

    enum CodingKeys: String, CodingKey {
        case leads
        case links = "_links"
    }
}

extension Leads {
    
    // MARK: - Gets leads list

    static func load(_ url: String) async -> Leads? {
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

            let leads = try? JSONDecoder().decode(self, from: data)
            return leads
        } catch {
            print(error)
        }
        
        return nil
    }
}
