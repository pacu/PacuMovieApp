//
//  MovieDBService.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation


public enum ResponseError: Error {
     case invalidResponse
}

public typealias ResultBlock =  (_ result: ResultsResponse?, _ error: Error?, _ request: URLRequest?) -> Void
public typealias DetailBlock =  (_ detail: ItemDetail?, _ error: Error?) -> Void

public protocol MovieDBResultService: class {
    static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) -> Void
    static func fetchDetail(id: Int?, apiTarget: TargetType, resultBlock: @escaping DetailBlock) -> Void
}

public class MovieDBResultAPI: MovieDBResultService {
    
    public static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) {
        NetworkConnector.performRequest(responseType: ResultsResponse.self ,target: apiTarget) { (result, error,request) in
            resultBlock(result,error, request)
        }
    }
    
    public static func fetchDetail(id: Int?, apiTarget: TargetType, resultBlock: @escaping DetailBlock) {
        NetworkConnector.performRequest(responseType: ItemDetail.self, target: apiTarget) { (detail, error, request) in
            resultBlock(detail,error)
        }
    }
}
