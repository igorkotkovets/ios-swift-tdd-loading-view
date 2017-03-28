//
//  ViewComputations.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/19/17.
//
//

import Foundation

typealias AnimationDuration = CGFloat

public class ViewComputations {
    private let animationDuration: AnimationDuration = 1

    public init() {
    }

    public func getYPosition(afterTime sec: TimeInterval) -> CGFloat {
        return sin(2.0*CGFloat.pi*CGFloat(sec)/animationDuration)
    }
}
