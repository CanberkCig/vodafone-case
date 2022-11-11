//
//  CheckBox.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

protocol CheckBoxDelegate: AnyObject {
    func onCheckBoxUpdate(sender: CheckBox)
}

class CheckBox: UIButton {
    // Images
    private let checkedImage = UIImage(named: "selected_cir_chkbx")! as UIImage
    private let uncheckedImage = UIImage(named: "unselected_cir_chkbx")! as UIImage
    
    weak var delegate: CheckBoxDelegate?
        
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            
            delegate?.onCheckBoxUpdate(sender: self)
        }
    }
}
