//
//  ViewComputations.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/19/17.
//
//

import Foundation

public typealias AnimationDuration = CGFloat

public class ViewComputations {
    private var animationDuration: AnimationDuration = 1

    public init(animation duration: AnimationDuration) {
        self.animationDuration = duration
    }

    public func getYPosition(afterTime sec: TimeInterval, with offset: TimeInterval) -> CGFloat {
        return (sin(2.0*CGFloat.pi*CGFloat(sec+offset)/self.animationDuration)+1)/2
    }
}
