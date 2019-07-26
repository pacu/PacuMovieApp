//
//  MovieDBServiceMocks.swift
//  movieDB
//
//  Created by Francisco Gindre on 8/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation



public class MovieDBResultAPIMock: MovieDBResultService {
    private struct Constants {
        
        static let waitTime = 3.0
    }
    
    public static func fetchResult(apiTarget: TargetType, page: Int?, resultBlock: @escaping ResultBlock) -> Void {
        
        guard let target = apiTarget as? Mockable, let name = target.mockFileName  else {
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
    
    
    public static func fetchDetail(id: Int?, apiTarget: TargetType, resultBlock: @escaping DetailBlock) -> Void {
        guard let target = apiTarget as? Mockable, let name = target.mockFileName  else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.waitTime) {
                resultBlock(nil, ResponseError.invalidResponse)
            }
            return
        }
        
        DispatchQueue.global().async {
            guard let response = self.detailFromFile(name: name) else {
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
    
    private static func detailFromFile(name: String) -> ItemDetail? {
        guard let path = Bundle.main.path(forResource: name, ofType: nil) else {
            return nil
        }
        let url = URL(fileURLWithPath:  path)
        guard let data = try? Data(contentsOf: url) else {
            
            return nil
        }
        do {
            return try JSONDecoder().decode(ItemDetail.self , from: data)
        } catch let error  {
            print(error)
            assert(false)
        }
        return nil
        
    }
    
}
