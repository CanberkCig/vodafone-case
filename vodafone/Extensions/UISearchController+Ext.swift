//
//  UISearchController+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation
import UIKit

extension UISearchController {
    func setSearchController() {
        searchBar.setImage(UIImage(named: "Search"), for: .search, state: .normal)
        searchBar.sizeToFit()
        hidesNavigationBarDuringPresentation = false
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchBar.isTranslucent = true
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkPurple(), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        } else {
            searchBar.textColor = UIColor.darkPurple()
        }
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], for: .normal)
    }
}

extension UISearchBar {
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                textField.textColor = newValue
            }
        }
    }
}
