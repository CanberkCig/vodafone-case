//
//  MoviesViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class MoviesViewController: BaseViewController {
    
    @IBOutlet weak var moviesViewModel: MoviesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel?.setLayouts(vc: self)
    }

}
