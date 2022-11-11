//
//  AppsViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class AppsViewController: BaseViewController {
    
    @IBOutlet weak var appsViewModel: AppsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        appsViewModel?.setLayouts(vc: self)
    }

}
