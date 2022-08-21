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
            mapView.centerCoordinate.latitude = item.latitude
            mapView.centerCoordinate.longitude = item.longitude
        }
    }

    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
