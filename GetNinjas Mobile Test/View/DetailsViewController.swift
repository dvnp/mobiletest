//
//  DetailsViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 16/08/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    //MARK: - Properties
    var detailViewModel: DetailsViewModel?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "Vila"

        //listTableView.register(MapDetailsTableViewCell.nib, forCellReuseIdentifier: MapDetailsTableViewCell.identifier)
        listTableView.register(TitleDetailsTableViewCell.nib, forCellReuseIdentifier: TitleDetailsTableViewCell.identifier)
        listTableView.register(InfoDetailsTableViewCell.nib, forCellReuseIdentifier: InfoDetailsTableViewCell.identifier)
        listTableView.register(ContactDetailsTableViewCell.nib, forCellReuseIdentifier: ContactDetailsTableViewCell.identifier)
        
        listTableView.dataSource = detailViewModel
    }

}
