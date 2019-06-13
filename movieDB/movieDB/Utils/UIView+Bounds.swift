//
//  UIView+Bounds.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre.
//

import Foundation
import UIKit

public extension UIView {
    
    
    func bindFrameToSuperviewBounds() {
        
        bindFrameHorizontalToSuperviewBounds()
        bindFrameVerticalToSuperviewBounds()
        
    }

    func bindFrameHorizontalToSuperviewBounds() {
        bindFrameHorizontalToSuperviewBounds(0, right: 0)
    }
    
    
    func bindFrameHorizontalToSuperviewBounds(_ right:CGFloat) {
        bindFrameHorizontalToSuperviewBounds(0, right: right)
    }
    
    
    func bindFrameHorizontalToSuperviewBounds(left:CGFloat) {
        bindFrameHorizontalToSuperviewBounds(left, right: 0)
    }
    
    
    func bindFrameHorizontalToSuperviewBounds(_ left:CGFloat, right:CGFloat) {
        guard superview != nil else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[self]-(right)-|", options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["left": left, "right": right],
                                                                   views: ["self": self]))
    }
    
    /// Este método alinea la view a la super view verticalmente. Tener en cuenta que este metodo no limpia las contraints de la view
     func bindFrameVerticalToSuperviewBounds() {
        bindFrameVerticalToSuperviewBounds(0, down: 0)
    }
    
    /// Este método alinea la view a la super view verticalmente dejando de margen hacia abajo el valor que se le parametriza. Tener en cuenta que este metodo no limpia las contraints de la view
     func bindFrameVerticalToSuperviewBounds(_ down:CGFloat) {
        bindFrameVerticalToSuperviewBounds(0, down: down)
    }
    
    /// Este método alinea la view a la super view verticalmente dejando de margen hacia arriba el valor que se le parametriza. Tener en cuenta que este metodo no limpia las contraints de la view
     func bindFrameVerticalToSuperviewBounds(up:CGFloat) {
        bindFrameVerticalToSuperviewBounds(up, down: 0)
    }
    
    /// Este método alinea la view a la super view verticalmente dejando de margen hacia arriba y abajo los valor que se le parametrizan. Tener en cuenta que este metodo no limpia las contraints de la view
     func bindFrameVerticalToSuperviewBounds(_ up:CGFloat, down:CGFloat) {
        guard superview != nil else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(up)-[self]-(down)-|", options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: ["up": up, "down": down],
                                                                   views: ["self": self]))
    }
    
    /// Este método centra la view en funcion de la super view verticalmente. Tener en cuenta que este metodo no limpia las contraints de la view
     func centerVerticalToSuperviewBounds() {
        
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: .centerY,
                           multiplier: 1, constant: 0).isActive = true
        
    }
    
    /// Este método centra la view en funcion de la super view horizontalmente. Tener en cuenta que este metodo no limpia las contraints de la view
     func centerHorizontalToSuperviewBounds() {
        
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: .centerX,
                           multiplier: 1, constant: 0).isActive = true
        
    }
    
     func bindFrameToSuperviewTopMargin() {
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .topMargin,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: .top,
                           multiplier: 1, constant: 0).isActive = true
        
    }
    
     func bindFrameToSuperviewBottomMargin(){
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .bottomMargin,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: .bottom,
                           multiplier: 1, constant: 0).isActive = true
        
    }
    
     func constrainTo(height: CGFloat){
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
    }
    
     func constrainTo(width: CGFloat){
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
    
}

