//
//  MainScreenController.swift
//  movieDBUITests
//
//  Created by Francisco Gindre on 29/07/2019.
//  Copyright © 2019 Francisco Gindre. All rights reserved.
//

import Foundation
import XCTest

protocol AppController {
    var app: XCUIApplication { get }
}

protocol MainScreenController: AppController {
    
    func tapMoviesTab()
    func tapShowsTab()
    
}

extension MainScreenController {
    
    func tapMoviesTab() {
        app.buttons["Movies"].tap()
    }
    
    func tapShowsTab() {
        app.buttons["Shows"].tap()
    }
    
}
