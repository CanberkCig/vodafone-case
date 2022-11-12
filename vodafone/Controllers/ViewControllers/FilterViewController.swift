//
//  FilterViewController.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import UIKit

class FilterViewController: BaseViewController {
    
    @IBOutlet weak var filterViewModel: FilterViewModel!
    var data: [Results]?
    var selectedFilterArray = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterViewModel.setLayouts(vc: self, data: data ?? [Results](), selectedFilterArray: selectedFilterArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
