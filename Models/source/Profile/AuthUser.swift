//
//  AuthUser.swift
//  Models
//
//  Created by Artem Chabannyi on 2/9/19.
//  Copyright © 2019 IDAP Group. All rights reserved.
//

import Foundation

public enum LoginProvider: String, Equatable {
    case email
    case google
}

public struct AuthUser: EntityModel, Equatable {
    
    public let profile: Profile
    
    public let provider: LoginProvider
    
    public init(profile: Profile,
                provider: LoginProvider) {
        self.profile = profile
        self.provider = provider
    }
}

extension AuthUser {
    public var id: UserId {
        return self.profile.id
    }
}
