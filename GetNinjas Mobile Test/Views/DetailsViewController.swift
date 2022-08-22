//
//  DetailsViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 16/08/22.
//

import UIKit

class DetailsViewController: UIViewController {
    let left = 0
    let right = 1

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

        leftButton.tag = left
        rightButton.tag = right
        
        listTableView.register(MapDetailsTableViewCell.nib, forCellReuseIdentifier: MapDetailsTableViewCell.identifier)
        listTableView.register(TitleDetailsTableViewCell.nib, forCellReuseIdentifier: TitleDetailsTableViewCell.identifier)
        listTableView.register(InfoDetailsTableViewCell.nib, forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
        listTableView.register(ContactDetailsTableViewCell.nib, forCellReuseIdentifier: ContactDetailsTableViewCell.identifier)
        
        if detailsViewModel?.detailType == .lead {
            navigationItem.title = detailsViewModel?.nameTitle
            setLeadsButtonView()
        }

        listTableView.dataSource = detailsViewModel

        detailsViewModel?.delegate = self
    }

    @IBAction func optionButtonPressed(_ sender: UIButton) {

        if detailsViewModel?.detailType == .offer {
            if sender.tag == right, let link = detailsViewModel?.offerLinkAccepted() {
                detailsViewModel = DetailsViewModel(url: link, type: .lead)
                if detailsViewModel?.detailType == .lead {
                    navigationItem.title = detailsViewModel?.nameTitle
                    setLeadsButtonView()
                }
                listTableView.dataSource = detailsViewModel
                listTableView.reloadData()
            } else if let navController = self.navigationController {
                navController.popViewController(animated: true)
                //self.delegate?.popViewRefresh()
            }
        }
    }

    private func setLeadsButtonView() {
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

extension DetailsViewController: DetailsViewModelDelegate {
 
    func detailsActivityIndicatorStart() {
        activityIndicator.startAnimating()
    }

    func detailsActivityIndicatorStop() {
        activityIndicator.stopAnimating()
    }
}
