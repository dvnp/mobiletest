//
//  Offer.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

// MARK: - Offer
struct Offer: Codable {
    let state: String
    let embedded: OfferEmbedded
    let links: Links

    enum CodingKeys: String, CodingKey {
        case state
        case embedded = "_embedded"
        case links = "_links"
    }
}
