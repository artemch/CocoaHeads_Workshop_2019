//
//  RealmProvider.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmProvider {
    
    // MARK: - Initializations and Deallocations
    
    public init(storageName: String) {
        var config = Realm.Configuration()
        config.inMemoryIdentifier = storageName
        Realm.Configuration.defaultConfiguration = config
        self.clear()
    }
    
    // MARK: - Public methods
    
    public var context: Realm {
        return try! Realm()
    }
    
    public func clear() {
        let context = self.context
        try? context.write {
            self.context.deleteAll()
        }
    }
    
}
