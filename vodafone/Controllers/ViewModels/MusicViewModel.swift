//
//  MusicViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit

class MusicViewModel: BaseViewModel {
        
    func setLayouts(vc: BaseViewController) {
        self.media = .music
        self.setData(vc: vc, title: "Musics", media: .music)
    }

}
