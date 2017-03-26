//
//  FramesManagerTests.swift
//  LoadingView
//
//  Created by Igor Kotkovets on 3/23/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import LoadingView


class FakeTimestampProvider: TimestampProvider {
    private var _timestamp: TimeInterval = 0.0

    func add(_ offset: TimeInterval) {
        _timestamp += offset
    }

    // MARK: TimestampProvider
    func timestamp() -> TimeInterval {
        return _timestamp
    }
}


class FakeTimestampProviderTests: XCTestCase {
    var timestampProvider: FakeTimestampProvider!
    
    override func setUp() {
        super.setUp()
        timestampProvider = FakeTimestampProvider()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatReturnsOneSecond() {
        // given
        
        // when
        timestampProvider.add(1.0)
        
        // then
        XCTAssertEqual(1.0, timestampProvider.timestamp())
    }
    
    func testThatReturnsElapsedTime() {
        // given
        
        // when
        timestampProvider.add(0.5)
        timestampProvider.add(1.0)
        
        // then
        XCTAssertEqual(1.5, timestampProvider.timestamp())
    }
}


class FramesManagerTests: XCTestCase {
    var framesManager: FramesManager!
    var timestampProvider: FakeTimestampProvider!
    
    override func setUp() {
        super.setUp()
        timestampProvider = FakeTimestampProvider()
        framesManager = FramesManager(timestampProvider)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatFramesManagerResetsCountAfterOneSecond() {
        // given
        
        // when
        framesManager.frame()
        timestampProvider.add(0.03)
        framesManager.frame()
        timestampProvider.add(0.03)
        framesManager.frame()
        timestampProvider.add(1.0)
        framesManager.frame()
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerResetsCountToThreeWithDelaysAfterOneSecond() {
        // given
        
        // when
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        
        // then
        XCTAssertEqual(3, framesManager.getFramesCount())
    }
    
    func testThatShowsCorrectNumberFPS() {
        // given
        
        // when
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        timestampProvider.add(0.3)
        framesManager.frame()
        
        // then
        XCTAssertEqual(3, framesManager.fps())
    }
    
    func testThatFrameSkipped() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        timestampProvider.add(1.0/FramesManager.maxFps)
        framesManager.frame()
        
        // then
        XCTAssertEqual(false, framesManager.canGo())
    }
    
    func testThatFramesManagerMonitorsFramesProgress() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        timestampProvider.add(1.0/FramesManager.maxFps+0.001)
        framesManager.frame()
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerFramesManagerIsAwareOfFramesPassed() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        timestampProvider.add(1.0/FramesManager.maxFps+0.001)
        framesManager.frame()
        timestampProvider.add(1.0/FramesManager.maxFps+0.001)
        framesManager.frame()
        timestampProvider.add(1.0/FramesManager.maxFps+0.001)
        framesManager.frame()
        
        // then
        XCTAssertEqual(3, framesManager.getFramesCount())
    }
    
    func testThatFramesManagerResetsFramesAfterOneSecond() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        for _ in 0..<3 {
            timestampProvider.add(1.0/FramesManager.maxFps+0.001)
            framesManager.frame()
        }
        timestampProvider.add(1.001)
        framesManager.frame()
        
        // then
        XCTAssertEqual(1, framesManager.getFramesCount())
    }
    
    func testThatShowsFpsAfterOneSecond() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        for _ in 0..<3 {
            timestampProvider.add(1.0/FramesManager.maxFps+0.001)
            framesManager.frame()
        }
        timestampProvider.add(1.001)
        framesManager.frame()
        
        // then
        XCTAssertEqual(3, framesManager.fps())
    }
    
    func testThatFrameCanBeDrawn() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        timestampProvider.add(1.0/FramesManager.maxFps+0.001)
        framesManager.frame()
        
        // then
        XCTAssertEqual(true, framesManager.canGo())
    }
    
    func testThatChecksIfFrameCanBeDrawn() {
        // given
        framesManager.frame() // Initialization frame (we need previous frames’s time)
        
        // when
        timestampProvider.add(1.0/FramesManager.maxFps-0.001)
        framesManager.frame() // canGo should be false
        timestampProvider.add(1.0/FramesManager.maxFps-0.001)
        framesManager.frame() // canGo should be true
        
        // then
        XCTAssertEqual(true, framesManager.canGo())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
