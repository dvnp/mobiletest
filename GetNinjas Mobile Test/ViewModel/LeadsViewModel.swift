//
//  LeadsViewModel.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 17/08/22.
//

import UIKit

class LeadsViewModel: NSObject {
    var leads: Leads?

    override init() {
        super.init()

        Task {
            guard let entryPoint = await Entrypoint.loadEntrypoint() else {
                return
            }
            
            leads = await Leads.loadLeads(url: entryPoint.links.leads.href)
        }
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: JobOffersTableViewCell.identifier, for: indexPath) as? JobOffersTableViewCell {
            if let leads = leads?.leads {
                let lead = leads[indexPath.row]
                cell.item = JobOffersViewModelItem(state: .invalid,
                                                   title: lead.embedded.request.title,
                                                   createdAt: lead.createdAt,
                                                   name: lead.embedded.user.name,
                                                   email: lead.embedded.user.email,
                                                   city: lead.embedded.address.city,
                                                   street: lead.embedded.address.street,
                                                   neighborhood: lead.embedded.address.neighborhood,
                                                   uf: lead.embedded.address.uf)
                //cell.contentView.backgroundColor = UIColor.systemCyan
            }
            return cell
        }
        return UITableViewCell()
    }
}
