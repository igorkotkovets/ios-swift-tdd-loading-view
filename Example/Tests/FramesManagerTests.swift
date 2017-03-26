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
    var framesManager: FramesManager!
    var baseDate: Date!
    
    override func setUp() {
        super.setUp()
        framesManager = FramesManager()
        baseDate = Date()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatFramesManagerCountToOne() {
        // given
        let framesManager = FramesManager()
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate!))
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerCountToThree() {
        // given
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        
        // then
        XCTAssertEqual(3, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerResetsCountAfterOneSecond() {
        // given
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        sleep(1);
        framesManager.frame(current: Date().timeIntervalSince(baseDate!))
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerResetsCountToThreeAfterOneSecond() {
        // given
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        sleep(1);
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        
        // then
        XCTAssertEqual(3, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerResetsCountToThreeWithDelaysAfterOneSecond() {
        // given
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 0.3sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 0.6sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 0.9sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 1.2sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 1.5sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(300000) // 1.8sec
        
        // then
        XCTAssertEqual(3, framesManager.getFramesCount())
    }
    
    func testThatShowsCorrectNumberFPS() {
        // given
        
        // when
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(1001000) // 1.1sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        usleep(1001000) // 1.1sec
        framesManager.frame(current: Date().timeIntervalSince(baseDate))
        
        // then
        XCTAssertEqual(2, framesManager.fps())
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
