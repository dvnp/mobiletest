//
//  Address.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let city: String
    let street: String?
    let neighborhood: String
    let uf: String
}
