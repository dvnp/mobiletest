//
//  LeadsViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 17/08/22.
//

import UIKit

protocol LeadsViewModelDelegate: AnyObject {
    func leadsActivityIndicatorStart()
    func leadsActivityIndicatorStop()
}

class LeadsViewModel: NSObject {
    var leads: Leads?

    //MARK: - Properties
    weak var delegate: LeadsViewModelDelegate?

    override init() {
        super.init()

        let semaphore = DispatchSemaphore(value: 0)
        self.delegate?.leadsActivityIndicatorStart()

        Task {
            guard let entryPoint = await Entrypoint.load() else {
                return
            }
            
            leads = await Leads.load(entryPoint.links.leads.href)
            semaphore.signal()
        }

        //TODO: improvement to a network timeout
        semaphore.wait()
        self.delegate?.leadsActivityIndicatorStop()
    }

    func linkSelf(indexOffer: Int) -> String? {
        if let leads = leads?.leads, !leads.isEmpty {
            return indexOffer < leads.count ? leads[indexOffer].links.linksSelf.href : nil
        }
        return nil
    }

}

extension LeadsViewModel: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let leads = leads?.leads else {
            return 0
        }
        return leads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let leads = leads?.leads, let cell = tableView.dequeueReusableCell(withIdentifier: JobOffersTableViewCell.identifier, for: indexPath) as? JobOffersTableViewCell {
            let lead = leads[indexPath.row]
            cell.item = JobOffersViewModelItem(state: .accepted,
                                               title: lead.embedded.request.title,
                                               createdAt: lead.createdAt,
                                               name: lead.embedded.user.name,
                                               email: lead.embedded.user.email,
                                               city: lead.embedded.address.city,
                                               street: lead.embedded.address.street,
                                               neighborhood: lead.embedded.address.neighborhood,
                                               uf: lead.embedded.address.uf)
            return cell
        }
        return UITableViewCell()
    }
}
