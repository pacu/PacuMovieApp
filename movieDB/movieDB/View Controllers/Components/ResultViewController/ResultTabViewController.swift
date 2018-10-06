//
//  ResultTabViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit

class ResultTabViewController: UIViewController {
    
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var resultContainer: UIView!
    
    // this could be generalized too but I consider it innecessary for now
    var segmentViewController: SegmentViewController?
    var resultViewControllers: [UIViewController]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializeSegments()
        loadController(at: 0)
        
    }
    
    private func initializeSegments() {
        guard let controller = self.segmentViewController else { return }
        UIViewController.move(child: controller, to: self, bindingTo: headerContainer)
        
    }
    
    fileprivate func loadController(at index:Int) {
        guard valid(index: index), let controllers = resultViewControllers else {
            return
        }
        
        let controller = controllers[index]
        UIViewController.move(child: controller, to: self, bindingTo: resultContainer)
        
    }
    
    fileprivate func valid(index:Int) -> Bool{
        guard let controllers = resultViewControllers else { return false }
        return (0..<controllers.count).contains(index)
    }
    
    fileprivate func removeFromParent(at index:Int) {
        guard valid(index:index),
              let controllers = resultViewControllers
               else { return }
        
        let controller = controllers[index]
        UIViewController.remove(child: controller)
     
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


extension UIViewController {
    static func move(child: UIViewController, to parent: UIViewController, bindingTo parentContainerView: UIView) {
        child.willMove(toParent: parent)
        parentContainerView.addSubview(child.view)
        parent.addChild(child)
        child.didMove(toParent: parent)
        child.view.bindFrameToSuperviewBounds()
    }
    
    static func remove(child: UIViewController) {
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
extension ResultTabViewController: SegmentViewDelegate {
    func segmentSelected(at index: Int, previous: Int) {
        
        guard valid(index: index),
            valid(index: previous) else { return }
        
        removeFromParent(at: previous)
        loadController(at: index)
        
    }
}




public struct ResultTabBuilder {
    
    
    static func buildResult(title: String, viewControllers: [UIViewController]) -> ResultTabViewController? {
        
        let bundle = Bundle(for: ResultViewController.self)
        let storyboard = UIStoryboard(name: "ResultTabViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? ResultTabViewController else {
            return nil
        }
        
        vc.resultViewControllers = viewControllers
        
        vc.segmentViewController = SegmentViewController.createSegmentController(segments: viewControllers.map { $0.title ?? "" }, delegate: vc)
        vc.segmentViewController?.delegate = vc
        return vc
        
    }
}
