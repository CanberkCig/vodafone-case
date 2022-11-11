//
//  AppDetailScreenViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 10.11.2022.
//

import Foundation
import UIKit
import DKPhotoGallery

class AppDetailScreenViewModel: NSObject {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var viewInAppStoreButton: UIButton!
    @IBOutlet weak var appDetailLabel: UILabel!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appStoreImagesCV: UICollectionView!
    @IBOutlet weak var trackContentRating: UILabel!
    @IBOutlet weak var trackContentView: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!

    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var cellId = "appCell"
    
    var appData: Results?
    var vc: UIViewController?
    var appPhotos = [DKPhotoGalleryItem]()
    
    func setCollectionView() {
        appStoreImagesCV.register(UINib(nibName: "AppImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        appStoreImagesCV.setCollectionViewLayout(layout, animated: true)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        appStoreImagesCV.showsHorizontalScrollIndicator = false
        appStoreImagesCV.backgroundColor = .white
    }
    
    func setLayouts(vc: UIViewController, data: Results) {
        self.vc = vc
        self.appData = data
        vc.title = data.trackCensoredName

        let rating = data.averageUserRating?.roundUp()
        let ratingCount = data.userRatingCount?.shortStringRepresentation
        ratingLabel.text = (rating ?? "") + "/5 - " + (ratingCount ?? "") + " Ratings"
        
        appNameLabel.text = data.trackName
        sellerNameLabel.text = data.artistName
        appDetailLabel.text = data.description?.html2String
        trackContentRating.text = data.trackContentRating
        releaseDateLabel.text = data.releaseDate?.toDate()
        
        sellerNameLabel.isUserInteractionEnabled = true
        let addArtistNameTap = UITapGestureRecognizer(target: self, action: #selector(showSellerPage))
        sellerNameLabel.addGestureRecognizer(addArtistNameTap)
        
        if data.formattedPrice == "Free" {
            priceLabel.text = data.formattedPrice
        } else {
            if let price = data.collectionPrice {
                priceLabel.text = "\(price)" + " " + (data.currency ?? "")
            } else {
                priceLabel.text = "FREE"
            }
        }
        
        if let image = data.artworkUrl100 {
            appImageView.sd_setImage(with: URL(string: image))
        } else {
            appImageView.image = UIImage()
        }
        
        viewInAppStoreButton.layer.borderWidth = 1
        viewInAppStoreButton.layer.borderColor = UIColor.systemBlue.cgColor
        viewInAppStoreButton.setCornerRadius(5)
        
        trackContentView.layer.borderWidth = 1
        trackContentView.layer.borderColor = UIColor.systemGray.cgColor
        trackContentView.setCornerRadius(5)
        appImageView.setCornerRadius(10)
        setCollectionView()
        
        guard let photos = data.screenshotUrls else { return }
        for photo in photos {
            if let url = URL(string: photo) {
                let item = DKPhotoGalleryItem(imageURL: url)
                appPhotos.append(item)
            }
        }
    }
    
    @objc func showSellerPage() {        
        GlobalHelper.openLinkInSafari(self.vc ?? UIViewController(), url: appData?.artistViewUrl ?? "")
    }
    
    @IBAction func viewBookInAppStore() {
        if let url = URL(string: appData?.trackViewUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: - CollectionView Delegate & DataSources -
extension AppDetailScreenViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: (collectionView.frame.size.width - 30 ) / 2 , height: collectionView.frame.size.height * 1.75 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appData?.screenshotUrls?.count ?? 0
    }
}


extension AppDetailScreenViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! AppImagesCollectionViewCell
        let appViewModel = AppSSCollectionViewCellModel.init(image: appData?.screenshotUrls?[indexPath.row] ?? .init(), images: appPhotos)
            cell.dataSource = appViewModel
            cell.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gallery = DKPhotoGallery()
        gallery.singleTapMode = .dismiss
        gallery.presentationIndex = indexPath.row
        gallery.items = appPhotos
        
        vc?.present(photoGallery: gallery)
    }

}
