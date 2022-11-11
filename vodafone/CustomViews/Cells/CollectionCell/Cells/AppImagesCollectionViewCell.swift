//
//  AppImagesCollectionViewCell.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import UIKit
import DKPhotoGallery

protocol AppImagesCellDataSource {
    func imageForCell(_ cell: AppImagesCollectionViewCell) -> String
    func imagesForShow(_ cell: AppImagesCollectionViewCell) -> [DKPhotoGalleryItem]
}

class AppImagesCollectionViewCell: UICollectionViewCell {
    
    var dataSource: AppImagesCellDataSource?
    @IBOutlet weak var appSSImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func reloadData(){
        guard let image = dataSource?.imageForCell(self) else { return }
        appSSImageView.sd_setImage(with: URL(string: image), completed: nil)
        
        let gallery = DKPhotoGallery()
        gallery.singleTapMode = .dismiss
        gallery.items = dataSource?.imagesForShow(self)
        gallery.presentingFromImageView = appSSImageView
    }
    
}
