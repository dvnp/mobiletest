//
//  DetailsViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 18/08/22.
//

import UIKit

enum DetailsViewModelType {
    case offer
    case lead
}
enum DetailsViewModelItemType {
    case map
    case title
    case info
    case contact
}

protocol DetailsViewModelItem {
    var itemType: DetailsViewModelItemType { get }
    var rowCount: Int { get }
    var detailType: DetailsViewModelType { get }
}

class DetailsViewModel: NSObject {
    var items = [DetailsViewModelItem]()
    var detailType: DetailsViewModelType
    var offers: OfferInfo?

    init(url: String, type: DetailsViewModelType) {
        self.detailType = type
        super.init()

        Task {
            var info: Codable?
            switch type {
            case .offer:
                info = await OfferInfo.load(url)
                if let offers = info as? OfferInfo {
                    self.offers = offers
                }
            case .lead:
                info = await LeadInfo.load(url)
            }

            if let info = info {
                items.append(MapDetailsViewModelItem(info: info, type: type))
                items.append(TitleDetailsViewModelItem(info: info, type: type))
                items.append(InfoDetailsViewModelItem(info: info, type: type))
                items.append(ContactDetailsViewModelItem(info: info, type: type))
            }
        }
    }

    func offerLinkAccepted() -> String? {
        if let link = offers?.links.accept.href {
            return link
        }
        return nil
    }

    func offerLinkRejected() -> String? {
        if let link = offers?.links.reject.href {
            return link
        }
        return nil
    }

}

class MapDetailsViewModelItem: DetailsViewModelItem {
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
                longitude = offer.embedded.address.geolocation.latitude
            } else if let lead = info as? LeadInfo {
                longitude = lead.embedded.address.geolocation.latitude
            }
            return longitude
        }
        self.longitude = longitude

        self.itemType = .map
        self.rowCount = 1
        self.detailType = type
    }
}

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

struct InfoLabelValue {
    let label: String
    let value: [String]
    let type: DetailsViewModelType

    init(label: String, value: [String], type: DetailsViewModelType) {
        self.label = label
        self.value = value
        self.type = type
    }
}

class InfoDetailsViewModelItem: DetailsViewModelItem {
    let itemType: DetailsViewModelItemType
    let rowCount: Int
    let detailType: DetailsViewModelType

    let infoLabelValues: [InfoLabelValue]

    init(info: Codable?, type: DetailsViewModelType) {
        var infoLabelValue: [InfoLabelValue] {
            var infoArray = [Info]()
            if let offer = info as? OfferInfo {
                infoArray = offer.embedded.info
            } else if let lead = info as? LeadInfo {
                infoArray = lead.embedded.info
            }
            if infoArray.isEmpty {
                return []
            }
            
            let infos: [InfoLabelValue] = infoArray.map { info in
                var stringArray = [String]()
                switch info.value.self {
                case .string(let string):
                    stringArray.append(string)
                case .stringArray(let strArray):
                    stringArray = strArray
                }
                return InfoLabelValue(label: info.label , value: stringArray, type: type)
            }
            return infos
        }
        self.infoLabelValues = infoLabelValue

        self.itemType = .info
        self.rowCount = self.infoLabelValues.count
        self.detailType = type
    }
}

class ContactDetailsViewModelItem: DetailsViewModelItem {
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

extension DetailsViewModel: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]

        switch item.itemType {
        case .map:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapDetailsTableViewCell.identifier, for: indexPath) as? MapDetailsTableViewCell {
                cell.item = item
                return cell
            }
        case .title:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TitleDetailsTableViewCell.identifier, for: indexPath) as? TitleDetailsTableViewCell {
                cell.item = item
                return cell
            }
        case .info:
            if let item = item as? InfoDetailsViewModelItem, let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailsTableViewCell.identifier, for: indexPath) as? InfoDetailsTableViewCell {
                let infoLabelValue = item.infoLabelValues[indexPath.row]
                cell.item = infoLabelValue
                return cell
            }
        case .contact:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailsTableViewCell.identifier, for: indexPath) as? ContactDetailsTableViewCell {
                cell.item = item
                return cell
            }
        }
        return UITableViewCell()
    }
}
