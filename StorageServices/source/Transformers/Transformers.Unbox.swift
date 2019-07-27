//
//  Transformers.Unbox.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 3/5/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift

extension Transformers {
    static func unbox<Value>(value: RealmOptional<Value>) throws -> Value {
        if let value = value.value {
            return value
        } else {
            throw StorageCodableError.missedValue(value.description)
        }
    }
    
    static func unbox<Value: Object>(value: Value?) throws -> Value {
        if let value = value {
            return value
        } else {
            throw StorageCodableError.missedValue("Missed \(type(of: Value.self))")
        }
    }
    
    static func unbox<Value>(value: Value?) throws -> Value {
        if let value = value {
            return value
        } else {
            throw StorageCodableError.missedValue("Missed \(type(of: Value.self))")
        }
    }
}
