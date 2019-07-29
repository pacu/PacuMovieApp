//
//  movieDBUITests.swift
//  movieDBUITests
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import XCTest

class MovieDBUITests: XCTestCase {
    lazy var app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app.launchArguments = ["useMocks"]
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launch()
 

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainControls() {
        
        let movieTab = app.buttons["Movies"]
        let showsTab = app.buttons["Shows"]
        let topRatedSegment = app.buttons["Top Rated"]
        let upcomingSegment = app.buttons["Upcoming"]
        let popularSegment = app.buttons["Popular"]
        
        
        // all controls are hittable
        XCTAssertTrue(movieTab.isHittable)
        XCTAssertTrue(showsTab.isHittable)
        XCTAssertTrue(topRatedSegment.isHittable)
        XCTAssertTrue(upcomingSegment.isHittable)
        XCTAssertTrue(popularSegment.isHittable)
        
        // on launch first tab should be selected and popular
        // should be the segment selected
        
        XCTAssert(popularSegment.isSelected)
        XCTAssert(movieTab.isSelected)
        
    }

}
