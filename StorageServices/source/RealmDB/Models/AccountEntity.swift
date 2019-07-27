//
//  AccountEntity.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift

class AccountEntity: Object {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var authUser: AuthUserEntity?
    
    let id = RealmOptional<Int>()
}
