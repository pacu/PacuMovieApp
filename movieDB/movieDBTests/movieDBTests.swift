//
//  movieDBTests.swift
//  movieDBTests
//
//  Created by Francisco Gindre on 4/10/18.
//  Copyright © 2018 Francisco Gindre. All rights reserved.
//

import XCTest
@testable import movieDB

class movieDBTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiMock() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = XCTestExpectation()
        
        MovieDBResultAPIMock.fetchResult(apiTarget: MovieTargetType.popular, page: nil) { (result, error) in
            
            if let e = error {
                
                XCTFail("error \(e)")
                
            } else {
                XCTAssert(result != nil)
                print(result!)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 3)
    }



}
