//
//  ViewComputationsTests.swift
//  LoadingView
//
//  Created by Igor Kotkovets on 3/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import LoadingView

class ViewComputationsTests: XCTestCase {
    private var viewComputations: ViewComputations?
    
    override func setUp() {
        super.setUp()
        
        viewComputations = ViewComputations()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
