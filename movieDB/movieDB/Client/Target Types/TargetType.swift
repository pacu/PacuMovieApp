//
//  DataConnector.swift
//  movieDB
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation


public protocol TargetType {
    
//    associatedtype ResponseItem: Decodable
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: String{ get }
    
    /// The parameters to be encoded in the request.
    var parameters: [String: Any]? { get }
    
    // mock file name to serve
    var mockFileName: String? { get }
    
    var headers: [String: String]? {get}

}



