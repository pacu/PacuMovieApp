//
//  ScoreView.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import GaugeKit

enum Score {
    case none
    case low
    case medium
    case high
    
    var color: UIColor {
        switch self {
        case .low:
            return Colors.red
        case .medium:
            return Colors.yellow
        case .high:
            return Colors.green
        case .none:
            return UIColor.clear
        }
    }
    
    var range: Range<Float> {
        switch self {
        case .low,
             .none:
            return (0.0..<0.4)
        case .medium:
            return (0.4..<0.7)
        case .high:
            return (0.7..<1)
        }
    }
    
    static func from(float: Float) -> Score {
        
        switch float {
        case let s where Score.low.range.contains(s):
            return Score.low
        case let s where s < Score.low.range.lowerBound:
            return Score.low
        case let s where Score.medium.range.contains(s):
            return Score.medium
        case let s where Score.high.range.contains(s):
            return Score.high
        case let s where s > Score.high.range.upperBound:
            return Score.high
            
        default:
            return Score.none
        }
    }

}

enum BackgroundType {
    case light
    case dark
    
}
class ScoreView: UIView, XibInstantiable {

    @IBOutlet weak var gauge: Gauge!
    @IBOutlet weak var label: UILabel!
    var backgroundType = BackgroundType.dark
    var score: Float = 0 {
        didSet {
            label.isHidden = true
            setUI(score: Score.from(float: score))
        }
    }
    
    
    // expects Float from 0 to 1
    static func gauge(score: Float) -> ScoreView? {
        
        guard let gauge = ScoreView.loadFromNib() else {
            return nil
        }
        gauge.score = score
        return gauge
    }
    
    private func setUI(score: Score) {
        
        let color = score.color
        self.gauge.startColor = color
        self.gauge.endColor = color
        self.gauge.bgColor = color
        switch backgroundType {
        case .light:
            self.label.textColor = Colors.darkGray
        case .dark:
            self.label.textColor = UIColor.white
        }
        self.label.text = String(describing: Int(self.score*100))
        self.gauge.animateRate(0.3, newValue:CGFloat(self.score), completion: {_ in
            self.label.isHidden = false
        })
    }

}
