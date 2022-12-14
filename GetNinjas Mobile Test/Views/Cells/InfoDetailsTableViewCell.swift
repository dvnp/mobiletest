//
//  InfoDetailsTableViewCell.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 18/08/22.
//

import UIKit

class InfoDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var infoIcon: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var item: InfoLabelValue? {
        didSet {
            guard let item = item else {
                return
            }
            infoLabel.text = item.label
            valueLabel.text = item.value.joined(separator: ", ")
            switch item.type {
            case .offer:
                infoIcon.tintColor = UIColor.systemBlue
            case .lead:
                infoIcon.tintColor = UIColor.systemGreen
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
