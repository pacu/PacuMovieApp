//
//  UIViewController+containment.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import UIKit
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
