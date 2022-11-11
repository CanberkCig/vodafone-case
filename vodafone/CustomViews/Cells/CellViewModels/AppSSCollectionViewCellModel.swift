//
//  AppSSCollectionViewCellModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit
import DKPhotoGallery

class AppSSCollectionViewCellModel: NSObject {
    
    var image: String?
    var images: [DKPhotoGalleryItem]?
    
    init(image: String, images: [DKPhotoGalleryItem]) {
        self.image = image
        self.images = images
    }
}

extension AppSSCollectionViewCellModel: AppImagesCellDataSource {
    func imageForCell(_ cell: AppImagesCollectionViewCell) -> String {
        return image ?? ""
    }
    
    func imagesForShow(_ cell: AppImagesCollectionViewCell) -> [DKPhotoGalleryItem] {
        return images ?? []
    }
}
