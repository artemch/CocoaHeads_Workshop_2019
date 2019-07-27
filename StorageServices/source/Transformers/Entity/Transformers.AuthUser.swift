//
//  Transformers+AuthUser.swift
//  StorageServices
//
//  Created by Artem Chabannyi on 2/15/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation
import Models

extension Transformers {
    
    enum AuthUser {}
    
}

extension Transformers.AuthUser {
    static func transform(entity: AuthUserEntity) throws -> AuthUser {
        return AuthUser(profile: try Transformers.Profile.transform(entity: try Transformers.unbox(value: entity.profile)),
                        provider: Models.Transformers.LoginProvider.transform(provider: try Transformers.unbox(value: entity.provider)))
    }
    
    static func transform(model: AuthUser, to entity: AuthUserEntity) throws -> AuthUserEntity {
        entity.provider = model.provider.rawValue
        if entity.profile == nil {
            let primaryKey = model.profile.id.value
            let userEntity = entity.realm.flatMap { $0.object(ofType: ProfileEntity.self, forPrimaryKey: primaryKey) } ?? ProfileEntity()
            if userEntity.realm == nil {
                ProfileEntity.primaryKey().do { userEntity.setValue(primaryKey, forKey: $0) }
            }
            entity.profile = userEntity
        }
        entity.profile = try Transformers.Profile.transform(model: model.profile, to: try Transformers.unbox(value: entity.profile))
        return entity
    }
}
