//
//  BookDetailScreenViewController.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import UIKit

class BookDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var bookDetailViewModel: BookDetailScreenViewModel!
    var data: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailViewModel.setLayouts(vc: self, data: data ?? .init())
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
