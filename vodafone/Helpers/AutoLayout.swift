//
//  AutoLayout.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import UIKit

@propertyWrapper
public struct AutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
