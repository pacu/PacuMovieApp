//
//  ResultViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var segmentViewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var collectionViewDataSource: UICollectionViewDataSource? {
        didSet {
            if viewIfLoaded != nil {
                self.collectionView.dataSource = self.collectionViewDataSource
            }
        }
    }
    var collectionViewDelegate: UICollectionViewDelegate? {
        didSet {
            if viewIfLoaded != nil {
                self.collectionView.delegate = self.collectionViewDelegate
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    public static func create(datasource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) -> ResultViewController? {
        let bundle = Bundle(for: ResultViewController.self)
        let storyboard = UIStoryboard(name: "ResultViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? ResultViewController else { return nil }
        
        return vc
        
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


