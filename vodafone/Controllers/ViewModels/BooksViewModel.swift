//
//  BooksViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit

class BooksViewModel: BaseViewModel {
    
    func setLayouts(vc: BaseViewController) {
        self.media = .book
        self.setData(vc: vc, title: "Books", media: .book)
    }

}
