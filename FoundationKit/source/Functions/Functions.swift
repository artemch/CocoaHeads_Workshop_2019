//
//  Functions.swift
//  FoundationKit
//
//  Created by Artem Chabannyi on 2/6/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public func toString(_ cls: Any) -> String {
    return String(describing: cls)
}

public func random(from: UInt32, to: UInt32) -> Int {
    return Int(arc4random_uniform(to - from + 1) + from)
}

public func clamp<T: Comparable>(value: T, min lower: T, max upper: T) -> T {
    return min(max(value, lower), upper)
}

public func degreesToRadians(_ degrees: Float) -> Float {
    return degrees * .pi / 180
}

public func radiansToDegrees(_ radians: Float) -> Float {
    return radians * 180 / .pi
}
