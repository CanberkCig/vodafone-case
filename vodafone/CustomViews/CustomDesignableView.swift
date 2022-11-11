//
//  CustomDesignableView.swift
//  vodafone
//
//  Created by canberk çığ on 11.11.2022.
//

import Foundation
import UIKit

class CustomDesignableView: UIView {
    private var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadViewFromNib(nibName: String(describing: Self.self)) else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
        initialize()
    }
    
    func initialize() {}
}
