//
//  API.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import Alamofire

class API {
    static let shared = API()
    private init() { }
    
    fileprivate let encoding = JSONEncoding.default
    
    func getItems(keyword: String, limit: Int?, mediaType: String, success: @escaping ((_ responseModel: SearchResponse)-> Void)){
        let searchEndpoint = "https://itunes.apple.com/search?term=\(keyword)&limit=\(limit ?? 25)&entity=\(mediaType)"
        AF.request(searchEndpoint,
                   method: .post,
                   parameters: nil,
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<600)
        .responseDecodable(of: SearchResponse.self) { response in
            guard let ingredients = response.value else { return }
            success(ingredients)
        }
    }
}
