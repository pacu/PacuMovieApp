//
//  ResultViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ResultViewControllerDelegate {
    func resultViewController(_ :ResultViewController, itemSelected: ResultItem)
}

class ResultViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewDataSource: PagedResultCollectionViewDataSource? {
        didSet {
            if viewIfLoaded != nil {
                self.collectionView.dataSource = self.collectionViewDataSource
            }
        }
    }
    
    var delegate: ResultViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: ResultItemCollectionViewCell.self)
        let nib = UINib(nibName: ResultItemCollectionViewCell._reuseIdentifier, bundle: bundle)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ResultItemCollectionViewCell._reuseIdentifier)
        self.collectionView.dataSource = self.collectionViewDataSource
        collectionViewDataSource?.load()
        
        
    }
    
    public static func create(targetType: TargetType) -> ResultViewController? {
        guard let resultController = ResultViewController.create() else { return nil }
        let dataSource = MovieDbCollectionViewDataSource(targetType: targetType, delegate: resultController)
        resultController.collectionViewDataSource = dataSource
        return resultController
    }
    
    private static func create() -> ResultViewController? {
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

extension ResultViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate,
              let item = collectionViewDataSource?.item(at: indexPath) else { return }
        
        delegate.resultViewController(self, itemSelected: item)
    }
}

extension ResultViewController: ResultDataSourceDelegate {
    
    func willBeginLoading(_ dataSource: ResultDataSource) {
        SVProgressHUD.show()
    }
    
    func didFinishLoading(_ dataSource: ResultDataSource) {
        collectionView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    func didFinishLoadingNoResults(_ dataSource: ResultDataSource) {
        SVProgressHUD.dismiss()
    }
    
    func didFinishLoading(_ dataSource: ResultDataSource, withError: Error?) {
        SVProgressHUD.dismiss()
    }
    
    
}
