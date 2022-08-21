//
//  TitleDetailsViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

class TitleDetailsViewModelItem: DetailsViewModelItem {
    let itemType: DetailsViewModelItemType
    let rowCount: Int
    let detailType: DetailsViewModelType

    let title: String
    let name: String
    let city: String
    let neighborhood: String
    let uf: String
    let distance: Int

    init(info: Codable?, type: DetailsViewModelType) {
        var title: String {
            var title = ""
            if let offer = info as? OfferInfo {
                title = offer.title
            } else if let lead = info as? LeadInfo {
                title = lead.title
            }
            return title
        }
        self.title = title

        var name: String {
            var name = ""
            if let offer = info as? OfferInfo {
                name = offer.embedded.user.name
            } else if let lead = info as? LeadInfo {
                name = lead.embedded.user.name
            }
            return name
        }
        self.name = name

        var city: String {
            var city = ""
            if let offer = info as? OfferInfo {
                city = offer.embedded.address.city
            } else if let lead = info as? LeadInfo {
                city = lead.embedded.address.city
            }
            return city
        }
        self.city = city
        
        var neighborhood: String {
            var neighborhood = ""
            if let offer = info as? OfferInfo {
                neighborhood = offer.embedded.address.neighborhood
            } else if let lead = info as? LeadInfo {
                neighborhood = lead.embedded.address.neighborhood
            }
            return neighborhood
        }
        self.neighborhood = neighborhood
        
        var uf: String {
            var uf = ""
            if let offer = info as? OfferInfo {
                uf = offer.embedded.address.neighborhood
            } else if let lead = info as? LeadInfo {
                uf = lead.embedded.address.neighborhood
            }
            return uf
        }
        self.uf = uf

        var distance: Int {
            var distance = 0
            if let offer = info as? OfferInfo {
                distance = offer.distance
            } else if let lead = info as? LeadInfo {
                distance = lead.distance
            }
            return distance
        }
        self.distance = distance

        self.itemType = .title
        self.rowCount = 1
        self.detailType = type
    }
}

