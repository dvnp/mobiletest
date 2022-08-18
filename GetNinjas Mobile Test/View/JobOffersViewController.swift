//
//  JobOffersViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 15/08/22.
//

import UIKit

class JobOffersViewController: UIViewController {

    //MARK: - Properties
    fileprivate let offersViewModel = OffersViewModel()
    fileprivate let leadsViewModel = LeadsViewModel()
    
    //MARK: - Outlets
    @IBOutlet weak var jobOffersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var jobOffersTableView: UITableView!

    //MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()

        jobOffersTableView.register(JobOffersTableViewCell.nib, forCellReuseIdentifier: JobOffersTableViewCell.identifier)
        
        jobOffersTableView.dataSource = offersViewModel
        jobOffersTableView.delegate = self
    }

    @IBAction func segmentedControlActionChanged(_ sender: UISegmentedControl) {
        jobOffersTableView.dataSource = sender.selectedSegmentIndex == 0 ? offersViewModel : leadsViewModel
        jobOffersTableView.reloadData()
    }
}

extension JobOffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(jobOffersSegmentedControl.selectedSegmentIndex) -> \(indexPath.row)")
        self.performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
}
