//
//  MapDetailsTableViewCell.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 18/08/22.
//

import UIKit
import MapKit

class MapDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!

    var item: DetailsViewModelItemProperties? {
        didSet {
            guard let item = item as? MapDetailsViewModelItem else {
                return
            }

            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
            mapView.addAnnotation(annotation)
            
            let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(viewRegion, animated: false)
        }
    }

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
