//
//  DetailScoreComponent.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import UIKit


class DetailScoreComponent: UIViewController {
    
    @IBOutlet weak var scoreContainer: UIView!
    @IBOutlet weak var userScoreLabel: UILabel!
    var scoreView: ScoreView?
    var score: Float = 0 {
        didSet {
            if viewIfLoaded != nil {
                setUp()
            }
        }
    }
    
    static func create(score: Float) -> DetailScoreComponent? {
        let bundle = Bundle(for: DetailScoreComponent.self)
        let storyboard = UIStoryboard(name: "DetailScoreComponent", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? DetailScoreComponent else { return nil }
        vc.score = score
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initScoreView()
        setUp()
        
    }
    
    private func initScoreView() {
        guard let scoreView = ScoreView.gauge(score: score) else {
            assert(false)
            return
        }
        scoreContainer.addSubview(scoreView)
        scoreView.bindFrameToSuperviewBounds()
        self.scoreView = scoreView
        self.userScoreLabel.text = NSLocalizedString("User Score", comment: "user score")
    }
    private func setUp() {
        scoreView?.score = score
    }
}

