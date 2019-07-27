//
//  RealmStorageFactory.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Valet
import Models

public class RealmStorageFactory: StorageFactory {
    
    private let realm: RealmProvider
    
    private let valet: Valet
    
    // MARK: - Initializations and Deallocations
    
    public init(realm: RealmProvider, securityStoreName: String) {
        self.realm = realm
        self.valet = Valet.valet(with: Identifier(nonEmpty: securityStoreName)!, accessibility: .whenUnlocked)
    }
    
    // MARK: - Public methods
    
    public func securityStorage() -> SecurityStorage {
        return SecurityStorageImp(valet: self.valet)
    }
    
    public func logOutStorage() -> LogOutStorage {
        return LogOutStorageRealm(realmProvider: self.realm)
    }
    
    public func accountStorage() -> AccountStorage {
        let authUserStorage = AuthUserStorageRealm(realmProvider: self.realm)
        return AccountStorageRealm(realmProvider: self.realm,
                                   authUserStorage: authUserStorage)
    }
}

extension RealmStorageFactory {
    public static func `default`(securityStoreName: String, storageName: String) -> RealmStorageFactory {
        return RealmStorageFactory(realm: RealmProvider(storageName: storageName), securityStoreName: securityStoreName)
    }
}
