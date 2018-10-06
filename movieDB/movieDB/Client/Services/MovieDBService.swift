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

public typealias ResultBlock =  (_ result: ResultsResponse?, _ error: Error?) -> Void

public protocol MovieDBResultService: class {
    static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) -> Void
}

// TODO: Mockear esta bella API
public class MovieDBResultAPIMock: MovieDBResultService {
    private struct Constants {
        static let popularFile = "popularity_page_1.json"
        static let topRated = "top_rated_page_1.json"
        static let upcoming = "upcoming_page_1.json"
        static let waitTime = 3.0
    }
    
    public static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) -> Void {
        
        guard let name = apiTarget.mockFileName  else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitTime) {
                resultBlock(nil, ResponseError.invalidResponse)
            }
            return
        }
        
        DispatchQueue.global().async {
            guard let response = self.resultFromFile(name: name) else {
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitTime) {
                    resultBlock(nil,ResponseError.invalidResponse)
                }
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitTime) {
                resultBlock(response,nil)
            }
        }
        
    }
    
    private static func resultFromFile(name: String) -> ResultsResponse? {
        guard let path = Bundle.main.path(forResource: name, ofType: nil) else {
            return nil
        }
        let url = URL(fileURLWithPath:  path)
        guard let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(ResultsResponse.self , from: data) else {
                
                return nil
            }
        
        return response
        
    }

}
