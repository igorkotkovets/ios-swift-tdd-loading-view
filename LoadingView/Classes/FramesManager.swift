//
//  FramesManager.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/23/17.
//
//

import Foundation

public class FramesManager {
    final class Constants {
        static public let maxFps: TimeInterval = 60
        static public let minTimePerFrame: TimeInterval = 1.0/maxFps
    }

    private var frames: Int = 0
    private var lastTimestamp: TimeInterval = 0
    private var timeSpan: TimeInterval = 0
    private var _fps: Int = 0

    private var timeFrame: TimeInterval = 0
    private var timestampProvider: TimestampProvider?

    public init(_ timestampProvider: TimestampProvider) {
        self.timestampProvider = timestampProvider
    }

    public func frame() {
        if self.canGo() {
            timeFrame = timeFrame.truncatingRemainder(dividingBy: Constants.minTimePerFrame)
        }

        let currentTimestamp = timestampProvider!.timestamp()
        let timeStep = currentTimestamp-lastTimestamp
        timeFrame += timeStep
        timeSpan += timeStep
        if timeSpan > 1 {
            timeSpan = 0
            _fps = getFramesCount()
            frames = 0
        }

        if self.canGo() {
            frames += 1
        }

        lastTimestamp = currentTimestamp
    }

    public func fps() -> Int {
        return _fps
    }

    public func getFramesCount() -> Int {
        return frames
    }

    public func canGo() -> Bool {
        return timeFrame > Constants.minTimePerFrame
    }
}
