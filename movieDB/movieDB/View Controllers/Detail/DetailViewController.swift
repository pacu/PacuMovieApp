//
//  DetailViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var model: ResultItem? {
        didSet {
            if self.viewIfLoaded != nil {
                setup()
            }
        }
    }
    
    static func create(item: ResultItem) -> DetailViewController? {
        let bundle = Bundle(for: DetailViewController.self)
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? DetailViewController else { return nil }
        vc.model = item

        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    public func setup() {
        
        guard let item = self.model else { return }
        
        label.text = item.originalTitle
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
