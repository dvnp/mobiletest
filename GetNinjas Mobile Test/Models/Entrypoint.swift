//
//  Entrypoint.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 16/08/22.
//

import Foundation

// MARK: - EntryPoint
struct Entrypoint: Codable {
    let links: LinksEntrypoint

    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

extension Entrypoint {
    
    // MARK: - The entrypoint URI
    static let URL = "http://testemobile.getninjas.com.br"

    // MARK: - Gets the entrypoint

    static func load() async -> Entrypoint? {
        guard var components = URLComponents(string: URL) else {
            return nil
        }
        components.scheme = "https"
        guard let url = components.url else {
            return nil
        }

        let session = URLSession.shared

        do {
            let (data, _) = try await session.data(from: url)

            let entrypoint = try? JSONDecoder().decode(self, from: data)
            return entrypoint
        } catch {
            print(error)
        }
        
        return nil
    }
}
