//
//  AppsViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit

class AppsViewModel: BaseViewModel {
    
    func setLayouts(vc: BaseViewController) {
        self.media = .app
        self.setData(vc: vc, title: "Apps", media: .app)
    }

}
