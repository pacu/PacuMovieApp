//
//  ResultItemCollectionViewCell.swift
//  movieDB
//
//  Created by Francisco Gindre on 6/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import SDWebImage
class ResultItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    var descriptionView: ResultItemDescriptionView!
    
    
    static let _reuseIdentifier = "ResultItemCollectionViewCell"
    var model: ResultItem?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setUp(model: nil)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let descriptionView = ResultItemDescriptionView.loadFromNib() else {
            assert(false)
            return
        }
        
        self.descriptionView = descriptionView
        descriptionContainer.addSubview(descriptionView)
        descriptionView.bindFrameToSuperviewBounds()
        
        self.layer.addShadow()

    }
    private func showDescription() {
        self.descriptionHeight.constant = 50
    }
    
    private func hideDescription() {
        self.descriptionHeight.constant = 0
    }
    
    func setUp(model: ResultItem?) {
        
        if let m = model {
            
            let resource = MovieDbImageURLBuilder(resource: m.posterPath)?.add(width: 500).build()
            self.imageView?.sd_setImage(with: resource, placeholderImage: UIImage.placeholderImage())
            
            if let descriptionModel = ResultItemViewModelBuilder.buildFrom(item: m) {
                showDescription()
                descriptionView.setup(model: descriptionModel)
            } else {
                hideDescription()
                descriptionContainer.isHidden = true
            }
        } else {
            imageView.image = nil
            if let reusableView = descriptionView {
                reusableView.prepareForReuse()
            }
        }
        
    }
}
