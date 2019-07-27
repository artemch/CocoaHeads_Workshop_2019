//
//  ProfileEntity.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/10/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileEntity: Object {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    let id = RealmOptional<Int>()
    @objc dynamic var displayName: String?
    @objc dynamic var email = ""
    @objc dynamic var avatar = ""
}
