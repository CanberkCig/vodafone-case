//
//  FilterViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

class FilterViewModel: NSObject {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var categoryView: FilterView!
    @IBOutlet weak var applyButton: UIButton!

    var vc: BaseViewController?
    var data: [Results]?
    var categoriesNames = [String]()
    var countriesNames = [String]()
    
    var uniqueCountryNames = [String]()
    var uniqueCatNames = [String]()
    
    var selectedCategories = [String]()
    var delegate: ApplySelectedDelegate?
    var catNames: [String] = ["Categories", "Countries"]
    var selectedFilterArray = [Results]()
    
    func setLayouts(vc: BaseViewController, data: [Results], selectedFilterArray: [Results]) {
        self.vc = vc
        self.data = data
        self.selectedFilterArray = selectedFilterArray
        bottomView.addShadow(location: .top)
        applyButton.setCornerRadius(10)
        categoryView.reloadData(name: "Categories", value: selectedCategories.joined(separator: ", "))
        
        for category in data {
            categoriesNames.append(category.primaryGenreName ?? "")
            countriesNames.append(category.country ?? "")
        }
        uniqueCatNames = Array(Set(categoriesNames))
        uniqueCountryNames = Array(Set(countriesNames))
        
        categoryView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.categoryTapped(_:)))
        categoryView.addGestureRecognizer(tap)
    }
    
    @IBAction func closePage() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyChanges() {
        delegate?.selectedCategories(categories: selectedCategories)
        vc?.navigationController?.popViewController(animated: true)
    }
    
    @objc func categoryTapped(_ sender: UITapGestureRecognizer? = nil) {
        GlobalHelper.pushController(id: "FilterSelectionViewController", self.vc ?? UIViewController()) { (vc: FilterSelectionViewController) in
            vc.categoryChilds = uniqueCatNames
            vc.selectedFilterArray = selectedFilterArray
            vc.filterSelectionViewModel.delegate = self
        }
    }
    
}

extension FilterViewModel: ApplySelectedDelegate {
    func selectedCategories(categories: [String]) {
        selectedCategories = categories
        categoryView.reloadData(name: "Categories", value: selectedCategories.joined(separator: ", "))
    }
}
