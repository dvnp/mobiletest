//
//  JobOffersTableViewCell.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import UIKit

class JobOffersTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var personIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressIcon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 20
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowRadius = 2.5
            containerView.layer.shadowOffset = CGSize(width: 2, height: 2)

            contentView.backgroundColor = UIColor.systemCyan
        }
    }
    
    var item: JobOffersViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            titleLabel.text = item.title
            nameLabel.text = item.name
            addressLabel.text = String("\(item.neighborhood) - \(item.city)")
            switch item.state {
            case .accepted:
                //personIcon.image = UIImage(systemName: "person.circle")
                personIcon.tintColor = UIColor.systemGreen
                dateIcon.tintColor = UIColor.systemGreen
                addressIcon.tintColor = UIColor.systemGreen
            case .read:
                personIcon.tintColor = UIColor.systemBlue
                dateIcon.tintColor = UIColor.systemBlue
                addressIcon.tintColor = UIColor.systemBlue
            case .unread:
                personIcon.tintColor = UIColor.systemGray
                dateIcon.tintColor = UIColor.systemGray
                addressIcon.tintColor = UIColor.systemGray
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: item.createdAt) {
                dateFormatter.dateFormat = "dd MMM"
                let dateString = dateFormatter.string(from: date)
                dateLabel.text = String(dateString.replacingOccurrences(of: " ", with: " de ").dropLast())
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
