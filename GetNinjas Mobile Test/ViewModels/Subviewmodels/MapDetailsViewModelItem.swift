//
//  MapDetailsViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

class MapDetailsViewModelItem: DetailsViewModelItemProperties {
    let itemType: DetailsViewModelItemType
    let rowCount: Int
    let detailType: DetailsViewModelType

    let latitude: Double
    let longitude: Double

    init(info: Codable?, type: DetailsViewModelType) {
        var latitude: Double {
            var latitude = 0.0
            if let offer = info as? OfferInfo {
                latitude = offer.embedded.address.geolocation.latitude
            } else if let lead = info as? LeadInfo {
                latitude = lead.embedded.address.geolocation.latitude
            }
            return latitude
        }
        self.latitude = latitude
        
        var longitude: Double  {
            var longitude = 0.0
            if let offer = info as? OfferInfo {
                longitude = offer.embedded.address.geolocation.longitude
            } else if let lead = info as? LeadInfo {
                longitude = lead.embedded.address.geolocation.longitude
            }
            return longitude
        }
        self.longitude = longitude

        self.itemType = .map
        self.rowCount = 1
        self.detailType = type
    }
}
