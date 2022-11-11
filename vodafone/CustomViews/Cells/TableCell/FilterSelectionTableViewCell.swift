//
//  FilterSelectionTableViewCell.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import UIKit

protocol FilterSelectionCellDataSource {
    func nameForCell(_ cell: FilterSelectionTableViewCell) -> String
    func isSelectedForCell(_ cell: FilterSelectionTableViewCell) -> Bool
}

class FilterSelectionTableViewCell: UITableViewCell {
    
    var dataSource: FilterSelectionCellDataSource?
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var valueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func reloadData(){
        guard let name = dataSource?.nameForCell(self) else { return }
        guard let isSelected = dataSource?.isSelectedForCell(self) else { return }
        valueName.text = name
        checkBox.isChecked = isSelected
    }
    
}
