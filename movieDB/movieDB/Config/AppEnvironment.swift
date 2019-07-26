//
//  AppEnvironment.swift
//  movieDB
//
//  Created by Francisco Gindre on 5/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import Foundation
import UIKit
enum EnvironmentError: Error {
    case unavaliableConfigFile
    case apikeyMissing
}

/**
 Application Environment: A Proxy class for common values
- Current Locale
- ApiKey
 */
class AppEnvironment {
    
    private struct Constants {
        static let configFileName = "dontCommitThis"
        static let imageEndpoint = "https://image.tmdb.org/t/p/"
    }
    
    public private(set) var apikey: String = ""
    
    public var language: String {
        return NSLocale.current.identifier
    }
    
    public var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // TODO: obtain real url from https://developers.themoviedb.org/3/configuration/get-api-configuration
    public var imageEndpoint:String {
        return Constants.imageEndpoint
    }
    
    public var locale: Locale {
        return NSLocale.current
    }
    
    // Fail if no app environment
    public static let shared =  try! AppEnvironment()
    
    fileprivate static func getApikey() throws -> String  {
        guard let path = Bundle.main.path(forResource: Constants.configFileName, ofType: "plist") else {
            throw EnvironmentError.unavaliableConfigFile
        }
        guard let myDict = NSDictionary(contentsOfFile: path) else {
            throw EnvironmentError.unavaliableConfigFile
        }

        guard let apikey = myDict["apikey"] as? String else {
            throw EnvironmentError.apikeyMissing
        }
        return apikey
    }
    
    private init() throws {
        self.apikey = try AppEnvironment.getApikey()
    }
    
    func isEnvironmentAvailable() -> Bool {
       return apikey != ""
    }
}
