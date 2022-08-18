//
//  DataViewModelItem.swift
//  GetNinjas Mobile Test
//
//  Created by Dio on 17/08/22.
//

import Foundation

enum OffersState {
    case invalid
    case read
    case unread
}

struct DataViewModelItem {
    var state: OffersState
    let title: String
    let createdAt: String
    let name: String
    let email: String?
    let city: String
    let street: String?
    let neighborhood: String
    let uf: String
}


