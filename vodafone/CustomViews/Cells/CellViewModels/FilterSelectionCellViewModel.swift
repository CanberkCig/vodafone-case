//
//  FilterSelectionCellViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

class FilterSelectionCellViewModel: NSObject {
    
    var catName: String?
    var selectedData: [Results]?
    
    init(catName: String?, selectedData: [Results]) {
        self.catName = catName
        self.selectedData = selectedData
    }
    
}

extension FilterSelectionCellViewModel: FilterSelectionCellDataSource {
    func nameForCell(_ cell: FilterSelectionTableViewCell) -> String {
        return catName ?? ""
    }
    
    func selectedDataForCell(_ cell: FilterSelectionTableViewCell) -> [Results] {
        return selectedData ?? []
    }
}
