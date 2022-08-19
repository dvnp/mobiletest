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

    //MARK: - Lifecycle
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

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DetailsViewController {
            let detailsViewModel = sender as? DetailsViewModel
            destination.detailViewModel = detailsViewModel
        }

    }

}

extension JobOffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(jobOffersSegmentedControl.selectedSegmentIndex) -> \(indexPath.row)")
        let detailsViewModel: Any? = nil//DetailsViewModel(url: "", type: .offer)
        self.performSegue(withIdentifier: "detailsSegue", sender: detailsViewModel)
    }
}
