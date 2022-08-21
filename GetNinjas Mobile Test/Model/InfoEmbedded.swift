//
//  InfoEmbedded.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

// MARK: - InfoEmbedded
struct InfoEmbedded: Codable {
    let info: [Info]
    let user: UserInfo
    let address: AddressInfo
}
