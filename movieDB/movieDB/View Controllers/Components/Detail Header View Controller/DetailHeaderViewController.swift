//
//  DetailHeaderViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import SDWebImage


struct DetailHeaderViewModel {
    var title: String
    var year: String
    var backdropURL: URL?
    var posterURL: URL?
    
    init(detail: ItemDetail) {
        
        title = detail.genericName ?? ""
        
        if let year = detail.year {
            self.year = "(\(year))"
        } else {
            self.year = ""
        }
        
        backdropURL = MovieDbImageURLBuilder.init(resource: detail.backdropPath)?.add(width: 500).build()
        posterURL = MovieDbImageURLBuilder.init(resource: detail.posterPath)?.add(width: 154).build()
        
    }
    
    
}
class DetailHeaderViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var model: DetailHeaderViewModel? {
        didSet {
            if viewIfLoaded != nil {
                setUp()
            }
        }
    }
    
    private func setUp() {
        
        guard let detail = self.model else { return }
        
        self.backdropImageView?.sd_setImage(with: detail.backdropURL, placeholderImage: UIImage.placeholderImage())
        self.posterImageView?.sd_setImage(with: detail.posterURL, placeholderImage: UIImage.placeholderImage())
        self.titleLabel.text = detail.title
        self.yearLabel.text = detail.year
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    static func create() -> DetailHeaderViewController? {
        let bundle = Bundle(for: DetailHeaderViewController.self)
        let storyboard = UIStoryboard(name: "DetailHeaderViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? DetailHeaderViewController else { return nil }
        return vc
    }

}
