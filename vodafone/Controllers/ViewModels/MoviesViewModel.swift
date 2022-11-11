//
//  MoviesViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit

class MoviesViewModel: BaseViewModel {

    func setLayouts(vc: BaseViewController) {
        self.media = .movie
        self.setData(vc: vc, title: "Movies", media: .movie)
    }
    
}
