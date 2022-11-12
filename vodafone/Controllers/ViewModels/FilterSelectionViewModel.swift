//
//  FilterSelectionViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

protocol ApplySelectedDelegate {
    func selectedCategories(categories: [String])
}

class FilterSelectionViewModel: NSObject {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var filterTableView: UITableView!

    var childNames = [String]()
    var selectedCategories = [String]()
    var vc: BaseViewController?
    var delegate: ApplySelectedDelegate?
    var selectedFilterArray = [Results]()
    
    func setValues(childNames: [String], vc: BaseViewController, selectedFilterArray: [Results]) {
        self.childNames = childNames
        self.vc = vc
        self.selectedFilterArray = selectedFilterArray
        bottomView.addShadow(location: .top)
        applyButton.setCornerRadius(10)
        filterTableView.register(UINib(nibName: "FilterSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "filterSelectionCell")
        cleanButtonControl()
    }
    
    func cleanButtonControl() {
        if selectedCategories.count > 0 {
            cleanButton.setTitleColor(.vodafoneRed(), for: .normal)
        } else {
            cleanButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func closePage() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cleanFilter() {
        if selectedCategories.count > 0 {
            selectedCategories.removeAll()
            filterTableView.reloadData()
            cleanButtonControl()
        }
    }
    
    @IBAction func applyChanges() {
        delegate?.selectedCategories(categories: selectedCategories)
        vc?.navigationController?.popViewController(animated: true)
    }
}

extension FilterSelectionViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if childNames.count > 0 {
            tableView.restore()
            return childNames.count
        } else {
            tableView.setEmptyMessage("No results", "no_result")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FilterSelectionTableViewCell = filterTableView.dequeueReusableCell(withIdentifier: "filterSelectionCell") as! FilterSelectionTableViewCell
        cell.checkBox.delegate = self
        cell.checkBox.tag = indexPath.row
        let filterData = FilterSelectionCellViewModel.init(catName: childNames[indexPath.row], selectedData: selectedFilterArray)
        cell.dataSource = filterData
        cell.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
}

extension FilterSelectionViewModel: CheckBoxDelegate {
    func onCheckBoxUpdate(sender: CheckBox) {
        let name = childNames[sender.tag]
        if selectedCategories.contains(name) {
            selectedCategories = selectedCategories.filter{ $0 != name }
        } else {
            selectedCategories.append(name)
        }
        cleanButtonControl()
    }
}




