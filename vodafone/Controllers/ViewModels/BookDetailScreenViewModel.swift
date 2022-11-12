//
//  BookDetailScreenViewModel.swift
//  vodafone
//
//  Created by canberk çığ on 9.11.2022.
//

import Foundation
import UIKit

class BookDetailScreenViewModel: NSObject {
    
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var viewInAppStoreButton: UIButton!
    @IBOutlet weak var bookDetailTV: UITextView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    var bookData: Results?
    var vc: UIViewController?
    
    func setLayouts(vc: UIViewController, data: Results) {
        self.vc = vc
        self.bookData = data
        vc.title = data.trackCensoredName

        let rating = "\(data.averageUserRating ?? 0)"
        let ratingCount = data.userRatingCount?.shortStringRepresentation
        ratingLabel.text = rating + "/5 - " + (ratingCount ?? "") + " Ratings"
        
        bookNameLabel.text = data.trackName
        artistNameLabel.text = data.artistName
        bookDetailTV.text = data.description?.html2String
        
        artistNameLabel.isUserInteractionEnabled = true
        let addArtistNameTap = UITapGestureRecognizer(target: self, action: #selector(showArtistPage))
        artistNameLabel.addGestureRecognizer(addArtistNameTap)
        
        if let price = data.formattedPrice {
            priceLabel.text = "\(price)"
        } else {
            priceLabel.text = "\(data.collectionPrice ?? 0)" + " " + (data.currency ?? "")
        }
        
        if let image = data.artworkUrl100 {
            bookImageView.sd_setImage(with: URL(string: image))
        } else {
            bookImageView.image = UIImage()
        }
        
        viewInAppStoreButton.layer.borderWidth = 1
        viewInAppStoreButton.layer.borderColor = UIColor.systemBlue.cgColor
        viewInAppStoreButton.setCornerRadius(5)
        
    }
    
    @objc func showArtistPage() {
        GlobalHelper.openLinkInSafari(self.vc ?? UIViewController(), url: bookData?.artistViewUrl ?? "")
    }
    
    @IBAction func viewBookInAppStore() {
        GlobalHelper.openLinkInSafari(self.vc ?? UIViewController(), url: bookData?.trackViewUrl ?? "")
    }
    
}
