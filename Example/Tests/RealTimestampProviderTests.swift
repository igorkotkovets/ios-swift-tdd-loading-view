//
//  RealTimestampProviderTests.swift
//  LoadingView
//
//  Created by Igor Kotkovets on 3/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import LoadingView

class RealTimestampProviderTests: XCTestCase {
    var timestampProvider: RealTimestampProvider!
    
    override func setUp() {
        super.setUp()
        timestampProvider = RealTimestampProvider()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatProviderGiveCurrentTime() {
        // given
        let timestamp = Date.timeIntervalSinceReferenceDate
        
        // when
        
        // then
        XCTAssertTrue(timestampProvider.timestamp()-timestamp < RealTimestampProvider.occuracySec, "Timestamp fits \(RealTimestampProvider.occuracySec)s window")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
