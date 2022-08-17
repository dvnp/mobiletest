//
//  OffersViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import UIKit

struct OffersViewModelItem {
    var state: String
    var title: String
    var createdAt: String
    var userName: String
    var addressCity: String
    var addressNeighborhood: String
    var addressUf: String
}

class OffersViewModel: NSObject {
    var offers: Offers?

    override init() {
        super.init()

        Task {
            guard let entryPoint = await EntryPoint.loadEntryPoint() else {
                return
            }
            
            offers = await Offers.loadOffers(urlString: entryPoint.links.offers.href)
        }
    }
}


extension OffersViewModel: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let offers = offers?.offers else {
            return 0
        }
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: JobOffersTableViewCell.identifier, for: indexPath) as? JobOffersTableViewCell {
            if let offers = offers?.offers {
                let offer = offers[indexPath.row]
                cell.item = OffersViewModelItem(state: offer.state,
                                                title: offer.embedded.request.title,
                                                createdAt: offer.embedded.request.createdAt,
                                                userName: offer.embedded.request.embedded.user.name,
                                                addressCity: offer.embedded.request.embedded.address.city,
                                                addressNeighborhood: offer.embedded.request.embedded.address.neighborhood,
                                                addressUf: offer.embedded.request.embedded.address.uf)
            }
            return cell
        }
        return UITableViewCell()
    }
}
