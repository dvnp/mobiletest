//
//  JobOffersViewController.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 15/08/22.
//

import UIKit

class JobOffersViewController: UIViewController {

    //MARK: - Properties
    fileprivate let offersViewModel = OffersViewModel()
    fileprivate let leadsViewModel = LeadsViewModel()
    fileprivate var detailsViewModel: DetailsViewModel?
    
    //MARK: - Outlets
    @IBOutlet weak var offersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.register(JobOffersTableViewCell.nib, forCellReuseIdentifier: JobOffersTableViewCell.identifier)
        
        listTableView.dataSource = offersViewModel
        listTableView.delegate = self

        offersViewModel.delegate = self
        leadsViewModel.delegate = self
    }

    @IBAction func segmentedControlActionChanged(_ sender: UISegmentedControl) {
        listTableView.dataSource = sender.selectedSegmentIndex == 0 ? offersViewModel : leadsViewModel
        listTableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            let detailsViewModel = sender as? DetailsViewModel
            destination.detailsViewModel = detailsViewModel
            destination.delegate = self
        }
    }

}

extension JobOffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let offersDataSource = listTableView.dataSource as? OffersViewModel,
           let link = offersDataSource.linkSelf(indexOffer: indexPath.row) {
            detailsViewModel = DetailsViewModel(url: link, type: .offer)
            navigationItem.backButtonTitle = "Oferta"
        } else if let leadsDataSource = listTableView.dataSource as? LeadsViewModel,
                  let link = leadsDataSource.linkSelf(indexOffer: indexPath.row) {
            detailsViewModel = DetailsViewModel(url: link, type: .lead)
            navigationItem.backButtonTitle = ""
        }
        self.performSegue(withIdentifier: "detailsSegue", sender: detailsViewModel)
    }
}

extension JobOffersViewController: DetailsViewControllerDelegate {
    func popViewRefresh() {
        //navigationItem.backButtonTitle = detailsViewModel?.detailType == .offer ? "Oferta" : ""
    }

    func activityIndicatorStart() {
        activityIndicator.startAnimating()
    }

    func activityIndicatorStop() {
        activityIndicator.stopAnimating()
    }
}

extension JobOffersViewController: OffersViewModelDelegate {

    func offerActivityIndicatorStart() {
        activityIndicator.startAnimating()
    }

    func offerActivityIndicatorStop() {
        activityIndicator.stopAnimating()
    }

}

extension JobOffersViewController: LeadsViewModelDelegate {

    func leadsActivityIndicatorStart() {
        activityIndicator.startAnimating()
    }

    func leadsActivityIndicatorStop() {
        activityIndicator.stopAnimating()
    }

}
