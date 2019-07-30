//
//  DetailViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit
import SVProgressHUD
class DetailViewController: UIViewController {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var scoreContainerView: UIView!
    @IBOutlet weak var overviewContainerView: UIView!
    
    private var headerController: DetailHeaderViewController?
    private var scoreController: DetailScoreComponent?
    private var overviewController: OverviewComponentViewController?
    private var service: MovieDBResultService.Type = AppEnvironment.shared.useMocks ? MovieDBResultAPIMock.self :  MovieDBResultAPI.self
    var targetType: TargetType?
    var id: Int? {
        didSet {
            if self.viewIfLoaded != nil{
                loadDetail()
            }
        }
    }
    var model: ItemDetail? {
        didSet {
            if self.viewIfLoaded != nil {
                setup()
            }
        }
    }
    
    static func create(item id: Int, targetType: DetailTargetType) -> DetailViewController? {
        let bundle = Bundle(for: DetailViewController.self)
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? DetailViewController else {
            assert(false)
            return nil
        }
        vc.targetType = targetType
        vc.id = id
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        SVProgressHUD.show()
        
        initHeader()
        initScore()
        initDescription()
        loadDetail()
    }
    
    private func fail() {
        
        SVProgressHUD.dismiss()
        assert(false)
        self.dismiss(animated: true, completion: {
            //TODO: SHOW ALERT
        })
    }
    
    private func loadDetail() {
        guard let targetType = self.targetType,
              let id = self.id else { return }
        service.fetchDetail(id: id, apiTarget: targetType) { [weak self] (detail, error) in
            guard let `self` = self else { return }
            guard error == nil else {
                self.fail()
                return
            }
            
            guard let detail = detail else {
                self.fail()
                return
            }
            
            self.model = detail
            SVProgressHUD.dismiss()
        }
    }
    private func initHeader(){
        
        guard let header = DetailHeaderViewController.create() else {
            assert(false)
            return
        }
        
        UIViewController.move(child: header, to: self, bindingTo: headerContainerView)
        self.headerController = header;
        
    }
    
    private func initScore() {
        
        guard let score = DetailScoreComponent.create(score: model?.score() ?? Float(0)) else {
            assert(false)
            return
        }
        UIViewController.move(child: score, to: self, bindingTo: scoreContainerView)
        self.scoreController = score
    }
    
    func initDescription() {
        guard let overview = OverviewComponentViewController.create(description: model?.overview ?? "") else {
            assert(false)
            return
        }
        
        UIViewController.move(child: overview, to: self, bindingTo: overviewContainerView)
        self.overviewController = overview
    }
    
    public func setup() {
        
        guard let item = self.model else {
            assert(false)
            return }
       
        
        headerController?.model = DetailHeaderViewModel(detail: item)
        
        if let score = item.score() {
            scoreContainerView.isHidden = false
            scoreController?.score = score
        } else {
            scoreContainerView.isHidden = true
        }
        
        if let overviewController = self.overviewController{
            overviewController.content = item.overview ?? NSLocalizedString("No Overview Available", comment: "")
        }
        
        self.view.setNeedsLayout()
        
    }
    
    @objc public func done () {
        self.dismiss(animated: true, completion: nil)
    }
 

}

extension ItemDetail {
    func score() -> Float? {
        guard let vote = self.voteAverage else {
            return nil
        }
        return vote/10
    }
    
}
