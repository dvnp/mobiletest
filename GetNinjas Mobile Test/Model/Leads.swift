//
//  Leads.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leads = try? newJSONDecoder().decode(Leads.self, from: jsonData)

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

//// MARK: - Links
//struct Links: Codable {
//    let linksSelf: SelfClass
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//    }
//}

//// MARK: - SelfClass
//struct SelfClass: Codable {
//    let href: String
//}

extension Leads {
    
    // MARK: - Gets Leads list

    static func loadLeads(urlString: String) async -> Leads? {
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

            let leads = try? JSONDecoder().decode(Leads.self, from: data)
            return leads
        } catch {
            print(error)
        }
        
        return nil
    }
}
