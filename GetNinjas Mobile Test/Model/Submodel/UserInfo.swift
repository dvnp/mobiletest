//
//  UserInfo.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

// MARK: - UserInfo
struct UserInfo: Codable {
    let name: String
    let email: String
    let embedded: UserEmbedded

    enum CodingKeys: String, CodingKey {
        case name
        case email
        case embedded = "_embedded"
    }
}
