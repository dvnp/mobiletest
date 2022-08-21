//
//  Lead.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

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
