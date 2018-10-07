//
//  ImageUtils.swift
//  movieDB
//
//  Created by Francisco Gindre on 7/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import UIKit

public class MovieDbImageURLBuilder {
    
    enum Parameters: String {
        case width = "w"
        case resource = "resource"
    }
    
    private var params = [String:String]()
    
    public init?(resource: String?) {
        guard let r = resource else {
            return nil
        }
        params[Parameters.resource.rawValue] = r
    }
    private func baseURL() -> URL? {
        guard let url = URL(string: AppEnvironment.shared.imageEndpoint) else {
            print("fatal error")
            assert(false)
            return nil
        }
        return url
    }
    
    // evaluate if this could be a class method
    public func original(resource: String) -> URL? {
        return self.baseURL()?.appendingPathComponent("original").appendingPathComponent(resource)
    }
    
    public func add(width: Int) -> MovieDbImageURLBuilder {
        params[Parameters.width.rawValue] = String(describing: width)
        return self
    }
    
    public func build() -> URL? {
        
        guard let width = params[Parameters.width.rawValue],
            let resource = params[Parameters.resource.rawValue] else  {
                print("Insufficient parameters to build url")
                assert(false)
                return nil }
        
        guard let url = baseURL() else { return nil }
        
        return url.appendingPathComponent("w" + width).appendingPathComponent(resource)
        
    }
}

extension UIImage {
    public static func placeholderImage() -> UIImage {
        guard let image = UIImage(named: "icon-img-placeholder") else {
            assert(false)
            return UIImage()
        }
        return image
    }

}
