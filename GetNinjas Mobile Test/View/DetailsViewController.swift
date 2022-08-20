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

    //MARK: - Properties
    var detailViewModel: DetailsViewModel?
    weak var delegate: DetailsViewControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = ""

        leftButton.tag = 0
        rightButton.tag = 1
        
        //listTableView.register(MapDetailsTableViewCell.nib, forCellReuseIdentifier: MapDetailsTableViewCell.identifier)
        listTableView.register(TitleDetailsTableViewCell.nib, forCellReuseIdentifier: TitleDetailsTableViewCell.identifier)
        listTableView.register(InfoDetailsTableViewCell.nib, forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
        listTableView.register(ContactDetailsTableViewCell.nib, forCellReuseIdentifier: ContactDetailsTableViewCell.identifier)
        
        listTableView.dataSource = detailViewModel
        if detailViewModel?.detailType == .lead {
            leftButton.isHidden = true
            rightButton.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    @IBAction func optionButtonPressed(_ sender: UIButton) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
            self.delegate?.popViewRefresh(button: sender.tag == 0 ? .left : .right)
        }
    }
}

