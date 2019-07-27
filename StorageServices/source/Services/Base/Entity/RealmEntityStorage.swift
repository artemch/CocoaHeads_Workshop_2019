//
//  RealmEntityStorage.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/10/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import RealmSwift
import Models
import FoundationKit

public class RealmEntityStorage<ID: IDType, Value: EntityModel, Entity: Object>: EntityStorage {
    
    typealias TransformEntityToModel = (Entity) throws -> Value
    
    typealias TransformModelToEntity = (Value, Entity) throws -> Entity
    
    internal let realmProvider: RealmProvider
    
    internal let queue: DispatchQueue
    
    internal let notificationQueue: DispatchQueue
    
    internal let transformEntityToModel: TransformEntityToModel
    
    internal let transformModelToEntity: TransformModelToEntity
    
    init(realmProvider: RealmProvider,
         transformEntityToModel: @escaping TransformEntityToModel,
         transformModelToEntity: @escaping TransformModelToEntity) {
        self.realmProvider = realmProvider
        self.queue = DispatchQueue(label: "com.idap.entity.storage",
                                   qos: .default,
                                   attributes: DispatchQueue.Attributes.concurrent)
        self.notificationQueue = DispatchQueue(label: "com.idap.entity.notification",
                                               qos: .default,
                                               attributes: DispatchQueue.Attributes.concurrent)
        self.transformEntityToModel = transformEntityToModel
        self.transformModelToEntity = transformModelToEntity
    }
    
    public func retrieve(id: ID) -> SignalProducer<Value?, StorageError> {
        return F.Realm.retrive(id: id,
                               realmProvider: self.realmProvider,
                               workQueue: self.queue,
                               notificationQueue: self.notificationQueue,
                               transform: self.transformEntityToModel)
    }
    
    public func write(model: Value) -> SignalProducer<Value, StorageError> {
        return F.Realm.write(model: model,
                             realmProvider: self.realmProvider,
                             workQueue: self.queue,
                             notificationQueue: self.notificationQueue,
                             transform: self.transformModelToEntity)
    }
    
    public func delete(id: ID) -> SignalProducer<Void, StorageError> {
        return F.Realm.delete(id: id,
                              realmProvider: self.realmProvider,
                              entityType: Entity.self,
                              workQueue: self.queue,
                              notificationQueue: self.queue)
    }
}
