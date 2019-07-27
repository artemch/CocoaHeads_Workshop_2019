//
//  AuthUserStorage.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift

public protocol AuthUserStorage {
    
    typealias ID = UserId
    
    typealias Value = AuthUser
    
    func retrive(id: ID) -> SignalProducer<Value?, StorageError>
    
    func write(model: Value) -> SignalProducer<Value, StorageError>
}
