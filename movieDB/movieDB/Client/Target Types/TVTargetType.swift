//
//  TVTargetType.swift
//  movieDB
//
//  Created by Francisco Gindre on 8/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation

public enum TVTargetType: TargetType, Detailable {
    
    case popular
    case topRated
    case detail(id: Int)
    
    public var path: String {
        get {
            switch self {
            case .popular:
                return "/tv/popular"
            case .topRated:
                return "/tv/top_rated"
            case .detail(let id):
                return "/tv/\(id)"
            }
        }
    }
    public func detailify(id: Int) -> DetailTargetType{
        return TVTargetType.detail(id: id)
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
                return "tv_shows_popularity_page_1.json"
            case .topRated:
                return "tv_shows_top_rated_page_1.json"
            case .detail( _):
                return "venom_detail.json"
            }
        }
    }
}
