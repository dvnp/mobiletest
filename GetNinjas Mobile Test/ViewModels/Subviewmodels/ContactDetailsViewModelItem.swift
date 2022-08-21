//
//  ContactDetailsViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

class ContactDetailsViewModelItem: DetailsViewModelItemProperties {
    let itemType: DetailsViewModelItemType
    let rowCount: Int
    let detailType: DetailsViewModelType

    let name: String
    let email: String
    let phones: [String]
    
    init(info: Codable?, type: DetailsViewModelType) {
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

        var email: String {
            var email = ""
            if let offer = info as? OfferInfo {
                email = offer.embedded.user.email
            } else if let lead = info as? LeadInfo {
                email = lead.embedded.user.email
            }
            return email
        }
        self.email = email

        var phones: [String] {
            var phoneArray = [Phone]()
            if let offer = info as? OfferInfo {
                phoneArray = offer.embedded.user.embedded.phones
            } else if let lead = info as? LeadInfo {
                phoneArray = lead.embedded.user.embedded.phones
            }
            if phoneArray.isEmpty {
                return []
            }
            
            return phoneArray.map { phone in phone.number }
        }
        self.phones = phones

        self.itemType = .contact
        self.rowCount = 1
        self.detailType = type
    }
}
