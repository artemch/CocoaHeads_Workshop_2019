//
//  EntityStorage.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/8/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public protocol EntityStorage {
    
    associatedtype ID
    
    associatedtype Value
    
    func retrieve(id: ID) -> SignalProducer<Value?, StorageError>
    
    func write(model: Value) -> SignalProducer<Value, StorageError>
    
    func delete(id: ID) -> SignalProducer<Void, StorageError>
}
