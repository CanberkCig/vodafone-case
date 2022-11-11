//
//  UILabel+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import Foundation
import UIKit

extension UILabel {
    func underline(color: UIColor, font: UIFont) {
        if let textString = self.text {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: color,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            
            let attributedString = NSMutableAttributedString(string: textString, attributes: attributes)
            attributedText = attributedString
        }
    }
}
