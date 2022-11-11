//
//  UINavigationController+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let topInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? statusBarFrame.height
        
        let statusBarView = UIView(frame: CGRect(x: statusBarFrame.origin.x, y: statusBarFrame.origin.y, width: statusBarFrame.width, height: topInset))
        
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
