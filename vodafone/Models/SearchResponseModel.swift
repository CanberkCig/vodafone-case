//
//  SearchResponseModel.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Foundation

class SearchResponse: Decodable {
    var resultCount: Int?
    var results: [Results]?
}

class Results: Decodable {
    var collectionPrice: Double?
    var formattedPrice: String?
    var collectionName: String?
    var artworkUrl100: String?
    var releaseDate: String?
    var wrapperType: String?
    var trackName: String?
    var kind: String?
    var longDescription: String?
    var primaryGenreName: String?
    var artistName: String?
    var currency: String?
    var previewUrl: String?
    var country: String?
    var collectionArtistViewUrl: String?
    var collectionViewUrl: String?
    var averageUserRating: Double?
    var userRatingCount: Double?
    var description: String?
    var artistViewUrl: String?
    var trackViewUrl: String?
    var trackCensoredName: String?
    var trackContentRating: String?
    var sellerUrl: String?
    var screenshotUrls: [String]?
}
