//
//  BooksViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class BooksViewController: BaseViewController {
    
    @IBOutlet weak var booksViewModel: BooksViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        booksViewModel?.setLayouts(vc: self)
    }

}
