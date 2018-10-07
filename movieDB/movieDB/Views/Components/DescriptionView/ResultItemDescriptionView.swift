//
//  ResultItemDescriptionView.swift
//  movieDB
//
//  Created by Francisco Gindre on 6/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import GaugeKit
import SDWebImage

protocol ResultItemDescriptionViewModel {
    var title: String { get set }
    var releaseDate: Date? { get set }
    var rating: Float? { get set }
    init?(item: ResultItem)
}


struct ResultItemViewModelBuilder {
    static func buildFrom(item: ResultItem) -> ResultItemDescriptionViewModel? {
        if item.firstAirDate != nil {
            return TVShowItemDescriptionViewModel(item: item)
        }
        
        return MovieItemDescriptionViewModel(item: item)
    }
}

struct MovieItemDescriptionViewModel: ResultItemDescriptionViewModel{
    var title: String
    var releaseDate: Date?
    var rating: Float?
    
    
    init?(item: ResultItem) {
        guard let title = item.title else { return nil }
        
        self.title = title
        let formatter = DateFormatter.moviedb_formatter()
        if let stringDate = item.releaseDate,
            let date = formatter.date(from: stringDate) {
            releaseDate = date
        }
        
        rating = item.voteAverage
        
    }
    
   
}

struct TVShowItemDescriptionViewModel: ResultItemDescriptionViewModel{
    var title: String
    var releaseDate: Date?
    var rating: Float?
    
    
    init?(item: ResultItem) {
        guard let title = item.name else { return nil }
        
        self.title = title
        let formatter = DateFormatter.moviedb_formatter()
        if let stringDate = item.firstAirDate,
            let date = formatter.date(from: stringDate) {
            releaseDate = date
        }
        
        rating = item.voteAverage
        
    }
    
    
}

public protocol Reusable {
    func prepareForReuse()
}

class ResultItemDescriptionView: UIView, Reusable, XibInstantiable {
    
    @IBOutlet weak var gaugeContainer: UIView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var gauge: Gauge!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    func setup(model: ResultItemDescriptionViewModel) {
        
        self.title.text = model.title
        if let rating = model.rating {
            gaugeContainer.isHidden = false
            set(rating: rating)
        } else {
            gaugeContainer.isHidden = true
        }
        
        if let date = model.releaseDate {
            releaseDate.text = Date.localizedDate(date: date)
        } else {
            releaseDate.text = nil
        }
    }
    
    func set(rating: Float) {
        gauge.animateRate(0.4, newValue: CGFloat(rating), completion: {_ in })
    }
    
    func prepareForReuse() {
        
        title.text = nil
        releaseDate.text = nil
        gauge.rate = CGFloat(0)
        
    }
}


