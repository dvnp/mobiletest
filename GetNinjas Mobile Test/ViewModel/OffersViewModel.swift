//
//  OffersViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import UIKit

class OffersViewModel: NSObject {
    var offers: Offers?

    override init() {
        super.init()

        Task {
            guard let entryPoint = await Entrypoint.load() else {
                return
            }
            
            offers = await Offers.load(entryPoint.links.offers.href)
        }
    }

    func linkSelf(indexOffer: Int) -> String? {
        if let offers = offers?.offers, !offers.isEmpty {
            return indexOffer < offers.count ? offers[indexOffer].links.linksSelf.href : nil
        }
        return nil
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
        if let offers = offers?.offers, let cell = tableView.dequeueReusableCell(withIdentifier: JobOffersTableViewCell.identifier, for: indexPath) as? JobOffersTableViewCell {
            let offer = offers[indexPath.row]
            cell.item = JobOffersViewModelItem(state: offer.state == "read" ? .read : .unread,
                                               title: offer.embedded.request.title,
                                               createdAt: offer.embedded.request.createdAt,
                                               name: offer.embedded.request.embedded.user.name,
                                               email: "",
                                               city: offer.embedded.request.embedded.address.city,
                                               street: "",
                                               neighborhood: offer.embedded.request.embedded.address.neighborhood,
                                               uf: offer.embedded.request.embedded.address.uf)
            return cell
        }
        return UITableViewCell()
    }
}
