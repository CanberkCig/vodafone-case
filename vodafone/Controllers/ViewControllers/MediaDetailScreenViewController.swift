//
//  MediaDetailScreenViewController.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import UIKit

class MediaDetailScreenViewController: UIViewController {
    
    @IBOutlet weak var mediaDetailViewModel: MediaDetailScreenViewModel!
    var data: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaDetailViewModel.setLayouts(vc: self, data: data ?? .init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaDetailViewModel.playerView.stop()
        self.tabBarController?.tabBar.isHidden = false
    }
}
