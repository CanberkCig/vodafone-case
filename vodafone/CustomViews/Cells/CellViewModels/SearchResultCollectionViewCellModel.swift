//
//  SearchResultCollectionViewCellModel.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation
import UIKit

class SearchResultCollectionViewCellModel: NSObject {
    
    var result: Results?
    
    init(result: Results) {
        self.result = result
    }
}

extension SearchResultCollectionViewCellModel: SearchResultCellDataSource {
    func imageForCell(_ cell: SearchResultCollectionViewCell) -> String {
        return result?.artworkUrl100 ?? ""
    }
    
    func nameForCell(_ cell: SearchResultCollectionViewCell) -> String {
        switch result?.kind {
        case "music-video":
            return result?.trackName ?? ""
        case "feature-movie":
            return result?.trackName ?? ""
        case "ebook":
            return result?.trackName ?? ""
        case "software":
            return result?.trackName ?? ""
        default:
            return ""
        }
    }
    
    func priceForCell(_ cell: SearchResultCollectionViewCell) -> String {
        if let price = result?.formattedPrice {
            return "\(price)"
        } else {
            return "\(result?.collectionPrice ?? 0)" + " " + (result?.currency ?? "")
        }
    }
    
    func releaseDateForCell(_ cell: SearchResultCollectionViewCell) -> String {
        if let date = result?.releaseDate?.toDate() {
            return date
        } else {
            return ""
        }
    }
    
}
