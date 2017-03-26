//
//  TimestampProvider.swift
//  Pods
//
//  Created by Igor Kotkovets on 3/26/17.
//
//

import Foundation

public protocol TimestampProvider {
    func timestamp() -> TimeInterval
}
