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
    var isChecked: Bool?
    
    init(catName: String?, isChecked: Bool?) {
        self.catName = catName
        self.isChecked = isChecked
    }
    
}

extension FilterSelectionCellViewModel: FilterSelectionCellDataSource {
    func nameForCell(_ cell: FilterSelectionTableViewCell) -> String {
        return catName ?? ""
    }
    
    func isSelectedForCell(_ cell: FilterSelectionTableViewCell) -> Bool {
        return isChecked ?? false
    }
    
    
}
