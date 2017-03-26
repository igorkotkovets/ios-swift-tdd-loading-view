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
    private var _fps: Int = 0

    public init() {

    }

    public func frame(current timestamp: CFTimeInterval) {
        timeSpan += timestamp-lastTimestamp
        if timeSpan > 1 {
            timeSpan = 0
            _fps = getFramesCount()
            frames = 0
        }

        frames += 1
        lastTimestamp = timestamp
    }

    public func fps() -> Int {
        return _fps
    }

    public func getFramesCount() -> Int {
        return frames
    }
}
