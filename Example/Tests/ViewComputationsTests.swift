//
//  ViewComputationsTests.swift
//  LoadingView
//
//  Created by Igor Kotkovets on 3/19/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import LoadingView
import Nimble

class ViewComputationsTests: XCTestCase {
    private var viewComputations: ViewComputations!
    
    override func setUp() {
        super.setUp()
        
        viewComputations = ViewComputations(animation: 1)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatCalculatesSinusoidResultBasedOnTime() {
        // given 
        
        // when
        
        // then
        expect(self.viewComputations.getYPosition(afterTime: 0)) == (0.0+1.0)/2
        expect(self.viewComputations.getYPosition(afterTime: 0.083333333333333)) ≈ ((1.0/2.0+1)/2, 0.001)
        expect(self.viewComputations.getYPosition(afterTime: 0.125)) == ((sqrt(2.0)/2.0+1)/2, 0.001)
        expect(self.viewComputations.getYPosition(afterTime: 0.250)) == (1.0+1)/2
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
