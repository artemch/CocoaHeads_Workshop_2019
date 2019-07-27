//
//  UserId.swift
//  Models
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public protocol IDType {
    
    associatedtype Value
    
    var value: Value { get }
}

public struct ID<Value>: IDType, Equatable, Hashable where Value: Hashable {
    public let value: Value
    
    public init(value: Value) {
        self.value = value
    }
}
