//
//  Double+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit

extension Double {
    var shortStringRepresentation: String {
        if self.isNaN {
            return "NaN"
        }
        if self.isInfinite {
            return "\(self < 0.0 ? "-" : "+")Infinity"
        }
        let units = ["", "k", "M"]
        var interval = self
        var i = 0
        while i < units.count - 1 {
            if abs(interval) < 1000.0 {
                break
            }
            i += 1
            interval /= 1000.0
        }
        return "\(String(format: "%0.*g", Int(log10(abs(interval))) + 2, interval))\(units[i])"
    }
    
    func roundUp() -> String {
        let decimal = String(format: "%.2f", self)
        return decimal
    }
}
