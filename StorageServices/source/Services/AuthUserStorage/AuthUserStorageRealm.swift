//
//  AuthUserStorageRealm.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models
import ReactiveSwift

public class AuthUserStorageRealm: AuthUserStorage {
    
    typealias Entity = AuthUserEntity
    
    let realmProvider: RealmProvider
    
    let entityStorage: RealmEntityStorage<AuthUserStorage.ID, Value, Entity>
    
    // MARK: - Initializations and Deallocations
    
    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
        self.entityStorage = RealmEntityStorage(realmProvider: realmProvider,
                                                transformEntityToModel: Transformers.AuthUser.transform,
                                                transformModelToEntity: Transformers.AuthUser.transform)
    }
    
    // MARK: - Public methods
    
    public func retrive(id: AuthUserStorage.ID) -> SignalProducer<Value?, StorageError> {
        return self.entityStorage.retrieve(id: id)
    }
    
    public func write(model: Value) -> SignalProducer<Value, StorageError> {
        return self.entityStorage.write(model: model)
    }
}
