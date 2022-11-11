//
//  BaseViewController.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setNavigationBar(title: String) {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = UIColor.darkPurple()
        navigationController?.setStatusBar(backgroundColor: UIColor.white)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.vodafoneRed()]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

}
