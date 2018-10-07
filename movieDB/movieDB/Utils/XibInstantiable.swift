//
//  NibLoading.swift
//  DespegarUIKit
//
//  Created by Francisco Gindre on 23/03/2018.
//

import Foundation
import UIKit
public protocol XibInstantiable { }

public extension XibInstantiable where Self: UIView {
    
    /// Returns a UIView from nib with the same name as the class
    static func loadFromNib() -> Self? {
        let className = String(describing: self)
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: className, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            return nil
        }
        return view
    }
    
    
}
