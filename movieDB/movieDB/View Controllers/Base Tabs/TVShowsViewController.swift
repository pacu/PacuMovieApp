//
//  SecondViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController, ResultViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("TV Shows", comment: "fasdfasd")
        
        guard let vc1 = ResultViewController.create(targetType: TVTargetType.popular) else {
            assert(false)
            return
        }
        vc1.title = NSLocalizedString("Popular",comment: "")
        vc1.delegate = self
        
        guard let vc2 = ResultViewController.create(targetType: TVTargetType.topRated) else {
            assert(false)
            return
        }
        vc2.title = NSLocalizedString("Top Rated",comment: "")
        vc2.delegate = self
        
        guard let controller = ResultTabBuilder.buildResult(title: NSLocalizedString("TV Shows", comment: ""), viewControllers: [vc1,vc2]) else {
            print("no anda nada")
            assert(false)
            return
        }
        
        UIViewController.move(child: controller, to: self, bindingTo: self.view)
    }
}
