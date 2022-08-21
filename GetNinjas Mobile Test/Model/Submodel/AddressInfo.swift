//
//  AddressInfo.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

// MARK: - AddressInfo
struct AddressInfo: Codable {
    let city: String
    let neighborhood: String
    let uf: String
    let geolocation: Geolocation
}
