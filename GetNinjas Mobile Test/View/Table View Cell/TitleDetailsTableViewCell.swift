//
//  TitleDetailsTableViewCell.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 18/08/22.
//

import UIKit

class TitleDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var personIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressIcon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var item: DetailsViewModelItem? {
        didSet {
            guard let item = item as? TitleDetailsViewModelItem else {
                return
            }
            contentView.backgroundColor = UIColor.systemBlue

            titleLabel.text = item.title
            nameLabel.text = item.name
            addressLabel.text = String("\(item.neighborhood) - \(item.city)")
            distanceLabel.text = "a 10Km de você"
            switch item.detailType {
            case .offer:
                personIcon.tintColor = UIColor.systemBlue
                addressIcon.tintColor = UIColor.systemBlue
            case .lead:
                personIcon.tintColor = UIColor.systemGreen
                addressIcon.tintColor = UIColor.systemGreen
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
