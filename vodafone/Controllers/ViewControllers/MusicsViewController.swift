//
//  MusicsViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class MusicsViewController: BaseViewController {
    
    @IBOutlet weak var musicViewModel: MusicViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        musicViewModel?.setLayouts(vc: self)
    }

}
