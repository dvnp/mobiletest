//
//  Leads.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
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

// MARK: - Lead
struct Lead: Codable {
    let createdAt: String
    let embedded: Embedded
    let links: Links

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case embedded = "_embedded"
        case links = "_links"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let address: Address
    let user: User
    let request: LeadsRequest
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let street: String?
    let neighborhood: String
    let uf: String
}

// MARK: - LeadsRequest
struct LeadsRequest: Codable {
    let title: String
}

// MARK: - User
struct User: Codable {
    let name: String
    let email: String?
}

extension Leads {
    
    // MARK: - Gets leads list

    static func loadLeads(url: String) async -> Leads? {
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
