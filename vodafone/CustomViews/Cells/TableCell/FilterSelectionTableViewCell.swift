//
//  FilterSelectionTableViewCell.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import UIKit

protocol FilterSelectionCellDataSource {
    func nameForCell(_ cell: FilterSelectionTableViewCell) -> String
    func selectedDataForCell(_ cell: FilterSelectionTableViewCell) -> [Results]
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
        valueName.text = name
        guard let data = dataSource?.selectedDataForCell(self) else { return }
        if data.contains(where: { $0.primaryGenreName == name }) {
            checkBox.isChecked = true
        } else {
            checkBox.isChecked = false
        }
    }
    
}
