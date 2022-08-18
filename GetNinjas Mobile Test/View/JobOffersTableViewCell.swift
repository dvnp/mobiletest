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
    
    var item: DataViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            titleLabel.text = item.title
            nameLabel.text = item.name
            addressLabel.text = String("\(item.neighborhood) - \(item.city)")

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
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        personIcon.layer.cornerRadius = 40
//        personIcon.clipsToBounds = true
//        personIcon.contentMode = .scaleAspectFit
//        personIcon.backgroundColor = UIColor.lightGray
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //personIcon.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
