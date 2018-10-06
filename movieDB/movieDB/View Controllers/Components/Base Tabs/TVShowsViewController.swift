//
//  SecondViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("TV Shows", comment: "")
        
        
        let vc1 = UIViewController()
        vc1.title = "title 1"
        vc1.view.backgroundColor = UIColor.red
        
        let vc2 = UIViewController()
        vc2.title = "title 2"
        vc2.view.backgroundColor = UIColor.green
        
        let vc3 = UIViewController()
        vc3.title = "title 3"
        vc3.view.backgroundColor = UIColor.blue
        guard let controller = ResultTabBuilder.buildResult(title: NSLocalizedString("TV Shows", comment: ""), viewControllers: [vc1,vc2,vc3]) else {
            print("no anda nada")
            return
        }
        controller.willMove(toParent: self)
        self.view.addSubview(controller.view)
        self.addChild(controller)
        controller.didMove(toParent: self)
        
    }
    
    

}

