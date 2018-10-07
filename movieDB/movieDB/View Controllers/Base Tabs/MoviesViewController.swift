//
//  FirstViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = NSLocalizedString("Movies", comment: "fasdfasd")
        
        guard let vc1 = ResultViewController.create(targetType: MovieTargetType.popular) else {
            assert(false)
            return
        }
        vc1.title = NSLocalizedString("Popular",comment: "")
        vc1.delegate = self
        
        guard let vc2 = ResultViewController.create(targetType: MovieTargetType.topRated) else {
            assert(false)
            return
        }
        vc2.title = NSLocalizedString("Top Rated",comment: "")
        vc2.delegate = self
        guard let vc3 = ResultViewController.create(targetType: MovieTargetType.upcoming) else {
            assert(false)
            return
        }
        vc3.title = NSLocalizedString("Upcoming",comment: "")
        vc3.delegate = self
        guard let controller = ResultTabBuilder.buildResult(title: NSLocalizedString("Movies", comment: ""), viewControllers: [vc1,vc2,vc3]) else {
            print("no anda nada")
            assert(false)
            return
        }
        
        UIViewController.move(child: controller, to: self, bindingTo: self.view)
    }


}

extension MoviesViewController: ResultViewControllerDelegate {
    func resultViewController(_: ResultViewController, itemSelected: ResultItem) {
        guard let detail = DetailViewController.create(item: itemSelected) else {
            print("error creando detalle")
            assert(false)
            return
        }
        self.present(detail, animated: true, completion: nil)
    }
    
    
}

