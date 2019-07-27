//
//  LogOutStorageRealm.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public class LogOutStorageRealm: LogOutStorage {
    
    let realmProvider: RealmProvider
    
    // MARK: - Initializations and Deallocations
    
    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
    }
    
    // MARK: - Public methods
    
    public func logOut() -> SignalProducer<(), NoError> {
        return SignalProducer { (observer, lifetime) in
            self.realmProvider.clear()
            observer.send(value: ())
            observer.sendCompleted()
        }.start(on: QueueScheduler(qos: .default, name: "com.idap.storage"))
    }
}
