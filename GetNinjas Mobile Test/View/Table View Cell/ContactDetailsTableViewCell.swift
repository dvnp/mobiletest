//
//  ContactDetailsTableViewCell.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 18/08/22.
//

import UIKit

class ContactDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard let item = item as? ContactDetailsViewModelItem else {
                return
            }
            contactLabel.text = item.name
            phoneLabel.text = item.phones[0]
            emailLabel.text = item.email
            switch item.detailType {
            case .offer:
                contactView.backgroundColor = UIColor.systemCyan
                contactLabel.textColor = UIColor.white
                phoneLabel.textColor = UIColor.white
                emailLabel.textColor = UIColor.white
                phoneIcon.tintColor = UIColor.white
                emailIcon.tintColor = UIColor.white
                messageLabel.text = "Aceite o pedido para destravar o contato!"
            case .lead:
                contactView.backgroundColor = UIColor.systemGreen
                contactLabel.textColor = UIColor.black
                phoneLabel.textColor = UIColor.black
                emailLabel.textColor = UIColor.black
                phoneIcon.tintColor = UIColor.black
                emailIcon.tintColor = UIColor.black
                messageLabel.text = "Fale com o cliente o quanto antes"
            }
        }
    }

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
