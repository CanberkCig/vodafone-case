//
//  FilterSelectionViewController.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import UIKit

class FilterSelectionViewController: BaseViewController {
    
    @IBOutlet weak var filterSelectionViewModel: FilterSelectionViewModel!
    var categoryChilds = [String]()
    var selectedFilterArray = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterSelectionViewModel.setValues(childNames: categoryChilds, vc: self, selectedFilterArray: selectedFilterArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }

}
