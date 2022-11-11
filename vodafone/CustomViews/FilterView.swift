//
//  FilterView.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

protocol ShowFilterChildDelegate {
    func show()
}

@IBDesignable class FilterView: CustomDesignableView {
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    
    var delegate: ShowFilterChildDelegate?
    
    func reloadData(name: String, value: String) {
        propertyName.text = name
        propertyValue.text = value
    }

}
