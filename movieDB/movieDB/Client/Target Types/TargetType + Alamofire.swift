//
//  TargetType + Alamofire.swift
//  movieDB
//
//  Created by Francisco Gindre on 8/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import Alamofire


class NetworkConnector {
    
    static func performRequest<T: Decodable>(responseType: T.Type, target: TargetType, responseBlock: @escaping (_ response: T?, _ error: Error?, _ Request: URLRequest?) ->()) {
        
        target.request.validate(statusCode: 200..<300).responseDecodable {
            (r:DataResponse<T>) in
            
            switch r.result {
            case .success(let value):
                responseBlock(value, nil,r.request)
                return
            case .failure(let error):
                responseBlock(nil, error,r.request)
            }
            
        }
        
    }
}


extension TargetType {
    
    var request: DataRequest {
        return Alamofire.request(self.url, method: HTTPMethod.init(rawValue: self.method) ?? .get, parameters: self.af_parameters, encoding: URLEncoding.default, headers: self.af_headers)
    }

    var af_parameters: Parameters? {
        return self.parameters
    }
    var af_headers: HTTPHeaders? {
        return self.headers
    }
    var url: URL {
        return self.baseURL.appendingPathComponent(self.path)
    }
}

extension DataRequest {
    
    private func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
}
