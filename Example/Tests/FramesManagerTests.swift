//
//  FramesManagerTests.swift
//  LoadingView
//
//  Created by Igor Kotkovets on 3/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import LoadingView

class FramesManagerTests: XCTestCase {
    var framesManager: FramesManager?
    
    override func setUp() {
        super.setUp()
        framesManager = FramesManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatFramesManagerCountToOne() {
        // given
        let framesManager = FramesManager()
        
        // when
        framesManager.frame()
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
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
