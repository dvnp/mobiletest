//
//  ViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 15/08/22.
//

import UIKit

class JobOffersViewController: UIViewController {

    //MARK: - Properties
    fileprivate let offersViewModel = OffersViewModel()
    
    //MARK: - Outlets
    @IBOutlet weak var jobOffersTableView: UITableView!

    //MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()


        jobOffersTableView.register(JobOffersTableViewCell.nib, forCellReuseIdentifier: JobOffersTableViewCell.identifier)
        jobOffersTableView.dataSource = offersViewModel
    }


}
