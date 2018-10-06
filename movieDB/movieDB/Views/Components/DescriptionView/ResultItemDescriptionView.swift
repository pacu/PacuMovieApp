//
//  ResultItemDescriptionView.swift
//  movieDB
//
//  Created by Francisco Gindre on 6/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import GaugeKit

struct ResultItemDescriptionViewModel {
    var title: String
    var releaseDate: Date?
    var rating: Float?
}

public protocol Reusable {
    func prepareForReuse()
}
class ResultItemDescriptionView: UIView, Reusable{
    
    
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
            title.text = Date.localizedDate(date: date)
        } else {
            title.text = nil
        }
    }
    
    func set(rating: Float) {
        
    }
    
    func prepareForReuse() {
        
        title.text = nil
        releaseDate.text = nil
        
    }
}


