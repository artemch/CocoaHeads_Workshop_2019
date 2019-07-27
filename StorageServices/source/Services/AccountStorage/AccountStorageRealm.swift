//
//  AccountStorageRealm.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift

public class AccountStorageRealm: AccountStorage {
    
    typealias Entity = AccountEntity
    
    typealias ProfileEntityType = ProfileEntity
    
    typealias AuthUserEntityType = AuthUserEntity
    
    let realmProvider: RealmProvider
    
    let authUserStorage: AuthUserStorage
    
    let profileStorage: RealmEntityStorage<ID, Profile, ProfileEntityType>
    
    // MARK: - Initializations and Deallocations
    
    init(realmProvider: RealmProvider,
         authUserStorage: AuthUserStorage) {
        self.realmProvider = realmProvider
        self.authUserStorage = authUserStorage
        self.profileStorage = RealmEntityStorage(realmProvider: realmProvider,
                                                 transformEntityToModel: Transformers.Profile.transform,
                                                 transformModelToEntity: Transformers.Profile.transform)
    }
    
    // MARK: - Public methods
    
    public func retrieveAuthUser(id: AccountStorageRealm.ID) -> SignalProducer<AccountStorageRealm.Value?, StorageError> {
        return self.authUserStorage.retrive(id: id)
    }
    
    public func writeAuthUser(model: Value) -> SignalProducer<Value, StorageError> {
        return self.retrieveAccount(id: model.id)
            .map { ($0, model) }
            .flatMap(FlattenStrategy.latest, { [weak self] (entity, model) in
                self.map { $0.linkAuthUserWithAccountIfNeeded(entity: entity, model: model) } ?? SignalProducer(error: .undefined) })
            .flatMap(FlattenStrategy.latest, self.authUserStorage.write)
    }
    
    public func deleteAccount(id: ID) -> SignalProducer<Void, StorageError> {
        return SignalProducer(value: ())
    }
    
    public func retrieveProfile(id: ID) -> SignalProducer<Profile?, StorageError> {
        return self.profileStorage.retrieve(id: id)
    }
    
    public func writeProfile(model: Profile) -> SignalProducer<Profile, StorageError> {
        return self.profileStorage.write(model: model)
    }
    
    // MARK: - Private methods
    
    private func retrieveAccount(id: AccountStorageRealm.ID) -> SignalProducer<Entity, StorageError> {
        return SignalProducer { (observer, lifetime) in
            let context = self.realmProvider.context
            let entity = context.object(ofType: Entity.self, forPrimaryKey: id.value) ?? Entity()
            if entity.realm == nil {
                Entity.primaryKey().do { entity.setValue(id.value, forKey: $0) }
                try! context.write {
                    context.add(entity)
                }
            }
            observer.send(value: entity)
            observer.sendCompleted()
        }.start(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.write", targeting: nil))
    }
    
    private func linkAuthUserWithAccountIfNeeded(entity: Entity, model: Value) -> SignalProducer<Value, StorageError> {
        return SignalProducer({ (observer, lifetime) in
            if entity.authUser == nil {
                let context = self.realmProvider.context
                let id = model.id
                let authUserEntity = context.object(ofType: AuthUserEntityType.self,
                                                    forPrimaryKey: id.value) ?? AuthUserEntityType()
                if authUserEntity.realm == nil {
                    AuthUserEntityType.primaryKey().do { authUserEntity.setValue(id.value, forKey: $0) }
                    try! context.write {
                        context.add(authUserEntity)
                        entity.authUser = authUserEntity
                    }
                }
            }
            observer.send(value: model)
            observer.sendCompleted()
        })
    }
}
