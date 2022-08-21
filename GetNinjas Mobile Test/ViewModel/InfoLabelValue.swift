//
//  InfoLabelValue.swift
//  GetNinjas Mobile Test
//
//  Created by Diogenes Pereira on 21/08/22.
//

import Foundation

struct InfoLabelValue {
    let label: String
    let value: [String]
    let type: DetailsViewModelType

    init(label: String, value: [String], type: DetailsViewModelType) {
        self.label = label
        self.value = value
        self.type = type
    }
}
