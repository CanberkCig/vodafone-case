//
//  String+Ext.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation

extension String {
    
    func toDate()-> String?{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        
        let date: Date? = dateFormatterGet.date(from: self)
        let currentDate = dateFormatterPrint.string(from: date ?? Date())
        return currentDate
    }
    
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
