//
//  Entrypoint.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import Foundation

// MARK: - EntryPoint
struct EntryPoint: Codable {
    let links: LinksEntryPoint

    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

// MARK: - Links
struct LinksEntryPoint: Codable {
    let leads, offers: LeadsEntryPoint
}

// MARK: - LeadsEntryPoint
struct LeadsEntryPoint: Codable {
    let href: String
}

extension EntryPoint {
    
    // MARK: - Entrypoint URI
    static let urlString = "https://testemobile.getninjas.com.br"

    // MARK: - Gets the entrypoint

    static func loadEntryPoint() async -> EntryPoint? {
        let url: URL = URL(string: urlString)!

        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(from: url)

            let entryPoint = try? JSONDecoder().decode(EntryPoint.self, from: data)
            return entryPoint
        } catch {
            print(error)
        }
        
        return nil
    }
}
