//
//  F+Realm.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/21/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import Models

extension F {
    enum Realm {}
}

extension F.Realm {
    static func retrive<Entity: Object, Value: EntityModel, ID: IDType>(id: ID,
                                                                        realmProvider: RealmProvider,
                                                                        workQueue: DispatchQueue? = nil,
                                                                        notificationQueue: DispatchQueue? = nil,
                                                                        transform: @escaping (Entity) throws -> Value) -> SignalProducer<Value?, StorageError>
    {
        return SignalProducer { (observer, lifetime) in
            let context = realmProvider.context
            let entity = context.object(ofType: Entity.self, forPrimaryKey: id.value)
            do {
                let model = try entity.map(transform)
                observer.send(value: model)
                observer.sendCompleted()
            } catch {
                observer.send(error: F.transform(error: error))
            }
        }.start(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.retrieve", targeting: workQueue))
        .observe(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.retrieve.notification", targeting: notificationQueue))
    }
}

extension F.Realm {
    static func write<Entity: Object, Value: EntityModel>(model: Value,
                                                          realmProvider: RealmProvider,
                                                          workQueue: DispatchQueue? = nil,
                                                          notificationQueue: DispatchQueue? = nil,
                                                          transform: @escaping (Value, Entity) throws -> Entity) -> SignalProducer<Value, StorageError>
    {
        return SignalProducer { (observer, lifetime) in
            let context = realmProvider.context
            let entity = context.object(ofType: Entity.self, forPrimaryKey: model.id.value)
            do {
                if let entity = entity {
                    try context.write {
                        _ = try transform(model, entity)
                    }
                } else {
                    var entity = Entity()
                    Entity.primaryKey().do { entity.setValue(model.id.value, forKey: $0) }
                    entity = try transform(model, entity)
                    try context.write {
                        context.add(entity)
                    }
                }
                observer.send(value: model)
                observer.sendCompleted()
            } catch {
                observer.send(error: F.transform(error: error))
            }
        }.start(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.write", targeting: workQueue))
        .observe(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.write.notification", targeting: notificationQueue))
    }
}

extension F.Realm {
    static func delete<ID: IDType, Entity: Object>(id: ID,
                                   realmProvider: RealmProvider,
                                   entityType: Entity.Type,
                                   workQueue: DispatchQueue? = nil,
                                   notificationQueue: DispatchQueue? = nil) -> SignalProducer<Void, StorageError> {
        return SignalProducer { (observer, lifetime) in
            let context = realmProvider.context
            let entity = context.object(ofType: entityType, forPrimaryKey: id.value)
            do {
                if let entity = entity {
                    try context.write {
                        context.delete(entity)
                    }
                }
                observer.send(value: ())
                observer.sendCompleted()
            } catch {
                observer.send(error: F.transform(error: error))
            }
        }.start(on: QueueScheduler.init(qos: .default, name: "com.idap.entity.storage.delete", targeting: workQueue))
        .observe(on: QueueScheduler(qos: .default, name: "com.idap.entity.storage.delete.notification", targeting: notificationQueue))
    }
}

extension F {
    static func transform(error: Error) -> StorageError {
        return (error as? StorageCodableError).map(Transformers.Error.transform) ??
            ((error as NSError?).map { .error(reason: $0.localizedDescription) } ?? .undefined )
    }
}


