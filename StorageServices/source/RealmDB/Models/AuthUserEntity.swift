//
//  AuthUserEntity.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/14/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift

class AuthUserEntity: Object {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var provider: String?
    
    @objc dynamic var profile: ProfileEntity?
    
    let id = RealmOptional<Int>()
}

extension AuthUserEntity {
    var isNonOptionalAttributes: Bool {
        return self.provider != nil && self.profile != nil
    }
}
