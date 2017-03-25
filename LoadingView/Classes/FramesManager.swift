//
//  FramesManager.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/23/17.
//
//

import Foundation

public class FramesManager {
    private var frames: Int = 0
    private var lastTimestamp: CFTimeInterval = 0
    private var timeSpan: CFTimeInterval = 0

    public init() {

    }

    public func frame(current timestamp: CFTimeInterval) {
        timeSpan += timestamp-lastTimestamp
        if timeSpan > 1 {
            frames = 0
            timeSpan = 0
        }

        frames += 1
        lastTimestamp = timestamp
    }

    public func getFramesCount() -> Int {
        return frames
    }
}
