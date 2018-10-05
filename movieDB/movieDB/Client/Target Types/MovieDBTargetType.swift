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

public enum MovieTargetType: TargetType {
    
    
    
    case popular
    case topRated
    case upcoming
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/movie/popular"
            case .topRated:
                return "/movie/top_rated"
            case .upcoming:
                return "/movie/upcoming"
            }
        }
    }
    
   public var method: String {
        get {
            return "GET"
        }
    }
    public var parameters: [String : Any]? {
        get {
            return AppEnvironment.shared.defaultParameters()
        }
    }
    
    public var mockFileName: String? {
        get {
            switch self {
            case .popular:
                return "popularity_page_1.json"
            case .topRated:
                return "top_rated_page_1.json"
            case .upcoming:
                return "upcoming_page_1.json"
            }
        }
    }
    
}

public enum TVTargetType: TargetType {
    
    case popular
    case topRated
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/tv/popular"
            case .topRated:
                return "/tv/top_rated"
            
            }
        }
    }
    
    public var method: String {
        get {
            return "GET"
        }
    }
    public var parameters: [String : Any]? {
        get {
            return AppEnvironment.shared.defaultParameters()
        }
    }
    
    public var mockFileName: String? {
        get {
            return nil
        }
    }
}


extension AppEnvironment {
    func defaultParameters() -> [String:String] {
            return ["apikey" : self.apikey,
             "language": self.apikey]
    }
}
