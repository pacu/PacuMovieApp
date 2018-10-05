//
//  AppEnvironment.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation

enum EnvironmentError: Error {
    case unavaliableConfigFile
}

/**
 Application Environment: A Proxy class for common values
- Current Locale
- ApiKey
 */
class AppEnvironment {
    
    
    private struct Constants {
        static let configFileName = "dontCommitThis"
    }
    
    public private(set) var apikey: String = ""
    
    
    public var language: String {
        get {
            return NSLocale.current.identifier
        }
    }
    
    public static let shared =  AppEnvironment()
    
    private init() {
        
        if let path = Bundle.main.path(forResource: Constants.configFileName, ofType: "plist"),
            let myDict = NSDictionary(contentsOfFile: path), let key = myDict["apikey"] as? String  {
            self.apikey = key
        }
        
    }
    
    //Todo: remove repeated code
    @discardableResult static func isEnvironmentAvailable() throws -> Bool {
        guard let path = Bundle.main.path(forResource: Constants.configFileName, ofType: "plist"),
            let myDict = NSDictionary(contentsOfFile: path),  let _ = myDict["apikey"] as? String  else {
                throw EnvironmentError.unavaliableConfigFile
        }
        
        return true
    }
        
    
}
