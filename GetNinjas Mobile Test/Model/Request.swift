//
//  Request.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

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
