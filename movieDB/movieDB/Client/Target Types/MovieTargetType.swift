//
//  MovieTargetType.swift
//  movieDB
//
//  Created by Francisco Gindre on 8/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation

public enum MovieTargetType: TargetType, Detailable {
    
    case popular
    case topRated
    case upcoming
    case detail(id: Int)
    
    public func detailify(id: Int) -> DetailTargetType {
        return MovieTargetType.detail(id: id)
    }
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/movie/popular"
            case .topRated:
                return "/movie/top_rated"
            case .upcoming:
                return "/movie/upcoming"
            case .detail(let id):
                return "/movie/\(id)"
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
            case .detail( _):
                return "venom_detail.json"
            }
        }
    }
    
}
