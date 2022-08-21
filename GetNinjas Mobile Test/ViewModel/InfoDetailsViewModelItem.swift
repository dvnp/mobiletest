//
//  InfoDetailsViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 21/08/22.
//

import Foundation

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
