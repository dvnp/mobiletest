//
//  DetailsViewControllerDelegate.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

protocol DetailsViewControllerDelegate: AnyObject {
    func popViewRefresh()
    
    func activityIndicatorStart()
    func activityIndicatorStop()
}
