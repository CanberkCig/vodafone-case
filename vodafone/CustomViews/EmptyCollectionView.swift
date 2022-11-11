//
//  EmptyCollectionView.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

@IBDesignable class EmptyCollectionView: CustomDesignableView {
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    func setMessage(title: String, emptyImage: String) {
        emptyMessageLabel.text = title
        emptyImageView.image = UIImage(named: emptyImage)
    }
}
