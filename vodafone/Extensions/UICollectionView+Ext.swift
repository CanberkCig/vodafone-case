//
//  UICollectionView+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation
import UIKit


extension UICollectionView {
    
    func setEmptyMessage(_ title: String, _ image: String) {
        let message = EmptyCollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        message.setMessage(title: title, emptyImage: image)
        self.backgroundView = message;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UITableView {
    
    func setEmptyMessage(_ title: String, _ image: String) {
        let message = EmptyCollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        message.setMessage(title: title, emptyImage: image)
        self.backgroundView = message;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
