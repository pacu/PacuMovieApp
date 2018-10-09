//
//  MovieDBTargetType.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation


extension TargetType {
    public var baseURL: URL { get {
        return URL(string: "https://api.themoviedb.org/3")!
        }
    }
}

public typealias DetailTargetType = TargetType & Detailable

public protocol Detailable {
    func detailify(id: Int) -> DetailTargetType
}

// Movie DB API v3 does not use other headers than this.
extension TargetType {

   public var headers: [String : String]? {
        return [ "Content-Type" : "application/json;charset=utf-8" ]
    }
}

extension AppEnvironment {
    func defaultParameters() -> [String:String] {
            return ["api_key" : self.apikey,
             "language": self.language]
    }
}
