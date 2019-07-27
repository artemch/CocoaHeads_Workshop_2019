//
//  Transformers+User.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/13/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

extension Transformers {
    
    enum Profile { }
    
}

extension Transformers.Profile {
    static func transform(entity: ProfileEntity) throws -> Profile {
        return Profile(id: UserId(value: try Transformers.unbox(value: entity.id)),
                                  displayName: entity.displayName,
                                  avatar: entity.avatar,
                                  email: entity.email)
    }
    
    @discardableResult
    static func transform(model: Profile, to entity: ProfileEntity) throws -> ProfileEntity {
        entity.displayName = model.displayName
        entity.avatar = model.avatar
        entity.email = model.email
        return entity
    }
}




