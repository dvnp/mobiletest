//
//  DetailsViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 18/08/22.
//

import UIKit

class DetailsViewModel: NSObject {
    var items = [DetailsViewModelItemProperties]()
    var detailType: DetailsViewModelType
    var offers: OfferInfo?
    var nameTitle: String?

    //MARK: - Properties
    weak var delegate: DetailsViewModelDelegate?

    init(url: String, type: DetailsViewModelType) {
        self.detailType = type
        super.init()

        let semaphore = DispatchSemaphore(value: 0)
        self.delegate?.detailsActivityIndicatorStart()

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
                if let offer = info as? OfferInfo {
                    nameTitle = offer.embedded.user.name
                } else if let lead = info as? LeadInfo {
                    nameTitle = lead.embedded.user.name
                }
                items.append(MapDetailsViewModelItem(info: info, type: type))
                items.append(TitleDetailsViewModelItem(info: info, type: type))
                items.append(InfoDetailsViewModelItem(info: info, type: type))
                items.append(ContactDetailsViewModelItem(info: info, type: type))
            }
            semaphore.signal()
        }

        //TODO: improvement to a network timeout
        semaphore.wait()
        self.delegate?.detailsActivityIndicatorStop()
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
