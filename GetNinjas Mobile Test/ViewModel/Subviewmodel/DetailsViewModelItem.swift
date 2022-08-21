//
//  DetailsViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

protocol DetailsViewModelItem {
    var itemType: DetailsViewModelItemType { get }
    var rowCount: Int { get }
    var detailType: DetailsViewModelType { get }
}
