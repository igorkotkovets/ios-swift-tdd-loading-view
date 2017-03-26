//
//  RealTimestampProvider.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/26/17.
//
//

import Foundation

public class RealTimestampProvider: TimestampProvider {
    static let occuracySec: TimeInterval = 0.002

    // MARK: TimestampProvider
    public func timestamp() -> TimeInterval {
        return Date.timeIntervalSinceReferenceDate
    }
}
