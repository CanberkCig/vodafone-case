//
//  AppDetailScreenViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class AppDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var appDetailViewModel: AppDetailScreenViewModel!
    var data: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDetailViewModel.setLayouts(vc: self, data: data ?? Results())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
