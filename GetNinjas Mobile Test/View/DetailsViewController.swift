//
//  DetailsViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import UIKit

enum buttonId: Int {
    case left = 0
    case right = 1
}

protocol DetailsViewControllerDelegate: AnyObject {
    func popViewRefresh(button: buttonId)
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var detailsViewModel: DetailsViewModel?
    weak var delegate: DetailsViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        leftButton.tag = 0
        rightButton.tag = 1
        
        listTableView.register(MapDetailsTableViewCell.nib, forCellReuseIdentifier: MapDetailsTableViewCell.identifier)
        listTableView.register(TitleDetailsTableViewCell.nib, forCellReuseIdentifier: TitleDetailsTableViewCell.identifier)
        listTableView.register(InfoDetailsTableViewCell.nib, forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
        listTableView.register(ContactDetailsTableViewCell.nib, forCellReuseIdentifier: ContactDetailsTableViewCell.identifier)
        
        listTableView.dataSource = detailsViewModel
        if detailsViewModel?.detailType == .lead {
            var configuration = UIButton.Configuration.plain()
            var container = AttributeContainer()
            container.font = UIFont.boldSystemFont(ofSize: 25)
            configuration.attributedTitle = AttributedString("LIGAR", attributes: container)
            configuration.image = UIImage(systemName: "phone.fill")
            configuration.baseBackgroundColor = UIColor.systemGray
            configuration.baseForegroundColor = UIColor.systemBlue
            configuration.imagePadding = 15.0
            leftButton.configuration = configuration
            configuration.attributedTitle = AttributedString("WHATSAPP", attributes: container)
            configuration.image = UIImage(systemName: "message.fill")
            rightButton.configuration = configuration
        }
    }

    @IBAction func optionButtonPressed(_ sender: UIButton) {
        if detailsViewModel?.detailType == .offer, let navController = self.navigationController {
            navController.popViewController(animated: true)
            self.delegate?.popViewRefresh(button: sender.tag == 0 ? .left : .right)
        }
    }
}
