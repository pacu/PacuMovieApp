//
//  SegmentViewController.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import UIKit


/**
 if there was no previous selection, previous value will be UISegmentedControl.noSegment
 */

protocol SegmentViewDelegate: class {
    func segmentSelected(at index: Int, previous: Int)
}

/**
 A Segmented control wrappper.
 Provides knowledge of previous and current selection for visual purposes.
 */
class SegmentViewController: UIViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    private var previousSegment: Int = UISegmentedControl.noSegment
    private var currentSegment: Int = UISegmentedControl.noSegment
    weak var delegate: SegmentViewDelegate?
    
    var segments: [String]? {
        didSet {
            if self.view != nil {
               reloadSegments()
            }
        }
    }

    private func reloadSegments() {
        guard let segments = segments else { return }
        segmentView.removeAllSegments()
        for index in 0..<segments.count {
            segmentView.insertSegment(withTitle: segments[index], at: index, animated: false)
        }
        segmentView.selectedSegmentIndex = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reloadSegments()
        
    }
    
    public static func createSegmentController(segments: [String], delegate: SegmentViewDelegate) -> SegmentViewController? {
        let bundle = Bundle(for: SegmentViewController.self)
        let storyboard = UIStoryboard(name: "SegmentViewController", bundle: bundle)
        guard let vc = storyboard.instantiateInitialViewController() as? SegmentViewController else { return nil }
        
        vc.segments = segments
        return vc
    }
    
    // MARK - IBAction
    
    @IBAction func valueChanged(_ sender: Any) {
        self.previousSegment = self.currentSegment
        self.currentSegment = self.segmentView.selectedSegmentIndex
        delegate?.segmentSelected(at: self.currentSegment, previous: self.previousSegment)
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
