//
//  SearchResultCollectionViewCell.swift
//  vodafone
//
//  Created by canberk çığ on 8.11.2022.
//

import UIKit
import SDWebImage

protocol SearchResultCellDataSource {
    func imageForCell(_ cell: SearchResultCollectionViewCell) -> String
    func nameForCell(_ cell: SearchResultCollectionViewCell) -> String
    func priceForCell(_ cell: SearchResultCollectionViewCell) -> String
    func releaseDateForCell(_ cell: SearchResultCollectionViewCell) -> String
}

class SearchResultCollectionViewCell: UICollectionViewCell {
    var dataSource: SearchResultCellDataSource?
    
    @IBOutlet weak var hobbyImageView: UIImageView!
    @IBOutlet weak var hobbyNameLabel: UILabel!
    @IBOutlet weak var hobbyPriceLabel: UILabel!
    @IBOutlet weak var hobbyReleaseDateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        containerView.layer.applyCornerRadiusShadow(color: .black, cornerRadiusValue: 10)
    }
    
    func reloadData(){
        if let image = dataSource?.imageForCell(self) {
            hobbyImageView.sd_setImage(with: URL(string: image), completed: nil)
        } else {
            hobbyImageView.image = UIImage()
        }
        
        hobbyNameLabel.text = dataSource?.nameForCell(self)
        hobbyPriceLabel.text = dataSource?.priceForCell(self)
        hobbyReleaseDateLabel.text = dataSource?.releaseDateForCell(self)
    }
}
