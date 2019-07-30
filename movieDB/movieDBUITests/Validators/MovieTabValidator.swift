//
//  MovieTabValidator.swift
//  movieDBUITests
//
//  Created by Francisco Gindre on 29/07/2019.
//  Copyright © 2019 Francisco Gindre. All rights reserved.
//

import Foundation
import XCTest
struct MovieTabValidator {
    
    static func validateSegments(app: XCUIApplication) {
        let topRatedSegment = app.buttons["Top Rated"]
        let upcomingSegment = app.buttons["Upcoming"]
        let popularSegment = app.buttons["Popular"]
        
        XCTAssertTrue(topRatedSegment.isHittable)
        XCTAssertTrue(upcomingSegment.isHittable)
        XCTAssertTrue(popularSegment.isHittable)
    }
    
    static func validatePopularSegment(isSelected: Bool, on app: XCUIApplication){
        
        let popularSegment = app.buttons["Popular"]
        XCTAssert(popularSegment.isSelected == isSelected)
    }
}
