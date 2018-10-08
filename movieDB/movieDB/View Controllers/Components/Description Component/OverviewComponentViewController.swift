//
//  OverviewComponentViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit


class OverviewComponentViewController: UIViewController {
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var content: String = "" {
        didSet {
            if viewIfLoaded != nil {
                setUp()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    

    private func setUp(){
        overviewLabel.text = NSLocalizedString("Overview", comment: "overview")
        descriptionLabel.text = content
    }
   
    
    static func create(description: String) -> OverviewComponentViewController? {
        let bundle = Bundle(for: OverviewComponentViewController.self)
        let storyboard = UIStoryboard(name: "OverviewComponentViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? OverviewComponentViewController else { return nil }
        vc.content = description
        
        return vc
    }
    
}
